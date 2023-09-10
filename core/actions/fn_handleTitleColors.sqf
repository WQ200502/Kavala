#include <zmacro.h>

//	File: fn_handleTitleColors.sqf
//	Author: ikiled / Fusah
//	Description: Assigns colors to titles n stuffs

if(scriptAvailable(5)) exitWith {hint "请不要垃圾邮件标题颜色！";};

private _color = [];

private _dialog = findDisplay 41250;
private _list = _dialog displayCtrl 41258;
private _sel = lbCurSel _list;
private _arr = _list lbData _sel;
private _allowedFaction = false;
private _allowedDonor = false;

if (_sel isEqualTo -1) exitWith {hint "请选择标题颜色！"};

_color = parseSimpleArray _arr;

switch (true) do {
	case (_color in [[76, 50, 26]]): { // Supporter ($15) (Brown)
		if (__GETC__(oev_donator) < 15) exitWith {_allowedDonor = true};
	};
	case (_color in [[255,255,0]]): { // MVP ($30) (Yellow)
		if (__GETC__(oev_donator) < 30) exitWith {_allowedDonor = true};
	};
	case (_color in [[0,0,255],[30,144,255],[0,153,204],[64,224,208]]): { // VIP ($50) (Blue)
		if (__GETC__(oev_donator) < 50) exitWith {_allowedDonor = true};
	};
	case (_color in [[255,255,0]]): { // VIP ($100) (Pink)
		if (__GETC__(oev_donator) < 100) exitWith {_allowedDonor = true};
	};
	case (_color in [[0,255,0]]): { // VIP ($250) (Green)
		if (__GETC__(oev_donator) < 250) exitWith {_allowedDonor = true};
	};
	case (_color in [[0,204,102]]): { // Developer (Mint Green)
		if (__GETC__(oev_developerlevel) < 2) exitWith {_allowedFaction = false};
	};
	case (_color in [[128,0,128]]): { // Designer (Purple)
		if (__GETC__(oev_designerlevel) < 2) exitWith {_allowedFaction = false};
	};
	case (_color in [[255,163,7]]): { // Support Team (Orange)
		if (__GETC__(life_supportlevel) < 1) exitWith {_allowedFaction = false};
	};
	case (_color in [[147,29,121]]): { // Civilian Council (Purple)
		if (__GETC__(oev_civcouncil) < 0) exitWith {_allowedFaction = false};
	};
	case (_color in [[251,0,0]]): { // Admin (Red) Offset a bit to counter exploiters :)
		if (__GETC__(life_adminlevel) isEqualTo 4) exitWith {_allowedFaction = false};
	};
};

if (_allowedDonor) exitWith {hint "您没有更改标题颜色所需的捐赠者级别。"};
if (_allowedFaction) exitWith {hint "此势力无法使用您尝试选择的颜色。"};

hint "您已成功更改标题颜色！";
player setVariable ["titlecolor",_color,true];
if (count _color < 3 || !(_color in oev_allowedColors)) then {_color = [217, 217, 217]};
profileNamespace setVariable ["titlecolor",_color];
