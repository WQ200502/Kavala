//  File: fn_setupInteractionMenu.sqf
//	Author: Matt "codeYeTi" Coffin
//	Description: initializes all the buttons of an interaction menu based on an array (see args to _fnc_setupButton for array formatting
disableSerialization;
private ["_display", "_button"];
_display = findDisplay 37400;

{
	_button = _display displayCtrl (37450 + _forEachIndex);
	private _args = [_button];
	_args append _x;
	_args call {
		params [
			["_btn", controlNull, [controlNull]],
			["_text", "", [""]],
			["_action", "", [""]],
			["_oef_shouldEnabl", { true }, [{}]]
		];
		_btn ctrlSetText _text;
		if (count _action > 0) then {
			_btn buttonSetAction _action;
		};
		_btn ctrlEnable ([] call _oef_shouldEnabl);
		_btn ctrlShow true;
	};
} forEach _this;

for "_idx" from (count _this) to 8 do {
	_button = _display displayCtrl (37450 + _idx);
	_button ctrlEnable false;
	_button ctrlShow false;
};
