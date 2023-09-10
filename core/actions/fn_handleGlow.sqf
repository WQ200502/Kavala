#include <zmacro.h>
//	File: fn_handleGlow.sqf
//	Author: Fusah
//	Description: Handles underglow for vehicles.

if (true) exitWith {hint "此功能暂时禁用。"};

if(scriptAvailable(5)) exitWith {hint "请不要低头！";};

params [
	["_veh",objNull]
];

private _donorLevel = (__GETC__(oev_donator));
private _pos = [];
private _color = [];

//if (_donorLevel < 15) exitWith {};
if (vehicle player != _veh) exitWith {};
if (vehicle player isEqualTo player) exitWith {};
if !(_veh isKindOf "LandVehicle") exitWith {};
if !((driver (vehicle player)) isEqualTo player) exitWith {hint "你必须是主动灌木丛的司机！"};

private _dialog = findDisplay 33000;
private _list = _dialog displayCtrl 33006;
private _sel = lbCurSel _list;
private _arr = _list lbData _sel;
private _exe = false;

switch (true) do {
	case (typeOf _veh in ["C_Hatchback_01_F","C_Hatchback_01_sport_F"]): {_pos = [0,-.3,-1.01]; if (_donorLevel < 50) exitWith {_exe = true};};
	case (typeOf _veh in ["C_Offroad_01_F","C_Offroad_01_repair_F","I_G_Offroad_01_AT_F"]): {_pos = [0,-0.3,-1.1]; if (_donorLevel < 15) exitWith {_exe = true};};
	case (typeOf _veh isEqualTo "C_SUV_01_F"): {_pos = [0,-0.2,-1.1]; if (_donorLevel < 30) exitWith {_exe = true};};
	case (typeOf _veh isEqualTo "O_MRAP_02_F"): {_pos = [0,-1.5,-1.01]; if (_donorLevel < 100) exitWith {_exe = true};};
	case (typeOf _veh isEqualTo "B_Quadbike_01_F"): {_pos = [0,0,0]};
	case (typeof _veh isEqualTo "I_MRAP_03_F"): {_pos =[0,-.4,-1.01]; if (_donorLevel < 100) exitWith {_exe = true};};
	case (typeof _veh isEqualTo "B_MRAP_01_F"): {_pos = [0,-1.6,-1.2]; if (_donorLevel < 100) exitWith {_exe = true};};
};

if (_pos isEqualTo []) exitWith {hint "此车辆当前不支持Underflow！"};
if (_exe) exitWith {hint "您没有所需的捐赠者级别，无法将Underflow添加到此车辆！"};
//if (_color isEqualTo []) exitWith {hint "请访问改装站为这辆车添加底光!"};

if (_veh getVariable ['underActive',false]) exitWith {_veh setVariable ['underActive',false,true]; hint "你已经把Underlow从这辆车上拆下来了！";};
if (_sel isEqualTo -1) exitWith {hint "请选择颜色！"};

hint "你已经成功地在这辆车上进行了潜航！";

_color = parseSimpleArray _arr;
_veh setVariable ["underglow",_color,true];
_veh setVariable ["underActive",true,true];

uiSleep 1;

[[_pos,_color,_veh],"OEC_fnc_handleGlowLights",-2,false] call OEC_fnc_MP;