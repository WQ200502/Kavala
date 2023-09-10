#include "..\..\macro.h"
//  File: fn_adminVehValidate.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Compensates a vehicle to a player from admin island

if ((__GETC__(life_adminlevel) < 3) && (__GETC__(oev_developerlevel) < 3)) exitWith {hint "You are not approved for vehicle compensation yet. Contact a senior admin or developer.";};
//if (((getPlayerUID player) isEqualTo _playerid) && !((getPlayerUID player) in ["76561198037151720","76561198239526280","76561198121004273"])) exitWith {hint "You cannot compensate a vehicle to your own garage.";};

params [
	["_classname","",[""]],
	["_playerid","",[""]]
];
if (_classname isEqualTo "" || _playerid isEqualTo "") exitWith {};

private _vehicleClassnames = [
	"I_C_Offroad_02_LMG_F",
	"I_G_Offroad_01_AT_F",
	"O_T_LSV_02_armed_F",
	"B_T_LSV_01_armed_F",
	"I_MRAP_03_F",
	"B_MRAP_01_F",
	"O_MRAP_02_F",
	"O_LSV_02_unarmed_viper_F",
	"B_LSV_01_unarmed_black_F",
	"B_G_Offroad_01_armed_F",
	"I_G_Offroad_01_armed_F",
	"B_G_Offroad_01_F",
	"B_Truck_01_box_F",
	"B_Truck_01_fuel_F",
	"B_Truck_01_transport_F",
	"C_Hatchback_01_sport_F",
	"C_Hatchback_01_F",
	"B_Heli_Light_01_F",
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_03_unarmed_F",
	"C_Heli_Light_01_civil_F",
	"B_Heli_Transport_03_black_F",
	"I_Heli_Transport_02_F",
	"I_Heli_light_03_unarmed_F",
	"O_Heli_Light_02_unarmed_F",
	"O_Heli_Transport_04_bench_F",
	"O_Heli_Transport_04_covered_F",
	"O_Heli_Transport_04_F",
	"O_Heli_Transport_04_fuel_F",
	"O_Truck_03_covered_F",
	"O_Truck_03_device_F",
	"O_Truck_03_fuel_F",
	"O_Truck_03_transport_F",
	"I_Truck_02_covered_F",
	"I_Truck_02_fuel_F",
	"I_Truck_02_transport_F",
	"C_Plane_Civil_01_F",
	"C_Plane_Civil_01_racing_F",
	"B_T_VTOL_01_vehicle_F",
	"B_T_VTOL_01_infantry_F",
	"O_Plane_CAS_02_F",
	"B_Plane_CAS_01_F",
	"I_Plane_Fighter_03_CAS_F",
	"C_Van_02_vehicle_F",
	"C_Van_02_transport_F",
	"B_Heli_Transport_01_camo_F",
	"I_Plane_Fighter_04_F",
	"B_Plane_Fighter_01_F",
	"O_Plane_Fighter_02_F"
];
if !(_classname in _vehicleClassnames) exitWith {};

private _characterByte = toArray _playerid;
private _length = count (_characterByte);
private _allowed = toArray ("0123456789");
private _badCharacter = false;

if !(_length isEqualTo 17) exitWith {hint "The user id you entered doesn't contain 17 digits!";};

{
	if (!(_x in _allowed)) exitWith {_badCharacter = true;};
} forEach _characterByte;
if (_badCharacter) exitWith {hint "The user id you entered has illegal characters in it!";};

private _steamValidate = _playerid select [0,7];
if !(_steamValidate isEqualTo "7656119") exitWith {hint "You have entered an invalid player id!";};

closeDialog 0;
[[_classname,_playerid,player],"OES_fnc_adminInsertVeh",false,false] spawn OEC_fnc_MP;
