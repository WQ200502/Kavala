//  File: fn_gpsEnhanced.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Group based GPS tracking unit.

params [
	["_target",objNull,[objNull]]
];
private _tooFar = false;
if (isNull _target) exitWith {};
if !(_target isKindOf "AllVehicles") exitWith {hint "You cannot add a GPS tracker to this."};
if (_target isKindOf "Man") exitWith {hint "You cannot add a GPS tracker to a person!"};
//Adjusted for blackfish vehicles
if (((typeOf _target) isEqualTo "B_T_VTOL_01_infantry_F") || ((typeOf _target) isEqualTo "B_T_VTOL_01_vehicle_F")) then {
	if (player distance _target > 15) exitWith {_tooFar = true;};
} else {
	if (player distance _target > 7) exitWith {_tooFar = true;};
};
if (_tooFar) exitWith {hint "You need to be close the the vehicle!";};
if (playerSide isEqualTo independent) exitWith {hint "This item is currently only able to be used by civilans and the APD!";};
if (!(((_target getVariable ["etracking",[]]) find (group player)) isEqualTo -1) && {playerSide isEqualTo civilian}) exitWith {hint "Your gang is already tracking this vehicle!";};
if (!(((_target getVariable ["etracking",[]]) find (group player)) isEqualTo -1) && {playerSide isEqualTo west}) exitWith {hint "The APD is already tracking this vehicle!";};
if (life_inv_egpstracker isEqualTo 0) exitWith {};
if (oev_action_inUse) exitWith {};

private _exit = false;
private _vehicles = [];
if (playerSide isEqualTo west) then {
	_vehicles = vehicles select {!(((_x getVariable ["etracking",[]]) find (group player)) isEqualTo -1)};
	if (count _vehicles >= 3) then {_exit = true;};
};
if (_exit) exitWith {hint "The APD may only track up to 3 vehicles as a group!";};


oev_action_inUse = true;
_upp = "Installing GPS";
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_cP = 0;
_exit = false;

["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;

while {true} do {
	uiSleep 0.3;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if (_cP >= 1) exitWith {};
	if!(alive player) exitWith {_exit = true;};
	if (player != vehicle player) exitWith {_exit = true;};
	if (oev_interrupted) exitWith {_exit = true;oev_interrupted = false;};
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

if (playerSide isEqualTo west) then {
	uiSleep random(3);
	uiSleep random(3);
	_vehicles = vehicles select {!(((_x getVariable ["etracking",[]]) find (group player)) isEqualTo -1)};
	if (count _vehicles >= 3) then {_exit = true;};
};
if (_exit) exitWith {hint "The APD may only track up to 3 vehicles as a group!";};

if !([false,"egpstracker",1] call OEC_fnc_handleInv) exitWith {hint "You do not have a Enhanced GPS Tracker";};

if (playerSide isEqualTo civilian && {((count units (group player)) < 2)}) then {
	oev_tracked_vehicles pushBack _target;
	_target setVariable ["tracking",true,true];
	hint "You have attached an enhanced tracking device to this vehicle. You are currently in a group with no members, the tracker will transfer to the group when you obtain additional members!";

	[_target] spawn{
		private _object = _this select 0;
		waitUntil {uiSleep 2; isNull _object || !(_object getVariable ["tracking",false]) || !(alive _object) || ((count units group player) > 1)};
		oev_tracked_vehicles deleteAt (oev_tracked_vehicles find _object);
		if ((count units group player) > 1) then {
			private _group = _object getVariable ["etracking",[]];
			private _isNew = -2;

			_isNew = _group pushBackUnique (group player);
			if !(_isNew isEqualTo -1) then {
				_object setVariable ["etracking",_group,true];
				titleText ["Your enhanced tracking device has changed ownership to your group!","PLAIN DOWN"];
			};
		};
	};
} else {
	private _group = _target getVariable ["etracking",[]];
	private _isNew = -2;

	_isNew = _group pushBackUnique (group player);

	if !(_isNew isEqualTo -1) then {
		_target setVariable ["etracking",_group,true];
		titleText["You have attached an enhanced tracking device to this vehicle.","PLAIN DOWN"];
	} else {
		hint "Your group is already tracking this vehicle!";
		[true,"egpstracker",1] call OEC_fnc_handleInv;
	};
};
