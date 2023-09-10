#include "..\macro.h"
//  File: fn_initMedic.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Initializes the medic..

waitUntil {!(isNull (findDisplay 46))};

if(((__GETC__(life_medicLevel)) isEqualTo 0) && ((__GETC__(life_adminlevel)) isEqualTo 0) && ((__GETC__(life_newslevel)) isEqualTo 0)) exitWith {
	["Notwhitelisted",FALSE,TRUE] call BIS_fnc_endMission;
	uiSleep 35;
};

if((str(player) in ["med_1","med_2","med_3","med_4","med_5","med_6","med_7","med_8","med_9","med_10"]) && ((__GETC__(life_medicLevel)) isEqualTo 0) && ((__GETC__(life_adminlevel)) isEqualTo 0)) exitWith {
	["Notwhitelisted",false,true] call BIS_fnc_endMission;
	uiSleep 35;
};

if((str(player) in ["indp_news_1","indp_news_2","indp_news_3","indp_news_4","indp_news_5","indp_news_6","indp_news_7","indp_news_8"]) && ((__GETC__(life_newslevel)) isEqualTo 0) && ((__GETC__(life_adminlevel)) isEqualTo 0)) exitWith {
	["Notwhitelisted",false,true] call BIS_fnc_endMission;
	uiSleep 35;
};

if((str(player) in ["indp_news_1","indp_news_2","indp_news_3","indp_news_4","indp_news_5","indp_news_6","indp_news_7","indp_news_8","indp_news_9","indp_news_10"]) && (((__GETC__(life_newslevel)) > 0) || ((__GETC__(life_medicLevel)) > 0))) then {
	oev_newsTeam = true;
};

if !(oev_newsTeam) then {
	[] spawn IG_fnc_IgiLoadInit;
	player setVariable["rank",(__GETC__(life_medicLevel)),true];
};

medredeploy = {
	[] spawn{
		_redeploying = ["Are you sure?", "Confirm", "yes", "no"] call BIS_fnc_guiMessage;
		if (_redeploying) then {
			oev_medredeploy = true;
			[] spawn OEC_fnc_spawnMenu;
		}else{
			oev_medredeploy = false;
			hint"Redeploying canceled";
		};
	};
};//Author mohsen98
[] spawn OEC_fnc_spawnMenu;

[[getPlayerUID player],"OES_fnc_wantedPardon",false,false] spawn OEC_fnc_MP;
waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.

if (oev_newsTeam) then {[] call OEC_fnc_newsLoadout;};
[] spawn OEC_fnc_nlrCircle;
[] spawn OEC_fnc_clothingMonitor;
[] call OEC_fnc_zoneCreator;
[] call OEC_fnc_checkMedGear;

life_buddyObj = objNull;
life_buddyPID = "";

_group = grpNull;
{
	if(str _x isEqualTo "R Alpha 1-1") exitWith {_group = _x};
}forEach allGroups select {side _x isEqualTo independent};

if !(str group player isEqualTo "R Alpha 1-1") then {
	if (!isNull _group) then {
		[player] join _group;
	} else {
		group player setGroupIDGlobal ["Alpha 1-1"];
	};
};
