//  File: fn_pardon.sqf
//	Author: Bryan "Tonic" Boardwine
//	Modified by: Fusah
//	Description: Handles pardoning of individual charges and players.

private["_display","_list","_uid","_crime","_pName"];
disableSerialization;

_display = findDisplay 39000;
_list = _display displayCtrl 39004;
_data = lbData[39003,(lbCurSel 39003)];
_data = call compile format["%1", _data];
if(isNil "_data") exitWith {};
if(typeName _data != "ARRAY") exitWith {};
if(count _data == 0) exitWith {};
_pName = _data select 0;
_uid = _data select 1;

if ((lbCurSel 39004) == -1) then { //Check if player has a specific crime selected or not to see if a full pardon is needed or just a single charge removal
	private _action = [
	format ["你确定要赦免他们所有指控的%1吗？",(_data select 0)],
	"确定赦免",
	"是",
	"否"
	] call BIS_fnc_guiMessage;
	if !(_action) exitWith {};
	[1,format["%1 赦免了 %2", name player, (_data select 0)]] remoteExecCall ["OEC_fnc_broadcast",-2];
	[_uid] remoteExecCall ["OES_fnc_wantedPardon",2];
	["pardons",1] spawn OEC_fnc_statArrUp;
	[] spawn OEC_fnc_wantedMenu;
	[
		["event","Pardon"],
		["player_id",getPlayerUID player],
		["target_id",_uid],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
} else {
	_crime = _list lbData (lbCurSel 39004);
	if (_crime == "") exitWith {}; //spooky
	private _action = [
	format ["你确定要从%2的一次计数中赦免%1吗？",(_data select 0),_crime],
	"确认赦免",
	"是",
	"否"
	] call BIS_fnc_guiMessage;
	if !(_action) exitWith {};
	[1,format["%1已被%3从%2的一个计数中赦免。",_pName,_crime,name player]] remoteExec ["OEC_fnc_broadcast",west];
	[_uid,_pName,_crime] remoteExec ["OES_fnc_wantedRemoveCharge",2];
	[] spawn OEC_fnc_wantedMenu;
	[
		["event","Pardon Charge"],
		["player_id",getPlayerUID player],
		["target_id",_uid],
		["charge",_crime],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
};
