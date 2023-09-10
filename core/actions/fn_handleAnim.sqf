//  File: fn_handleAnim.sqf
//	Author: Fusah
//	Description: Handles player animations.

params ["_anim","_delay"];


if (player getVariable ["inAnim",false]) then {
	player setVariable ["inAnim",false];
} else {
	player setVariable ["inAnim",true];
};

if !(player getVariable ["inAnim",false]) exitWith {};

//Makes sure they put away weapon so it doesnt fuck with the animation
if(!(player getVariable["restrained",false]) && (isNull (player getVariable ["TransportingPlayer",objNull]))) then {
	if(currentWeapon player != "") then {
		life_curWep_h = currentWeapon player;
		player action ["SwitchWeapon", player, player, 100];
		player switchCamera cameraView;
	};
};

while {player getVariable ["inAnim",false]} do {
	player playMoveNow _anim;
	uiSleep _delay;
	if (!alive player || (vehicle player) != player) then {player setVariable ["inAnim",false]};
};

player playActionNow "stop";