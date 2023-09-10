// File: fn_bankWarPointToggle.sqf
// Author: Matt "codeYeTi" Coffin
// Description: Toggles between money and war points in the bank dialog.
params [
	["_enableToggle", true, [true]]
];
disableSerialization;
private ["_display", "_toggleButton", "_transferButton", "_isMoneyMode", "_cashText"];
_display = findDisplay 2700;
_toggleButton = _display displayCtrl 2706;
_transferButton = _display displayCtrl 2705;
_cashText = _display displayCtrl 2701;

if (isNil "oev_bankMode") then {
	oev_bankMode = 0;
};

if (_enableToggle) then {
	if (isNil "oev_bankMode" || { oev_bankMode == 1 }) then {
		oev_bankMode = 0;
	} else {
		oev_bankMode = 1;
	};
};

if !(playerSide isEqualTo civilian) then {
	oev_bankMode = 0;
	_toggleButton ctrlEnable false;
};

_isMoneyMode = (oev_bankMode == 0);

{
	(_display displayCtrl _x) ctrlEnable _isMoneyMode;
} forEach [2707, 2708, 2709];

if (oev_bankMode == 0) then {
	_toggleButton ctrlSetText "管理战争点";
	[objNull, objNull, -1, "", oev_bankMode] call OEC_fnc_atmMenu;
} else {
	_toggleButton ctrlSetText "管理游戏币";
	_cashLabel ctrlSetStructuredText parseText "Loading...";
	[] spawn{
		private _cashLabel = findDisplay 2700 displayCtrl 2701;

		// Following the model from OEC_fnc_updateStatsTab
		oev_warpts_count = -999;
		[0, 0, player] remoteExec ["OES_fnc_warGetSetPts", 2];
		waitUntil {!(oev_warpts_count isEqualTo -999)};
		oev_warpts_cache = oev_warpts_count + oev_random_cash_val;
		[objNull, objNull, -1, "", oev_bankMode] call OEC_fnc_atmMenu;
	};
};
_toggleButton ctrlCommit 0;
