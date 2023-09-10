//  File: fn_copTrainRevoke.sqf
//	Author: Fusah
//	Description: click button and get hint simulator

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

_display = findDisplay 37400;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;
_Btn3 = _display displayCtrl Btn3;
_Btn4 = _display displayCtrl Btn4;
_Btn5 = _display displayCtrl Btn5;
_Btn6 = _display displayCtrl Btn6;
_Btn7 = _display displayCtrl Btn7;
_Btn8 = _display displayCtrl Btn8;
life_pInact_curTarget = _curTarget;

{_x ctrlShow true;} foreach [_Btn3,_Btn4];
{_x ctrlShow false;} foreach [_Btn5,_Btn6,_Btn7,_Btn8];

//Set Seize drivers license
_Btn1 ctrlSetText "吊销驾驶执照";
_Btn1 buttonSetAction "hint 'Congrats you revoked his Drivers licence!'; closeDialog 0;";

//Set Seize firearms license
_Btn2 ctrlSetText "吊销枪支许可证";
_Btn2 buttonSetAction "hint 'Congrats you revoked his Firearms licence!'; closeDialog 0;";

//Set Seize wpl license
_Btn3 ctrlSetText "吊销WP许可证";
_Btn3 buttonSetAction "hint 'Congrats you revoked his Workers Protection licence!'; closeDialog 0;";

//Set Seize vigilante license
_Btn4 ctrlSetText "吊销义警许可证";
_Btn4 buttonSetAction "hint 'Congrats you revoked his Vigilante licence!'; closeDialog 0;";
