//  File: fn_vehicleAmmo.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Refills vehicles ammo.

private ["_vehicle","_vehicleClass","_vehicleName","_role","_exit","_upp","_ui","_progress","_pgText","_cP","_role2"];
if (isNull objectParent player) exitWith {hint "You can only reload the ammunition from inside the vehicle.";};
_vehicle = vehicle player;
_vehicleClass = typeOf (_vehicle);
_vehicleName = getText(configFile >> "CfgVehicles" >> _vehicleClass >> "displayName");

if !(_vehicleClass in ["B_G_Offroad_01_armed_F","I_G_Offroad_01_armed_F","O_T_LSV_02_armed_F","B_T_LSV_01_armed_F","B_Heli_Transport_03_black_F","B_Heli_Transport_01_F","I_C_Offroad_02_LMG_F","B_Heli_Transport_01_camo_F","I_G_Offroad_01_AT_F","O_MRAP_02_F","I_MRAP_03_F","B_Heli_Transport_03_F"]) exitWith {hint "You can't refill this vehicles ammunition."};
if (playerSide isEqualTo independent) exitWith {hint "Hell no. Armed Medical hawks... You're sick.";};
if (oev_action_inUse) exitWith {hint "You're already performing another action!";};
if (life_inv_vehAmmo isEqualTo 0) exitWith {};
_role = ((assignedVehicleRole (_vehicle)) select 0);
_exit = false;

switch (true) do {
	case (_vehicleClass isEqualTo "O_MRAP_02_F"): {
		if !(_role isEqualTo "driver" && (driver (_vehicle)) isEqualTo player) exitWith {_exit = true; hint "You must be in the driver seat to refill the smokes!";};
	};
	case (_vehicleClass isEqualTo "I_MRAP_03_F"): {
		if !(_role isEqualTo "Turret") exitWith {_exit = true; hint "You must be in the commander seat to refill the smokes!";};
	};
	case (_vehicleClass in ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F","B_Heli_Transport_03_F","B_Heli_Transport_03_black_F"]): {
		if !(player call OEC_fnc_isUnitGunner || (_role isEqualTo "driver" && (driver (_vehicle)) isEqualTo player)) exitWith {_exit = true; hint "You must be in a turret or pilot seat to rearm the vehicle!";};
		if !(isAutoHoverOn _vehicle || {(_vehicle turretUnit [-1]) isEqualTo objNull && (_vehicle turretUnit [0]) isEqualTo objNull}) exitWith {_exit = true; hint "You must be autohovered or the pilot must exit to rearm the vehicle!";};
	};
	default {
		if !(_role isEqualTo "Turret") exitWith {_exit = true; hint "You must be in a turret position to reload the turret!";};
		if (player call OEC_fnc_isUnitCopilot) exitWith {_exit = true; hint "You cannot refill the guns from the copilot seat!";};
	};
};
if (_exit) exitWith {};

oev_interrupted = false;
oev_action_inUse = true;

_upp = format ["Rearming %1",_vehicleName];
disableSerialization;
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_cP = 0;

_exit = false;
_role2 = "";
while {!_exit} do {
	uiSleep 0.09;
	_cP = _cP + 0.005;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if (_cP >= 1) exitWith {};
	_role2 = ((assignedVehicleRole (vehicle player)) select 0);
	if !(_role2 isEqualTo _role) exitWith {_exit = true; hint "You must remain seated to rearm the vehicle!";};
	if !(alive player) exitWith {_exit = true;};
	if (isNull objectParent player) exitWith {_exit = true; hint "You must reload the ammunition from inside the vehicle!";};
	if (oev_interrupted) exitWith {_exit = true; oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
	if (life_inv_vehAmmo isEqualTo 0) exitWith {_exit = true;};
	if (_vehicleClass in ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F","B_Heli_Transport_03_F","B_Heli_Transport_03_black_F"]) then {
		if !(isAutoHoverOn _vehicle || {(_vehicle turretUnit [-1]) isEqualTo objNull && (_vehicle turretUnit [0]) isEqualTo objNull}) exitWith {_exit = true; hint "You must be autohovered or the pilot must exit to rearm the vehicle!";};
	};
};

oev_action_inUse = false;
5 cutText ["","PLAIN DOWN"];
player playActionNow "stop";
if (_exit) exitWith {};

if !([false,"vehAmmo",1] call OEC_fnc_handleInv) exitWith {};
_vehicle setVehicleAmmo 1;
hint format ["The %1 has been rearmed!",_vehicleName];
