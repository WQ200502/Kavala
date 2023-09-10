// File: fn_neuterAction.sqf
// Author: codeYeTi
// Description: Effectively neuters the target, or reverses the effect
params [
	["_unit", objNull, [objNull]],
	["_undo", false, [false]]
];
if (isNull _unit) exitWith {};
private _idx = _unit getVariable ["oev_neuterHandler", -1];
if (_idx >= 0) then {
	_unit removeEventHandler ["Reloaded", _idx];
};
private _otherIndices = _unit getVariable ["oev_neuterHandlers", []];
private _aIdx = _unit getVariable ["oev_neuterFixer", -1];
if (_aIdx >= 0) then {
	_unit removeAction _aIdx;
};
{
	_unit removeEventHandler _x;
} forEach _otherIndices;
if (!_undo) then {
	private _obj_main = _unit;
	_otherIndices = [];
	if (_unit == player) then {
		titleText ["你的撞针被拿走了。", "PLAIN DOWN"];
	};
	_idx = _unit addEventHandler ["Reloaded", {
		params ["_unit", "_weapon"];
		_unit setAmmo [_weapon, 0];
	}];
	_aIdx = _obj_main addAction [
		"重新装配撞针",
		"[(_this select 0), 30, true] spawn OEC_fnc_neuterActionCl;",
		nil,
		6,
		true,
		false,
		"",
		"(!(missionNamespace getVariable [""oev_action_inUse"", false])) && (!(_target getVariable [""restrained"", false]))"
	];
	private _otherIdx = _unit addEventHandler ["Take", {
		params ["_taker", "_container", "_item"];
		if (_taker hasWeapon _item) then {
			_taker setAmmo [_item, 0];
		};
	}];
	_otherIndices append [["Take", _otherIdx]];
	_unit setVariable ["oev_neuterHandler", _idx];
	_unit setVariable ["oev_neuterFixer", _aIdx];
	_unit setVariable ["oev_neuterHandlers", _otherIndices];
	{
		_unit setAmmo [_x, 0];
	} forEach [
		primaryWeapon _unit,
		secondaryWeapon _unit,
		handgunWeapon _unit
	];
} else {
	if (_idx >= 0) then {
		systemChat "你现在把撞针拿回来了！";
	};
};
