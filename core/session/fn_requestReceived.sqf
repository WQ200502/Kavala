#include "..\..\macro.h"
//  File: fn_requestReceived.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Called by the server saying that we have a response so let's
//	sort through the information, validate it and if all valid
//	set the client up.
private["_newCrimes","_isDeadCiv","_timeStamp","_timeDiff","_isKidneyImpaired"];
oev_session_tries = oev_session_tries + 1;
if(oev_session_completed) exitWith {}; //Why did this get executed when the client already initialized? Fucking arma...
if(oev_session_tries > 3) exitWith {life_loadingStatus = "<t color='#0000FF'>尝试设置客户端时出错。</t>";};
_isDeadCiv = (playerside isEqualTo civilian && (profileNamespace getVariable["epiActive",false])); //(playerSide == civilian && (profileNamespace getVariable["oisd",false]));
_isKidneyImpaired = (playerside isEqualTo civilian && (profileNamespace getVariable["kidneyRemoved",false]));
life_loadingStatus = "<t color='#FF0000'>从服务器收到请求。。。正在验证。。。</t>";

//Error handling and  junk..
if(isNil "_this") exitWith {[] call OEC_fnc_insertPlayerInfo;};
if(_this isEqualType "") exitWith {[] call OEC_fnc_insertPlayerInfo;};
if(count _this == 0) exitWith {[] call OEC_fnc_insertPlayerInfo;};
if((_this select 0) == "Error") exitWith {[] call OEC_fnc_insertPlayerInfo;};
if (((_this select 0) == "cooldown") || ((_this select 0) == "cooldown2")) exitWith {
	_timeDiff = (_this select 1);
	if ((_this select 0) == "cooldown2") then {
		_timeStamp = time + 900;
		if(_timeDiff <= 900) then {
			_timeStamp = time + (900 - _timeDiff);
		} else {
			diag_log format["time too long - %1",(900 - _timeDiff)];
		};
	} else {
		_timeStamp = time + 300;
		if(_timeDiff <= 300) then {
			_timeStamp = time + (300 - _timeDiff);
		} else {
			diag_log format["time too long - %1",(300 - _timeDiff)];
		};
	};

	player enableSimulation false;

	while{true} do {
		life_loadingStatus = format["<t color='#0000FF'>角色数据修改中，需等待15分钟: %1</t>", ([(round(_timeStamp - time)),"MM:SS"] call BIS_fnc_secondsToString)];
		if(round(_timeStamp - time) <= 0) exitWith {};
		sleep 1;
	};

	player enableSimulation true;

	[] call OEC_fnc_dataQuery;
};
if((getPlayerUID player) != _this select 0) exitWith {[] call OEC_fnc_dataQuery;};

//Lets make sure some vars are not set before hand.. If they are get rid of them, hopefully the engine purges past variables but meh who cares.
if(!isServer && (!isNil "life_adminlevel" || !isNil "life_coplevel" || !isNil "oev_donator")) exitWith {
	[[profileName,getPlayerUID player,"VariablesAlreadySet"],"OEC_fnc_cookieJar",false,false] spawn OEC_fnc_MP;
	[[profileName,format["Variables set before client initialization...\nlife_adminlevel: %1\nlife_coplevel: %2\noev_donator: %3",life_adminlevel,life_coplevel,oev_donator]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	uiSleep 0.5;
	SPYGLASS_END
};
diag_log _this;
private _queryIndex = ["playerid", "name", "cash", "bank", "admin", "designer", "developer", "civcouncil", "restrictions", "donatorlvl", "licenses", "rankarrest", "gear", "aliases", "stats", "wanted", "blposnews", "support", "vigiarrests", "vigiarrests_stored","deposit_box", "loot", "gangarr", "housearr", "housekeysarr", "vehkeys"];

//Parse basic player information.
oev_cash = parseNumber (_this select (_queryIndex find "cash"));
oev_cache_cash = oev_cash + oev_random_cash_val;
oev_atmcash = parseNumber (_this select (_queryIndex find "bank"));
oev_cache_atmcash = oev_atmcash + oev_random_cash_val;
__CONST__(life_adminlevel,(_this select (_queryIndex find "admin")));
__CONST__(oev_designerlevel,(_this select (_queryIndex find "designer")));
__CONST__(oev_developerlevel,(_this select (_queryIndex find "developer")));
__CONST__(oev_civcouncil,(_this select (_queryIndex find "civcouncil")));
private _playerRestricted = [false, true] select (_this select (_queryIndex find "restrictions"));
__CONST__(oev_restrictions,_playerRestricted);
//__CONST__(oev_restrictions,(_this select 7));
player setVariable ["adminlvl",(_this select (_queryIndex find "admin")),true]; // Only used for bones on combat log :) + map markers for staff
player setVariable ["devlvl",(_this select (_queryIndex find "developer")),true];
player setVariable ["deslvl",(_this select (_queryIndex find "designer")),true];
player setVariable ["restrictions",_playerRestricted,true];
__CONST__(oev_donator,(_this select (_queryIndex find "donatorlvl")));
private _newsLevel = 0;
private _suppLevel = 0;
oev_newsTeam = false;
__CONST__(life_supportlevel,(_this select (_queryIndex find "support")));

if(__GETC__(oev_restrictions)) then {
	__CONST__(oev_houseLimit,3);
} else {
	__CONST__(oev_houseLimit,5);
};



//if(playerSide isEqualTo civilian) then {_suppLevel = (_this select 13); __CONST__(life_supportlevel,_suppLevel);} else {__CONST__(life_supportlevel,0);};
if(playerSide isEqualTo independent) then {_newsLevel = (_this select (_queryIndex find "blposnews"));};
if ((str(player) in ["indp_news_1","indp_news_2","indp_news_3","indp_news_4","indp_news_5","indp_news_6","indp_news_7","indp_news_8","indp_news_9","indp_news_10"]) && ((_newsLevel > 0) || (__GETC__(life_adminlevel) > 0))) then {
	oev_newsTeam = true;
	_newsLevel = (_this select (_queryIndex find "blposnews"));
	if ((__GETC__(life_adminlevel) > 0) && ((_this select (_queryIndex find "blposnews")) isEqualTo 0)) then {
		_newsLevel = 3;
	};
} else {
	_newsLevel = 0;
};
__CONST__(life_newslevel,_newsLevel);

private _obsoleteLic = ["license_civ_bananap","license_civ_topaz","license_civ_cocoap","license_civ_lumber","license_civ_bananaSplit","license_civ_sugarp","license_civ_methu","license_civ_mashu","license_civ_gang","license_cop_swat","license_civ_taxi"];
//Loop through licenses
if(count (_this select (_queryIndex find "licenses")) > 0) then {
	{
		if !((_x select 0) in _obsoleteLic) then {
			missionNamespace setVariable [(_x select 0),(_x select 1)];
		};
	} foreach (_this select (_queryIndex find "licenses"));
};

life_gear = _this select (_queryIndex find "gear");

life_gear_snapshot = life_gear;
oev_lastSynced_gear = format["%1",life_gear];
[] call OEC_fnc_loadGear;
life_aliases = _this select (_queryIndex find "aliases");
life_loot = _this select (_queryIndex find "loot");

//stats
O_stats = _this select (_queryIndex find "stats");
if(count O_stats != 10) then {
	O_stats = [0,0,0,0,0,0,0,0,0,0];
};
O_stats_kills = O_stats select 0;
O_stats_deaths = O_stats select 1;
O_stats_revives = O_stats select 2;
O_stats_distanceFoot = O_stats select 3;
O_stats_distanceVehicle = O_stats select 4;
O_stats_bountiesReceived = O_stats select 5;
O_stats_arrestsMade = O_stats select 6;
O_stats_playtime_civ = O_stats select 7;
O_stats_playtime_cop = O_stats select 8;
O_stats_playtime_med = O_stats select 9;
O_stats_teleports = 0;

O_stats_crimes = _this select (_queryIndex find "wanted");
if(((count O_stats_crimes) - 1) < oev_totalCrimes) then {
	_newCrimes = oev_totalCrimes - ((count O_stats_crimes) - 1);
	for [{_x=1},{_x<=_newCrimes},{_x=_x+1}] do {
		O_stats_crimes pushBack 0;
	};
};
if(((count O_stats_crimes) - 1) != oev_totalCrimes) then {
	O_stats_crimes = [];
	for [{_x=0},{_x<=oev_totalCrimes},{_x=_x+1}] do {
		O_stats_crimes pushBack 0;
	};
};
[] spawn{
	uiSleep 10;
	player setVariable["statBounty",O_stats_crimes select 0,true];
	uiSleep 30;
	player setVariable["statBounty",O_stats_crimes select 0,true];
	uiSleep 60;
	player setVariable["statBounty",O_stats_crimes select 0,true];
};

oev_deposit_box = _this select (_queryIndex find "deposit_box");

//Parse side specific information.
switch(playerSide) do {
	case west: {
		if (__GETC__(oev_restrictions)) then {
			__CONST__(life_coplevel,0);
		} else {
			__CONST__(life_coplevel,(_this select (_queryIndex find "rankarrest")));
		};
		__CONST__(life_medicLevel,0);
		oev_cop_gangData = _this select (_queryIndex find "gangarr");
	};

	case civilian: {
		oev_is_arrested = _this select (_queryIndex find "rankarrest");
		__CONST__(life_coplevel, 0);
		__CONST__(life_medicLevel, 0);

		life_ses_last_pos = _this select (_queryIndex find "blposnews");
		player setVariable ["vigilanteArrests",_this select (_queryIndex find "vigiarrests"),true];
		oev_vigiarrests = _this select (_queryIndex find "vigiarrests");
		player setVariable ["vigilanteArrestsStored",_this select (_queryIndex find "vigiarrests_stored"),true];
		oev_vigiarrests_stored = _this select (_queryIndex find "vigiarrests_stored");
		life_houses = _this select (_queryIndex find "housearr");
		life_house_keys = _this select (_queryIndex find "housekeysarr");
		{
			if((count (nearestObjects[(call compile format["%1", _x select 0]),["House_F"],10])) > 0) then {
				_house = ((nearestObjects[(call compile format["%1", _x select 0]),["House_F"],10]) select 0);

				oev_vehicles pushBack _house;
			};
		} foreach life_houses;

		[] spawn OEC_fnc_ClinitHouses;
		[] spawn OEC_fnc_ClinitHouseKeys;

		oev_gang_data = _this select (_queryIndex find "gangarr");
		if(count oev_gang_data > 0) then {
			player setVariable["gang_data",oev_gang_data,true];
		} else {
			player setVariable["gang_data",nil,true];
		};
		[] spawn{
			uiSleep 60;
			if(isNil {player getVariable "gang_data"}) then {
				if(count oev_gang_data > 0) then {
					player setVariable["gang_data",oev_gang_data,true];
				};
			};
		};

		if((oev_gang_data select 0) <= 0) then {oev_gang_data = [];};
		if(count oev_gang_data != 0) then {
				[] spawn OEC_fnc_initGang;
				if (!isNil{oev_gang_data select 3})then{
				[0] call OEC_fnc_gangBldgDraw;
			};
		};
	};

	case independent: {
		if !(oev_newsTeam) then {
			if (__GETC__(oev_restrictions)) then {
				__CONST__(life_medicLevel,0);
			} else {
				__CONST__(life_medicLevel,(_this select (_queryIndex find "rankarrest")));
			};
		} else {
			__CONST__(life_medicLevel,0);
		};
		__CONST__(life_coplevel,0);
	};
};

// Adds cars to key chain and trackers back to cars on login
if(count (_this select (_queryIndex find "vehkeys")) > 0) then {
	{
		oev_vehicles pushBack _x;
		_mods = _x getVariable ["modifications",[0,0,0,0,0,0]];
		_tracked = _x getVariable ["tracking",false];
			if (((_mods select 2) == 3 && isNil{_tracked}) || _tracked)then{
				[_x, false] remoteExec ["OEC_fnc_installTracker", _x];
				oev_tracked_vehicles pushBack _x;
			};
	} foreach (_this select (_queryIndex find "vehkeys"));
};

if(!(profileName in life_aliases)) then {
	life_aliases pushBack profileName;
	[8] call OEC_fnc_ClupdatePartial;
	__CONST__(life_aliases,life_aliases);
};

oev_paycheck = oev_paycheck + 1250;

switch(__GETC__(life_coplevel)) do {
	case 1: {oev_paycheck = oev_paycheck + 300;};
	case 2: {oev_paycheck = oev_paycheck + 600;};
	case 3: {oev_paycheck = oev_paycheck + 900;};
	case 4: {oev_paycheck = oev_paycheck + 1200;};
	case 5: {oev_paycheck = oev_paycheck + 1200;};
	case 6: {oev_paycheck = oev_paycheck + 1500;};
	case 7: {oev_paycheck = oev_paycheck + 1800;};
	case 8: {oev_paycheck = oev_paycheck + 1800;};
	case 9: {oev_paycheck = oev_paycheck + 1800;};
	case 10: {oev_paycheck = oev_paycheck + 1800;};
};

switch(__GETC__(life_medicLevel)) do {
	case 1: {oev_paycheck = oev_paycheck + 300;};
	case 2: {oev_paycheck = oev_paycheck + 600;};
	case 3: {oev_paycheck = oev_paycheck + 900;};
	case 4: {oev_paycheck = oev_paycheck + 1200;};
	case 5: {oev_paycheck = oev_paycheck + 1200;};
	case 6: {oev_paycheck = oev_paycheck + 1500;};
	case 7: {oev_paycheck = oev_paycheck + 1800;};
};

[player,0] remoteExec["OES_fnc_hexMasterServ",2];

if (playerSide isEqualTo civilian) then {
	private _perkTier = 0;
	_perkTier = ["civ_minutes"] call OEC_fnc_fetchStats;
	switch (_perkTier) do {
		case 1: {oev_paycheck = oev_paycheck + 500;};
		case 2: {oev_paycheck = oev_paycheck + 1000;};
		case 3: {oev_paycheck = oev_paycheck + 1500;};
	};
};

if(_isDeadCiv) then {
	[] call OEC_fnc_ClupdateRequest;
	[] spawn{
		sleep 15;
		profileNamespace setVariable["epiActive",false];
	};
};

if(_isKidneyImpaired) then {
	[] spawn{
		player setVariable ["kidneyRemoved",true,true];
		private["_uiDisp"];
		disableSerialization;
		11 cutRsc ["life_kidney_timer","PLAIN DOWN"];
		_uiDisp = uiNamespace getVariable "life_kidney_timer";
		while {true} do {
			if(isNull _uiDisp) then {
				11 cutRsc ["life_kidney_timer","PLAIN DOWN"];
				_uiDisp = uiNamespace getVariable "life_kidney_timer";
			};
			if(!(player getVariable["kidneyRemoved", false])) exitWith {
				if(playerside isEqualTo civilian) then {
					profileNamespace setVariable ["kidneyRemoved",false];
				};
			};
			if(!alive player) exitWith {};
			if (getDammage player < 0.5) then {_dam_obj = player; _dam_obj setDamage 0.5;};
			uiSleep 1.5;
		};
		11 cutText["","PLAIN DOWN"];
	};
};

if (oev_deposit_box > 0) then {
	[] spawn{
		uiSleep 45;
		hint parseText format["<t color='#00ff00' size='2' align='center'>可用资金</t><br/><br/>您的存款箱中有%1元！去任何一台自动取款机兑换到你的银行账户！",[oev_deposit_box] call OEC_fnc_numberText];
	};
};

oev_session_completed = true;
