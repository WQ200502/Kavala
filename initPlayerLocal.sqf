#include "macro.h"
//  File:initPlayerLocal.sqf
//	Description: Starts the initialization of the player.

if (!hasInterface) exitWith {
	if (!isServer) exitWith {
		systemChat "启动无头客户端";
    [] call compile preprocessFileLineNumbers "\life_hc\initHC.sqf";
	};
}; //This is a headless client. Call the initHC file.
__CONST__(BIS_fnc_endMission,BIS_fnc_endMission);
SpyGlass_lastCheckTime = nil;
diag_log "init player" + str(allDisplays);
cutText["","BLACK FADED"];
0 cutFadeOut 9999999;

[] spawn OEC_fnc_initSpy;

// kick players who have illegal characters in their names. /x00
/* if([name player] call OEC_fnc_checkName) exitWith {
	disableSerialization;
	["BadName",true,true] call BIS_fnc_endMission;
	while{true} do {
		(findDisplay 49) displayCtrl 1010 ctrlEnable false;
	};
}; */

oev_newsTeam = false;
//[] execVM"zlt_fastrope.sqf";
[] spawn OEC_fnc_briefing;
[] execVM"core\init.sqf";

//Execute JIP code.
if((_this select 1)) then {
	//[] execVM"core\jip.sqf";
	//Do Jip stuff here since obfuscating/compression breaks certain execVM stuff probably
	[] spawn{
		waitUntil{!isNil "olympusVehiclesLoaded"};
		waitUntil{olympusVehiclesLoaded};
		waitUntil{!isNil "olympusGangVehiclesLoaded"};
		waitUntil{olympusGangVehiclesLoaded};
		waitUntil{!isNil "oev_sesion_completed"};
		waitUntil{oev_session_completed};
		sleep 4;

		{
			if(isPlayer _x && _x != player) then {
				[_x,true] spawn OEC_fnc_skinUniform;
			};
		}foreach (allMissionObjects "Man");

		{
			_index = _x getVariable "oev_veh_color";
			if(!isNil "_index") then {
				[_x,_index] spawn OEC_fnc_colorVehicle;
			};
			_lights = _x getVariable ["lights",false];
			if(_lights) then {
				[_x,0.22] spawn OEC_fnc_copLights;
			};
			_underGlow = _x getVariable ['underActive',false];
			if (_underGlow) then {
				[[0,0,0],_x getVariable ['underglow',[]],_x] spawn OEC_fnc_handleGlowLights;
			};
		}foreach allMissionObjects "Car";

		{
			_index = _x getVariable "oev_veh_color";
			if(!isNil "_index") then {
				[_x,_index] spawn OEC_fnc_colorVehicle;
			};
			_lights = _x getVariable ["lights",false];
			if(_lights) then {
				[_x,0.22] spawn OEC_fnc_copLights;
			};
		}foreach allMissionObjects "Air";

		{
			_index = _x getVariable "oev_veh_color";
			if(!isNil "_index") then {
				[_x,_index] spawn OEC_fnc_colorVehicle;
			};
			_lights = _x getVariable ["lights",false];
			if(_lights) then {
				[_x,0.22] spawn OEC_fnc_copLights;
			};
		}foreach allMissionObjects "Ship";
	};
};

inGameUISetEventHandler ["PrevAction",""];
inGameUISetEventHandler ["NextAction",""];
inGameUISetEventHandler ["Action",""];

BIS_fnc_establishingShot_playing = false;
dont_respawn_yet = true;
[] spawn{//disable spawn button to prevent players spawning with a blank character and syncing over all their previous progress
	while{dont_respawn_yet} do {
		disableSerialization;
		private["_respawnButton"];
		_respawnButton = (findDisplay 49) displayCtrl 1010;
		_respawnButton ctrlEnable false;
	};
	disableSerialization;
	private["_respawnButton"];
	_respawnButton = (findDisplay 49) displayCtrl 1010;
	_respawnButton ctrlEnable true;
};

[] spawn OEC_fnc_markerMonitor;
[] spawn OEC_fnc_emptyFuel;
[] spawn OEC_fnc_sideChatMonitor;
[] spawn OEC_fnc_startingMusic;

life_bwObj = nearestObject [[20898.6,19221.7,0.00143909],"Land_Dome_Big_F"];
