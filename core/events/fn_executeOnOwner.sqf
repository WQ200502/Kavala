//  File: fn_executeOnOwner.sqf
//	Description: Performs a specified action on a player, typically when a command requires locality

private["_eventAction","_vehicle","_type","_magazines"];
_eventAction = param [0,"",[""]];

if(_eventAction == "") exitWith {};

switch(_eventAction) do {
	case "refuelAndRearm": {
		_vehicle = vehicle player;
		if(_vehicle == player) exitWith {};

		/*
			_type = (typeof _vehicle);

			_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");
			if(count _magazines > 0) then {
				{
					_vehicle removeMagazines _x;
					_vehicle addMagazine _x;
				}foreach _magazines;
			};

			_turrets = getArray(configFile >> "CfgVehicles" >> _type >> "Turrets");
			if(count _turrets > 0) then {
				{
					_magazines = getArray(_x >> "magazines");
					{
							_vehicle removeMagazines _x;
							_vehicle addMagazine _x;
					} forEach _magazines;
				}foreach _turrets;
			};
			_vehicle setVehicleAmmoDef 1;
			_vehicle setVehicleAmmo 1;
		*/
		_vehicle setFuel 1;
	};

	case "drainFuel": {
		_vehicle = vehicle player;
		if(_vehicle == player) exitWith {};

		_vehicle setFuel 0;
	};

	case "eatNDrink":{
		oev_thirst = 100;
		oev_hunger = 100;
		private _dam_obj = player;
		_dam_obj setDamage 0;
	};
};