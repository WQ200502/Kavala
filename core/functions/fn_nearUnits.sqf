//  File: fn_nearUnits.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Checks for units near (human units)

//	Returns:
//	TRUE - Units are near
//	FALSE - No units near
params [
	["_faction",sideUnknown,[sideUnknown]],
	["_position",(getPos player),[[]]],
	["_radius",30,[0]]
];

private _ret = false;

//Error check
if(_faction isEqualTo sideUnknown) exitWith {_ret};

_ret ={_x != player && side _x == _faction && alive _x && _position distance _x < _radius} count playableUnits > 0;

_ret;