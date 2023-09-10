//  File: fn_baitCar.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Attaches bait car appliance to a vehicle

params [
	["_target",objNull,[objNull]]
];

if (isNull _target) exitWith {};
if !((_target getVariable ["side",""]) == "cop") exitWith {hint "You can only add bait appliances to cop cars.";};
if !(_target isKindOf "AllVehicles") exitWith {hint "You cannot add a bait car appliance to this."};
if (_target getVariable ["isBlackwater",false]) exitWith {hint "Nice try.";};
if (_target isKindOf "Air") exitWith {hint "You cannot add a bait car appliance to helicopters.";};
if (_target isKindOf "Man") exitWith {hint "You cannot add a bait car appliance to a person!"};
if (player distance _target > 7) exitWith {hint "You need to be close the the vehicle!"};
if !(playerSide isEqualTo west) exitWith {hint "This item is currently only able to be used by the APD!";};
if (!(((_target getVariable ["etracking",[]]) find (group player)) isEqualTo -1) && {playerSide isEqualTo west}) exitWith {hint "The APD is already tracking this vehicle!";};
if (life_inv_baitcar isEqualTo 0) exitWith {hint "You do not have a bait car appliance";};
if (oev_action_inUse) exitWith {};
if (oev_bait_active) exitWith {hint "You can only have one active bait car at a time.";};

private _exit = false;
private _vehicles = [];
if (playerSide isEqualTo west) then {
	_vehicles = vehicles select {!(((_x getVariable ["etracking",[]]) find (group player)) isEqualTo -1)};
	if (count _vehicles >= 3) then {_exit = true;};
};
if (_exit) exitWith {hint "The APD may only track up to 3 vehicles as a group!";};

oev_action_inUse = true;
private _upp = "Installing Bait Appliance";
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
private _ui = uiNameSpace getVariable "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
private _cP = 0;
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
	if (player distance _target > 7) exitWith {_exit = true; hint "You need to be close the the vehicle!";};
};

[] spawn OEC_fnc_handleAnim;

5 cutText ["","PLAIN DOWN"];
oev_action_inUse = false;
if (_exit) exitWith {};

_exit = false;
private _group = _target getVariable ["etracking",[]];
private _isNew = -2;

_isNew = _group pushBackUnique (group player);

if !(_isNew isEqualTo -1) then {
	if !([false,"baitcar",1] call OEC_fnc_handleInv) exitWith {hint "You do not have a bait car appliance"; _exit = true;};
	if !([true, "bcremote", 1] call OEC_fnc_handleInv) exitWith {
		hint "You somehow don't have inventory space for the bait car remote!";
		_exit = true;
	};
	_target setVariable ["etracking",_group,true];
	_target setVariable ["baited",true,true];
	titleText["You have attached a bait car appliance to this vehicle.","PLAIN DOWN"];
} else {
	hint "This car is already being tracked or has a bait car appliance attached already.";
	_exit = true;
};
if (_exit) exitWith {};

_obj_main = player;
oev_bait_carObj = _target;
oev_bait_carObj addEventHandler ["Deleted", {
	params ["_carObj"];
	if (_carObj != oev_bait_carObj) exitWith {};
	[false, "bcremote", 1] call OEC_fnc_handleInv;
	oev_bait_carObj = objNull;
	oev_bait_active = false;
	oev_bait_actions = [false, false];
}];
"baited" addPublicVariableEventHandler [oev_bait_carObj, {
	private _baited = param [1, false, [false]];
	if (!_baited) then {
		[false, "bcremote", 1] call OEC_fnc_handleInv;
		oev_bait_carObj = objNull;
		oev_bait_active = false;
		oev_bait_actions = [false, false];
	};
}];
oev_bait_active = true;
