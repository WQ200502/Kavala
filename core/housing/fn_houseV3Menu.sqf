// File: fn_houseMenuV3.sqf
// Author: Jesse "tkcjesse" Schultz
// Description: New house menu for windows keying homes...

if(!dialog) then {
	["newHomeMenu"] call OEC_fnc_createDialog;
};
disableSerialization;

params [
	["_building",objNull,[objNull]]
];
if (isNull _building) exitWith {closeDialog 0;};
if (oev_action_inUse) exitWith {closeDialog 0;};
private _houseCfg = [(typeOf _building)] call OEC_fnc_houseConfig;
if (_houseCfg isEqualTo []) exitWith {closeDialog 0;};

private _display = findDisplay 110000;
private _btn1 = _display displayCtrl 110002;
private _btn2 = _display displayCtrl 110003;
private _btn3 = _display displayCtrl 110004;
private _btn4 = _display displayCtrl 110005;
private _btn5 = _display displayCtrl 110006;
private _btn6 = _display displayCtrl 110007;
private _btn7 = _display displayCtrl 110008;
private _btn8 = _display displayCtrl 110009;
private _btn9 = _display displayCtrl 110010;
private _btn10 = _display displayCtrl 110011;
private _btn11 = _display displayCtrl 110012;
private _btn12 = _display displayCtrl 110013;
private _btn13 = _display displayCtrl 110014;
private _btn14 = _display displayCtrl 110015;
private _text = _display displayCtrl 110001;
private _title = _display displayCtrl 110100;

private _buildingID = _building getVariable ["house_id",-1];
private _vStorage = _building getVariable ["storageCapacity",10000];
private _pStorage = _building getVariable ["physicalStorageCapacity",10000];
private _time = _building getVariable ["house_expire",-1];
_title ctrlSetText format ["房屋管理 剩余天数- %1",_buildingID];

//Global Var Setup
life_pInact_curTarget = _building;

// If home is unowned or bought and no keys
if((!(_building in oev_vehicles) && !(getPlayerUID player in (_building getVariable["keyPlayers",[]]))) || isNil {_building getVariable "house_owner"}) exitWith {
	closeDialog 0;
	[] spawn OEC_fnc_availableHouse;
};

// If it's a garage setup that menu otherwise do a house
if ((typeOf _building) in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"]) then {
	// Disable some buttons
	_btn1 ctrlEnable false;
	private _bool = if (((_building getVariable "house_owner") select 0) isEqualTo (getPlayerUID player)) then {true} else {false};
	_btn4 ctrlEnable _bool;
	_btn5 ctrlEnable _bool;
	_btn6 ctrlEnable _bool;
	_btn7 ctrlEnable _bool;
	_btn8 ctrlEnable _bool;
	_btn14 ctrlEnable _bool;
	if(oev_conquestData select 0 && {getPos player inPolygon (oev_conquestData select 1 select 1)}) then {
		_btn5 ctrlEnable false;
	};

	// House Storage
	_btn1 ctrlSetText "查看存储";
	if (_building isKindOf "House_F" && {player distance _building < 10}) then {
		if (!(oev_conquestData select 0 && {getPos player inPolygon (oev_conquestData select 1 select 1)}) && (_building in oev_vehicles || (playerside isEqualTo civilian && (getPlayerUID player in (_building getVariable["keyPlayers",[]]))))) then {
			_btn1 ctrlEnable true;
			_btn1 buttonSetAction "closeDialog 0; [life_pInact_curTarget,false] spawn OEC_fnc_openHouseInventory;";
			//[_building,false] spawn OEC_fnc_openHouseInventory;
		};
		if (((call life_adminlevel) >= 2) && {playerSide isEqualTo civilian}) then {
			if (!(_building in oev_vehicles) && !(getPlayerUID player in (_building getVariable["keyPlayers",[]])) && (_buildingID > 0)) then {
				_btn1 ctrlEnable true;
				_btn1 buttonSetAction "closeDialog 0; [life_pInact_curTarget,true] spawn OEC_fnc_openHouseInventory;";
			};
		};
	};

	_btn2 ctrlSetText "存取车库";
	_btn2 buttonSetAction "[life_pInact_curTarget,""Car""] spawn OEC_fnc_vehicleGarage; closeDialog 0;";

	_btn3 ctrlSetText "存入载具";
	_btn3 buttonSetAction "[life_pInact_curTarget,player] spawn OEC_fnc_storeVehicle; closeDialog 0;";

	_btn4 ctrlSetText "钥匙扣清单";
	_btn4 ctrlEnable false;

	_btn5 ctrlSetText "管理钥匙";
	_btn5 buttonSetAction "['propertyKeys'] call OEC_fnc_createDialog;";

	_btn6 ctrlSetText "缴纳房屋税";
	if(_time >= 45) then {_btn6 ctrlEnable false;};
	_btn6 buttonSetAction "closeDialog 0; [life_pInact_curTarget] spawn OEC_fnc_payHouseTax;";

	_btn7 ctrlSetText "出售给银行";
	_btn7 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_ClsellHouse; closeDialog 0;";

	if !((_building getVariable ["for_sale",""]) isEqualTo "") then {
		_btn8 ctrlSetText "房源市场";
		_btn8 buttonSetAction "closeDialog 0; [life_pInact_curTarget,2] spawn OEC_fnc_listHouse;";
		_btn1 ctrlEnable false; // View Storage
		_btn2 ctrlEnable false; // lock/unlock storage
		_btn3 ctrlEnable false; // light home
		_btn4 ctrlEnable false; // Repair Door
		_btn5 ctrlEnable false; // upgrade
		_btn6 ctrlEnable false; // upgrade
		_btn7 ctrlEnable false; // oil storage
		_text ctrlSetStructuredText parseText format ["<t align='center'><t color='#ff0000'>Your garage is listed for sale currently and you may not access it.</t></t>"];
	} else {
		_btn8 ctrlSetText "待售清单";
		_btn8 buttonSetAction "closeDialog 0; ['life_list_house_price'] call OEC_fnc_createDialog;";
		if (_time <= 1) then {_time = "< 24 Hours";} else {_time = format ["%1 Days",_time];};
		_text ctrlSetStructuredText parseText format ["Virtual Storage Capacity: %1<br/>Physical Storage Capacity: %2<br/>House Expiration: %3",_vStorage,_pStorage,_time];
	};

	_btn14 ctrlSetText "收到房屋补偿";
	_btn14 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_ClhouseComp; closeDialog 0;";

	{ _x ctrlShow false; } forEach [_btn9,_btn10,_btn11,_btn12,_btn13];
} else {
	_btn1 ctrlSetText "查看存储";
	_btn2 ctrlSetText "解锁存储";
	_btn3 ctrlSetText "打开灯";
	_btn4 ctrlSetText "维修门";
	_btn5 ctrlSetText "升级虚拟存储";
	_btn6 ctrlSetText "升级物理存储";
	_btn7 ctrlSetText "增加储油量";
	_btn8 ctrlSetText "钥匙扣清单";
	_btn9 ctrlSetText "管理钥匙";
	_btn10 ctrlSetText "未使用的按钮";
	//_btn10 ctrlShow false;
	_btn11 ctrlSetText "缴纳房产税";
	if(_time >= 45) then {_btn11 ctrlEnable false;};
	_btn12 ctrlSetText "出售给银行";
	_btn13 ctrlSetText "待售清单";

	// lock these just incase the check below fails or something
	private _bool = if (((_building getVariable "house_owner") select 0) isEqualTo (getPlayerUID player)) then {true} else {false};
	_btn1 ctrlEnable false;
	_btn2 ctrlEnable _bool; // lock/unlock storage
	_btn3 ctrlEnable _bool; // light home
	_btn5 ctrlEnable _bool; // upgrade
	_btn6 ctrlEnable _bool; // upgrade
	_btn7 ctrlEnable _bool; // oil storage
	_btn9 ctrlEnable _bool; // House Key stuff
	_btn11 ctrlEnable _bool; // Refresh Deed
	_btn12 ctrlEnable _bool; // Sell2Market
	_btn13 ctrlEnable _bool; // List4Sale
	_btn14 ctrlEnable _bool; // House Comp
	if(oev_conquestData select 0 && {getPos player inPolygon (oev_conquestData select 1 select 1)}) then {
		_btn9 ctrlEnable false;
	};
	// ---------------------------------------------------------

	// View/Open Storage
	_btn1 ctrlSetText "查看存储";
	if (_building isKindOf "House_F" && {player distance _building < 10}) then {
		if (_building isKindOf "House_F" && {player distance _building < 10}) then {
		if (!(oev_conquestData select 0 && {getPos player inPolygon (oev_conquestData select 1 select 1)}) && (_building in oev_vehicles || (playerside isEqualTo civilian && (getPlayerUID player in (_building getVariable["keyPlayers",[]]))))) then {
			_btn1 ctrlEnable true;
			_btn1 buttonSetAction "closeDialog 0; [life_pInact_curTarget,false] spawn OEC_fnc_openHouseInventory;";
			//[_building,false] spawn OEC_fnc_openHouseInventory;
			};
		};
		if (((call life_adminlevel) >= 2) && {playerSide isEqualTo civilian}) then {
			if (!(_building in oev_vehicles) && !(getPlayerUID player in (_building getVariable["keyPlayers",[]])) && (_buildingID > 0)) then {
				_btn1 ctrlEnable true;
				_btn1 buttonSetAction "closeDialog 0; [life_pInact_curTarget,true] spawn OEC_fnc_openHouseInventory;";
			};
		};
	};

	// Unlock home storage
	if (_building getVariable ["locked",false]) then {
		_btn2 ctrlSetText "解锁库存";
	} else {
		_btn2 ctrlSetText "锁上库存";
	};
	_Btn2 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_lockHouse; closeDialog 0;";


	// Home lighting
	if (isNull (_building getVariable ["lightSource",objNull])) then {
		_btn3 ctrlSetText "开灯";
	} else {
		_btn3 ctrlSetText "关灯";
	};
	_btn3 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_light1HouseAction; closeDialog 0;";

	// Repair Doors
	_btn4 ctrlSetText "修理车门";
	_btn4 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_lockupHouse; closeDialog 0;";

	// Upgrade Virtual Storage
	_btn5 ctrlSetText "升级虚拟存储";
	_btn5 buttonSetAction "[life_pInact_curTarget,'storage'] spawn OEC_fnc_upgradeProperty; closeDialog 0;";
	if ((_building getVariable ["storageCapacity",10000]) >= ((_houseCfg select 1)*700)) then {
		_btn5 ctrlEnable false;
		_btn5 ctrlSetText "已经升级";
	};

	// Upgrade Physical Storage
	_btn6 ctrlSetText "升级物理存储";
	_btn6 buttonSetAction "[life_pInact_curTarget,'physicalstorage'] spawn OEC_fnc_upgradeProperty; closeDialog 0;";
	if ((_building getVariable ["physicalStorageCapacity",10000]) >= (((_houseCfg select 1)*200) + 100)) then {
		_btn6 ctrlEnable false;
		_btn6 ctrlSetText "已经升级";
	};

	// Add Oil Storage Modification
	_btn7 ctrlSetText "添加机油存储";
	_btn7 buttonSetAction "[life_pInact_curTarget,'oil'] spawn OEC_fnc_upgradeProperty; closeDialog 0;";
	if (_building getVariable ["oilstorage",false]) then {
		_Btn7 ctrlEnable false;
		_btn7 ctrlSetText "已经升级";
	};

	_btn8 ctrlSetText "钥匙持有人名单";
	_btn8 ctrlEnable false;

	// Add or Remove Perm Keys
	_btn9 ctrlSetText "管理钥匙";
	_btn9 buttonSetAction "['propertyKeys'] call OEC_fnc_createDialog;";

	_btn10 ctrlSetText "未使用的按钮";
	_btn10 ctrlShow false;

	_btn11 ctrlSetText "缴纳房产税";
	if(_time >= 45) then {_btn11 ctrlEnable false;};
	_btn11 buttonSetAction "closeDialog 0; [life_pInact_curTarget] spawn OEC_fnc_payHouseTax;";

	// Sell House Straight
	_btn12 ctrlSetText "出售给银行";
	_btn12 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_ClsellHouse; closeDialog 0;";

	// Get House Comp - Items added through LC
	_btn14 ctrlSetText "收到房屋补偿";
	_btn14 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_ClhouseComp; closeDialog 0;";

	// Sell to Market for other players -- TO DO EVENTUALLY
	if !((_building getVariable ["for_sale",""]) isEqualTo "") then {
		_btn13 ctrlSetText "房源市场";
		_btn13 buttonSetAction "closeDialog 0; [life_pInact_curTarget,2] spawn OEC_fnc_listHouse;";
		_btn1 ctrlEnable false; // View Storage
		_btn2 ctrlEnable false; // lock/unlock storage
		_btn3 ctrlEnable false; // light home
		_btn4 ctrlEnable false; // Repair Door
		_btn5 ctrlEnable false; // upgrade
		_btn6 ctrlEnable false; // upgrade
		_btn7 ctrlEnable false; // oil storage
		_btn8 ctrlEnable false; // Key Holder List
		_btn9 ctrlEnable false; // House Key stuff
		_btn11 ctrlEnable false; // Refresh Deed
		_btn12 ctrlEnable false; // Sell2Market
		_text ctrlSetStructuredText parseText format ["<t align='center'><t color='#ff0000'>您的房屋目前已上市出售，您可能无法使用。</t></t>"];
	} else {
		_btn13 ctrlSetText "待售清单";
		_btn13 buttonSetAction "closeDialog 0; ['life_list_house_price'] call OEC_fnc_createDialog;";
		if (_time <= 1) then {_time = "< 24 Hours";} else {_time = format ["%1 Days",_time];};
		_text ctrlSetStructuredText parseText format ["虚拟存储容量: %1<br/>物理存储容量: %2<br/>房屋到期: %3<br/>房屋税率: %4",_vStorage,_pStorage,_time,format["%1%2",[_building,1] call OEC_fnc_calcHouseTax,"%"]];
	};
};
