//  File: fn_searchInteractionMenu.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Replaces the mass for various cop actions towards another player.

#include <interaction.h>
private["_display","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7","_Btn8","_Btn9"];
if(!dialog) then {
	["pInteraction_Menu"] call OEC_fnc_createDialog;
};
disableSerialization;
params [
	["_curTarget",objNull,[objNull]]
];
if(isNull _curTarget) exitWith {closeDialog 0;}; //Bad target

if(!isPlayer _curTarget && side _curTarget isEqualTo civilian) exitWith {closeDialog 0;}; //Bad side check?
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

{_x ctrlShow false;} foreach [_Btn3,_Btn4,_Btn5,_Btn6,_Btn7,_Btn8,_Btn9];

life_pInact_curTarget = _curTarget;

//Set Check Licenses Button
_Btn1 ctrlSetText localize "STR_pInAct_checkLicenses";
_Btn1 buttonSetAction "[[player],""OEC_fnc_licenseCheck"",life_pInact_curTarget,FALSE] spawn OEC_fnc_MP;";

//Set Search Button
_Btn2 ctrlSetText localize "STR_pInAct_SearchPlayer";
_Btn2 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_searchAction;";
