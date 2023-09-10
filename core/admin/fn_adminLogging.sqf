//  File: fn_adminLogging.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Handles logging after the item comp is used.

params [
	["_ticket","",[""]],
	["_message","",[""]],
	["_mode",-1,[0]]
];

if (_ticket isEqualTo "" || _message isEqualTo "" || _mode isEqualTo -1) exitWith {hint "An error has occured. Please retry."; closeDialog 0;};

private _shop = switch (_mode) do {
	case 1: {"Blackwater Weapons"};
	case 2: {"Restricted Clothing"};
	case 3: {"Virtual Items"};
	case 4: {"Vehicle Compensation"};
	case 5: {"Cop Weapon Compensation"};
	default {""};
};

if (_shop isEqualTo "") exitWith {hint "An error has occured. Please retry."; closeDialog 0;};
