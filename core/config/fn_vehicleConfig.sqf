#include "..\..\macro.h"
//  File: fn_vehicleConfig.sqf
//	描述：所有车辆信息的主配置，这将创建一个更简单的获取车辆外观、价格、可用性等的系统。

private["_mode","_side","_slotName","_skinsArray","_vehicleArray","_return","_copLevel","_medicLevel","_adminLevel","_donatorLevel"];
_mode = param [0,"",[""]];
_side = playerSide;
_copLevel = __GETC__(life_coplevel);
_medicLevel = __GETC__(life_medicLevel);
_donatorLevel = __GETC__(oev_donator);
_newsLevel = __GETC__(life_newslevel);
_adminLevel = __GETC__(life_adminlevel);

if(_mode == "") exitWith {};

//format 加车[车辆类别名称-0, [平民]-1, [店名]-2, copLevel-3, medicLevel-4, donatorLevel-5, _买价-6, warpointBuyPrice-7 , _车库费-8, _基本干重-9, newslevel-10, 默认修改-11]

_vehicleArray = [
	["B_G_Offroad_01_armed_F", [civilian], ["reb_v","war_v"], 0, 0, 0, 750000, 50, 62750, 50, -1],										// Offroad (HMG)
	["I_G_Offroad_01_armed_F", [civilian], ["reb_v","war_v"], 0, 0, 0, 850000, 60, 62750, 50, -1],										// Offroad (HMG) w/ shield and reticle
	["B_G_Offroad_01_F", [civilian], ["reb_v"], 0, 0, 0, 35000, 0, 2150, 80, -1],																			// Offroad
	["B_Heli_Light_01_F", [civilian, west, independent], ["civ_air","reb_v","cop_air","indp_news","med_air_hs"], 3, 3, 0, 250000, 0, 20400, 80, 3],		// MH-9 Hummingbird
	["B_Heli_Transport_01_F", [west,independent], ["cop_air","med_air_hs"], 6, 6, 0, 645000, 0, 37900, 80, -1],				// UH-80 Ghost Hawk
	["B_Heli_Transport_03_unarmed_F", [civilian], ["civ_air"], 0, 0, 0, 900000, 0, 46500, 300, -1],										// CH-67 Huron (Unarmed)
	["B_Lifeboat", [civilian], ["civ_ship","reb_boat"], 0, 0, 0, 7500, 0, 625, 50, -1],																					// Rescue Boat
	["B_Quadbike_01_F", [civilian, west,independent], ["civ_car","reb_v","cop_car","med_shop"], 1, 2, 0, 4000, 0, 300, 20, -1],							// Quad Bike
	["B_SDV_01_F", [west,independent], ["cop_ship","med_ship"], 4, 0, 0, 400000, 0, 20200, 40, -1],																		// SDV (Cop/R&R)
	["B_Truck_01_box_F", [civilian], ["civ_truck"], 0, 0, 0, 465000, 0, 27000, 1000, -1],															// HEMTT Box
	["B_Truck_01_fuel_F", [civilian], ["civ_truck"], 0, 0, 0, 390000, 0, 23000, 1000, -1],														// HEMTT Fuel
	["B_Truck_01_transport_F", [civilian], ["civ_truck"], 0, 3, 0, 335000, 0, 19850, 800, -1],												// HEMTT Transport
	["B_Truck_01_flatbed_F", [independent], ["med_shop"], 0, 3, 0, 335000, 0, 19850, 800, -1],												// hemtt flatbed
	["C_Boat_Civil_01_F", [civilian], ["civ_ship","reb_boat"], 0, 0, 0, 40000, 0, 200, 140, -1],																	// Motorboat
	["C_Boat_Civil_01_rescue_F", [independent], ["civ_ship","med_ship","reb_boat"], 0, 2, 0, 40000, 0, 200, 140, -1],						// Motorboat (Rescue)
	["C_Hatchback_01_F", [civilian], ["civ_car", "vigi_car"], 0, 0, 0, 15000, 0, 950, 40, -1],												// Hatchback
	["C_Hatchback_01_sport_F", [civilian, west,independent], ["civ_car","cop_car", "vigi_car","reb_v","med_shop"], 2, 1, 0, 30000, 0, 1700, 40, -1],	// Hatchback (Sport)
	["C_Heli_Light_01_civil_F", [civilian,independent], ["civ_air","med_air_hs"], 2, 3, 0, 150000, 0, 15400, 80, -1],								// M-900
	["C_Kart_01_Blu_F", [civilian], ["civ_kart"], 0, 0, 0, 30000, 0, 1050, 10, -1],																		// Kart (Bluking)
	["C_Kart_01_F", [civilian], ["civ_kart"], 0, 0, 0, 30000, 0, 1050, 10, -1],																				// Kart
	["C_Kart_01_F", [civilian], ["civ_kart"], 0, 0, 0, 30000, 0, 1050, 10, -1],																	// Kart (Fuel)
	["C_Kart_01_Red_F", [civilian], ["civ_kart"], 0, 0, 0, 30000, 0, 1050, 10, -1],																		// Kart (Redstone)
	["C_Kart_01_Vrana_F", [civilian], ["civ_kart"], 0, 0, 0, 30000, 0, 1050, 10, -1],																	// Kart (Vrana)
	["C_Kart_01_green_F", [independent], ["med_shop"], 0, 5, 0, 50000, 0, 1050, 0, -1],																// kart medic
	["C_Offroad_01_F", [civilian, west], ["civ_car","cop_car", "vigi_car"], 0, 0, 0, 35000, 0, 2150, 80, -1],					// Offroad
	["C_Offroad_01_comms_F", [west,independent], ["cop_car","med_shop"], 3, 3, 0, 45000, 0, 1000, 100, -1],						// Offroad (Comms)
	["C_Offroad_01_covered_F", [civilian,west], ["civ_car","reb_v","cop_car"], 2, 0, 0, 50000, 0, 1000, 100, -1],			// Offroad (Covered)
	["C_Tractor_01_F", [civilian], ["civ_car","reb_v"], 0, 0, 0, 30000, 0, 1000, 20, -1],															// Tractor
	["C_Rubberboat", [civilian], ["civ_ship","reb_boat"], 0, 0, 0, 7500, 0, 575, 40, -1],																				// Rescue Boat
	["C_Scooter_Transport_01_F", [civilian,west], ["civ_ship","cop_ship","reb_boat"], 2, 0, 0, 5000, 0, 200, 10, -1],						// Water Scooter
	["C_SUV_01_F", [civilian, west, independent], ["civ_car","cop_car","med_shop","indp_news", "vigi_car","reb_v"], 2, 1, 0, 45000, 0, 2750, 100, 2],	// SUV
	["C_Van_01_box_F", [civilian,west,independent], ["civ_truck","indp_news","cop_car"], 3, 1, 0, 130000, 0, 7500, 300, 1],				// Truck Boxer
	["C_Van_01_fuel_F", [civilian], ["civ_truck"], 0, 0, 0, 170000, 0, 10600, 300, -1],																// Fuel Truck
	["C_Van_01_transport_F", [civilian], ["civ_truck"], 0, 0, 0, 75000, 0, 4500, 200, -1],														// Truck
	["I_Heli_Transport_02_F", [civilian], ["civ_air"], 0, 0, 0, 800000, 0, 41500, 300, -1],														// CH-49 Mohawk
	["I_Heli_light_03_unarmed_F", [civilian,independent], ["civ_air","med_air_hs"], 7, 7, 0, 275000, 0, 1000, 120, -1],												// WY-55 Hellcat (Unarmed)
	["I_Truck_02_covered_F", [west,civilian], ["cop_car","civ_truck"], 3, 0, 0, 187500, 0, 16000, 600, -1],						// Zamak Transport (Covered)
	["I_Truck_02_fuel_F", [civilian], ["civ_truck"], 0, 0, 0, 170000, 0, 14000, 600, -1],															// Zamak Fuel
	["I_Truck_02_transport_F", [civilian], ["civ_truck"], 0, 0, 0, 150000, 0, 11800, 400, -1],												// Zamak Transport
	["O_Heli_Light_02_unarmed_F", [civilian,independent,west], ["reb_v","civ_air","med_air_hs","cop_air","war_v"], 3, 4, 0, 500000, 25, 19550, 160, -1],// PO-30 Orca (Unarmed)
	["O_Heli_Transport_04_bench_F", [civilian,west], ["reb_v","cop_air"], 7, 0, 0, 850000, 0, 43000, 100, -1],												// Mi-290 Taru (Bench)
	["O_Heli_Transport_04_covered_F", [civilian,west], ["reb_v","cop_air"], 7, 0, 0, 950000, 0, 43100, 300, -1],											// Mi-290 Taru (Transport)
	["O_Heli_Transport_04_F", [civilian,independent,west], ["reb_v","cop_air","med_air_hs"], 6, 4, 0, 700000, 0, 35700, 140, -1],		// Mi-290 Taru
	["O_Heli_Transport_04_repair_F", [], [], 0, 4, 0, 700000, 0, 37750, 250, -1],																			// Mi-290 Taru (Repair)
	["O_Heli_Transport_04_fuel_F", [civilian], ["civ_air"], 0, 0, 0, 650000, 0, 34000, 300, -1],											// Mi-290 Taru (Fuel)
	["O_MRAP_02_F", [civilian], ["reb_v","war_v"], 0, 0, 0, 650000, 45, 37800, 60, -1],																// Ifrit
	["O_SDV_01_F", [civilian], ["reb_boat","civ_ship"], 0, 0, 0, 60000, 0, 500, 80, -1],															// SDV
	["O_Truck_03_covered_F", [civilian], ["reb_v","civ_truck"], 0, 0, 0, 330000, 0, 19875, 800, -1],									// Tempest Transport (Covered)
	//["O_Truck_03_device_F", [civilian,west], ["civ_truck","cop_car"], 3, 0, 0, 425000, 0, 23750, 500, -1],						// Tempest (Device)
	["O_Truck_03_fuel_F", [civilian], ["civ_truck"], 0, 0, 0, 320000, 0, 19000, 800, -1],															// Tempest Fuel
	["O_Truck_03_transport_F", [civilian], ["reb_v","civ_truck"], 0, 0, 0, 280000, 0, 16300, 600, -1],								// Tempest Transport
	["Land_Wreck_Traw_F", [], [], 0, 0, 0, 99999999, 0, 0, 1000, -1],																									// Trawler Wreck (Front)
	["Land_Wreck_Traw2_F", [], [], 0, 0, 0, 99999999, 0, 0, 1000, -1],																								// Trawler Wreck (Back)
	["C_Offroad_01_repair_F", [independent], ["med_shop"], 0, 2, 0, 35000, 0, 2150, 80, -1],													// Offroad (Services)
	["O_T_LSV_02_armed_F", [civilian], ["reb_v"], 0, 0, 0, 1250000, 0, 50000, 50, -1],																// Qilin (Minigun)
	["B_T_LSV_01_armed_F", [], [], 0, 0, 0, 1250000, 0, 62750, 50, -1],																								// Prowler (HMG)
	["B_Heli_Transport_03_black_F", [], [], 0, 0, 0, 1250000, 0, 62750, 50, -1],																			// CH-67 Huron (Black)
	["C_Offroad_02_unarmed_F", [civilian], ["civ_car", "vigi_car"], 0, 0, 0, 35000, 0, 2150, 80, -1],									// MB 4WD
	["C_Plane_Civil_01_F", [civilian, west], ["civ_plane","cop_plane"], 3, 0, 0, 300000, 0, 15400, 800, -1],					// Caesar BTT
	["C_Plane_Civil_01_racing_F", [civilian, west], ["civ_plane","cop_plane"], 6, 0, 0, 500000, 0, 15400, 800, -1, [0,0,0,0,0,0,0,0]],	// Caesar BTT (Racing) Unarmed
	["C_Plane_Civil_01_racing_F", [civilian, west], ["civ_plane","cop_plane","war_v"], 6, 0, 0, 2000000, 130, 15400, 800, -1, [0,0,0,1,0,0,0,0]],	// Caesar BTT (Racing) Armed
	["O_LSV_02_unarmed_viper_F", [independent,west,civilian], ["med_shop","cop_car","reb_v","war_v"], 3, 2, 0, 200000, 12, 2150, 80, -1],		// Qilin (Unarmed)
	["B_LSV_01_unarmed_black_F", [civilian,west], ["vigi_car","cop_car"], 3, 0, 0, 200000, 0, 1000, 60, -1],    			// APD/Vigi Prowler light
	["C_Boat_Transport_02_F", [civilian,west,independent], ["civ_ship","cop_ship","med_ship","reb_boat"], 2, 2, 0, 15000, 0, 575, 100, -1],		// RHIB
	["B_T_VTOL_01_vehicle_F", [civilian], ["civ_plane"], 0, 0, 0, 5000000, 0, 93000, 700, -1],												// Blackfish (Vehicle Transport)
	["B_T_VTOL_01_infantry_F", [civilian], ["civ_plane"], 0, 0, 0, 1000000, 0, 93000, 1000, -1],											// Blackfish (Infantry Transport)
	["B_MRAP_01_F", [civilian,west,independent], ["reb_v","cop_car","med_shop","war_v"], 4, 5, 0, 400000, 20, 37750, 50, -1],				// Hunter

	["O_Plane_CAS_02_F", [civilian], ["civ_plane"], 0, 0, 0, 2750000, 0, 90000, 700, -1],															// Neophron
	["B_Plane_CAS_01_F", [civilian], ["civ_plane"], 0, 0, 0, 2250000, 0, 85000, 700, -1],															// Wipeout
	["I_Plane_Fighter_03_CAS_F", [civilian], ["civ_plane"], 0, 0, 0, 1750000, 0, 75000, 70, -1],											// Buzzard
	["I_Plane_Fighter_04_F", [civilian], ["civ_plane"], 0, 0, 0, 3200000, 0, 95000, 70, -1],													// Gryphon
	["B_Plane_Fighter_01_F", [civilian], ["civ_plane"], 0, 0, 0, 3500000, 0, 100000, 70, -1],													// Wasp
	["O_Plane_Fighter_02_F", [civilian], ["civ_plane"], 0, 0, 0, 4000000, 0, 105000, 70, -1],													// Shikra
	["C_Van_02_vehicle_F", [civilian], ["civ_car","reb_v"], 0, 0, 0, 100000, 0, 6000, 200, -1],												// Van (Cargo)
	["C_Van_02_transport_F", [civilian], ["civ_car","reb_v"], 0, 0, 0, 75000, 0, 3000, 80, -1],												// Van Transport
	["B_G_Van_02_vehicle_F", [west], ["cop_car"], 3, 0, 0, 65000, 0, 6000, 200, -1],																	// Van (Cargo)
	["B_G_Van_02_transport_F", [west], ["cop_car"], 3, 0, 0, 55000, 0, 2000, 80, -1],																	// Van Transport
	["C_Van_02_medevac_F", [independent], ["med_shop"], 0, 1, 0, 100000, 0, 1000, 80, -1],														// Van (Ambulance)
	["IG_supplyCrate_F", [], [], 0, 0, 0, 999999, 0, 0, 10000, -1],																										// Supply Box [FIA]
	["O_Truck_03_repair_F", [], [], 0, 0, 0, 400000, 0, 0, 0, -1],																											// Zamak Ammo
	["O_Truck_03_ammo_F", [], [], 0, 0, 0, 400000, 0, 0, 0, -1],																											// Tempest Ammo
	["B_Truck_01_ammo_F", [], [], 0, 0, 0, 400000, 0, 0, 0, -1],																											// HEMTT Ammo
	["O_LSV_02_armed_F", [], [], 0, 0, 0, 400000, 0, 0, 80, -1],																											// Qilin (Minigun)
	["B_Heli_Transport_01_camo_F", [], [], 0, 0, 0, 600000, 0, 37900, 80, -1],																				// UH-80 Ghost Hawk (Camo)
	["I_G_Offroad_01_AT_F", [], [], 0, 0, 0, 600000, 0, 37900, 80, -1],																								// Offroad (AT)
	["I_MRAP_03_F", [civilian,west,independent], ["reb_v","cop_car","med_shop","war_v"], 7, 4, 0, 550000, 40, 45300, 60, -1],							// Strider
	["I_C_Offroad_02_LMG_F", [civilian], ["reb_v"], 0, 0, 0, 200000, 0, 10000, 80, -1],								// MB 4WD (LMG)
	["B_Heli_Transport_03_F", [west], ["cop_air"], 7, 0, 0, 600000, 0, 46500, 80, -1],																// CH-67 Huron
	["O_T_VTOL_02_vehicle_F", [independent], ["med_air_hs"], 0, 7, 0, 600000, 0, 1000, 250, -1],											// Y-32 (vehicle Transport)
	["B_Heli_Transport_03_unarmed_green_F", [west], ["cop_air"], 7, 0, 0, 425000, 0, 46500, 300, -1],							   	// CH-67 Huron Unarmed (Green)
	["I_Heli_light_03_dynamicLoadout_F", [civilian,west], ["reb_v","cop_air"], 5, 7, 0, 300000, 0, 1000, 80, -1]		  //hellcat bench unarmed
	//["B_APC_Wheeled_01_cannon_F", [civilian], ["civ_car","reb_v"], 0, 0, 0, 133769, 0, 1000, 60, 4],							  // Marshall

];
//if (getPlayerUID player isEqualTo "76561198016247666") then {
	//_vehicleArray pushBack ["O_T_VTOL_02_infantry_F", [west], ["cop_plane"], 7, 0, 0, 5000000, 0, 60000, 250, -1];
//} else {
	//_vehicleArray pushback ["O_T_VTOL_02_infantry_F", [west], ["cop_plane"], 8, 0, 0, 5000000, 0, 60000, 250, -1];
//};
if (getPlayerUID player isEqualTo "76561198144351505") then {
	_vehicleArray pushBack ["I_Heli_light_03_dynamicLoadout_F", [independent], ["med_air_hs"], 0, 7, 0, 300000, 0, 60000, 1000, -1];
} else {
	_vehicleArray pushBack ["I_Heli_light_03_dynamicLoadout_F", [independent], ["med_air_hs"], 0, 8, 0, 300000, 0, 60000, 1000, -1];
};
//精密车
if (6 in life_loot) then {
_vehicleArray pushBack ["O_Truck_03_device_F", [civilian,west], ["civ_truck","cop_car"], 3, 0, 0, 425000, 0, 23750, 500, -1];
};

//if (700 in life_loot) then {
//_vehicleArray pushBack ["O_MRAP_02_F", [west], ["cop_car"], 0, 0, 0, 425000, 0, 23750, 500, -1];
//};
_return = [];
switch(_mode) do {
	case "allVehicles": {
		_vehicleName = param [1,"",[""]];

		{
			if(_vehicleName == (_x select 0)) exitWith {_return = _x;};
		} forEach _vehicleArray;
	};

	case "availableVehicles": {
		_shopName = param [1,"",[""]];

		{
			switch(_side) do{
				case civilian: {
					if(((_shopName in (_x select 2)) && {(_side in (_x select 1))}) && {(_donatorLevel >= (_x select 5))} && {((_x select 0) != "B_LSV_01_unarmed_black_F")}) then {_return pushBack _x;};
					if (player getVariable ["isVigi",false]) then {if((_shopName in (_x select 2)) && (_side in (_x select 1)) && ((_x select 0) == "B_LSV_01_unarmed_black_F") && (oev_vigiarrests >= 1)) then {_return pushBack _x;};};
				};

				case west: {
					if(((_shopName in (_x select 2)) && (_side in (_x select 1))) && (((_donatorLevel >= (_x select 5)) && (_copLevel >= (_x select 3))))) then {_return pushBack _x;};

				};

				case independent: {
					if(((_shopName in (_x select 2)) && (_side in (_x select 1))) && {!(oev_newsTeam)} && (((_donatorLevel >= (_x select 5)) && (_medicLevel >= (_x select 4))))) then {_return pushBack _x;};
					if(((_shopName isEqualTo "indp_news") && {(_side in (_x select 1))}) && {oev_newsTeam} && {!((_x select 10) isEqualTo -1)} && {(_newsLevel >= (_x select 10))}) then {_return pushBack _x;};
				};

				case east: {
					if(((_shopName in (_x select 2)) && (_side in (_x select 1)))) then {_return pushBack _x;};
				};
			};
		} forEach _vehicleArray;
	};
};

_return;
