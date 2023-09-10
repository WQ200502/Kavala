//  File: fn_pullOutVeh.sqf
//	Author: Bryan "Tonic" Boardwine

if ((playerSide isEqualTo west && (!(player getVariable ["restrained",false]) && !(player getVariable ["downed",false]))) || (isNull objectParent player)) exitWith {};
if (player getVariable ["restrained",false]) then {
	detach player;
	player setVariable["Escorting",false,true];
	player setVariable["transporting",false,true];
	oev_disable_getOut = false;

	player action ["Eject", vehicle player];
	player action ["GetOut", vehicle player];

	oev_disable_getIn = true;
} else {
	player action ["Eject", vehicle player];
	player action ["GetOut", vehicle player];
};

titleText [localize "STR_NOTF_PulledOut","PLAIN DOWN"];
titleFadeOut 4;