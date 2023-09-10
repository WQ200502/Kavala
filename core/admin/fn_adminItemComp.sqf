#include "..\..\macro.h"
//  File: fn_adminItemComp.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Prelude to opening compensation menus for admins on admin island.
params [
	["_mode",-1,[0]]
];
if (__GETC__(life_adminlevel) < 3) exitWith {};

if (!dialog) then {["life_admin_itemComp"] call OEC_fnc_createDialog;}else{closeDialog 0; ["life_admin_itemComp"] call OEC_fnc_createDialog;};
disableSerialization;

private _display = (findDisplay (100200));
private _confirmBtn = _display displayCtrl 100204;

switch (_mode) do {
	case 1: {
		_confirmBtn buttonSetAction "[ctrlText 100201,ctrlText 100202,1] call OEC_fnc_adminLogging; closeDialog 0; [nil,nil,nil,'bwadmin'] spawn OEC_fnc_weaponShopMenu;";
	};

	case 2: {
		_confirmBtn buttonSetAction "[ctrlText 100201,ctrlText 100202,2] call OEC_fnc_adminLogging; closeDialog 0; [nil,nil,nil,'adminclothing'] spawn OEC_fnc_weaponShopMenu;";
	};

	case 3: {
		_confirmBtn buttonSetAction "[ctrlText 100201,ctrlText 100202,3] call OEC_fnc_adminLogging; closeDialog 0; [nil,nil,nil,'admin'] spawn OEC_fnc_virt_menu;";
	};

	case 4: {
		_confirmBtn buttonSetAction "[ctrlText 100201,ctrlText 100202,4] call OEC_fnc_adminLogging; closeDialog 0; [] spawn OEC_fnc_adminVehComp;";
	};
	case 5: {
		_confirmBtn buttonSetAction "[ctrlText 100201,ctrlText 100202,5] call OEC_fnc_adminLogging; closeDialog 0; [nil,nil,nil,'copadmin'] spawn OEC_fnc_weaponShopMenu;";
	};
};