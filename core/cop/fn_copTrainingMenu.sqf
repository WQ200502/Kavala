//  File: fn_copTrainingMenu.sqf
//	Author: Fusah
//	Description: Lets Derputies learn how2cop.

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
_Btn9 = _display displayCtrl Btn9;
life_pInact_curTarget = _curTarget;

//Set Unrestrain Button
_Btn1 ctrlSetText localize "STR_pInAct_Unrestrain";
_Btn1 buttonSetAction "hint '干得好你放了他！'; closeDialog 0;";

//Set Search Menu
_Btn2 ctrlSetText "搜索菜单";
_Btn2 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_copTrainSearch;";

//Set Seize Menu
_Btn3 ctrlSetText "抓捕菜单";
_Btn3 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_copTrainSeize;";

//Set Escort Button
_Btn4 ctrlSetText localize "STR_pInAct_Escort";
_Btn4 buttonSetAction "hint '恭喜你把这个罪犯带走了！'; closeDialog 0;";

//Set Ticket Button
_Btn5 ctrlSetText localize "STR_pInAct_TicketBtn";
_Btn5 buttonSetAction "['life_ticket_train'] call OEC_fnc_createDialog;";

//Set Arrest Button
_Btn6 ctrlSetText localize "STR_pInAct_Arrest";
_Btn6 buttonSetAction "hint '恭喜你把这个罪犯送进监狱！'; closeDialog 0;";

//PUT ER IN
_Btn7 ctrlSetText localize "STR_pInAct_PutInCar";
_Btn7 buttonSetAction "hint '恭喜你把罪犯放进你的车里！'; closeDialog 0;";

//who turned off the lights ;)
_Btn8 ctrlSetText "戴上头套";
_Btn8 buttonSetAction "hint '谁把灯关了？'; closeDialog 0;";
_Btn9 ctrlShow false;