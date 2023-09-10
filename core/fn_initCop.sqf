#include "..\macro.h"
//  File: fn_initCop.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Cop Initialization file.

waitUntil {!(isNull (findDisplay 46))};

private _end = false;
if((__GETC__(life_coplevel) == 0) && (__GETC__(life_adminlevel) == 0)) then {
	["NotWhitelisted",false,true] call BIS_fnc_endMission;
	[
		["event","Login Fail"],
		["player",name player],
		["player_id",getPlayerUID player]
	] call OEC_fnc_logIt;

	uiSleep 20;
};

player setVariable ["rank",(__GETC__(life_coplevel)),true];
player setVariable ["nonLethals",true,true];
player setVariable ["lethalsPO",false,true];

private _copLevel = (__GETC__(life_coplevel));

private _stringLevel = switch (_copLevel) do {
	case 1: {"Deputy"};
	case 2: {"Patrol Officer"};
	case 3: {"Corporal"};
	case 4: {"Retired SrAPD"};
	case 5: {"Staff Sergeant"};
	case 6: {"Sergeant"};
	case 7: {"Lieutenant"};
	case 8: {"Staff Chief"};
	case 9: {"Deputy Chief of Police"};
	case 10: {"Chief of Police"};
	default {"No Rank"};
};

[
	["event","Login Succ"],
	["player",name player],
	["player_id",getPlayerUID player],
	["whitelist",_stringLevel]
] call OEC_fnc_logIt;
["oev_cop_stolenVehicles"] remoteExecCall ["OES_fnc_jipRequestVar", 2];
[] spawn OEC_fnc_spawnMenu;

[[getPlayerUID player],"OES_fnc_wantedPardon",false,false] spawn OEC_fnc_MP;
waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.

[] spawn OEC_fnc_clothingMonitor;
[] call OEC_fnc_zoneCreator;
[] call OEC_fnc_checkCopGear;

[] spawn{
	while {true} do {
		uiSleep (2.5 * 60);
		[
		 	["event","APD Location"],
		 	["player",name player],
		 	["player_id",getPlayerUID player],
		 	["position",getPosATL player]
		 ] call OEC_fnc_logIt;
	};
};

private _blackwaterDome = nearestObject [[20898.6,19221.7,0.00143909],"Land_Dome_Big_F"];
if (_blackwaterDome getVariable ["chargeplaced",false]) then {
	[[_blackwaterDome,player],"OES_fnc_jipRequestTimer",false,false] call OEC_fnc_MP;
};

if (fed_bank getVariable ["chargeplaced",false]) then {
	[[fed_bank,player],"OES_fnc_jipRequestTimer",false,false] call OEC_fnc_MP;
};

if (altis_bank getVariable ["chargeplaced",false]) then {
	[[altis_bank,player],"OES_fnc_jipRequestTimer",false,false] call OEC_fnc_MP;
};

if (altis_bank_1 getVariable ["chargeplaced",false]) then {
	[[altis_bank_1,player],"OES_fnc_jipRequestTimer",false,false] call OEC_fnc_MP;
};

if (altis_bank_2 getVariable ["chargeplaced",false]) then {
	[[altis_bank_2,player],"OES_fnc_jipRequestTimer",false,false] call OEC_fnc_MP;
};

if (jailwall getVariable ["chargeplaced",false]) then {
	[[jailwall,player],"OES_fnc_jipRequestTimer",false,false] call OEC_fnc_MP;
};

if (oev_artGallery) then {
	[[gallery_siren,player],"OES_fnc_jipRequestTimer",false,false] call OEC_fnc_MP;
};

copredeploy = {
	[] spawn{
		_redeploying = ["Are you sure?", "Confirm", "yes", "no"] call BIS_fnc_guiMessage;
		if (_redeploying) then {
			oev_copredeploy = true;
			[] spawn OEC_fnc_spawnMenu;
		}else{
			oev_copredeploy = false;
			hint"Redeploying canceled";
		};
	};
};
_group = grpNull;
{
	if(str _x isEqualTo "B Alpha 1-1") exitWith {_group = _x};
}forEach allGroups select {side _x isEqualTo independent};

if !(str group player isEqualTo "B Alpha 1-1") then {
	if (!isNull _group) then {
		[player] join _group;
	} else {
		group player setGroupIDGlobal ["Alpha 1-1"];
	};
};
