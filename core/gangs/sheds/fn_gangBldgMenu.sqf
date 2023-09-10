#include "..\..\..\macro.h"
//  File: fn_gangBldgMenu.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Called from ActionKeyHandler when looking at a gang building...

if (!dialog) then {["gangShedMenu"] call OEC_fnc_createDialog;};
disableSerialization;
params [["_building",objNull,[objNull]]];
if (isNull _building) exitWith {closeDialog 0;};
if (oev_action_inUse) exitWith {closeDialog 0;};
if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") exitWith {closeDialog 0;};
if (_building getVariable ["restricted_shed",false]) exitWith {hint "This building is restricted and cannot be purchased."; closeDialog 0;};
if !(playerSide isEqualTo civilian) exitWith {closeDialog 0;};
if (((count oev_gang_data) isEqualTo 0) && ((_building getVariable "bldg_owner") != (getPlayerUID player))) exitWith {closeDialog 0; hint "You must be in a gang or the property owner!";};

private _display = findDisplay 100000;
private _Btn1 = _display displayCtrl 100050;
private _Btn2 = _display displayCtrl 100051;
private _Btn3 = _display displayCtrl 100052;
private _Btn4 = _display displayCtrl 100053;
private _Btn5 = _display displayCtrl 100054;
private _Btn6 = _display displayCtrl 100055;
private _Btn7 = _display displayCtrl 100056;
private _Btn8 = _display displayCtrl 100057;
private _Btn9 = _display displayCtrl 100058;
private _Btn10 = _display displayCtrl 100059;
private _Btn11 = _display displayCtrl 100060;
private _Btn12 = _display displayCtrl 100062;
private _Btn13 = _display displayCtrl 100063;
private _text = _display displayCtrl 100061;
{_x ctrlShow false;} forEach [_Btn1,_Btn2,_Btn3,_Btn4,_Btn5,_Btn6,_Btn7,_Btn8,_Btn9,_Btn10,_Btn11,_Btn12,_Btn13];

life_pInact_curTarget = _building;

if ((!((_building getVariable ["bldg_gangName",""]) isEqualTo (oev_gang_data select 1))) || isNil {_building getVariable "bldg_owner"} || isNil {_building getVariable "bldg_gangName"}) then {
	if (_building in life_houses) then {life_houses = life_houses - [_building];};
	if ((!isNil {_building getVariable "bldg_owner"}) || (!isNil {_building getVariable "bldg_gangName"})) then {
		_Btn1 ctrlSetText "已拥有";
		_Btn1 ctrlShow true;
		_Btn1 ctrlEnable false;
	} else {
		if ((oev_gang_data select 2) isEqualTo 5) then {
			_Btn1 ctrlSetText "购买建筑物";
			_Btn1 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_buyGangBldg; closeDialog 0;";
			_Btn1 ctrlShow true;
		} else {
			_Btn1 ctrlSetText "军衔不足";
			_Btn1 ctrlShow true;
			_Btn1 ctrlEnable false;
		};
	};
} else {
	if ((_building getVariable ["bldg_gangName",""]) isEqualTo (oev_gang_data select 1)) then {
		if (isNull(_building getVariable ["lightSource",ObjNull])) then {
			_Btn1 ctrlSetText localize "STR_pInAct_LightsOn";
		} else {
			_Btn1 ctrlSetText localize "STR_pInAct_LightsOff";
		};
		_Btn1 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_light1HouseAction; closeDialog 0;";
		_Btn1 ctrlShow true;

		_Btn2 ctrlSetText "升级虚拟存储";
		_Btn2 buttonSetAction "[life_pInact_curTarget,true] spawn OEC_fnc_addGangInv; closeDialog 0;";
		_Btn2 ctrlShow true;
		if ((_building getVariable ["storageCapacity",10000]) >= 10000) then {
			_Btn2 ctrlSetText "完全升级";
			_Btn2 buttonSetAction "";
			_Btn2 ctrlEnable false;
		};

		_Btn3 ctrlSetText "升级物理存储";
		_Btn3 buttonSetAction "[life_pInact_curTarget,false] spawn OEC_fnc_addGangInv;closeDialog 0;";
		_Btn3 ctrlShow true;
		if ((_building getVariable ["physicalStorageCapacity",10000]) >= 900) then {
			_Btn3 ctrlSetText "全面升级";
			_Btn3 buttonSetAction "";
			_Btn3 ctrlEnable false;
		};

		_Btn12 ctrlSetText "添加机油存储";
		_Btn12 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_addGangOil; closeDialog 0;";
		_Btn12 ctrlShow true;
		if (_building getVariable ["oilstorage",false]) then {
			_Btn12 ctrlEnable false;
		};

		if ((oev_gang_data select 2) < 4) then {
			_Btn2 ctrlEnable false;
			_Btn3 ctrlEnable false;
			_Btn12 ctrlEnable false;
		};

		_Btn4 ctrlSetText "解锁所有车门";
		_Btn4 buttonSetAction "[life_pInact_curTarget,0] call OEC_fnc_doorManager; closeDialog 0;";
		_Btn4 ctrlShow true;

		_Btn5 ctrlSetText "锁上所有车门";
		_Btn5 buttonSetAction "[life_pInact_curTarget,1] call OEC_fnc_doorManager; closeDialog 0;";
		_Btn5 ctrlShow true;
	};

	if ((oev_gang_data select 2) >= 1) then {
		_Btn7 ctrlShow true;
		if (_building getVariable ["inv_locked",false]) then {
			_Btn7 ctrlSetText "解锁存储";
			_Btn7 buttonSetAction "[life_pInact_curTarget,0] call OEC_fnc_unlockInv; closeDialog 0;";
		} else {
			_Btn7 ctrlSetText "锁上存储";
			_Btn7 buttonSetAction "[life_pInact_curTarget,1] call OEC_fnc_unlockInv; closeDialog 0;";
		};
	};

	if ((oev_gang_data select 2) >= 1) then {
		_Btn6 ctrlShow true;
		if (_building getVariable ["locked",false]) then {
			_Btn6 ctrlSetText "解锁物理存储";
			_Btn6 buttonSetAction "life_pInact_curTarget setVariable [""locked"",false,true];titleText[""Building physical storage is now unlocked."",""PLAIN DOWN""]; closeDialog 0;";
		} else {
			_Btn6 ctrlSetText "锁定物理存储";
			_Btn6 buttonSetAction "life_pInact_curTarget setVariable [""locked"",true,true];titleText[""Building physical storage is now locked."",""PLAIN DOWN""]; closeDialog 0;";
		};
	};

	_Btn13 ctrlShow true;
	_Btn13 ctrlSetText "添加帮派车辆";
	_Btn13 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_claimGangVeh; closeDialog 0;";

	if (((_building getVariable "bldg_owner") isEqualTo (getPlayerUID player)) || ((oev_gang_data select 2) isEqualTo 5)) then {
		_Btn8 ctrlSetText "出售建筑物";
		_Btn8 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_gangSellBldg; closeDialog 0;";
		_Btn8 ctrlShow true;
	};

	_Btn9 ctrlSetText localize "STR_pInAct_AccessGarage";
	_Btn9 buttonSetAction "[life_pInact_curTarget,""Car""] spawn OEC_fnc_shedGarage; closeDialog 0;";
	_Btn9 ctrlShow true;

	_Btn10 ctrlSetText localize "STR_pInAct_StoreVeh";
	_Btn10 buttonSetAction "[life_pInact_curTarget,player] spawn OEC_fnc_storeVehicle; closeDialog 0;";
	_Btn10 ctrlShow true;

	private _storageCap = _building getVariable ["storageCapacity",-33];
	private _physicalStorageCap = _building getVariable ["physicalStorageCapacity",-33];
	if (_storageCap isEqualTo -33 || _physicalStorageCap isEqualTo -33) exitWith {closeDialog 0;};
	private _payment = _building getVariable ["bldg_payment",[]];
	if ((count _payment) < 2) exitWith {closeDialog 0;};
	private _cost = (_storageCap * 50);
	private _time = (_payment select 0);
	private _paid = (_payment select 1);

	if (_time <= 1) then {
		_time = "< 24 Hours";
	} else {
		_time = format ["%1 Days",_time];
	};

	//hint str _payment;

	switch(_paid) do { // i understand that there are two switches for _paid, but i figured it might be better to keep these seperated.
		case 0: {_text ctrlSetStructuredText parseText format ["Virtual Storage Capacity: %1<br/>Physical Storage Capacity: %2<br/>Payment Status: <t color='#FF0000'>Not Recieved</t><br/>Remaining Time: <t color='#FF0000'>%3</t><br/>Payment Due: $%4",_storageCap,_physicalStorageCap,_time,[_cost] call OEC_fnc_numberText];};
		case 1: {_text ctrlSetStructuredText parseText format ["Virtual Storage Capacity: %1<br/>Physical Storage Capacity: %2<br/>Payment Status: <t color='#2ECC71'>Recieved</t><br/>Remaining Time: %3<br/>Next Payment: %4",_storageCap,_physicalStorageCap,_time,[_cost] call OEC_fnc_numberText];};
		default {_text ctrlSetStructuredText parseText format ["Virtual Storage Capacity: %1<br/>Physical Storage Capacity: %2<br/>Payment Status: <t color='#2ECC71'>Recieved next months payment</t><br/>Remaining Time: %3<br/>Next Payment: %4",_storageCap,_physicalStorageCap,_time,[_cost] call OEC_fnc_numberText];};
	};
	//if (_paid isEqualTo 1) then {
		//text ctrlSetStructuredText parseText format ["Virtual Storage Capacity: %1<br/>Physical Storage Capacity: %2<br/>Payment Status: <t color='#2ECC71'>Recieved</t><br/>Next Payment: %3",_storageCap,_physicalStorageCap,[_cost] call OEC_fnc_numberText];
	//} else {
		//_text ctrlSetStructuredText parseText format ["Virtual Storage Capacity: %1<br/>Physical Storage Capacity: %2<br/>Payment Status: <t color='#FF0000'>Not Recieved</t><br/>Remaining Time: <t color='#FF0000'>%3</t><br/>Payment Due: $%4",_storageCap,_physicalStorageCap,_time,[_cost] call OEC_fnc_numberText];
	//};

	if ((oev_gang_data select 2) >= 3) then { // your rank in gang
		_Btn11 ctrlShow true; // pay rent button

		//if (_paid isEqualTo 1) then {
			//_Btn11 ctrlSetText "Rent Paid";
			//_Btn11 ctrlEnable false;
		//} else {
			//_Btn11 ctrlSetText "Pay Rent";
			//_Btn11 buttonSetAction format ["[life_pInact_curTarget,%1,%2] spawn OEC_fnc_payRent;",_paid,_cost];
			//_Btn11 ctrlEnable true;
		//};
		switch(_paid) do {
			case 0: {_Btn11 ctrlSetText "支付租金";_Btn11 buttonSetAction format ["[life_pInact_curTarget,%1,%2] spawn OEC_fnc_payRent;",_paid,_cost];_Btn11 ctrlEnable true;};
			case 1: {_Btn11 ctrlSetText "提前支付租金";_Btn11 buttonSetAction format ["[life_pInact_curTarget,%1,%2] spawn OEC_fnc_payRent;",_paid,_cost];_Btn11 ctrlEnable true;};
			default {_Btn11 ctrlSetText "预付租金";_Btn11 ctrlEnable false;};
		};
	};
};
