//	Author: x00
//	File: fn_handleBeatdown.sqf (OEC_fnc_handleBeatdown)

private["_player"];

_player = param [0,ObjNull,[ObjNull]];

if(player == _player) exitWith {
	addCamShake [80,4,80];
	[4000] call BIS_fnc_bloodEffect;
};