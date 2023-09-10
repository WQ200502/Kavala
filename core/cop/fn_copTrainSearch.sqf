//  File: fn_copTrainSearch.sqf
//	Author: Fusah
//	Description: your MISSING me babie

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

{_x ctrlShow false;} foreach [_Btn3,_Btn4,_Btn5,_Btn6,_Btn7,_Btn8];

life_pInact_curTarget = _curTarget;

//Set Check Licenses Button
_Btn1 ctrlSetText localize "STR_pInAct_checkLicenses";
_Btn1 buttonSetAction "hint parseText (['license_fake'] call OEC_fnc_varToStr); closeDialog 0;";

//Set Search Button
_Btn2 ctrlSetText localize "STR_pInAct_SearchPlayer";
_Btn2 buttonSetAction "hint parseText (['fake_search'] call OEC_fnc_varToStr); closeDialog 0;";