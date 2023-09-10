#include "..\..\macro.h"
//  File: fn_ClchopShopBoatSell.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Sells the selected vehicle off.
disableSerialization;
private["_control","_price","_vehicle","_nearVehicles","_price2","_vehData","_vehOwnerStr","_playerUIDStr","_priceRnd","_vehicleArrayIndex"];
_control = ((findDisplay 39404) displayCtrl 39406);
_price = _control lbValue (lbCurSel _control);
_vehicleArrayIndex = _control lbData (lbCurSel _control);
_vehicleArrayIndex = call compile format["%1", _vehicleArrayIndex];
_nearVehicles = nearestObjects [getMarkerPos life_chopShop,["Ship","Submarine"],25];
_vehicle = _nearVehicles select _vehicleArrayIndex;
if !(_vehicle getVariable ["chopListIndex", -1] isEqualTo _vehicleArrayIndex) exitWith {hint "Vehicle was not found"};
if(isNull _vehicle) exitWith {hint "Vehicle does not exist.";};
private _vehicleData = _vehicle getVariable["vehicle_info_owners",[]];
if (count _vehicleData isEqualTo 0) then {
	oev_hackedChopShop = oev_hackedChopShop + 1;
	if (oev_hackedChopShop >= 2) then {
		[[profileName,format["Has attempted to sell %1 vehicles with no owner data!",oev_hackedChopShop]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	};
	[
		["event","Chop Shop Exploit"],
		["player_id",getPlayerUID player],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
};
if (count _vehicleData isEqualTo 0) exitWith {deleteVehicle _vehicle;closeDialog 0;hint "Vehicle had no owner data and has been deleted.";};

closeDialog 0;

[_vehicle,_price] spawn{
	_vehicle = _this select 0;
	_price = _this select 1;

	oev_action_inUse = true;
	hint "Inspecting vehicle...";
	uiSleep 5;
	uiSleep random(5);
	uiSleep random(10);

	if(isNull _vehicle) exitWith {hint "Vehicle does not exist.";oev_action_inUse = false;};
	if((vehicle player) != player) exitWith {hint "Please exit your current vehicle.";oev_action_inUse = false;};
	if!(alive player) exitWith {oev_action_inUse = false;};
	if!(isNull objectParent player) exitWith {oev_action_inUse = false;};
	if(player getVariable ["downed",false]) exitWith {};
	if(player getVariable ["restrained",false]) exitWith {};

	_price2 = oev_cash + _price;
	_priceRnd = oev_cache_cash + _price;
	[[player,_vehicle,_price,_price2,_priceRnd],"OES_fnc_chopShopSell",false,false] spawn OEC_fnc_MP;
	hint "Vehicle looks good, here's some cash...";
	[
		["event","BW Chop"],
		["player_id",getPlayerUID player],
		["target",typeOf _vehicle],
		["position",getPosATL player],
		["price", [_price] call OEC_fnc_numberText]
	] call OEC_fnc_logIt;
};
