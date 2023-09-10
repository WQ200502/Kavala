#include "..\..\macro.h"
//  File: fn_handleCopIsland.sqf
//	Author: Fusah
//	Description: Handles cop tele 2 and from cop island.

if (oev_action_inUse) exitWith {titleText ["你已经在进行另一个动作了！", "PLAIN DOWN"]};
if (player getVariable ["restrained",false]) exitWith {};
if (playerSide != west) exitWith {};
if (oev_isDowned) exitWith {};
private _nearPlayers = ((nearestObjects[player,["Man"],10]) arrayIntersect playableUnits);
private _nearCivs = false;
private _nearSeniors = false;
private _admin = if(__GETC__(life_adminlevel) < 1) then {false} else {true};

{
	if (side _x isEqualTo civilian) exitWith {_nearCivs = true};
	if ((_x getVariable "rank") >= 3) then {_nearSeniors = true};
} forEach _nearPlayers;

if (_nearCivs) exitWith {hint "你不能和平民这么近的传送！"};
if !((player getVariable "rank" >= 3) || _nearSeniors || _admin) exitWith {hint "如果附近没有人进行训练，你就无法传送！"};

private _position = [[29714.5,559.034,2],[29724.4,560.977,2],[29725,569.659,2],[29718.3,570.748,2],[29710.1,570.105,2]];

cutText ["","BLACK OUT",-1,true,true];
uiSleep 1;

[
	[
		["欢迎来到。。","align = 'center' shadow = '1' size = '0.7' font='PuristaBold'"],
		["APD训练岛","align = 'center' shadow = '1' size = '0.7' font='PuristaBold'","#0000ff"],
		["","<br/>"],
		["请随时与高级APD成员在一起！","align = 'center' shadow = '1' size = '0.7'"]
	]
] spawn BIS_fnc_typeText2;

player enableSimulation false;
player setPos (selectRandom _position);
uiSleep 5;
player enableSimulation true;
cutText ["","BLACK IN",-1,true,true];

private _islandLoc = [29720.7,577.079,0.00142026];
while {true} do {
	if !(alive player) exitWith {};
	if ((player distance2D _islandLoc) > 150) exitWith {};
	if (underwater player) exitWith {
		player setPos [17396,13241.9,1];
	};
	uiSleep 1;
};