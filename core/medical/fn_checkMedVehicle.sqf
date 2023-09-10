//  File: fn_checkMedVehicle.sqf
// 	Author: TheCmdrRex
//	Description: Checks if medics are in turrent or gunner position in non-whitelisted vehicles

if !(playerSide isEqualTo independent) exitWith {};
if !(((player getvariable ["isInEvent",["no"]]) select 0) == "no") exitWith {};
if (player getVariable["restrained", false]) exitWith {};

private ["_armedVehicles","_role","_copilot"];

//	Whitelisted vehicles
_armedVehicles = [
	"B_G_Offroad_01_armed_F",			// .50 Cal Offroad
	"I_G_Offroad_01_armed_F",			// .50 Cal Offroad w/ shield
	"O_T_LSV_02_armed_F",					// Quilin Minigun
	"B_T_LSV_01_armed_F",					// .50 Cal Prowler
	"B_Heli_Transport_03_black_F",		// Armed Huron
	"O_LSV_02_armed_F",						// Pharma Quilin Minigun
	"B_Heli_Transport_01_camo_F",		// Civilian Ghosthawk
	"I_G_Offroad_01_AT_F",				// AT Offroad
	"I_C_Offroad_02_LMG_F"				// Jeep LMG
];


// 				Series of Checks
//************************************************
	// Is Vehicle Armed?
if !(typeOf (vehicle player) in _armedVehicles) exitWith {};
	// Is medic in turret? (This happens to false execute on occasion - reason why the script was flipped)
_role = ((assignedVehicleRole (vehicle player)) select 0);
if !(_role isEqualTo "Turret") exitWith {};
	// Is medic in the copilot seat? (Copilot is considered Turret position in Arma)
_copilot = player call OEC_fnc_isUnitCopilot;
if (_copilot) exitWith {};
//************************************************

// Checks are passed, they are in a turrent position
player action ["getOut", vehicle player];
hint "Medics are not allowed on turret postions!";
