//  File: fn_copTrainSeize.sqf
//	Author: Fusah
//	Description: TRAIN ME BABYYYYYYYYYYYYYY

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

{_x ctrlShow false;} foreach [_Btn4,_Btn5,_Btn6,_Btn7,_Btn8];


_Btn1 ctrlSetText "许可证吊销菜单";
_Btn1 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_copTrainRevoke;"; // JESUS FUCK ANOTHER SCRIPT

//Set Seize illegal items button
_Btn2 ctrlSetText "查获非法物品/毒品";
_Btn2 buttonSetAction "hint 'Congrats you seized his illegal stuffs!'; closeDialog 0;";

//Set Seize illegal items button
_Btn3 ctrlSetText "没收非法武器/装备";
_Btn3 buttonSetAction "hint 'Congrats you seized his illegal pewpew!'; closeDialog 0;";

