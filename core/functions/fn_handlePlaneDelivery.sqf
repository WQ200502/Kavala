#include "..\..\macro.h"
// File: fn_handlePlaneDelivery.sqf
// Author: Kurt
if(scriptAvailable(3)) exitWith {};

params [
	"_target",
	"_caller",
	"_actionId",
	"_arguments"
];

//Initializing the args
private _mode = _arguments select 0;
private _location = _arguments select 1;

//Config
private _purchasePrice = 60000;
private _reward = 100000 + floor(random(50000));

//Do action depending on the mode
switch (_mode) do
{
	case "start":
	{
		if !(playerSide isEqualTo civilian) exitWith {hint parseText format["<t color='#ff0000'><t size='2'>Cargo Failed</t></t><br/><br/>You can't do plane missions as an APD or Rescue and Recovery member."];};
		if (oev_action_inUse) exitWith {};
		//Get all air vehicles nearby
		private _nearAirObjects = (position _caller) nearObjects ["Air", 40];
		//Loop through each object to determine if the object is a plane and is owned by the caller
		private _vehicleFound = false;
		private _vehicle = objNull;
		{
			private _owners = _x getVariable ["vehicle_info_owners",[]];
			if (count _owners > 0) then {
				private _owner = _owners select 0;
				//If the person owns the vehicle, the vehicle is an unarmed plane, and there is no cargo loaded on the plane.
				if (((_owner select 0) isEqualTo (getPlayerUID _caller)) && (((typeOf _x) isEqualTo "C_Plane_Civil_01_F") || ((typeOf _x) isEqualTo "C_Plane_Civil_01_racing_F")) && ((_x getVariable ["cargoDestination",0]) isEqualTo 0)) then {
					_vehicleFound = true;
					_vehicle = _x;
				};
			};
		} forEach _nearAirObjects;

		//Did we find a vehicle?
		if (_vehicleFound) then {
			//Check to see if they can afford it
			if (oev_cash < _purchasePrice && oev_atmcash < _purchasePrice) exitWith {hint parseText format["<t color='#ff0000'><t size='2'>Cargo Failed</t></t><br/><br/>You don't have enough money to start the air delivery mission! It costs $%1 to load the cargo.",[_purchasePrice] call OEC_fnc_numberText]};
			//Confirmation menu
			private _action = [
				format["Are you sure you want to start this air delivery mission? It will cost $%1 to load the cargo onto the plane",[_purchasePrice] call OEC_fnc_numberText],
				"Start Air Delivery",
				"Yes",
				"No"
			] call BIS_fnc_GUImessage;

			if (_action) then {
				oev_action_inUse = true;

				// Refer to https://gyazo.com/bceefe7407f853089c80a11350d98523 for location indeces
				private _possibleLocations = [1,2,3,4,5,6];
				_possibleLocations = _possibleLocations - [_location];
				//Select a random new location
				private _randomIndex = floor(random(count _possibleLocations));
				private _destinationIndex = _possibleLocations select _randomIndex;
				if !((_vehicle getVariable ["cargoDestination",0]) isEqualTo 0) exitWith {oev_action_inUse = false;};
				//Set it on the vehicle
				_vehicle setVariable ["cargoDestination", _destinationIndex, true];
				private _oldCash = oev_cash;
				private _oldBank = oev_atmcash;
				if(oev_cash >= _purchasePrice) then {
					oev_cash = oev_cash - _purchasePrice;
					oev_cache_cash = oev_cache_cash - _purchasePrice;
				}else{
					oev_atmcash = oev_atmcash - _purchasePrice;
					oev_cache_atmcash = oev_cache_atmcash - _purchasePrice;
				};

				//Hint to the user
				hint parseText format["<t color='#00ff00'><t size='2'>Cargo Loaded</t></t><br/><br/>The cargo has been successfully loaded into your aircraft!<br/><br/>Your destination will be revealed once you enter the aircraft."];
				oev_action_inUse = false;

				//Log purchase
				[
					["event","Started Plane Delivery"],
					["player",name player],
					["player_id",getPlayerUID player],
					["position",getPosATL player]
				] call OEC_fnc_logIt;
			};
		} else {
			hint parseText format["<t color='#ff0000'><t size='2'>Cargo Failed</t></t><br/><br/>No suitable aircraft was found nearby to load the cargo!<br/><br/>Make sure you are within 20m of your Caesar BTT (armed or unarmed) to begin the delivery mission."];
		};
	};

	case "end":
	{
		if !(playerSide isEqualTo civilian) exitWith {hint parseText format["<t color='#ff0000'><t size='2'>Cargo Failed</t></t><br/><br/>You can't do plane missions as an APD or Rescue and Recovery member."];};
		if (oev_action_inUse) exitWith {};
		//Get all air vehicles nearby
		private _nearAirObjects = (position _caller) nearObjects ["Air", 40];
		//Loop through each object to determine if the object is a plane and is owned by the caller
		private _vehicleFound = false;
		private _vehicle = objNull;
		{
			private _owners = _x getVariable ["vehicle_info_owners",[]];
			if (count _owners > 0) then {
				//Is the player on the keychain
				private _onKeyChain = false;
				{
					if ((_x select 0) isEqualTo (getPlayerUID _caller)) then {
						_onKeyChain = true;
					};
				} forEach _owners;

				//If the person is on the vehicle keychain, the vehicle is an unarmed plane, and this location is the proper destination.
				if ((((typeOf _x) isEqualTo "C_Plane_Civil_01_F") || ((typeOf _x) isEqualTo "C_Plane_Civil_01_racing_F")) && ((_x getVariable ["cargoDestination",0]) isEqualTo _location) && _onKeyChain)	then {
						_vehicleFound = true;
						_vehicle = _x;
				};
			};
		} forEach _nearAirObjects;

		//Did we find a vehicle?
		if (_vehicleFound) then {
			//Make sure noone else is near the NPC to prevent duping
			private _nearUnits = (nearestObjects[_caller,["Man"],10]) arrayIntersect playableUnits;
			private _isNearKeyholder = false;
			if(count _nearUnits > 1) then {
				{
					if !(player isEqualTo _x) then {
						private _player = _x;
						private _ownerList = _vehicle getVariable ["vehicle_info_owners",[]];
						{
							if ((getPlayerUID _player) isEqualTo (_x select 0)) then {
								_isNearKeyholder = true;
							};
						} forEach _ownerList;
					};
				} forEach _nearUnits;
			};

			if !(_isNearKeyholder) then {
				oev_action_inUse = true;
				titleText ["Unloading cargo...","PLAIN DOWN",.3];
				uiSleep ceil(random(10));

				//Check to make sure that the cargo wasn't already unloaded
				if ((_vehicle getVariable ["cargoDestination", 0]) isEqualTo 0) exitWith {};

				//Reset cargo index on vehicle
				_vehicle setVariable ["cargoDestination", 0, true];
				if !(oev_currentDeliveryMarker isEqualTo "") then {
					deleteMarkerLocal oev_currentDeliveryMarker;
					oev_currentDeliveryMarker = "";
				};

				//Hint to the user
				hint parseText format["<t color='#00ff00'><t size='2'>Cargo Delivered</t></t><br/><br/>The cargo has been successfully delivered!<br/><br/> Well done, you have been paid $%1 for your efforts!",[_reward] call OEC_fnc_numberText];

				//Pay the person
				private _oldCash = oev_cash;
				private _oldBank = oev_atmcash;
				oev_cash = oev_cash + _reward;
				oev_cache_cash = oev_cache_cash + _reward;

				//Log purchase
				[
					["event","Sold Plane Delivery"],
					["player",name player],
					["player_id",getPlayerUID player],
					["value",_reward],
					["position",getPosATL player]
				] call OEC_fnc_logIt;

				oev_action_inUse = false;
			} else {
				hint parseText format["<t color='#ff0000'><t size='2'>Cargo Failed</t></t><br/><br/>You can't unload the cargo while a keyholder is near!"];
			};
		} else {
			hint parseText format["<t color='#ff0000'><t size='2'>Cargo Failed</t></t><br/><br/>No suitable aircraft was found nearby to take the cargo!<br/><br/>Make sure you are within 20m of your Caesar BTT (armed or unarmed) and are at the right drop-off to unload your cargo."];
		};
	};

	default
	{

	};
};
