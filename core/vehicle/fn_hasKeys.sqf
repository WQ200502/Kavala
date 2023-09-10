// File: fn_hasKeys.sqf
// Author: codeYeTi
// Description: Checks if the user has keys the vehicle
params [
	["_vehicle", objNull, [objNull]]
];

if (isNull _vehicle) exitWith { false };
if (_vehicle in oev_vehicles) exitWith { true };
if (playerSide isEqualTo civilian && getPlayerUID player in (_vehicle getVariable ["keyPlayers", []])) exitWith { true };
private _gangID = _vehicle getVariable ["gangID", 0];
if (_gangID == 0) exitWith { false };
private _playerGangID = (player getVariable ["gang_data", [0, "", 0]]) select 0;
if (_playerGangID == 0) exitWith { false };
(_playerGangID == _gangID)
