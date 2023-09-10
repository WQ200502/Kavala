#include "..\..\macro.h"
//  File: fn_adminVehComp.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Compensates a vehicle to a player from admin island

if ((__GETC__(life_adminlevel) < 3) && (__GETC__(oev_developerlevel) < 3)) exitWith {hint "You are not approved for vehicle compensation yet. Contact a senior admin or developer.";};

if (!dialog) then {["life_admin_vehComp"] call OEC_fnc_createDialog;};
disableSerialization;

private _display = (findDisplay (100220));
private _confirmBtn = _display displayCtrl 100223;
private _vehicleList = _display displayCtrl 100222;

private _vehicleClassnames = [
	"O_T_LSV_02_armed_F",
	"B_T_LSV_01_armed_F",
	"I_MRAP_03_F",
	"B_MRAP_01_F",
	"O_MRAP_02_F",
	"O_LSV_02_unarmed_viper_F",
	"I_C_Offroad_02_LMG_F",
	"I_G_Offroad_01_AT_F",
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

{
	_name = getText (configFile >> "cfgVehicles" >> _x >> "displayName");

	_vehicleList lbAdd _name;
	_vehicleList lbSetData [(lbSize _vehicleList)-1, _x];
} forEach _vehicleClassnames;

_confirmBtn buttonSetAction "[lbData[100222,lbCurSel(100222)],ctrlText 100221] call OEC_fnc_adminVehValidate;";
