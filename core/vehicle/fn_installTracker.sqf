// File: fn_installTracker.sqf
// Author: codeYeTi
// Description: Installs a GPS tracker IMMEDIATELY on the target vehicle.
params [
	["_target", objNull, [objNull]],
	["_displayMessage", true, [true]]
];
if (isNull _target) exitWith {};
oev_tracked_vehicles pushBack _target;
_target setVariable ["tracking", true, true];
if (_displayMessage) then {
	titleText ["You have attached a tracking device to this vehicle.", "PLAIN DOWN"];
};
[_target] spawn{
	private _object = param [0, objNull, [objNull]];
	waitUntil {uiSleep 2; (isNull _object || !(_object getVariable ["tracking", false]) || !(alive _object))};
	oev_tracked_vehicles deleteAt (oev_tracked_vehicles find _object);
};
