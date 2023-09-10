//  File: fn_hudUpdate.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Updates the HUD when it needs to.
if(isServer && isDedicated) exitWith {};
private["_ui","_selectedBar","_foodText","_foodBar","_waterText","_waterBar","_healthBar","_healthText","_bountyBar","_bountyText","_selectedBar","_iconEarplugs"];
disableSerialization;

_ui = uiNameSpace getVariable ["playerHUD",displayNull];
if(isNull _ui) then {[] call OEC_fnc_hudSetup;};

_foodText = _ui displayCtrl 23500;
_foodBar = _ui displayCtrl 23502;
_waterText = _ui displayCtrl 23510;
_waterBar = _ui displayCtrl 23512;
_healthText = _ui displayCtrl 23515;
_healthBar = _ui displayCtrl 23517;
_bountyText = _ui displayCtrl 23520;
_bountyBar = _ui displayCtrl 23522;
_weightText = _ui displayCtrl 23525;
_weightBar = _ui displayCtrl 23527;
_iconEarplugs = _ui displayCtrl 23528;
_adminGod = _ui displayCtrl 23529;
_adminInvis = _ui displayCtrl 23530;
_adminESP = _ui displayCtrl 23531;
_adminStase = _ui displayCtrl 23532;
_adminStream = _ui displayCtrl 23533;
_adminFly = _ui displayCtrl 23534;

_weightBar progressSetPosition (oev_carryWeight / oev_maxWeight);
_foodBar progressSetPosition (oev_hunger / 100);
_waterBar progressSetPosition (oev_thirst / 100);
_healthBar progressSetPosition (1 - (damage player));
if((([position player select 0,position player select 1,0] distance getMarkerPos("debug_island_marker")) > 600)) then {
	_weightText ctrlsetText format["%1 / %2", oev_carryWeight, oev_maxWeight];
	_foodText ctrlSetText format["%1", oev_hunger];
	_waterText ctrlSetText format["%1", oev_thirst];
	_healthText ctrlSetText format["%1", round((1 - (damage player)) * 100)];
}else{
	_weightText ctrlSetText "--";
	_foodText ctrlSetText "--";
	_waterText ctrlSetText "--";
	_healthText ctrlSetText "死亡";
};

switch (true) do {
	case (oev_earplugs && oev_earVol): {
		_iconEarplugs ctrlShow false;
	};
	case (oev_earplugs && !oev_earVol): {
		_iconEarplugs ctrlShow true;
		_iconEarplugs ctrlSetTextColor [0.78, 1, 0, 0.5];
	};
	case (!oev_earplugs && !oev_earVol): {
		_iconEarplugs ctrlShow true;
		_iconEarplugs ctrlSetTextColor [1, 0, 0, 0.5];
	};
};

{
	_selectedBar = ([_weightBar,_waterBar,_foodBar,_healthBar] select (_forEachIndex));

	switch(true) do {
		case (_x >= 0.85):{_selectedBar ctrlSetTextColor [0, 1, 0, .5];};
		case (_x >= 0.65):{_selectedBar ctrlSetTextColor [0.78, 1, 0, .5];};
		case (_x >= 0.45):{_selectedBar ctrlSetTextColor [0.85, 0.9, 0, .5];};
		case (_x >= 0.30):{_selectedBar ctrlSetTextColor [0.9, 0.7, 0, .5];};
		case (_x >= 0):{_selectedBar ctrlSetTextColor [1, 0, 0, .5];};
	};
} foreach [(1 - (oev_carryWeight/oev_maxWeight)),(oev_thirst / 100),(oev_hunger / 100),(1 - (damage player))];

if(((O_stats_crimes select 0) > 0) && playerside isEqualTo civilian) then {
	_bountyBar progressSetPosition (100);
	if((player getVariable["isInEvent",["no"]]) select 0 != "no") then {
		_bountyBar ctrlSetTextColor [1, 0.8, 0, 0.5];
		_bountyText ctrlSetText "在事件中";
	}else{
		_bountyBar ctrlSetTextColor [1, 0, 0, .5];
		_bountyText ctrlSetText format["%1k", round((O_stats_crimes select 0)/1000)];
	};
} else {
	_bountyBar progressSetPosition (100);

	if((player getVariable["isInEvent",["no"]]) select 0 != "no") then {
		_bountyBar ctrlSetTextColor [1, 0.8, 0, 0.5];
		_bountyText ctrlSetText "在活动中";
	}else{
		_bountyBar ctrlSetTextColor [0, 1, 0, .5];
		if(playerside isEqualTo civilian) then {
			_bountyText ctrlSetText "合法公民";
		}else{
			_bountyText ctrlSetText "值班";
		};
	};
};

if(call life_adminlevel > 0 || call oev_developerlevel > 0) then {
	if (oev_godmode) then {
		_adminGod ctrlSetStructuredText parseText"<t align='right' color='#00FF00'>无敌模式开启</t>";
	} else {
		_adminGod ctrlSetText "";
	};
	if (player getVariable ["invis", false]) then {
		_adminInvis ctrlSetStructuredText parseText"<t align='right' color='#00FF00'>Invis ON</t>";
	} else {
		_adminInvis ctrlSetText "";
	};
	if (oev_eventESP) then {
		_adminESP ctrlSetStructuredText parseText"<t align='right' color='#00FF00'>ESP ON</t>";
	} else {
		_adminESP ctrlSetText "";
	};
	if (player getVariable ["superTaze", false]) then {
		_adminStase ctrlSetStructuredText parseText"<t align='right' color='#00FF00'>STase ON</t>";
	} else {
		_adminStase ctrlSetText "";
	};
	if (oev_streamerMode) then {
		_adminStream ctrlSetStructuredText parseText"<t align='right' color='#00FF00'>Streamer ON</t>";
	} else {
		_adminStream ctrlSetText "";
	};
	if (player getVariable["fly",false]) then {
		_adminFly ctrlSetStructuredText parseText"<t align='right' color='#00FF00'>Fly ON</t>";
	} else {
		_adminFly ctrlSetText "";
	};
};

profileNamespace setVariable["oev_thirst",oev_thirst];
profileNamespace setVariable["oev_hunger",oev_hunger];
profileNamespace setVariable["life_playerDamage",getDammage player];

{
	_x ctrlCommit 0;
}foreach [_foodText,_foodBar,_waterText,_waterBar,_healthText,_healthBar,_bountyText,_bountyBar,_weightText,_weightBar,_iconEarplugs];
