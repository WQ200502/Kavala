// File: fn_interruptableAction.sqf
// Author: codeYeTi
// Description: Performs a generic interruptable action
params [
	["_text", "Performing Action", [""]],
	["_duration", 5, [0]],
	["_fnc_shouldCancel", { false }, [{}]],
	["_fnc_onTermination", {}, [{}]],
	["_animation", "AinvPknlMstpSnonWnonDnon_medic_1", [""]]
];
disableSerialization;
5 cutRsc ["life_progress", "PLAIN DOWN"];
private _ui = uiNamespace getVariable "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayctrl 38202;
_pgText ctrlSetText "";
private _cP = 0;
if (_animation != "") then {
	[_animation, 1.5] spawn OEC_fnc_handleAnim;
};
private _interrupted = false;
while {true} do {
	uiSleep  (_duration / 100);
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format ["%3 (%1%2)...", round(_cP * 100), "%", _text];
	if (_cP >= 1) exitWith {};
	if !(alive player) exitWith {_interrupted = true;};
	if (player != vehicle player) exitWith {_interrupted = true;};
	if (oev_interrupted) exitWith {_interrupted = true; oev_interrupted = false;};
	if ([] call _fnc_shouldCancel) exitWith {_interrupted = true;};
};
if (_animation != "") then {
	[] spawn OEC_fnc_handleAnim;
};
5 cutText ["", "PLAIN DOWN"];
[_interrupted] call _fnc_onTermination;
