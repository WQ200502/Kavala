#include "..\..\macro.h"
//  File: fn_sellGarage.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Sells a vehicle from the garage.
private _confirm = [
	format ["Are you sure you want to sell that vehicle?"],
	"Confirm Vehicle Sell",
	"Yes",
	"No"
] call BIS_fnc_guiMessage;
if !(_confirm) exitWith {closeDialog 0};
disableSerialization;
if (lbCurSel 2802 isEqualTo -1) exitWith {hint localize "STR_Global_NoSelection";};
private _vehicle = lbData[2802,(lbCurSel 2802)];
private _vid = (call compile format["%1",_vehicle]) select 5;
_vehicle = (call compile format["%1",_vehicle]) select 0;
//private _vid = lbValue[2802,(lbCurSel 2802)];

if (isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error";};

if (_vid isEqualTo oev_previousVehicleSold) exitWith {hint "您不能两次出售同一辆车。";};
oev_previousVehicleSold = _vid;

private _price = 1000;
private _sellPct = 0.4;
private _vehicleDetails = ["allVehicles", _vehicle] call OEC_fnc_vehicleConfig;
if(count _vehicleDetails > 0) then {
	_price = ((_vehicleDetails select 6) * __GETC__(life_medDis) * _sellPct);
};

[[_vid,(getPlayerUID player),_price,player,oev_garage_type],"OES_fnc_vehicleDelete",false,false] spawn OEC_fnc_MP;
hint format[localize "STR_Garage_SoldCar",[_price] call OEC_fnc_numberText];

oev_atmcash = oev_atmcash + _price;
oev_cache_atmcash = oev_cache_atmcash + _price;
[
	["event", "Garage Sell"],
	["player_id", getPlayerUID player],
	["vehicle_id", _vid],
	["value", _price],
	["position", getPos player]
] call OEC_fnc_logIt;
closeDialog 0;
