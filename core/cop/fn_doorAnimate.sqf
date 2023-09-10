//  File: fn_doorAnimate.sqf

params [
	["_building",objNull,[objNull]]
];
closeDialog 0;
if (isNull _building) exitWith {};
if !(playerSide isEqualTo west) exitWith {};

private _exit = false;

if (player distance (getMarkerPos "fed_reserve_1") < 65) then {
	if (typeOf _building isEqualTo "Land_Dome_Big_F") then {
		if (fed_bank getVariable ["chargeplaced",false]) exitWith {_exit = true; hint "You must defuse the bomb before opening or closing the doors!";};
		if (fed_bank getVariable ["safe_open",false]) exitWith {_exit = true; hint "You must repair the safe before locking the facility!";};
	};

	if (typeOf _building isEqualTo "Land_Research_house_V1_F") then {
		if (fed_bank getVariable ["chargeplaced",false]) exitWith {_exit = true; hint "You must defuse the bomb before opening or closing the doors!";};
		if (fed_bank getVariable ["safe_open",false]) exitWith {_exit = true; hint "You must repair the safe before locking the facility!";};
	};
};

if (player distance (getMarkerPos "bw_marker") < 65) then {
	if (typeOf _building isEqualTo "Land_Dome_Big_F") then {
		if (_building getVariable ["chargeplaced",false]) exitWith {_exit = true; hint "You must defuse the bomb before opening or closing the doors!";};
		if (_building getVariable ["safe_open",false]) exitWith {_exit = true; hint "You must repair the door before messing with the doors!";};
	};
};

if (_exit) exitWith {};

private _doors = 1;
_doors = getNumber(configFile >> "CfgVehicles" >> (typeOf _building) >> "NumberOfDoors");

private _door = 0;
//Find the nearest door
for "_i" from 1 to _doors do {
	_selPos = _building selectionPosition format["Door_%1_trigger",_i];
	_worldSpace = _building modelToWorld _selPos;
		if (player distance _worldSpace < 5) exitWith {_door = _i;};
};
if (_door isEqualTo 0) exitWith {hint localize "STR_Cop_NotaDoor"}; //Not near a door to be broken into.

if (((typeOf _building) isEqualTo "Land_Dome_Big_F") && {(player distance (getMarkerPos "bw_marker") < 65)}) then {
	if ((_building getVariable "bis_disabled_Door_1") isEqualTo 1) then {
		for "_i" from 1 to 3 do {_building setVariable[format["bis_disabled_Door_%1",_i],0,true]; _building animate [format["Door_%1_rot",_i],1];};
	} else {
		for "_i" from 1 to 3 do {_building setVariable[format["bis_disabled_Door_%1",_i],1,true]; _building animate [format["Door_%1_rot",_i],0];};
	};
} else {
	if (_building animationPhase format["door_%1_rot",_door] isEqualTo 0) then {
		_building animate[format["door_%1_rot",_door],1];
	} else {
		_building animate[format["door_%1_rot",_door],0];
	};
};