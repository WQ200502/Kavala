params [
	["_unit", objNull, [objNull]],
	["_role", "cargo", [""]],
	["_vehicle", objNull, [objNull]]
];
if (isNull _unit || isNull _vehicle) exitWith {};
if (_vehicle in oev_vehicles || (getPlayerUID _unit in (_vehicle getVariable ["keyPlayers", []]))) then {
	_vehicle setVariable ["vehicle_info_lastSeen", position _vehicle];
};
