//  File: fn_gpsTracker.sqf
//	Author: Unknown
//	Modified: Jesse "tkcjesse" Schultz
//	Description: Attaches a gps tracker to selected vehicle.

params [
	["_target",objNull,[objNull]]
];
private _tooFar = false;
if (isNull _target) exitWith {};
if !(_target isKindOf "AllVehicles") exitWith {hint "You cannot add a GPS tracker to this."};
if (_target isKindOf "Man") exitWith {hint "You cannot add a GPS tracker to a person!"};
//Adjust distance check for blackfish vehicles
if (((typeOf _target) isEqualTo "B_T_VTOL_01_infantry_F") || ((typeOf _target) isEqualTo "B_T_VTOL_01_vehicle_F")) then {
	if (player distance _target > 15) exitWith {_tooFar = true;};
} else {
	if (player distance _target > 7) exitWith {_tooFar = true;};
};

if (_target in oev_tracked_vehicles) exitWith {hint "You already have a tracker on this vehicle!";};
if (life_inv_gpstracker isEqualTo 0) exitWith {};
if (oev_action_inUse) exitWith {};

oev_action_inUse = true;
_upp = "Installing GPS tracker";
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
	uiSleep 0.17;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if (_cP >= 1) exitWith {};
	if!(alive player) exitWith {_exit = true;};
	if (player != vehicle player) exitWith {_exit = true;};
	if (oev_interrupted) exitWith {_exit = true; oev_interrupted = false;};
	if (((typeOf _target) isEqualTo "B_T_VTOL_01_infantry_F") || ((typeOf _target) isEqualTo "B_T_VTOL_01_vehicle_F")) then {
		if (player distance _target > 15) exitWith {hint "You need to be close the the vehicle!";_exit=true;};
	} else {
		if (player distance _target > 7) exitWith {hint "You need to be close the the vehicle!";_exit=true;};
	};
};

[] spawn OEC_fnc_handleAnim;

5 cutText ["","PLAIN DOWN"];
oev_action_inUse = false;
if (_exit) exitWith {};

if !([false,"gpstracker",1] call OEC_fnc_handleInv) exitWith {hint "You do not have a GPS Tracker";};
[_target] call OEC_fnc_installTracker;
