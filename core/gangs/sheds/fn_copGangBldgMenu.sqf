#include "..\..\..\macro.h"
#include <interaction.h>
//  File: fn_copGangBldgMenu.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Options for cops on gang buildings

if (!dialog) then {["pInteraction_Menu"] call OEC_fnc_createDialog;};
disableSerialization;
params [["_building",objNull,[objNull]]];
if (isNull _building) exitWith {closeDialog 0;};
if (oev_action_inUse) exitWith {closeDialog 0;};
if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") exitWith {closeDialog 0;};
if !(playerSide isEqualTo west) exitWith {closeDialog 0;};
if (isNil {_building getVariable "bldg_gangName"} || isNil {_building getVariable "bldg_gangid"}) exitWith {closeDialog 0;};

private _display = findDisplay 37400;
private _Btn1 = _display displayCtrl Btn1;
private _Btn2 = _display displayCtrl Btn2;
private _Btn3 = _display displayCtrl Btn3;
private _Btn4 = _display displayCtrl Btn4;
private _Btn5 = _display displayCtrl Btn5;
private _Btn6 = _display displayCtrl Btn6;
private _Btn7 = _display displayCtrl Btn7;
private _Btn8 = _display displayCtrl Btn8;
private _Btn9 = _display displayCtrl Btn9;
{_x ctrlShow false;} forEach [_Btn1,_Btn2,_Btn3,_Btn4,_Btn5,_Btn6,_Btn7,_Btn8,_Btn9];

life_pInact_curTarget = _building;

if ((typeOf _building isEqualTo "Land_i_Shed_Ind_F") && {playerSide isEqualTo west}) then {
	private _onlineMembers = ([(_building getVariable "bldg_gangid")] call OEC_fnc_getOnlineMembers);

	_Btn1 ctrlSetText "搜索属性所有者";
	_Btn1 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_copHouseOwner; closeDialog 0;";
	_Btn1 ctrlShow true;

	if (count _onlineMembers > 0) then {
		if (__GETC__(life_coplevel) >= 3) then {
		_Btn2 ctrlSetText "解锁所有车门";
		_Btn2 buttonSetAction "[life_pInact_curTarget,0] call OEC_fnc_doorManager; closeDialog 0;";
		_Btn2 ctrlShow true;

		_Btn3 ctrlSetText "锁上所有车门";
		_Btn3 buttonSetAction "[life_pInact_curTarget,1] call OEC_fnc_doorManager; closeDialog 0;";
		_Btn3 ctrlShow true;
		};

		if (__GETC__(life_coplevel) >= 6) then {
			_Btn4 ctrlSetText "搜索建筑物";
			_Btn4 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_gangBldgSearch; closeDialog 0;";
			_Btn4 ctrlShow true;
		};

		if (player distance _building > 12) then {_Btn4 ctrlEnable false;};
	};
} else {
	closeDialog 0;
};
