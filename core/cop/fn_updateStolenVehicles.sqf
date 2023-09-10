// File: fn_updateStolenVehicles.sqf
// Author: codeYeTi
// Description: Updates the stolen vehicles dialog
params [
	["_list", controlNull, [controlNull]]
];
private _stolenVehicles = missionNamespace getVariable ["oev_cop_stolenVehicles", []];
for [{private _idx = _stolenVehicles findIf { isNull (_x select 0) }}, {_idx >= 0}, {_idx = _stolenVehicles findIf { isNull (_x select 0) }}] do {
	_stolenVehicles deleteAt _idx;
};
oev_cop_stolenVehicles = _stolenVehicles;

lbClear _list;

if (count(_stolenVehicles) < 1) exitWith {_list lbAdd "No Vehicles Reported Stolen.";};
{
	_x params [
		["_veh", objNull, [objNull]],
		["_pos", [], [[]]],
		["_reporter", "", [""]]
	];
	private ["_vehicleConfig", "_vehicleName", "_vehicleSkin", "_vehiclePicture","_idx","_reward"];
	_vehicleConfig = configFile >> "CfgVehicles" >> (typeOf _veh);
	_vehicleName = getText (_vehicleConfig >> "displayName");
	_vehiclePicture = getText (_vehicleConfig >> "picture");
	_vehicleSkin = [_veh] call OEC_fnc_skinName;
	_reward = 0.05 * ((["allVehicles", typeOf _veh] call OEC_fnc_vehicleConfig) select 6);
	_reward = round _reward;
	if (_vehicleSkin != "") then {
		_vehicleName = format ["%1 (%2)", _vehicleName, _vehicleSkin];
	};
	_vehicleName = format ["%1 - $%2", _vehicleName, [_reward] call OEC_fnc_numberText];
	_list lbAdd _vehicleName;
	if (_vehiclePicture != "pictureStaticObject") then {
		_list lbSetPicture [_forEachIndex, _vehiclePicture];
	};
	_list lbSetData [_forEachIndex, str _reward];
} forEach _stolenVehicles;