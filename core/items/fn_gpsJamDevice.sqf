//  File: fn_gpsJamDevice.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Removes GPS from a vehicle.

params [
	["_target",objNull,[objNull]]
];

if (isNull _target) exitWith {};
if (player distance _target > 7) exitWith {hint "You need to be close the the vehicle!";};
if !(_target isKindOf "AllVehicles") exitWith {hint "GPS Jammers can only be placed on vehicles. Make sure you're looking towards the center of the vehicle for best results.";};
if (_target isKindOf "Man") exitWith {hint "We have not gone in to the human trafficking business just yet...";};
if !(_target in oev_vehicles) exitWith {hint "You need keys to this vehicle before you can jam the GPS!";};
if !(playerSide isEqualTo civilian) exitWith {[false,"gpsjammer",life_inv_gpsjammer] call OEC_fnc_handleInv; hint "Only civilians can use GPS Jammers!";};
if (life_inv_gpsjammer isEqualTo 0) exitWith {};
if (oev_action_inUse) exitWith {hint "You are already performing another action!"};

oev_action_inUse = true;
_upp = "Jamming GPS";
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_cP = 0;

private _exit = false;
["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
while {true} do {
	uiSleep 0.32;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if (_cP >= 1) exitWith {};
	if!(alive player) exitWith {_exit = true;};
	if (player != vehicle player) exitWith {_exit = true;};
	if (oev_interrupted) exitWith {_exit = true; oev_interrupted = false;};
	if (player distance _target > 7) exitWith {_exit = true; hint "You need to be close the the vehicle!";};
};

oev_action_inUse = false;
5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
if (_exit) exitWith {};

if !([false,"gpsjammer",1] call OEC_fnc_handleInv) exitWith {};

if (_target getVariable ["tracking",false]) then {
	_target setVariable ["tracking",false,true];
};

if !(isNil {_target getVariable "etracking"}) then {
	_target setVariable ["etracking",[],true];
};

if (_target getVariable ["baited",false]) then {
	_target setVariable ["baited",false,true];
};
titleText ["You've jammed this vehicles GPS unit.","PLAIN DOWN"];