//	Author: Jiri Wainar
//	Modified by: Poseidon
//	This file is not to be used outside of Olympus servers.
//	Description: Displays the intro to the server and checks mod pack after.
private["_unit","_anims","_anim","_available","_time","_linkedUnits","_linkedAnims","_xTime","_interpolate"];
_unit = param[0, objNull, [objNull]];

if (isNull _this) exitWith {};
if !(alive _this && canMove _this) exitWith {};

_anims 	= _unit getVariable ["BIS_fnc_ambientAnim__anims",[]];

if (count _anims == 0) exitWith {
	//["Unit '%1' doesn't have defined ambient anims!",_unit,_anims] call BIS_fnc_logFormat;
};

_linkedUnits = _unit getVariable ["BIS_fnc_ambientAnim__linked",[]];
_interpolate = _unit getVariable ["BIS_fnc_ambientAnim__interpolate",false];
_linkedAnims = [];
_time = time - 10;

{
	_xTime = _x getVariable ["BIS_fnc_ambientAnim__time",_time];

	if (_xTime > _time) then {
		_linkedAnims pushBack (animationState _x);
	};
}
forEach _linkedUnits;

_available = _anims - _linkedAnims;

if (count _available == 0) then {
	//["Unit '%1' doesn't have an available/free animation to play",_unit] call BIS_fnc_logFormat;

	_available = _anims;
};

_anim = _available call BIS_fnc_selectRandom;

if (_interpolate) then {
	_unit playMoveNow _anim;
} else {
	_unit switchMove _anim;
};



