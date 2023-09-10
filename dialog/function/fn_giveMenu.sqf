//  File: fn_giveMenu.sqf
//	Author: Matt "codeYeTi" Coffin
//	Description: Opens the "give" sub-menu of the player interaction menu
["pInteraction_Menu"] call OEC_fnc_createDialog;
waitUntil { !isNull findDisplay 37400 };
[
	[
		"给钱",
		"if (oev_cash <= 0) exitWith { hint ""You have no cash to give!""; }; player setVariable ['life_extraInventoryTargets', [life_pInact_curTarget]]; [] spawn{ ['yMenuMain'] call OEC_fnc_createDialog; }; closeDialog 0;"
	],
	[
		"给物品",
		"player setVariable ['life_extraInventoryTargets', [life_pInact_curTarget]]; [] spawn{ ['yMenuInventory'] call OEC_fnc_createDialog; }; closeDialog 0;"
	],
	[
		"给钥匙",
		"player setVariable ['life_extraInventoryTargets', [life_pInact_curTarget]]; [] spawn{ ['yMenuKeyChain'] call OEC_fnc_createDialog; }; closeDialog 0;"
	]
] call OEC_fnc_setupInteractionMenu;
