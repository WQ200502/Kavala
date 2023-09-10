// File: fn_escortTimer.sqf
// Author: Jesse "tkcjesse" Schultz

params [
	["_time",0,[0]],
	["_mode",0,[0]]
];

if (_mode isEqualTo 1) then {_time = _time + time;};

disableSerialization;

8 cutRsc ["pharma_timer","PLAIN DOWN"];

private _color = [0.36,0.14,0.69,1];
private _display = uiNamespace getVariable "pharma_timer";
private _timer = _display displayCtrl 38312;
_timer ctrlSetTextColor _color;

while {true} do {
	if (isNull _display) then {
		8 cutRsc ["pharma_timer","PLAIN DOWN"];
		_display = uiNamespace getVariable "pharma_timer";
		_timer = _display displayCtrl 38312;
		_timer ctrlSetTextColor _color;
	};

	if ((_mode isEqualTo 1) && !(escort_status select 0)) exitWith {};
	if (round(_time - time) < 1) exitWith {};
	_timer ctrlSetText format["%1",[(_time - time),"MM:SS"] call BIS_fnc_secondsToString];
	uiSleep 0.09;
};

8 cutText ["","PLAIN DOWN"];