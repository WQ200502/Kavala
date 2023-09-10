#include "..\..\..\macro.h"
//  File: fn_buyGangBldg.sqf
//	Author: Bryan "Tonic" Boardwine
//	Modifications: Jesse "tkcjesse" Schultz, Fusah
//	Description: Buys a gang building, based off fn_buyHouse.sqf

params [
	["_building",objNull,[objNull]]
];
if (oev_houseTransaction) exitWith {hint "您当前有一个活动事务，请稍候。";};
if (isNull _building) exitWith {};
if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") exitWith {};
if !(_building isKindOf "House_F") exitWith {};
if (_building getVariable ["restricted_shed",false]) exitWith {};
if !((oev_gang_data select 2) isEqualTo 5) exitWith {};
if (!license_civ_home) exitWith {hint localize "STR_House_License"};

oev_gangfund_ready = false;
oev_gang_funds = -1;
[[0,oev_gang_data select 0,player],"OES_fnc_gangBank",false,false] spawn OEC_fnc_MP;

waitUntil{oev_gangfund_ready};
uiSleep 0.5;

if (life_donation_house) then {

	if (oev_gang_funds < 17000000) exitWith {hint "你的帮派银行没有足够的钱来购买！";};

	private _action = [
		"这栋楼售价17000000美元。它支持多达900个物理存储空间，并提供其他功能供您和您的帮派使用！",
		"购买房屋",
		localize "STR_Global_Buy",
		localize "STR_Global_Cancel"
	] call BIS_fnc_GUImessage;

	if (_action) then {
		if (oev_gang_funds < 17000000) exitWith {hint "你的帮派银行没有足够的钱来购买！";};
		if (oev_houseTransaction) exitWith {hint "您当前有一个活动事务，请稍候。";};
		oev_houseTransaction = true;
		oev_action_inUse = true;

		[[player,_building,(typeOf _building),(oev_gang_data select 0),(oev_gang_data select 1)],"OES_fnc_addGangBldg",false,false] spawn OEC_fnc_MP;
		hint "正在向房地产经纪人发送购买请求。。。";
	};
	} else {

	if (oev_gang_funds < 20000000) exitWith {hint "你的帮派银行没有足够的钱来购买！";};

	private _action = [
		"这栋楼可售2000万美元。它支持多达900个物理存储空间，并提供其他功能供您和您的帮派使用！",
		"购买房屋",
		localize "STR_Global_Buy",
		localize "STR_Global_Cancel"
	] call BIS_fnc_GUImessage;

	if (_action) then {
		if (oev_gang_funds < 20000000) exitWith {hint "You don't have enough money in your gang bank to make this purchase!";};
		if (oev_houseTransaction) exitWith {hint "You currently have an active transaction, please wait.";};
		oev_houseTransaction = true;
		oev_action_inUse = true;

		[[player,_building,(typeOf _building),(oev_gang_data select 0),(oev_gang_data select 1)],"OES_fnc_addGangBldg",false,false] spawn OEC_fnc_MP;
		hint "正在向房地产经纪人发送购买请求。。。";
	};

};

