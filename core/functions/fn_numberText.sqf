//	Author: Karel Moricky
//	Description: Convert a number into string (avoiding scientific notation)
// 	File: fn_numberText.sqf
//	Parameter(s):
//	_this: NUMBER

//	Returns:
//	STRING

private ["_number","_mod","_digots","_digitsCount","_modBase","_numberText"];

_number = param [0,0,[0]];
_mod = param [1,3,[0]];

_digits = _number call bis_fnc_numberDigits;
_digitsCount = count _digits - 1;

_modBase = _digitsCount % _mod;
_numberText = "";
{
	_numberText = _numberText + str _x;
	if ((_foreachindex - _modBase) % (_mod) == 0 && _foreachindex != _digitsCount) then {_numberText = _numberText + ",";};
} foreach _digits;
_numberText