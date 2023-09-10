// File: fn_reportStolen.sqf
// Author: codeYeTi
// Description: Reports a stolen vehicle to the APD
params [
	["_vehicle", objNull, [objNull]],
	["_pos", [], [[]]],
	["_reporter", objNull, [objNull]]
];

// sanity checks
if (isNull _vehicle) exitWith {};
if !(alive _vehicle) exitWith {};
if (isNull _reporter && _pos isEqualTo []) then {
	_pos = _vehicle getVariable ["vehicle_info_lastSeen", []];
};
if (_pos isEqualTo []) exitWith {
	["Vehicle must have a last seen position"] call BIS_fnc_error;
};

if (isNull _reporter) then {
	if (playerSide != civilian) exitWith {
		hint "Non-civilians may not report vehicles as stolen.";
	};
	if !(_vehicle in oev_vehicles || (getPlayerUID player in (_vehicle getVariable ["keyPlayers", []]))) exitWith {
		hint "You cannot report a vehicle stolen if you don't have keys.";
	};
	private _robbers = _vehicle getVariable ["vehicle_info_lockpicked", []];
	if (getPlayerUID player in (_vehicle getVariable ["vehicle_info_lockpicked", []])) exitWith {
		hint "You cannot report a vehicle stolen if you lockpicked it.";
	};
	if !(_vehicle getVariable ["oev_cop_stolen", false]) exitWith {
		hint "It doesn't look like that vehicle has been stolen. Maybe you should keep better track of your stuff?";
	};
	if !(_vehicle getVariable ["oev_cop_reportedStolen", false]) then {
		[_vehicle, _pos, player] remoteExecCall ["OEC_fnc_reportStolen", [west, 2]];
		_vehicle setVariable ["oev_cop_reportedStolen", true];
		private _vehicleName = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
		private _skinName = [_vehicle] call OEC_fnc_skinName;
		if (_skinName != "") then {
			_vehicleName = format ["%1 (%2)", _vehicleName, _skinName];
		};
		[1, format ["You have reported your %1 as stolen.", _vehicleName]] call OEC_fnc_broadcast;
		[] spawn OEC_fnc_updateKeyChainTab;
	} else {
		[1, "This vehicle has already been reported as stolen."] call OEC_fnc_broadcast;
	};
} else {
	if (playerSide != west) exitWith {};

	private _reporterName = _reporter getVariable ["realname", name _reporter];
	private _stolenVehicles = missionNamespace getVariable ["oev_cop_stolenVehicles", []];

	for [{private _idx = _stolenVehicles findIf { isNull (_x select 0) }}, {_idx >= 0}, {_idx = _stolenVehicles findIf { isNull (_x select 0) }}] do {
		_stolenVehicles deleteAt _idx;
	};

	if (_stolenVehicles findIf { _x param [0, objNull, [objNull]] isEqualTo _vehicle } < 0) then {
		_stolenVehicles pushBack [_vehicle, _pos, _reporterName];
	};

	oev_cop_stolenVehicles = _stolenVehicles;

	if (hasInterface) then {
		private _vehicleName = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
		private _vehicleSkin = [_vehicle] call OEC_fnc_skinName;
		if (_vehicleSkin != "") then {
			_vehicleName = format ["%1 (%2)", _vehicleName, _vehicleSkin];
		};
		systemChat format ["%1 has reported a %2 as stolen.", _reporterName, _vehicleName];
	};
};
