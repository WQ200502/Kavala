//  File: fn_splitPay.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Modifications: TheCmdrRex
//	Description: Splits payout of cop related instances to nearby players.

params [
	["_officer",objNull,[objNull]],
	["_value",0,[0]],
	["_percent",0,[0]],
	["_distance",0,[0]],
	["_isContraband",false,[false]],
	["_isLethal",false,[false]],
	["_isHawk",false,[false]]
];
if (isNull _officer) exitWith {};

private _officers = [];
private _payout = 0;
if (_isHawk) then {
	if (count fullcrew vehicle player <= 0) exitWith {}; // nobody in vehicle to split pay with
	{
		if (side _x isEqualTo west && {_x distance _officer < _distance} && ((assignedVehicleRole _x select 0) == "driver") && (vehicle player == vehicle _x)) then {_officers pushBack _x;};
	} forEach playableUnits;
} else {
	{
		if (side _x isEqualTo west && {_x distance _officer < _distance}) then {_officers pushBack _x;};
	} forEach playableUnits;
};

_payout = ceil(_value * _percent);

if (_isLethal) then {
	_officers deleteAt (_officers find _officer);
};

if !(count _officers isEqualTo 0) then {
	_payout = ceil(_payout / count _officers);
} else {
	_payout = 0;
};

{
	[[5,_payout,name _officer,_isContraband],"OEC_fnc_payPlayer",_x,false] spawn OEC_fnc_MP;
} forEach _officers;
