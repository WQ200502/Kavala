// File: fn_setupPickupMenu.sqf
// Author: Ozadu
// Sets up all the pickup data

private["_pickupList","_itemName","_dollarValue","_text","_data","_UINS","_i","_inUse"];
params [
	["_obj",objNull,[objNull]]
];
if(isNull _obj) exitWith {};
if(getPlayerUID (_obj getVariable["inUse", ObjNull]) != (getPlayerUID player)) exitWith{};
["life_pickup_menu"] call OEC_fnc_createDialog;

disableSerialization;
waitUntil{!isNull findDisplay 7125};
_pickupList = ((findDisplay 7125) displayCtrl 7126);

_data = _obj getVariable "O_droppedItem";
//keep it updated
if !(isNull _obj) then {
	lbClear _pickupList;
	{
		if (_x select 0 isEqualTo "money") then {
			_itemName = "Money";
			_dollarValue = [_x select 1] call OEC_fnc_numberText;
			_text = format["%1 ($%2)",_itemName, _dollarValue];
		} else {
			_itemName = [([_x select 0,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr;
			_text = format["%1 (%2)",_itemName, _x select 1];
		};
		_UINS = uiNamespace setVariable [_x select 0,_obj];
		_i = _pickupList lbAdd _text;
		_pickupList lbSetData [_i,_x select 0];
	} forEach _data;
};
waitUntil{isNull findDisplay 7125 || getPlayerUID (_obj getVariable["inUse", ObjNull]) != (getPlayerUID player)};
if (isNull findDisplay 7300)then { //Checks to see if the deathScreen is open
	closeDialog 0;
};
_obj setVariable["inUse",ObjNull,true];
oev_action_pickingUp = false;
