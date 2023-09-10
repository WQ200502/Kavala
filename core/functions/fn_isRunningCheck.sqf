#include "..\..\macro.h"
//	Author: Poseidon
//	Description: This is called by the server to all players to make sure their spyglass thread is still running. Some hacks exit all loops on join to bypass antihacks.

if((isServer && isDedicated) || (!hasInterface)) exitWith {};
private["_maxTime"];
_maxTime = time + 300;

if(isNil "SpyGlass_lastCheckTime") then {
	waitUntil{time > _maxTime || !(isNil "SpyGlass_lastCheckTime")};
};

if(dont_respawn_yet) then {sleep 10;};

if(isNil "SpyGlass_lastCheckTime") exitWith {
	// [[player],"OES_fnc_SpyGlassResponse",false,false] call OEC_fnc_MP;
	[[profileName,steamid,format["SpyGlass thread not running, timer variable nil!",""]],"OEC_fnc_cookieJar",false,false] call OEC_fnc_MP;
	[[profileName,format["SpyGlass thread not running, timer variable nil! Player kicked.",""]],"OEC_fnc_notifyAdmins",-2,false] call OEC_fnc_MP;
	uiSleep 2;
	SpyGlass_lastCheckTime = nil;
	failMission "SpyGlass";
};

if((time - SpyGlass_lastCheckTime) > 180) exitWith {
	// [[player],"OES_fnc_SpyGlassResponse",false,false] call OEC_fnc_MP;
	[[profileName,steamid,format["SpyGlass thread not running, last running %1 seconds ago!",(time - SpyGlass_lastCheckTime)]],"OEC_fnc_cookieJar",false,false] call OEC_fnc_MP;
	[[profileName,format["SpyGlass thread not running, last running %1 seconds ago! Player kicked.",(time - SpyGlass_lastCheckTime)]],"OEC_fnc_notifyAdmins",-2,false] call OEC_fnc_MP;
	uiSleep 2;
	SpyGlass_lastCheckTime = nil;
	failMission "SpyGlass";
};