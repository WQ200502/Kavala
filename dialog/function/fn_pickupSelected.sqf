// File: fn_pickupSelected.sqf
// Author:Ozadu
// Called when a item is selected in the pickup menu

private["_selectedItem","_items"];
disableSerialization;

_selectedItem = lbData[7126,lbCurSel (7126)];
_obj = uiNamespace getVariable _selectedItem;
_items = _obj getVariable "O_droppedItem";

if !(oev_action_pickingUp) then {
	oev_action_pickingUp = true;
	{
		if ((_x select 0) isEqualTo _selectedItem) then {
			[_obj,(_x select 0),(_x select 1)] spawn OEC_fnc_pickupItem;
		};
	} forEach _items;
};
