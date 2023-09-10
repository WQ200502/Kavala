#include "..\..\macro.h"
//  File: fn_ClimpoundYardImpound.sqf
//	Author: [OS] Odin
//	Description: Impounds the selected vehicle.
disableSerialization;
private["_control","_price","_vehicle","_nearVehicles","_price2","_vehData","_vehOwnerStr","_playerUIDStr","_priceRnd","_gangID","_gangName"];
_control = ((findDisplay 39600) displayCtrl 39602);
_price = _control lbValue (lbCurSel _control);
_vehicle = _control lbData (lbCurSel _control);
_vehicle = call compile format["%1", _vehicle];
_nearVehicles = nearestObjects [getMarkerPos life_impoundYard,["Car","Truck","Air","Ship","Submarine"],10];
_vehicle = _nearVehicles select _vehicle;
if(isNull _vehicle) exitWith {hint "Vehicle does not exist.";};
closeDialog 0;

[_vehicle,_price] spawn{
	_vehicle = _this select 0;
	_price = _this select 1;
	private _vehicleName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
	private _gangID = _vehicle getVariable ["gangID",0];
	private _gangName = _vehicle getVariable ["gangName",""];

	oev_action_inUse = true;
	hint "Inspecting vehicle...";
	uiSleep 5;
	hint "Registering vehicle in system...";
	uiSleep random(5);
	hint "Assigning storage location...";
	uiSleep random(10);

	if(isNull _vehicle) exitWith {hint "Vehicle does not exist.";};

	[_vehicle,true,player] remoteExec ["OES_fnc_vehicleStore",2];

	private _perkTier = ["med_impounds"] call OEC_fnc_fetchStats;
	private _impoundIncrease = switch (_perkTier) do {
		case 1: {1.02};
		case 2: {1.04};
		case 3: {1.06};
		case 4: {1.08};
		case 5: {1.10};
		default {1};
	};
	_price = _price * _impoundIncrease;
	if (_impoundIncrease != 1) then {
		hint format["Everything checks out, vehicle has been impounded. You recieved %1 for the impound due to your total impounds!",[_price] call OEC_fnc_numberText];
	} else {
		hint "Everything checks out, vehicle has been impounded....";
	};
	["med_impounds",1] call OEC_fnc_statArrUp;
	oev_atmcash = oev_atmcash + _price;
	oev_cache_atmcash = oev_cache_atmcash + _price;
	oev_action_inUse = false;
	_own = (((_vehicle getVariable["vehicle_info_owners",""]) select 0) select 1);
	if !(_gangID isEqualTo 0) then {
		_own = _gangName;
	};
	[0,format["%1 has impounded %2's %3",name player,_own,_vehicleName]] remoteExec ["OEC_fnc_broadcast",-2];
	[
		["event","Medic Vehicle Impound"],
		["player",name player],
		["player_id",getPlayerUID player],
		["target",_own],
		["vehicle",_vehicleName],
		["value",_price]
	] call OEC_fnc_logIt;
};
