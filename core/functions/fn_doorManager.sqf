//  File: fn_doorManager.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Locks/Unlocks all doors to a building.
//	1 - Locked
//	0 - Unlocked

params [
	["_building",objNull,[objNull]],
	["_mode",-1,[0]]
];
if (_mode isEqualTo -1 || isNull _building) exitWith {};

private _numOfDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _building) >> "numberOfDoors");
for "_i" from 1 to _numOfDoors do {
	_building setVariable[format["bis_disabled_Door_%1",_i],_mode,true];
};

if (_mode isEqualTo 0) then {
	systemChat "所有的建筑门都被解锁了。";
} else {
	systemChat "所有的建筑门都被上锁了。";
};