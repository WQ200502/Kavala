#include "..\..\macro.h"
//  File: fn_adminMenu.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Opens the admin menu, sorry nothing special in here. Take a look for yourself.

if(__GETC__(life_adminlevel) < 1) exitWith {closeDialog 0;};
private["_display","_list","_side","_vlist","_sortedPlayers","_type", "_col"];

disableSerialization;
waitUntil {!isNull (findDisplay 2900)};
_display = findDisplay 2900;
_list = _display displayCtrl 2902;
_vlist = _display displayCtrl 1501;
_zonelist = _display displayCtrl 1046;
if(__GETC__(life_adminlevel) < 1) exitWith {closeDialog 0;};
//Purge List
lbClear _list;
_type = "";
_sortedPlayers = [];
{
	if(alive _x) then {
		switch (side _x) do {
			case west: {_type = "Cop"; _col = [0.239,0.612,0.859,1]};
			case civilian: {_type = "Civ"; _col = [1,1,1,1]};
			case independent: {_type = "Med"; _col = [0.047,0.588,0.027,1]};
		};
		if (_x getVariable ["devlvl", 0] >= 2) then {_col = [0.2,0.7,0.6	,1]}; // Developer Color
		if (_x getVariable ["adminlvl", 0] > 0) then {_col = [0.9,0,0,1]}; // Admin Color
		if (_x distance2d (getMarkerPos "debug_island_marker") < 600) then {_col = [1,0.5,1,1];};
		_sortedPlayers pushBack [format["%1 (%2)",_x getVariable["realname",name _x], _type], _x, _col];
	};
} forEach playableUnits;

_sortedPlayers sort true;

{
	_list lbAdd (_x select 0);
	_list lbSetData [(lbSize _list)-1,str(_x select 1)];
	_list lbSetColor [(lbSize _list)-1,(_x select 2)];
} forEach _sortedPlayers;

if(__GETC__(life_adminlevel) < 1) exitWith {closeDialog 0;};

if(__GETC__(life_adminlevel) < 4) then {
	{
		ctrlEnable[_x,false];
		ctrlShow[_x,false];
	} forEach [1069,2989];
};

if(player getVariable["airdropEnabled",false] || getPlayerUID player in ["76561198045288873","76561198064919358","76561198068537683"]) then {
	ctrlEnable[1070,true];
	ctrlShow [1070, true];
} else {
	ctrlEnable[1070,false];
	ctrlShow [1070, false];
};

// conquest controls for admin+
if ((__GETC__(life_adminlevel) >= 3)) then {
	_zonelist lbAdd "Conquest Vote";
	_zonelist lbSetData [(lbSize _zonelist)-1, "-1"];
	{
		_zonelist lbAdd _x;
		_zonelist lbSetData [(lbSize _zonelist)-1, str(_forEachIndex)];
	} forEach ["Ghost Hotel","Nifi","Kavala","Syrta","Oreokastro","Warzone","Panagia","Sofia"];
	_zonelist lbSetCurSel 0;
};

if ((__GETC__(life_adminlevel) < 3) && (__GETC__(oev_developerlevel) < 2)) then {
	{
		ctrlEnable[_x,false];
		ctrlShow[_x,false];
	} forEach [1030,1031,1032,1033,1034,1035,1036];
};

lbClear _vlist;

//Hide all weather buttons, conquest buttons, and vehicle spawning if below admin.
if(__GETC__(life_adminlevel) < 3) then {
	_vlist lbAdd "";
	_vlist lbAdd "Vehicle Spawning Disabled";
	{
		ctrlEnable [_x, false];
		ctrlShow [_x, false];
	} forEach [1042,1043,1044,1045,1046,1052];
} else {
	private _waterVeh = [
		["Boat | Rescue Boat","B_Lifeboat"],
		["Boat | Motorboat","C_Boat_Civil_01_F"],
		["Boat | SDV","B_SDV_01_F"],
		["Boat | RHIB","C_Boat_Transport_02_F"],
		["Boat | Jetski","C_Scooter_Transport_01_F"],
		["Boat | Speedboat (Minigun)","B_T_Boat_Armed_01_minigun_F"]
	];

	private _landVeh = [
		["Kart | Random","C_Kart_01_F"],
		["Auto | Quadbike","B_Quadbike_01_F"],
		["Auto | Hatchback","C_Hatchback_01_F"],
		["Auto | Hatchback Sport","C_Hatchback_01_sport_F"],
		["Auto | SUV","C_SUV_01_F"],
		["Auto | Qilin","O_LSV_02_unarmed_viper_F"],
		["Auto | Prowler","B_LSV_01_unarmed_black_F"],
		["Auto | Prowler (AT)","B_T_LSV_01_AT_F"],
		["Auto | Prowler (HMG)","B_T_LSV_01_armed_CTRG_F"],
		["Auto | Offroad","B_T_LSV_01_armed_CTRG_F"],
		["Auto | Offroad (HMG)","B_G_Offroad_01_armed_F"],
		["Auto | Offroad (HMG+)","I_G_Offroad_01_armed_F"],
		["Auto | Offroad (AT)","B_G_Offroad_01_AT_F"],
		["Auto | 4WD Offroad","C_Offroad_02_unarmed_F"],
		["Auto | Boxer","C_Van_01_box_F"],
		["Auto | Fuel Truck","C_Van_01_fuel_F"],
		["Auto | Van Cargo", "B_G_Van_02_vehicle_F"],
		["Auto | Van Transport", "B_G_Van_02_transport_F"],
		["Truck | HEMTT Transport","B_Truck_01_transport_F"],
		["Truck | HEMTT Fuel","B_Truck_01_fuel_F"],
		["Truck | HEMTT Box","B_Truck_01_box_F"],
		["Truck | Tempest Transport","O_Truck_03_transport_F"],
		["Truck | Tempest Covered","O_Truck_03_covered_F"],
		["Truck | Tempest Fuel","O_Truck_03_fuel_F"],
		["Truck | Tempest Device","O_Truck_03_device_F"],
		["Truck | Zamak Transport","O_Truck_02_transport_F"],
		["Truck | Zamak Covered","O_Truck_02_covered_F"],
		["Truck | Zamak Fuel","I_Truck_02_fuel_F"],
		["Armored | Hunter","B_MRAP_01_F"],
		["Armored | Ifrit","O_MRAP_02_F"],
		["Armored | Strider","I_MRAP_03_F"],
		["Armored | Hunter (GMG)","B_MRAP_01_gmg_F"],
		["Armored | Hunter (HMG)","B_MRAP_01_hmg_F"],
		["Armored | Strider (HMG)","I_MRAP_03_hmg_F"],
		["Armored | Strider (GMG)","I_MRAP_03_gmg_F"]
	];

	private _airVeh = [
		["Heli | MH-9 Hummingbird","B_Heli_Light_01_F"],
		["Heli | M-900 Civilian","C_Heli_Light_01_civil_F"],
		["Heli | Orca","O_Heli_Light_02_unarmed_F"],
		["Heli | Mohawk","I_Heli_Transport_02_F"],
		["Heli | Taru Sling","O_Heli_Transport_04_F"],
		["Heli | Taru Open Bench","O_Heli_Transport_04_bench_F"],
		["Heli | Taru Enclosed Bench","O_Heli_Transport_04_covered_F"],
		["Heli | Huron (Unarmed)","B_Heli_Transport_03_unarmed_F"],
		["Heli | Ghosthawk (Armed)","B_Heli_Transport_01_F"],
		["Heli | AH-9 Pawnee","B_Heli_Light_01_armed_F"],
		["Heli | AH-99 Blackfoot","B_Heli_Attack_01_F"],
		["Plane | Caesar BTT","I_C_Plane_Civil_01_F"],
		["Plane | Caesar BTT (Armed)","C_Plane_Civil_01_racing_F"],
		["Jet | To-201 Shikra","O_Plane_Fighter_02_F"],
		["Jet | F/A-181 Black Wasp II","B_Plane_Fighter_01_F"],
		["Jet | A-149 Gryphon (Cluster)","I_Plane_Fighter_04_Cluster_F"],
		["Jet | A-143 Buzzard (CAS)","I_Plane_Fighter_03_CAS_F"],
		["Jet | A-164 Wipeout (CAS)","B_Plane_CAS_01_F"],
		["Jet | To-199 Neophron (CAS)","O_Plane_CAS_02_F"]
	];

	_vlist lbAdd "- - - Water - - -";

	{
		_vlist lbAdd (_x select 0);
		_vlist lbSetData [(lbSize _vlist) - 1,(_x select 1)];
	} forEach _waterVeh;

	_vlist lbAdd "";
	_vlist lbAdd "- - - Ground - - -";

	{
		_vlist lbAdd (_x select 0);
		_vlist lbSetData [(lbSize _vlist) - 1,(_x select 1)];
	} forEach _landVeh;

	_vlist lbAdd "";
	_vlist lbAdd "- - - Air - - -";

	{
		_vlist lbAdd (_x select 0);
		_vlist lbSetData [(lbSize _vlist) - 1,(_x select 1)];
	} forEach _airVeh;
};

[
	["event","ADMIN Open Menu"],
	["player",name player],
	["player_id",getPlayerUID player],
	["location",getPosATL player]
] call OEC_fnc_logIt;
