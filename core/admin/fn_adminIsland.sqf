#include "..\..\macro.h"
//  File: fn_adminIsland.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Teleports admin to island.

if (__GETC__(life_adminlevel) < 1) exitWith {};

player enableSimulation false;
player setPos [30270.6,295.076,1.5];
uiSleep 6;
player enableSimulation true;