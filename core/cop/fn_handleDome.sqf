//  File: fn_handleDome.sqf
//	Author: Fusah
//	Description: Handles the locking and unlocking of APD training dome.

params [
	["_building",objNull,[objNull]]
];

private _action = "";
closeDialog 0;
if (isNull _building) exitWith {};
private _nearCivs = false;
private _lockOrNot = [
	"What would you like to do with the training dome?",
	"Training Dome Control Panel",
	"Lock",
	"Unlock"
] call BIS_fnc_guiMessage;

if (_lockOrNot) then {
	_action = "locked";
} else {
	_action = "unlocked";
};

private _nearPlayers = ((nearestObjects[_building,["Man"],40]) arrayIntersect playableUnits);

{
	if (side _x isEqualTo civilian) exitWith {_nearCivs = true};
} forEach _nearPlayers;

if (_nearCivs && _lockOrNot) exitWith {hint "You can't lock the dome while civilians are near!"};
if (_lockOrNot && oev_inCombat) exitWith {hint "You can't lock the dome while in combat!"};
if (((_building getVariable ["bis_disabled_Door_1",0]) isEqualTo 1 && _lockOrNot) || ((_building getVariable ["bis_disabled_Door_1",0]) isEqualTo 0 && !_lockOrNot)) exitWith {hint format["The training dome is already %1!",_action]};

if (_lockOrNot) then {
	for "_i" from 1 to 2 do {
		_building setVariable[format["bis_disabled_Door_%1",_i],1,true];
		_building animate [format["Door_%1A_move",_i],0];
		_building animate [format["Door_%1B_move",_i],0];
	};
	titleText ["Training Dome locked!", "PLAIN DOWN"];
} else {
	for "_i" from 1 to 2 do {
		_building setVariable[format["bis_disabled_Door_%1",_i],0,true];
		_building animate [format["Door_%1A_move",_i],1];
		_building animate [format["Door_%1B_move",_i],1];
	};
	titleText ["Training Dome unlocked!", "PLAIN DOWN"];
};