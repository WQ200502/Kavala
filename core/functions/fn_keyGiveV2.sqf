//  File: fn_keyGiveV2.sqf
//  Parameterized version of OEC_fnc_keyGive

//	Description: Gives a copy of the key for the selected vehicle to the selected player.
params [
	["_unit", objNull, [objNull]],
	["_vehicle", objNull, [objNull]]
];

if (isNull _unit || isNull _vehicle) exitWith {
	["Bad unit or vehicle in OEC_fnc_keyGiveV2"] call BIS_fnc_error;
};

if (player getVariable ["restrained",false]) exitWith {hint "You cannot give keys to another player while restrained.";};
if (_unit getVariable ["restrained",false]) exitWith {hint "You cannot give keys to a restrained player.";};

private _uid = getPlayerUID _unit;
private _owners = _vehicle getVariable ["vehicle_info_owners", []];
private _thieves = _vehicle getVariable ["vehicle_info_lockpicked", []];
private _index = [_uid, _owners] call OEC_fnc_index;
if (_index == -1) then {
	_owners pushBack [_uid, _unit getVariable ["realname", name _unit]];
	_vehicle setVariable ["vehicle_info_owners", _owners, true];
	if ((getPlayerUID player) in _thieves) then {
		_thieves append [getPlayerUID _unit];
		_vehicle setVariable ["vehicle_info_lockpicked", _thieves, true];
	};
};

private _vehicleName = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
hint format ["You have given %1 keys to your %2", _unit getVariable ["realname", name _unit], _vehicleName];
[[_vehicle, _unit, profileName], "OEC_fnc_clientGetKey", _unit, false] spawn OEC_fnc_MP;
