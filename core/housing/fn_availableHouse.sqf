// File: fn_availableHouse.sqf
// Author: Jesse "tkcjesse" Schultz
params [
	["_house",objNull,[objNull]]
];

if (isNull _house) exitWith {closeDialog 0;};
if (playerSide isEqualTo independent) exitWith {};

//house is in conquest zone and conquest is active or in pregame
if (oev_conquestData select 0 && position player inPolygon (oev_conquestData select 1 select 1)) exitWith {
	hint "征服期间没有时间搞房地产！";
};

if !(dialog) then {
	["houseAvailable"] call OEC_fnc_createDialog;
};

disableSerialization;

private _display = findDisplay 109000;
private _purchaseBtn = _display displayCtrl 109008;
private _adminCheckKeys = _display displayCtrl 109009;
_adminCheckKeys ctrlEnable false;
_adminCheckKeys ctrlSetText "检查钥匙";
_purchaseBtn ctrlEnable false;
_purchaseBtn ctrlSetText "购买";

life_pInact_curTarget = _house;
if((!(_house in oev_vehicles) && !(getPlayerUID player in (_house getVariable["keyPlayers",[]]))) || isNil {_house getVariable "house_owner"}) then {
	if(_house in oev_vehicles) then {oev_vehicles = oev_vehicles - [_house];};

	private _houseCfg = [(typeOf _house)] call OEC_fnc_houseConfig;
	if (count _houseCfg isEqualTo 0) exitWith {};

	ctrlSetText[109001,format["%1",getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName")]];

	if (!isNil {_house getVariable "house_owner"} && ((_house getVariable ["for_sale",""]) isEqualTo "")) then {
		if((call life_adminlevel) >= 3) then {
			_adminCheckKeys ctrlEnable true;
			_adminCheckKeys buttonSetAction "[life_pInact_curTarget] call OEC_fnc_copHouseOwner;";
		};
		ctrlSetText[109002,"价格：不提供"];
		ctrlSetText[109003,"此房屋已被购买。"];
	} else {
		// If house is listed for sale by a player
		if !((_house getVariable ["for_sale",""]) isEqualTo "") then {
			ctrlSetText[109002,format["价格:%1元",([(_house getVariable ["for_sale",""]) select 1] call OEC_fnc_numberText)]];
			ctrlSetText[109003,format["此属性可从%1购买",((_house getVariable ["house_owner",""]) select 1)]];
			ctrlSetText[109005,format["当前虚拟空间：%1。当前物理空间%2。",(_house getVariable ["storageCapacity",10000]),(_house getVariable ["physicalStorageCapacity",10000])]];
			if ((typeOf _house) in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"]) then {
				ctrlSetText[109006,"你可以从这个地方取车。"];
				ctrlSetText[109007,"你死后可以在这个地方重生。"];
			} else {
				ctrlSetText[109006,"你可以把这栋楼升级以备储油之用。"];
				ctrlSetText[109007,"你死后可以在这个地方重生。"];
			};
			_purchaseBtn ctrlEnable true;
			_purchaseBtn buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_buyHouse; closeDialog 0;";
			if((call life_adminlevel) >= 3) then {
				_adminCheckKeys ctrlEnable true;
				_adminCheckKeys buttonSetAction "[life_pInact_curTarget] call OEC_fnc_copHouseOwner;";
			};
		} else {
			// If house is just available (NOT LISTED BY PLAYER)
			ctrlSetText[109002,format["价格:%1元",[(_houseCfg select 0)] call OEC_fnc_numberText]];
			ctrlSetText[109003,"这处房产可供购买。"];
			ctrlSetText[109005,format["最大虚拟空间：%1。最大物理空间%2。",((_houseCfg select 1) * 700),((_houseCfg select 1) * 200) + 100]];
			if ((typeOf _house) in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"]) then {
				ctrlSetText[109006,"你可以从这个地方取车。"];
				ctrlSetText[109007,"你死后可以在这个地方重生。"];
			} else {
				ctrlSetText[109006,"你可以把这栋楼升级以备储油之用。"];
				ctrlSetText[109007,"你死后可以在这个地方重生。"];
			};
			_purchaseBtn ctrlEnable true;
			_purchaseBtn buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_buyHouse; closeDialog 0;";
		};
	};
};
