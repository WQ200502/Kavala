//  File: fn_gangBldgOwnership.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Based off fn_houseOwnership - Assigns keys & inventory and stuff.

params [
	["_building",objNull,[objNull]],
	["_classname","",[""]]
];
if (isNull _building || _classname isEqualTo "") exitWith {};
if !(_classname isEqualTo "Land_i_Shed_Ind_F") exitWith {};

private _exit = false;
private _buildingPos = getPosATL _building;
private _nearBldgs = nearestObjects [_buildingPos,["House_F"],10];
if ((count _nearBldgs) > 0) then {
	if !(typeOf (_nearBldgs select 0) isEqualTo "Land_i_Shed_Ind_F") then {
		_exit = true;
	};
};

if (_exit) exitWith {
	hint "Something terrible has happened with this purchase! Please report it to an admin or developer! Error: JS1";
	diag_log format ["Error JS1: %1 - %2 - %3 - %4",_building,_classname,_nearBldgs,_buildingPos];
	oev_houseTransaction = false;
	oev_action_inUse = false;
};

_numOfDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _building) >> "numberOfDoors");
for "_i" from 1 to _numOfDoors do {
	_building setVariable[format["bis_disabled_Door_%1",_i],1,true];
};

oev_houseTransaction = false;
oev_action_inUse = false;

[
	["event","Purchased Gang Shed"],
	["player",name player],
	["player_id",getPlayerUID player],
	["value",20000000],
	["position",getPosATL player]
] call OEC_fnc_logIt;


hint "Purchase request accepted, here's the keys.";

private _onlineMembers = ([(oev_gang_data select 0)] call OEC_fnc_getOnlineMembers);
if ((count _onlineMembers) > 0) then {
	[[_building,1],"OEC_fnc_gangBldgMembers",_onlineMembers,false] spawn OEC_fnc_MP;
};
