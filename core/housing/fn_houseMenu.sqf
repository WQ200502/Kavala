#include "..\..\macro.h"
#include <interaction.h>
// 	File: fn_houseMenu.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Building interaction menu DESCRIPTIONEND

if(!dialog) then {
	["pInteraction_Menu"] call OEC_fnc_createDialog;
};
disableSerialization;
params [
	["_curTarget",objNull,[objNull]]
];

if(isNull _curTarget) exitWith {closeDialog 0;}; //Bad target
if(oev_newsTeam) exitWith {closeDialog 0; hint "作为新闻组，你不能执行这个动作!";};

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

private _dome = nearestObject [[16019.5,16952.9,0],"Land_Dome_Big_F"];
private _rsb = nearestObject [[16019.5,16952.9,0],"Land_Research_house_V1_F"];
private _blackwaterDome = nearestObject [[20898.6,19221.7,0.00143909],"Land_Dome_Big_F"];
private _trainingDome = nearestObject [[17402.2,13235.8,0.0014677],"Land_Dome_Small_F"];
private _jailDome = nearestObject [[16709.8,13602,4.00142384],"Land_Dome_Big_F"];

life_pInact_curTarget = _curTarget;
if(_curTarget isKindOf "House_F" && playerSide isEqualTo west) exitWith {
	if(_dome == _curTarget || _rsb == _curTarget || _blackwaterDome == _curTarget || _trainingDome == _curTarget || _jailDome == _curTarget) then {
		if (!(_trainingDome == _curTarget) && !(_jailDome == _curTarget)) then {
			_Btn1 ctrlSetText localize "STR_pInAct_Repair";
			_Btn1 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_repairDoor; closeDialog 0;";
			_Btn1 ctrlShow true;

			_Btn2 ctrlSetText localize "STR_pInAct_CloseOpen";
			_Btn2 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_doorAnimate; closeDialog 0;";
			_Btn2 ctrlShow true;
		} else {
			if(_curTarget == _jailDome) then {
			_display = findDisplay 37400;
			_Btn1 = _display displayCtrl Btn1;
			_Btn1 ctrlSetText localize "STR_pInAct_CloseOpen";
			_Btn1 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_doorAnimate; closeDialog 0;";
			_Btn1 ctrlShow true;
			} else {
			_Btn1 ctrlSetText "锁定/解锁训练球";
			_Btn1 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_handleDome;";
			_Btn1 ctrlShow true;
			if !(__GETC__(life_coplevel) >= 3) then {_Btn1 ctrlEnable false};
			if (__GETC__(life_adminlevel) >= 1) then {_Btn1 ctrlEnable true};
			};
		};
	} else {
		if(!isNil {_curTarget getVariable "house_owner"}) then {
			_Btn1 ctrlSetText "检查房门钥匙";
			_Btn1 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_copHouseOwner;";
			_Btn1 ctrlShow true;

			_Btn2 ctrlSetText localize "STR_pInAct_BreakDown";
			_Btn2 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_copBreakDoor; closeDialog 0;";
			_Btn2 ctrlShow true;

			_Btn3 ctrlSetText localize "STR_pInAct_SearchHouse";
			_Btn3 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_raidHouse; closeDialog 0;";
			_Btn3 ctrlShow true;

			if(player distance _curTarget > 3.6) then {
				_Btn3 ctrlEnable false;
			};

			_Btn4 ctrlSetText localize "STR_pInAct_LockHouse";
			_Btn4 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_lockupHouse; closeDialog 0;";
			_Btn4 ctrlShow true;
			if(__GETC__(life_coplevel) < 6) then
			{
				_Btn3 ctrlEnable false;
			};
			if(__GETC__(life_coplevel) < 2) then
			{
				_Btn2 ctrlEnable false;
				_Btn4 ctrlEnable false;
			};
		} else {
			closeDialog 0;
		};
	};
};
if (_curTarget isKindOf "House_F" && playerSide isEqualTo independent) exitWith {
	if(!isNil {_curTarget getVariable "house_owner"}) then {
			_Btn1 ctrlSetText localize "STR_pInAct_LockHouse";
			_Btn1 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_lockupHouse; closeDialog 0;";
			_Btn1 ctrlShow true;
	} else {
			closeDialog 0;
	};
};





_houseCfg = [(typeOf _curTarget)] call OEC_fnc_houseConfig;
if(_houseCfg isEqualTo []) exitWith {closeDialog 0;};





if((!(_curTarget in oev_vehicles) && !(getPlayerUID player in (_curTarget getVariable["keyPlayers",[]]))) || isNil {_curTarget getVariable "house_owner"}) then {
	closeDialog 0;
	[] spawn OEC_fnc_availableHouse;
} else {
	if((typeOf _curTarget) in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"]) then {
		if(((_curTarget getVariable "house_owner") select 0) != (getPlayerUID player)) then {
			_Btn1 ctrlEnable false;
			_Btn4 ctrlEnable false;
		};

		_Btn1 ctrlSetText localize "STR_pInAct_SellGarage";
		_Btn1 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_ClsellHouse; closeDialog 0;";
		_Btn1 ctrlShow true;

		_Btn2 ctrlSetText localize "STR_pInAct_AccessGarage";
		_Btn2 buttonSetAction "[life_pInact_curTarget,""Car""] spawn OEC_fnc_vehicleGarage; closeDialog 0;";
		_Btn2 ctrlShow true;

		_Btn3 ctrlSetText localize "STR_pInAct_StoreVeh";
		_Btn3 buttonSetAction "[life_pInact_curTarget,player] spawn OEC_fnc_storeVehicle; closeDialog 0;";
		_Btn3 ctrlShow true;

		_Btn4 ctrlSetText "管理钥匙";
		_Btn4 buttonSetAction "['propertyKeys'] call OEC_fnc_createDialog;";
		_Btn4 ctrlShow true;

	} else {
		if(((_curTarget getVariable "house_owner") select 0) != (getPlayerUID player)) then {
			_Btn1 ctrlEnable false;
			_Btn2 ctrlEnable false;
			_Btn4 ctrlEnable false;
			_Btn5 ctrlEnable false;
			_Btn6 ctrlEnable false;
			_Btn7 ctrlEnable false;
		};

		_Btn1 ctrlSetText localize "STR_pInAct_SellHouse";
		_Btn1 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_ClsellHouse; closeDialog 0;";
		_Btn1 ctrlShow true;

		if(_curTarget getVariable ["locked",false]) then {
			_Btn2 ctrlSetText localize "STR_pInAct_UnlockStorage";
		} else {
			_Btn2 ctrlSetText localize "STR_pInAct_LockStorage";
		};
		_Btn2 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_lockHouse; closeDialog 0;";
		_Btn2 ctrlShow true;

		if(isNull (_curTarget getVariable ["lightSource",ObjNull])) then {
			_Btn3 ctrlSetText localize "STR_pInAct_LightsOn";
		} else {
			_Btn3 ctrlSetText localize "STR_pInAct_LightsOff";
		};
		_Btn3 buttonSetAction "[life_pInact_curTarget] call OEC_fnc_light1HouseAction; closeDialog 0;";
		_Btn3 ctrlShow true;

		_Btn4 ctrlSetText "升级虚拟存储";
		_Btn4 buttonSetAction "[life_pInact_curTarget,'storage'] spawn OEC_fnc_upgradeProperty; closeDialog 0;";
		_Btn4 ctrlShow true;

		_Btn5 ctrlSetText "升级物理存储";
		_Btn5 buttonSetAction "[life_pInact_curTarget,'physicalstorage'] spawn OEC_fnc_upgradeProperty; closeDialog 0;";
		_Btn5 ctrlShow true;

		_Btn6 ctrlSetText "管理钥匙";
		_Btn6 buttonSetAction "['propertyKeys'] call OEC_fnc_createDialog;";
		_Btn6 ctrlShow true;

		_Btn7 ctrlSetText "增加储油量";
		_Btn7 buttonSetAction "[life_pInact_curTarget,'oil'] spawn OEC_fnc_upgradeProperty; closeDialog 0;";
		_Btn7 ctrlShow true;

		_Btn8 ctrlSetText "维修门";
		_Btn8 buttonSetAction "[life_pInact_curTarget] spawn OEC_fnc_lockupHouse; closeDialog 0;";
		_Btn8 ctrlShow true;

		if ((typeOf _curTarget) in ["Land_GarageShelter_01_F","Land_House_Big_03_F","Land_House_Big_02_F"]) then {
			_Btn7 ctrlSetText localize "STR_pInAct_AccessGarage";
			_Btn7 buttonSetAction "[life_pInact_curTarget,""Car""] spawn OEC_fnc_vehicleGarage; closeDialog 0;";
			_Btn7 ctrlShow true;

			_Btn8 ctrlSetText localize "STR_pInAct_StoreVeh";
			_Btn8 buttonSetAction "[life_pInact_curTarget,player] spawn OEC_fnc_storeVehicle; closeDialog 0;";
			_Btn8 ctrlShow true;
		};

		if ((_curTarget getVariable ["storageCapacity",10000]) >= ((_houseCfg select 1)*700)) then {
			_Btn4 ctrlEnable false;
		};
		if ((_curTarget getVariable ["physicalStorageCapacity",10000]) >= (((_houseCfg select 1)*200) + 100)) then {
			_Btn5 ctrlEnable false;
		};
		if (_curTarget getVariable ["oilstorage",false]) then {_Btn7 ctrlEnable false;};
	};
};
