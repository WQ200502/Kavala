//  File: fn_seizeInteractionMenu.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Replaces the mass for various cop actions towards another player.

#include <interaction.h>
private["_display","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7","_Btn8"];
if(!dialog) then {
	["pInteraction_Menu"] call OEC_fnc_createDialog;
};
disableSerialization;
params [
	["_curTarget",objNull,[objNull]]
];
if(isNull _curTarget) exitWith {closeDialog 0;}; //Bad target
if(!isPlayer _curTarget && side _curTarget isEqualTo civilian) exitWith {closeDialog 0;}; //Bad side check?
life_pInact_curTarget = _curTarget;
[
	["许可证吊销", "[life_pInact_curTarget] call OEC_fnc_revokeInteractionMenu;"],
	["没收非法物品", "[[1,player],""OEC_fnc_seizePlayerItems"",life_pInact_curTarget,FALSE] spawn OEC_fnc_MP;"],
	["没收非法武器", "[[2,player],""OEC_fnc_seizePlayerItems"",life_pInact_curTarget,FALSE] spawn OEC_fnc_MP;"],
	["黑掉手头现金", "[life_pInact_curTarget] spawn OEC_fnc_seizeMoneyConfirmation;"],
	["拆除玩家撞针", "if (player distance life_pInact_curTarget > 4) exitWith {hint 'You are too far away.'}; [life_pInact_curTarget, 6] spawn OEC_fnc_neuterActionCl; closeDialog 0;"]
] call OEC_fnc_setupInteractionMenu;
