//  File: fn_removeItem.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Removes the selected item & amount to remove from the players virtual inventory.
private["_data","_value","_obj","_pos","_ind"];
disableSerialization;
_data = lbData[31010,(lbCurSel 31010)];
_value = ctrlText 31012;
if (_data == "") exitWith {hint "You didn't select anything to remove.";};
if (!([_value] call OEC_fnc_isNumeric)) exitWith {hint "You didn't enter an actual number format."};
if (parseNumber(_value) <= 0) exitWith {hint "You need to enter an actual amount you want to remove."};
_ind = [_data,oev_illegal_items] call OEC_fnc_index;
if ((_ind != -1 && ([west,getPos player,100] call OEC_fnc_nearUnits)) && !(playerSide isEqualTo west)) exitWith {titleText["This is an illegal item and cops are near by, you cannot dispose of the evidence","PLAIN DOWN"]};
if (player != vehicle player) exitWith {titleText["You cannot remove an item when you are in a vehicle.","PLAIN DOWN"]};
if (!([false,_data,(parseNumber _value)] call OEC_fnc_handleInv)) exitWith {hint "Couldn't remove that much of that item, maybe you don't have that amount?"};
if (player getVariable ["restrained",false]) exitWith {hint "You cannot remove items from inventory while you are restrained.";};

_type = [_data,0] call OEC_fnc_varHandle;
_type = [_type] call OEC_fnc_varToStr;
hint format["You have successfully removed %1 %2 from your inventory.",(parseNumber _value), _type];

[] call OEC_fnc_updateInventoryTab;