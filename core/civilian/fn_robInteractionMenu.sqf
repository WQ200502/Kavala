//  File: fn_robInteractionMenu.sqf
//	Author: Kurt Reanolds
//	Description: What type of robbery?

#include <interaction.h>
private["_display","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7","_Btn8","_Btn9"];
if(!dialog) then {
	["pInteraction_Menu"] call OEC_fnc_createDialog;
};
disableSerialization;
params [
	["_curTarget",objNull,[objNull]]
];
if(isNull _curTarget) exitWith {}; //Bad target

if(!isPlayer _curTarget && side _curTarget isEqualTo civilian) exitWith {}; //Bad side check?
_display = findDisplay 37400;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;
_Btn3 = _display displayCtrl Btn3;
_Btn4 = _display displayCtrl Btn4;
_Btn5 = _display displayCtrl Btn5;
_Btn6 = _display displayCtrl Btn6;
_Btn7 = _display displayCtrl Btn7;
_Btn8 = _display displayCtrl Btn8;
_Btn9 = _display displayCtrl Btn9;
life_pInact_curTarget = _curTarget;

_Btn1 ctrlEnable true;
_Btn2 ctrlEnable true;
_Btn3 ctrlEnable true;
_Btn4 ctrlEnable true;
_Btn5 ctrlEnable true;
_Btn6 ctrlEnable true;
_Btn7 ctrlEnable true;
{_x ctrlShow false;} foreach [_Btn9];
//[target, "slot", time(s)] spawn OEC_fnc_stripGearCl;
//Set Rob money button
_Btn1 ctrlSetText "抢劫钱";
_Btn1 buttonSetAction "
	if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'};
	[life_pInact_curTarget] call OEC_fnc_robAction;
	closeDialog 0;
";

//Set Rob inventory button
_Btn2 ctrlSetText "抢劫库存";
_Btn2 buttonSetAction "
	if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'};
	[life_pInact_curTarget, ""inventory"", 6] spawn OEC_fnc_stripGearCl;
	closeDialog 0;
";

//Set Rob backpack button
_Btn3 ctrlSetText "抢劫背包";
_Btn3 buttonSetAction "
	if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'};
	[life_pInact_curTarget, ""backpack"", 8] spawn OEC_fnc_stripGearCl;
	closeDialog 0;
";

//Set Rob headgear button
_Btn4 ctrlSetText "抢劫帽子";
_Btn4 ctrlEnable true;
_Btn4 buttonSetAction "
	if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'};
	[life_pInact_curTarget, ""headgear"", 4] spawn OEC_fnc_stripGearCl;
	closeDialog 0;
";

//Set Rob uniform button
_Btn5 ctrlSetText "抢劫衣服";
_Btn5 buttonSetAction "
	if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'};
	[life_pInact_curTarget, ""uniform"", 10] spawn OEC_fnc_stripGearCl;
	closeDialog 0;
";

//Set Rob vest button
_Btn6 ctrlSetText "抢劫背心";
_Btn6 buttonSetAction "
	if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'};
	[life_pInact_curTarget, ""vest"", 8] spawn OEC_fnc_stripGearCl;
	closeDialog 0;
";

//Set Rob weapons button
_Btn7 ctrlSetText "抢劫武器";
_Btn7 ctrlEnable true;
_Btn7 buttonSetAction "
	if(player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'};
	[life_pInact_curTarget, ""weapon"", 6] spawn OEC_fnc_stripGearCl;
	closeDialog 0;
";

// Neuter Player
_Btn8 ctrlSetText "开火。 别针";
_Btn8 ctrlEnable true;
_Btn8 buttonSetAction "if (player distance life_pInact_curTarget > 4) exitWith {hint '你离的太远了!'}; [life_pInact_curTarget, 6] spawn OEC_fnc_neuterActionCl; closeDialog 0;";
