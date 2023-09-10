#include "..\..\macro.h"
//  File: fn_martialLaw.sqf
//	Author: Jesse "tkcjesse" Schultz
//  Modified by: Fusah
//	Description: Enable/Disable Martial Law on city.

(_this select 3) params [
	["_mode",-1,[0]],
	["_city","",[""]]
];
if (_mode isEqualTo -1 || _city isEqualTo "") exitWith {};
if (playerSide != west) exitWith {};
if (__GETC__(life_coplevel) < 4) exitWith {};

if (oev_actions_cooldown > time) exitWith {hint "Please wait a few seconds before trying this action again.";};
private _type = "";

if (_mode isEqualTo 0) then {
	_type = "declare";
	} else {
	_type = "end";
};

_areYouSure = [
	format ["Are you sure you want to %2 martial law in the city of %1?",_city,_type],
	"Confirm Martial Law",
	"Yes",
	"No"
] call BIS_fnc_guiMessage;

if !(_areYouSure) exitWith {};
if (_mode isEqualTo 0) then {
	[[_mode,_city,player],"OES_fnc_declareMartial",false,false] spawn OEC_fnc_MP;
	[
		["event", "Declare Martial Law"],
		["player", name player],
		["player_id", getPlayerUID player],
		["city", _city],
		["position", getPos player]
	] call OEC_fnc_logIt;
};

if (_mode isEqualTo 1) then {
	[[_mode,_city,player],"OES_fnc_declareMartial",false,false] spawn OEC_fnc_MP;
};

oev_actions_cooldown = (time + 35);
