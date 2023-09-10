//  File: fn_medicsirenLights.sqf
//	Author: Bryan "Tonic" Boardwine

private["_vehicle"];
_vehicle = param [0,ObjNull,[ObjNull]];
if(isNull _vehicle) exitWith {}; //Bad entry!
if(!(typeOf _vehicle in ["C_SUV_01_F","C_Hatchback_01_sport_F","C_Offroad_01_repair_F","I_MRAP_03_F","C_Boat_Civil_01_F","B_Heli_Transport_03_unarmed_F","C_Heli_Light_01_civil_F","I_Heli_Transport_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_F","O_Heli_Transport_04_repair_F","B_Heli_Transport_01_F","B_Heli_Light_01_F","C_Van_02_medevac_F","I_Heli_light_03_unarmed_F","O_LSV_02_unarmed_viper_F","B_MRAP_01_F","O_T_VTOL_02_vehicle_F","C_Offroad_01_comms_F","C_Boat_Civil_01_rescue_F","C_Boat_Transport_02_F","I_Heli_light_03_dynamicLoadout_F","B_Quadbike_01_F","B_Truck_01_flatbed_F","C_Kart_01_green_F","B_SDV_01_F"])) exitWith {};

_trueorfalse = _vehicle getVariable["lights",FALSE];

if(_trueorfalse) then {
	_vehicle setVariable["lights",FALSE,TRUE];
	titleText [localize "STR_MISC_LightsOff","PLAIN DOWN"];
} else {
	_vehicle setVariable["lights",TRUE,TRUE];
	titleText [localize "STR_MISC_LightsOn","PLAIN DOWN"];
	if (typeOf _vehicle in ["C_Heli_Light_01_civil_F","I_Heli_Transport_02_F","O_Heli_Light_02_unarmed_F","B_Heli_Transport_01_F","O_Heli_Transport_04_F","O_Heli_Transport_04_repair_F","B_Heli_Transport_03_unarmed_F","B_Heli_Light_01_F","I_Heli_light_03_unarmed_F","O_T_VTOL_02_vehicle_F","C_Boat_Civil_01_rescue_F","C_Boat_Transport_02_F","I_Heli_light_03_dynamicLoadout_F","B_Quadbike_01_F","C_Kart_01_green_F","B_SDV_01_F"]) then {
		[[_vehicle,0.9],"OEC_fnc_medicLights",-2,false] call OEC_fnc_MP;
	} else {
		[[_vehicle,0.22],"OEC_fnc_medicLights",-2,false] call OEC_fnc_MP;
	};
};
