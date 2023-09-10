//  File: fn_warGetStats.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Takes war menu selection and displays the stats for that war
disableSerialization;
if ((lbCurSel 37202) isEqualTo -1) exitWith {hint "You didn't select a war from the list!";};
private _control = ((findDisplay 37200) displayCtrl 37202);
private _gangID = _control lbValue (lbCurSel _control);
private _gangName = "";
private _myGangName = oev_gang_data select 1;
private _myGangID = oev_gang_data select 0;

closeDialog 0;
if (oev_action_inUse) exitWith {};

{
	if ((_x select 0) isEqualTo _gangID) exitWith {_gangName = (_x select 1);};
} forEach oev_gang_activeWars;
if (_gangName isEqualTo "") exitWith {hint "Unable to find an active gang with that name. Try again.";};

life_gang_warData = [];
life_gang_warReady = false;

oev_action_inUse = true;
[[0,player,_gangID,_myGangID],"OES_fnc_warGetData",false,false] spawn OEC_fnc_MP;
waitUntil {life_gang_warReady || !alive player};
oev_action_inUse = false;
if !(alive player) exitWith {life_gang_warReady = nil; life_gang_warData = nil;};

['yMenuGangWarStats'] call OEC_fnc_createDialog;
private _display = findDisplay 37300;
private _aKills = 0;
private _aDeaths = 0;
private _eKills = 0;
private _eDeaths = 0;
private _dateDiff = (life_gang_warData select 6);

if ((life_gang_warData select 0) isEqualTo _myGangID) then {
	_aKills = life_gang_warData select 1;
	_aDeaths = life_gang_warData select 2;
	_eKills = life_gang_warData select 4;
	_eDeaths = life_gang_warData select 5;
} else {
	_aKills = life_gang_warData select 4;
	_aDeaths = life_gang_warData select 5;
	_eKills = life_gang_warData select 1;
	_eDeaths = life_gang_warData select 2;
};

(_display displayCtrl 37301) ctrlSetText format ["%1 vs %2",_gangName,_myGangName];
(_display displayCtrl 37302) ctrlSetText format ["Ally Kills: %1",[_aKills] call OEC_fnc_numberText];
(_display displayCtrl 37303) ctrlSetText format ["Ally Deaths: %1",[_aDeaths] call OEC_fnc_numberText];
(_display displayCtrl 37304) ctrlSetText format ["Enemy Kills: %1",[_eKills] call OEC_fnc_numberText];
(_display displayCtrl 37305) ctrlSetText format ["Enemy Deaths: %1",[_eDeaths] call OEC_fnc_numberText];
(_display displayCtrl 37306) ctrlSetText format ["Active for %1 days.",[_dateDiff] call OEC_fnc_numberText];

life_gang_warData = nil;
life_gang_warReady = nil;