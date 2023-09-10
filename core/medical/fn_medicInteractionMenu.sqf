//  File: fn_medicInteractionMenu.sqf
//	Author: [OS] Odin
//	Description: Replaces the mass addactions for various medic actions towards another player.

private["_display","_curTarget","_Btn1","_fnc_setupGiveKey"];
if(!dialog) then {
	["pInteraction_Menu"] call OEC_fnc_createDialog;
};
disableSerialization;
_curTarget = param [0,ObjNull,[ObjNull]];
if(isNull _curTarget) exitWith {closeDialog 0;};

if(!isPlayer _curTarget && side _curTarget isEqualTo civilian) exitWith {closeDialog 0;}; //Bad side check?

// Set Target
life_pInact_curTarget = _curTarget;

private _buddyButton = if (isNull life_buddyObj) then {
	["Request Buddy", "hint 'Sending buddy offer...'; [[player, getPlayerUID player, 0],'OEC_fnc_medicBuddy',life_pInact_curTarget,false] spawn OEC_fnc_MP;"]
} else {
	["End Buddy", "hint 'Ending buddy agreement...'; [[player, getPlayerUID player, 1],'OEC_fnc_medicBuddy',life_pInact_curTarget,false] spawn OEC_fnc_MP;life_buddyObj = objNull;life_buddyPID = '';"]
};
_buddyButton pushBack { side life_pInact_curTarget isEqualTo independent };

if (side _curTarget isEqualTo independent && !(isNull life_buddyObj) && !([life_buddyPID] call OEC_fnc_isUIDActive)) exitWith {
	life_buddyObj = objNull;
	life_buddyPID = "";
	closeDialog 0;
	hint "Buddy no longer exists on the server. Removing data... reopen and try again";
};

[
	// Invoice Button
	[localize "STR_pInAct_InvoiceBtn", "[life_pInact_curTarget] call OEC_fnc_medicInvoiceAction;"],
	// Give Button
	[localize "STR_Global_Give", "[] spawn OEC_fnc_giveMenu; closeDialog 0;"],
	// Give Lolipop
	["Give Lollipop", "[life_pInact_curTarget, ""lollypop""] call OEC_fnc_medicQuickGive;"],
	// Request Buddy
	_buddyButton
] call OEC_fnc_setupInteractionMenu;
