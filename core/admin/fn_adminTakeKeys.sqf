#include "..\..\macro.h"
//  File: fn_adminTakeKeys.sqf
//	Author: [OS] Odin

//	Description: Take keys for current target.
if(__GETC__(life_adminlevel) < 2) exitWith {hint "Insufficient Permissions";};
private["_curTarget","_isVehicle"];
_curTarget = cursorTarget;
_isVehicle = if((_curTarget isKindOf "LandVehicle") || (_curTarget isKindOf "Ship") || (_curTarget isKindOf "Air")) then {true} else {false};
if(_isVehicle && _curTarget in oev_vehicles) exitWith {hint localize "STR_ISTR_Lock_AlreadyHave"};

switch (true) do {
	_vehicleData = _curTarget getVariable["vehicle_info_owners",[]];
	_vehicleData pushBack [getPlayerUID player,player getVariable["realname",name player]];
	_curTarget setVariable["vehicle_info_owners",_vehicleData,true];
	oev_vehicles pushBack _curTarget;
	[
		["event", "ADMIN Get Keys"],
		["player", name player],
		["player_id", getPlayerUID player],
		["target", getText(configFile >> "CfgVehicles" >> (typeOf _curTarget) >> "displayName")],
		["position", getPos player]
	] call OEC_fnc_logIt;
};
