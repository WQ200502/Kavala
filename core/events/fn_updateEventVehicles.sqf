//	Description: Updates the available locations for the selected event type

private["_display","_eventType","_eventVehicleList"];
disableSerialization;

_display = findDisplay 50000;
_eventType = lbData[50003,lbCurSel (50003)];
_eventVehicleList = _display displayCtrl 50005;
lbClear _eventVehicleList;

[] spawn OEC_fnc_loadEventActions;

switch (_eventType) do {
	case "derby": {
		_eventVehicleList lbAdd "Quad";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_Quadbike_01_F""]"];

		_eventVehicleList lbAdd "Random";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Kart_01_F""]"];

		_eventVehicleList lbAdd "Boxer";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Van_01_box_F""]"];

		_eventVehicleList lbAdd "Fuel Truck";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Van_01_fuel_F""]"];

		_eventVehicleList lbAdd "SUV";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_SUV_01_F""]"];

		_eventVehicleList lbAdd "Hatchback";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Hatchback_01_F""]"];

		_eventVehicleList lbAdd "Hatchback Sport";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Hatchback_01_sport_F""]"];

		_eventVehicleList lbAdd "Offroad";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_G_Offroad_01_F""]"];

		_eventVehicleList lbAdd "Hunter";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_MRAP_01_F""]"];

		_eventVehicleList lbAdd "Ifrit";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""O_MRAP_02_F""]"];

		_eventVehicleList lbAdd "Strider";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""I_MRAP_03_F""]"];

		_eventVehicleList lbAdd "Van";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Van_02_vehicle_F""]"];

	};

	case "race": {
		_eventVehicleList lbAdd "Quad";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_Quadbike_01_F""]"];

		_eventVehicleList lbAdd "Random";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Kart_01_F""]"];

		_eventVehicleList lbAdd "Boxer";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Van_01_box_F""]"];

		_eventVehicleList lbAdd "Fuel Truck";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Van_01_fuel_F""]"];

		_eventVehicleList lbAdd "SUV";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_SUV_01_F""]"];

		_eventVehicleList lbAdd "Hatchback";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Hatchback_01_F""]"];

		_eventVehicleList lbAdd "Hatchback Sport";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Hatchback_01_sport_F""]"];

		_eventVehicleList lbAdd "Offroad";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_G_Offroad_01_F""]"];

		_eventVehicleList lbAdd "Hunter";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_MRAP_01_F""]"];

		_eventVehicleList lbAdd "Ifrit";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""O_MRAP_02_F""]"];

		_eventVehicleList lbAdd "Strider";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""I_MRAP_03_F""]"];

		_eventVehicleList lbAdd "Van";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_G_Van_01_transport_F""]"];
	};

	case "escort": {
		_eventVehicleList lbAdd "Escort with hunter";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_MRAP_01_F"",""B_G_Offroad_01_F"",""B_G_Offroad_01_F"",""C_Hatchback_01_sport_F""]"];

		_eventVehicleList lbAdd "Armed Extract - T1";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_G_Offroad_01_armed_F"",""I_G_Offroad_01_armed_F"",""I_MRAP_03_hmg_F"",""I_MRAP_03_hmg_F"",""B_Truck_01_transport_F""]"];

		_eventVehicleList lbAdd "Armed Extract - T2";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_G_Offroad_01_armed_F"",""I_G_Offroad_01_armed_F"",""B_MRAP_01_hmg_F"",""B_MRAP_01_hmg_F"",""B_Truck_01_transport_F""]"];

		_eventVehicleList lbAdd "Armored Extract - T1";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""O_MRAP_02_F"",""O_MRAP_02_F"",""O_MRAP_02_F"",""B_Truck_01_transport_F""]"];

		_eventVehicleList lbAdd "Armored Extract - T2";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_MRAP_01_F"",""B_MRAP_01_F"",""B_MRAP_01_F"",""B_Truck_01_transport_F""]"];

		_eventVehicleList lbAdd "Regular Extraction";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Offroad_01_F"",""C_Offroad_01_F"",""B_Truck_01_transport_F""]"];

		_eventVehicleList lbAdd "Heli & Ground Extract - T1";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Offroad_01_F"",""I_MRAP_03_hmg_F"",""I_MRAP_03_hmg_F"",""B_Heli_Transport_03_black_F""]"];

		_eventVehicleList lbAdd "Heli & Ground Extract - T2";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""C_Offroad_01_F"",""B_MRAP_01_hmg_F"",""B_MRAP_01_hmg_F"",""B_Heli_Transport_03_black_F""]"];

		_eventVehicleList lbAdd "Water Extract - T1";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""O_Boat_Armed_01_hmg_F"",""O_Boat_Armed_01_hmg_F"",""O_Boat_Armed_01_hmg_F"",""B_SDV_01_F""]"];

		_eventVehicleList lbAdd "Water Extract - T2";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""O_Boat_Armed_01_hmg_F"",""O_Boat_Armed_01_hmg_F"",""O_Boat_Armed_01_hmg_F"",""B_SDV_01_F""]"];
	};

	case "lastman": {
		_eventVehicleList lbAdd "LMS Default Crates";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""lmsDefault""]"];
	};

	case "dogfight": {
		_eventVehicleList lbAdd "Buzzard Jet";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""I_Plane_Fighter_03_CAS_F""]"];

		_eventVehicleList lbAdd "Neophron Jet";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""O_Plane_CAS_02_F""]"];

		_eventVehicleList lbAdd "Wipeout Jet";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_Plane_CAS_01_F""]"];

		_eventVehicleList lbAdd "Black Wasp II Jet";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_Plane_Fighter_01_F""]"];

		_eventVehicleList lbAdd "Shikra Jet";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""O_Plane_Fighter_02_F""]"];

		_eventVehicleList lbAdd "Gryphon Jet";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""I_Plane_Fighter_04_F""]"];

		_eventVehicleList lbAdd "Pawnee Heli";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_Heli_Light_01_armed_F""]"];

		_eventVehicleList lbAdd "Orca Heli";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""O_Heli_Light_02_v2_F""]"];

		_eventVehicleList lbAdd "Huron Heli";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""B_Heli_Transport_03_F""]"];
	};

	case "tankbattle": {
		_eventVehicleList lbAdd "Varsuk tank";
		_eventVehicleList lbSetData [(lbSize _eventVehicleList) - 1,"[""O_T_MBT_02_cannon_ghex_F""]"];
	};
	default {};
};

_eventVehicleList lbSetCurSel 0;
