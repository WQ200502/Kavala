//	Author: Jiri Wainar
//	Modified by: Poseidon
//	This file is not to be used outside of Olympus servers.
//	Description: Displays the intro to the server and checks mod pack after.
private["_unit","_ehAnimDone","_ehKilled","_detachCode"];
_unit = param[0, objNull, [objNull]];

if (typeName _unit != typeName objNull) exitWith {};
if (isNull _unit) exitWith {};


_ehAnimDone = _unit getVariable ["BIS_EhAnimDone",-1];
_ehKilled 	= _unit getVariable ["BIS_EhKilled",-1];

if (_ehAnimDone != -1) then {
	_unit removeEventHandler ["AnimDone",_ehAnimDone];
	_unit setVariable ["BIS_EhAnimDone",-1];
};

if (_ehKilled != -1) then {
	_unit removeEventHandler ["Killed",_ehKilled];
	_unit setVariable ["BIS_EhKilled",-1];
};

_detachCode = {
	private["_logic"];

	if (isNull _this) exitWith {};

	_logic = _this getVariable ["BIS_fnc_ambientAnim__logic",objNull];

	if !(isNull _logic) then {
		deleteVehicle _logic;
	};

	_this setVariable ["BIS_fnc_ambientAnim__attached",nil];
	_this setVariable ["BIS_fnc_ambientAnim__animset",nil];
	_this setVariable ["BIS_fnc_ambientAnim__anims",nil];
	_this setVariable ["BIS_fnc_ambientAnim__interpolate",nil];
	_this setVariable ["BIS_fnc_ambientAnim__time",nil];
	_this setVariable ["BIS_fnc_ambientAnim__logic",nil];
	_this setVariable ["BIS_fnc_ambientAnim__linked",nil];

	detach _this; _this switchMove "";
};

if (time > 0) then {
	_unit call _detachCode;
} else {
	[_unit,_detachCode] spawn{
		sleep 0.3; (_this select 0) call (_this select 1);
	};
};
true