//  File: fn_sirenLights.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Lets play a game! Can you guess what it does? I have faith in you, if you can't
//	then you have failed me and therefor I lose all faith in humanity.. No pressure.
private["_vehicle"];
_vehicle = param [0,ObjNull,[ObjNull]];
if(isNull _vehicle) exitWith {}; //Bad entry!
if(!(typeOf _vehicle in ["C_Offroad_01_F","C_SUV_01_F","B_MRAP_01_F","O_MRAP_02_F","C_Hatchback_01_sport_F","B_Heli_Light_01_F","B_Heli_Transport_01_F","I_MRAP_03_F","B_Heli_Transport_03_unarmed_green_F","I_Truck_02_covered_F","O_Heli_Light_02_unarmed_F","C_Boat_Transport_02_F","C_Scooter_Transport_01_F","B_G_Van_02_vehicle_F","B_G_Van_02_transport_F","B_Quadbike_01_F","O_LSV_02_unarmed_viper_F","C_Plane_Civil_01_racing_F","C_Plane_Civil_01_F","I_C_Offroad_02_LMG_F","B_Heli_Transport_03_F","C_Offroad_01_repair_F","C_Offroad_01_comms_F","C_Offroad_01_covered_F","O_T_VTOL_02_infantry_F","I_Heli_light_03_dynamicLoadout_F","B_Truck_01_flatbed_F","B_SDV_01_F","C_Offroad_02_unarmed_F","B_LSV_01_unarmed_black_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_F"])) exitWith {};

_trueorfalse = _vehicle getVariable["lights",FALSE];

if(_trueorfalse) then {
	_vehicle setVariable["lights",FALSE,TRUE];
	titleText [localize "STR_MISC_LightsOff","PLAIN DOWN"];
} else {
	_vehicle setVariable["lights",TRUE,TRUE];
	titleText [localize "STR_MISC_LightsOn","PLAIN DOWN"];
	[[_vehicle,0.22],"OEC_fnc_copLights",-2,false] call OEC_fnc_MP;
};
