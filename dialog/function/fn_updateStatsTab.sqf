//  File: fn_updateStatsTab.sqf

disableSerialization;

private _civTime = [(O_stats_playtime_civ * 60),"HH:MM",true] call BIS_fnc_secondsToString;
private _copTime = [(O_stats_playtime_cop * 60),"HH:MM",true] call BIS_fnc_secondsToString;
private _medTime = [(O_stats_playtime_med * 60),"HH:MM",true] call BIS_fnc_secondsToString;
private _warPtCache = 0;
private _vigilanteRank = 0;

if (playerSide isEqualTo civilian) then {
	ctrlShow [32011, false];
};

ctrlSetText[32001,format["平民: %1 小时 %2 分钟",parseNumber(_civTime select 0),parseNumber(_civTime select 1)]];
ctrlSetText[32002,format["警察: %1 小时 %2 分钟",parseNumber(_copTime select 0),parseNumber(_copTime select 1)]];
ctrlSetText[32003,format["医生: %1 小时 %2 分钟",parseNumber(_medTime select 0),parseNumber(_medTime select 1)]];
ctrlSetText[32004,format["K/D: %1 - %2",O_stats_kills,O_stats_deaths]];
ctrlSetText[32005,format["复活: %1",O_stats_revives]];
ctrlSetText[32006,format["累计逮捕: %1",O_stats_arrestsMade]];
ctrlSetText[32007,format["UID: %1",(getPlayerUID player)]];

switch(true) do {
	case (oev_vigiarrests < 25): {_vigilanteRank = 1};
	case (oev_vigiarrests >= 25 && oev_vigiarrests < 50): {_vigilanteRank = 2};
	case (oev_vigiarrests >= 50 && oev_vigiarrests < 100): {_vigilanteRank = 3};
	case (oev_vigiarrests >= 100 && oev_vigiarrests < 200): {_vigilanteRank = 4};
	case (oev_vigiarrests >= 200): {_vigilanteRank = 5};
};

if !(license_civ_vigilante) then {
	_vigilanteRank = 0;
};

ctrlSetText[32009,format["维吉兰特排名: %1",_vigilanteRank]];
ctrlSetText[32010,format["私刑拘捕: %1",oev_vigiarrests]];

if(oev_warPointTimeFetched isEqualTo 0) then {
	ctrlSetText[32008,format["战争要点: %1","Loading..."]];
	oev_warpts_count = -999;
	[[0,0,player],"OES_fnc_warGetSetPts",false,true] call OEC_fnc_MP;
	waitUntil {!(oev_warpts_count isEqualTo -999)};
	ctrlSetText[32008,format["战争要点: %1",oev_warpts_count]];
	oev_warPointTimeFetched = serverTime + 60;
} else{
	if (serverTime > oev_warPointTimeFetched) then {
		oev_warpts_count = -999;
		[[0,0,player],"OES_fnc_warGetSetPts",false,true] call OEC_fnc_MP;
		waitUntil {!(oev_warpts_count isEqualTo -999)};
		ctrlSetText[32008,format["战争要点: %1",oev_warpts_count]];
		oev_warPointTimeFetched = serverTime + 60;
	} else {
		ctrlSetText[32008,format["战争要点: %1",oev_warpts_count]];
	};
};
