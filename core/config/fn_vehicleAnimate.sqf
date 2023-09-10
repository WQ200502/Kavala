//  File: fn_vehicleAnimate.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Pass what you want to be animated.
params [
	["_vehicle",objNull,[objNull]],
	["_animate","",["",[]]],
	["_preset",false,[false]]
];
if (isNull _vehicle) exitWith {};

if !(_preset) then {
	if (count _animate > 1) then {
		{
			_vehicle animate [_x select 0,_x select 1];
		} forEach _animate;
	} else {
		_vehicle animate [_animate select 0,_animate select 1];
	};
} else {
	switch (_animate) do {
		case "civ_littlebird": {
			waitUntil {!isNil {_vehicle getVariable "oev_veh_color"}};
			_vehicle animate ["addDoors",1];
			_vehicle animate ["AddCivilian_hide",1];
			_vehicle lockCargo [2,true];
			_vehicle lockCargo [3,true];
			_vehicle lockCargo [4,true];
			_vehicle lockCargo [5,true];
		};

		case "service_truck": {
			_vehicle animate ["HideServices", 0];
			_vehicle animate ["HideDoor3", 1];
		};

		case "med_offroad": {
			if ((typeOf _vehicle) isEqualTo "C_Offroad_01_F" || (typeOf _vehicle) isEqualTo "C_Offroad_01_comms_F") then {
				waitUntil {!isNil {_vehicle getVariable "oev_veh_color"}};
			};
			_vehicle animate ["HidePolice", 0];
		};

		case "cop_offroad": {
			if ((typeOf _vehicle) isEqualTo "C_Offroad_01_F" || (typeOf _vehicle) isEqualTo "C_Offroad_01_comms_F" || (typeOf _vehicle) isEqualTo "C_Offroad_01_covered_F")  then {
				waitUntil {!isNil {_vehicle getVariable "oev_veh_color"}};
			};
			_vehicle animate ["HidePolice", 0];
			_vehicle animate ["HideBumper1", 0];
			_vehicle animate ["HideConstruction", 0];
		};

		case "med_boat": {
			if (typeOf _vehicle == "C_Boat_Civil_01_F") then {
				waitUntil {!isNil {_vehicle getVariable "oev_veh_color"}};
			};
			_vehicle animate ["HidePolice", 1];
		};

		case "qilin_doors": {
			_vehicle animate ["Unarmed_Doors_Hide", 1];
		};
	};
};