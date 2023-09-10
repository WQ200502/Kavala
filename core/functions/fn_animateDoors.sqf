//	Author: Poseidon
//  Modifications: Fusah
//	Description: Opens/Closes doors on vehicles which support it

private["_doorNames","_className"];

params [
	["_veh",objNull,[objNull]],
	["_mode",false,[false]]
];

if (isNull _veh) exitWith {};

if (_mode) then {
	switch (typeOf _veh) do {
		case 'O_MRAP_02_F': {
			_veh animateDoor ["Door_LM",1];
			_veh animateDoor ["Door_RM",1];
			_veh animateDoor ["Door_LF",1];
			_veh animateDoor ["Door_RF",1];
		};
		case 'B_Heli_Transport_01_F': {
			 _veh animateDoor ["door_R",1];
			 _veh animateDoor ["door_L",1];
		};
		case 'B_T_VTOL_01_infantry_F': {
			_veh animateDoor ['Door_1_source',1];
		};
		case 'B_T_VTOL_01_vehicle_F': {
			_veh animateDoor ['Door_1_source',1];
		};
		case 'B_MRAP_01_F': {
			_veh animateDoor ['Door_LF',1];
			_veh animateDoor ['Door_RF',1];
			_veh animateDoor ['Door_LB',1];
			_veh animateDoor ['Door_RB',1];
		};
		case 'B_Heli_Transport_03_F': {
			_veh animateDoor ['Door_L_source',1];
			_veh animateDoor ['Door_rear_source',1];
		};
		case 'B_Heli_Transport_03_unarmed_F': {
			_veh animateDoor ['Door_L_source',1];
			_veh animateDoor ['Door_rear_source',1];
		};
		case 'I_MRAP_03_F': {
			_veh animateDoor ['Door_LF',1];
			_veh animateDoor ['Door_RF',1];
		};
		case 'I_Truck_02_covered_F': {
			_veh animateDoor ['Door_LF',1];
			_veh animateDoor ['Door_RF',1];
		};
		case 'I_Truck_02_fuel_F': {
			_veh animateDoor ['Door_LF',1];
			_veh animateDoor ['Door_RF',1];
		};
		case 'I_Truck_02_transport_F': {
			_veh animateDoor ['Door_LF',1];
			_veh animateDoor ['Door_RF',1];
		};
		case 'B_Truck_01_ammo_F': {
			_veh animateDoor ['Door_LF',1];
			_veh animateDoor ['Door_RF',1];
		};
		case 'O_Heli_Transport_04_F': {
			_veh animateDoor ['Door_1_source',1];
			_veh animateDoor ['Door_2_source',1];
			_veh animateDoor ['Door_3_source',1];
		};
		case 'O_Heli_Transport_04_fuel_F': {
			_veh animateDoor ['Door_1_source',1];
			_veh animateDoor ['Door_2_source',1];
			_veh animateDoor ['Door_3_source',1];
		};
		case 'C_Van_02_transport_F': {
			_veh animateDoor ['Door_1_source',1];
			_veh animateDoor ['Door_2_source',1];
			_veh animateDoor ['Door_3_source',1];
		};
		case 'C_Van_02_vehicle_F': {
			_veh animateDoor ['Door_1_source',1];
			_veh animateDoor ['Door_2_source',1];
			_veh animateDoor ['Door_3_source',1];
		};
		case 'B_G_Van_02_vehicle_F': {
			_veh animateDoor ['Door_1_source',1];
			_veh animateDoor ['Door_2_source',1];
			_veh animateDoor ['Door_3_source',1];
		};
		case 'B_G_Van_02_transport_F': {
			_veh animateDoor ['Door_1_source',1];
			_veh animateDoor ['Door_2_source',1];
			_veh animateDoor ['Door_3_source',1];
		};
		case 'I_C_Offroad_02_LMG_F': {
			_veh animateDoor ['Door_1_source',1];
			_veh animateDoor ['Door_2_source',1];
			_veh animateDoor ['Door_3_source',1];
		};
		case 'C_Offroad_02_unarmed_F': {
			_veh animateDoor ['Door_1_source',1];
			_veh animateDoor ['Door_2_source',1];
			_veh animateDoor ['Door_3_source',1];
		};

	};
} else {
	switch (typeOf _veh) do {
		case 'O_MRAP_02_F': {
			_veh animateDoor ["Door_LM",0];
			_veh animateDoor ["Door_RM",0];
			_veh animateDoor ["Door_LF",0];
			_veh animateDoor ["Door_RF",0];
		};
		case 'B_Heli_Transport_01_F': {
			 _veh animateDoor ["door_R",0];
			 _veh animateDoor ["door_L",0];
		};
		case 'B_T_VTOL_01_infantry_F': {
			_veh animateDoor ['Door_1_source',0];
		};
		case 'B_T_VTOL_01_vehicle_F': {
			_veh animateDoor ['Door_1_source',0];
		};
		case 'B_MRAP_01_F': {
			_veh animateDoor ['Door_LF',0];
			_veh animateDoor ['Door_RF',0];
			_veh animateDoor ['Door_LB',0];
			_veh animateDoor ['Door_RB',0];
		};
		case 'B_Heli_Transport_03_F': {
			_veh animateDoor ['Door_L_source',0];
			_veh animateDoor ['Door_rear_source',0];
		};
		case 'B_Heli_Transport_03_unarmed_F': {
			_veh animateDoor ['Door_L_source',0];
			_veh animateDoor ['Door_rear_source',0];
		};
		case 'I_MRAP_03_F': {
			_veh animateDoor ['Door_LF',0];
			_veh animateDoor ['Door_RF',0];
		};
		case 'I_Truck_02_covered_F': {
			_veh animateDoor ['Door_LF',0];
			_veh animateDoor ['Door_RF',0];
		};
		case 'I_Truck_02_fuel_F': {
			_veh animateDoor ['Door_LF',0];
			_veh animateDoor ['Door_RF',0];
		};
		case 'I_Truck_02_transport_F': {
			_veh animateDoor ['Door_LF',0];
			_veh animateDoor ['Door_RF',0];
		};
		case 'B_Truck_01_ammo_F': {
			_veh animateDoor ['Door_LF',0];
			_veh animateDoor ['Door_RF',0];
		};
		case 'O_Heli_Transport_04_F': {
			_veh animateDoor ['Door_1_source',0];
			_veh animateDoor ['Door_2_source',0];
			_veh animateDoor ['Door_3_source',0];
		};
		case 'O_Heli_Transport_04_fuel_F': {
			_veh animateDoor ['Door_1_source',0];
			_veh animateDoor ['Door_2_source',0];
			_veh animateDoor ['Door_3_source',0];
		};
		case 'C_Van_02_transport_F': {
			_veh animateDoor ['Door_1_source',0];
			_veh animateDoor ['Door_2_source',0];
			_veh animateDoor ['Door_3_source',0];
		};
		case 'C_Van_02_vehicle_F': {
			_veh animateDoor ['Door_1_source',0];
			_veh animateDoor ['Door_2_source',0];
			_veh animateDoor ['Door_3_source',0];
		};
		case 'B_G_Van_02_vehicle_F': {
			_veh animateDoor ['Door_1_source',0];
			_veh animateDoor ['Door_2_source',0];
			_veh animateDoor ['Door_3_source',0];
		};
		case 'B_G_Van_02_transport_F': {
			_veh animateDoor ['Door_1_source',0];
			_veh animateDoor ['Door_2_source',0];
			_veh animateDoor ['Door_3_source',0];
		};
		case 'I_C_Offroad_02_LMG_F': {
			_veh animateDoor ['Door_1_source',0];
			_veh animateDoor ['Door_2_source',0];
			_veh animateDoor ['Door_3_source',0];
		};
		case 'C_Offroad_02_unarmed_F': {
			_veh animateDoor ['Door_1_source',0];
			_veh animateDoor ['Door_2_source',0];
			_veh animateDoor ['Door_3_source',0];
		};

	};
};