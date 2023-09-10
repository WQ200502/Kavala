//  File: fn_revokeInteractionMenu.sqf
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

{_x ctrlShow true;} foreach [_Btn3,_Btn4,_Btn5];
{_x ctrlShow false;} foreach [_Btn6,_Btn7,_Btn8];

//Set Seize drivers license
_Btn1 ctrlSetText "吊销驾照";
_Btn1 buttonSetAction "[[1],""OEC_fnc_revokePlayerLicense"",life_pInact_curTarget,FALSE] spawn OEC_fnc_MP; hint ""Drivers license revoked"";";

//Set Seize firearms license
_Btn2 ctrlSetText "吊销枪支许可证";
_Btn2 buttonSetAction "[[2],""OEC_fnc_revokePlayerLicense"",life_pInact_curTarget,FALSE] spawn OEC_fnc_MP; hint ""Firearms license revoked"";";

//Set Seize wpl license
_Btn3 ctrlSetText "吊销WP许可证";
_Btn3 buttonSetAction "[[3],""OEC_fnc_revokePlayerLicense"",life_pInact_curTarget,FALSE] spawn OEC_fnc_MP; hint ""Workers Protection license revoked"";";

//Set Seize vigilante license
_Btn4 ctrlSetText "吊销义警许可证";
_Btn4 buttonSetAction "[[4,player],""OEC_fnc_revokePlayerLicense"",life_pInact_curTarget,FALSE] spawn OEC_fnc_MP; hint ""Vigilante license revoked"";";

//Set Downgrade Vigilante License
_Btn5 ctrlSetText "降低赏金猎人等级";
_Btn5 buttonSetAction "[[5,player],""OEC_fnc_revokePlayerLicense"",life_pInact_curTarget,FALSE] spawn OEC_fnc_MP; hint""Vigilante tier downgraded"";";