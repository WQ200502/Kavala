// File: fn_createMarkerLocal.sqf
// Author: Matt "codeYeTi" Coffin
// Description: Creates a marker all at once
params [
	["_markerName", "", [""]],
	["_pos", [0, 0], [[]]],
	["_markerShape", "ICON", [""]],
	["_markerType", "DOT", [""]],
	["_markerText", "", [""]],
	["_markerColor", "ColorBlack", [""]],
	["_markerSize", [2, 2], [[]]],
	["_markerDir", 180, []]
];
if !(getMarkerPos _markerName isEqualTo [0, 0, 0]) then {
	deleteMarkerLocal _markerName;
};
private _marker = createMarkerLocal [_markerName, _pos];
_marker setMarkerShapeLocal _markerShape;
_marker setMarkerTypeLocal _markerType;
_marker setMarkerColorLocal _markerColor;
_marker setMarkerDirLocal _markerDir; // Set marker to be upside down
_marker setMarkerSizeLocal _markerSize; // Set marker size to be doubled

if (count _markerText > 0) then {
	_marker setMarkerTextLocal _markerText;
};
