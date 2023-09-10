//	File: fn_surrender.sqf
//	Modifications: Fusah
//	Description: Causes player to put their hands on their head.

if (player getVariable ["restrained",false]) exitWith {};
if (player getVariable ["Escorting",false]) exitWith {};
if (vehicle player != player) exitWith {};
if (speed player > 1) exitWith {};

if (player getVariable ["playerSurrender",false]) then {
	player setVariable ["playerSurrender",false,true];
} else {
	player setVariable ["playerSurrender",true,true];
};
while {player getVariable ["playerSurrender",false]} do {
	player playMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
	if (!alive player || (vehicle player) != player) then { player setVariable ["playerSurrender",false,true]; };
	uiSleep 0.002;
};

player playMoveNow "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";