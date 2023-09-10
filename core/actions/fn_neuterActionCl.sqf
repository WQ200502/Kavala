//  File: fn_neuterActionCl.sqf

params [
	["_curTarget", objNull, [objNull]],
	["_time", 0, [0]],
	["_undo", false, [false]]
];
private ["_ui", "_progress", "_pgText", "_text"];

if (isNull _curTarget) exitWith {};
if (_time isEqualTo 0) exitWith {};
if !(isNull objectParent player) exitWith {hint "你不能在车里重新组装你的武器！";};
_time = _time / 100;

disableSerialization;
oev_action_inUse = true;
"progressBar" cutRsc ["life_progress", "PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_text = if (_undo) then {
	"Reassembling firearms"
} else {
	"Disassembling firearms"
};
_pgText ctrlSetText format ["%2 (1%1)...","%",_text];
_progress progressSetPosition 0.01;
_cP = 0.01;
["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
for "_i" from 0 to 1 step 0 do {
    uiSleep _time;
    _cP = _cP + 0.01;
    _progress progressSetPosition _cP;
    _pgText ctrlSetText format ["%3 (%1%2)...",round(_cP * 100),"%",_text];
    if (_cP >= 1) exitWith {};
    if (!alive player) exitWith {};
    if !(isNull objectParent player) exitWith {};
    if (oev_interrupted) exitWith {};
};

oev_action_inUse = false;
"progressBar" cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;
if (oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
if !(isNull objectParent player) exitWith {hint "你不能在车里重新组装你的武器！";};

if (_undo) then {
	[_curTarget, true] call OEC_fnc_neuterAction;
} else {
	life_pInact_curTarget = _curTarget;
	[life_pInact_curTarget] remoteExec ["OEC_fnc_neuterAction", life_pInact_curTarget];
};
