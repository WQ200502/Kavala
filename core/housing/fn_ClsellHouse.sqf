#include "..\..\macro.h"
//	Author: Bryan "Tonic" Boardwine
//	Description: Start of house selling process. The actual money transfer occurs in houseOwnership.sqf

params [
	["_house",objNull,[objNull]]
];

if (oev_houseTransaction) exitWith {hint "You currently have an active transaction, please wait.";};
if (isNull _house) exitWith {};
if !(_house isKindOf "House_F") exitWith {};
if (isNil {_house getVariable "house_owner"}) exitWith {hint "There is no owner for this house."};
closeDialog 0;

private _houseCfg = [(typeOf _house)] call OEC_fnc_houseConfig;
if (count _houseCfg isEqualTo 0) exitWith {};

private _action = [
	format[localize "STR_House_SellHouseMSG",
	(round((_houseCfg select 0)/2)) call OEC_fnc_numberText,
	(_houseCfg select 1)],localize "STR_pInAct_SellHouse",localize "STR_Global_Sell",localize "STR_Global_Cancel"
] call BIS_fnc_guiMessage;

if (_action) then {
	if (oev_houseTransaction) exitWith {hint "You currently have an active transaction, please wait.";};
	if (oev_lastSoldHouse isEqualTo _house) exitWith {
		hint "You cannot sell the same house multiple times! This is considered exploiting!";
		[
			["event","House Sell Exploit"],
			["player",name player],
			["player_id",getPlayerUID player],
			["position",getPosATL player]
		] call OEC_fnc_logIt;

	};

	oev_lastSoldHouse = _house;
	oev_houseTransaction = true;
	oev_action_inUse = true;
	_keyPlayers = _house getVariable["keyPlayers",[]];
	{
		if((getPlayerUID _x) in _keyPlayers) then {
			_keyPlayer = call compile format["%1", _x];
			[2,[_house, format["%1",(_house getVariable "uid")], [], (player getVariable["realname",name player])]] remoteExecCall ["OEC_fnc_manageHouseMarkers", _keyPlayer, false];
		};
	} forEach playableUnits;
	_house setVariable ["house_sold",true,true];
	[_house,player] remoteExec ["OES_fnc_sellHouse",2];
	hint "Sending sell request to realtor...";
};
