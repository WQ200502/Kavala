// File: fn_serviceHeli.sqf
// Author: Astral
// Description: Requires helis at service station to land and wait a progress bar of 15 seconds before their heli is repaired.
// The repair requires players to be alive, inside pilot seat, and touching ground at all times or the repair is cancelled.
// Fuel is also fully filled with the repair.

_vehicle = param [0,ObjNull,[ObjNull]];

if(typeOf _vehicle in
	["B_Heli_Light_01_F","O_Heli_Light_02_unarmed_F","I_Heli_Transport_02_F","B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F","C_Heli_Light_01_civil_F","O_Heli_Transport_04_F","O_Heli_Transport_04_repair_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_medevac_F","B_Heli_Transport_03_unarmed_F","B_Heli_Transport_03_F","B_Heli_Transport_03_unarmed_green_F","
O_Heli_Transport_04_fuel_F","I_Heli_light_03_unarmed_F","I_Heli_light_03_dynamicLoadout_F"])
	then {
	_vehOldPos = getPos _vehicle;
	if!(isTouchingGround _vehicle) then {hint "Please land your helicopter if you wish to begin repairing!";};
	waitUntil {(isTouchingGround _vehicle) || (getpos _vehicle distance _vehOldPos > 30);};
	if(isTouchingGround _vehicle) then {
		sleep 1; // gives player time to fully land. Always cancels while lowering with helis like taru or huron.
		// Creating the progress bar for 15 seconds
		disableSerialization;
		5 cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
		_title = "Repairing Vehicle...";
		_titleText ctrlSetText format["%2 (1%1)...","%",_title];
		_progressBar progressSetPosition 0.01;
		_cP = 0.01;

		_vehRepair = 0;

		while {true} do {
			uiSleep 0.15; // 15 seconds
			_cP = _cP + 0.01;
			_progressBar progressSetPosition _cP;
			_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
			if (_cP >= 1) exitWith {_vehRepair = 1;};
			if (!alive player) exitWith {_vehRepair = 0;};
			if (!isTouchingGround _vehicle) exitWith {_vehRepair = 0;};
			if (isNull(driver _vehicle)) exitWith {_vehRepair = 0;};
		};
		5 cutText ["","PLAIN DOWN"];
		if (_vehRepair == 1) then { // If player waited full 15 secs, then _vehRepair == 1, else its 0
			_dam_obj = _vehicle;
			_dam_obj setDamage 0;
			_vehicle setFuel 1;
			hint "Your vehicle has been repaired!";
		} else {
			hint "You must stay alive and be landed in the pilot seat to repair!";
		};
	} else {
		titleText ["You have gone too far from the service station!", "PLAIN DOWN"];
	};
} else {
	_dam_obj = _vehicle;
	_dam_obj setDamage 0;
	_vehicle setFuel 1;
};
