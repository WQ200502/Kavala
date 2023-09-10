#include "..\macro.h"
//  File: fn_initCiv.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Initializes the civilian.
private["_spawnPos"];
civ_spawn_1 = nearestObjects[getMarkerPos  "civ_spawn_1", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_03_V1_F","Land_i_Stone_HouseBig_V1_F"],250];
civ_spawn_2 = nearestObjects[getMarkerPos  "civ_spawn_2", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_03_V1_F","Land_i_Stone_HouseBig_V1_F"],250];
civ_spawn_3 = nearestObjects[getMarkerPos  "civ_spawn_3", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_03_V1_F","Land_i_Stone_HouseBig_V1_F"],250];
civ_spawn_4 = nearestObjects[getMarkerPos  "civ_spawn_4", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_03_V1_F","Land_i_Stone_HouseBig_V1_F"],250];
civ_spawn_5 = nearestObjects[getMarkerPos  "civ_spawn_5", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_03_V1_F","Land_i_Stone_HouseBig_V1_F"],250];
civ_spawn_6 = nearestObjects[getMarkerPos  "civ_spawn_6", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_03_V1_F","Land_i_Stone_HouseBig_V1_F"],250];
jailtransport_5 = nearestObjects[getMarkerPos "jailtransport_5", ["Land_Cargo_House_V3_F","Land_Cargo_Patrol_V3_F","Land_Wreck_CarDismantled_F"],250];
waitUntil {!(isNull (findDisplay 46))};

[[getPlayerUID player,player getVariable["realname",name player],O_stats_crimes],"OES_fnc_bulkAdd",false,false] spawn OEC_fnc_MP;

if((oev_is_arrested select 0) == 1) then {
	oev_is_arrested set[0,0];
	[player,true] spawn OEC_fnc_jaill;
} else {
	if(count life_ses_last_pos > 2) then {
		oev_thirst = profileNamespace getVariable["oev_thirst",100];
		oev_hunger = profileNamespace getVariable["oev_hunger",100];
		player setDir (profileNamespace getVariable["life_playerDir",0]);
		private _dam_obj = player;
		_dam_obj setDamage (profileNamespace getVariable["life_playerDamage",0]);

		if(life_ses_last_pos distance [0,0,0] > 500) then {
			if((life_ses_last_pos select 2) > 50) then {
				life_ses_last_pos set[2,0];
			};

			// 0 - MarkerName, 1 - Distance From, 2 - Min from center, 3 - max from center
			private _badLogout = [
				["rebelOne",110,160,250],
				["rebelTwo",110,160,250],
				["rebelThree",110,160,250],
				["rebelFour",110,160,250],
				["rebelFive",110,160,250],
				["rebelSix",110,160,250],
				["meth_cartel",200,235,310],
				["moonshine_cartel",200,235,310],
				["mushroom_cartel",200,235,310],
				["arms_cartel",200,235,310],
				["bmOne",75,80,125],
				["bmTwo",75,80,125],
				["bmThree",75,80,125],
				["bmFour",75,80,125],
				["bw_marker",35,40,65],
				["jail_marker",35,40,65],
				["fed_reserve_1",35,40,65],
				["rebelBoat",110,160,250]
			];

			{
				if ((life_ses_last_pos distance (getMarkerPos (_x select 0))) < (_x select 1)) then {
					life_ses_last_pos = [life_ses_last_pos,(_x select 2),(_x select 3),1,if (_x select 0 in ["rebelBoat"]) then [{1}, {0}],0,0] call BIS_fnc_findSafePos;
				};
			} forEach _badLogout;

			[] spawn{
				waitUntil{life_loadingSystemContinue};
				player setPos life_ses_last_pos;
				if ((count oev_ammoToDrop) > 0) then {
					["您携带了太多东西，所以有些东西掉在了地上！","Notice",true] spawn BIS_fnc_GUImessage;
					[player,oev_ammoToDrop] remoteExec ["OES_fnc_spawnDeletedAmmoOnLoad",2];
					oev_ammoToDrop = [];
				};
			};
		} else {
			[] spawn OEC_fnc_spawnMenu;
			waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
			waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.
		};
	} else {
		[] spawn OEC_fnc_spawnMenu;
		waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
		waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.
	};
};

//Position auto-syncer
[] spawn{
	while{true} do {
		sleep 240;

		if(alive player) then {
			[12] call OEC_fnc_ClupdatePartial;
		};
	};
};
[] spawn OEC_fnc_nlrCircle;

/*
[] spawn{
	while{true} do {
		_startPosition = getPosWorld player;
		waitUntil{sleep 1; getPosWorld player distance _startPosition >= 400};//Wait for the player to travel 400 meters

		if(alive player && isNull objectParent player) then {//only sync if they're on foot for right now
			oev_lastPosSync = time;
			[12] call OEC_fnc_ClupdatePartial;
		};
	};
};
*/

[] spawn OEC_fnc_clothingMonitor;
[] call OEC_fnc_zoneCreator;

// Upon init, check Realtor for Cash and notify player if found
[nil,nil,nil,[-1,2]] call OEC_fnc_checkRealtor;


if (life_newPlayerHints || (O_stats_playtime_civ <= 600)) then {
	[] spawn OEC_fnc_helpHints;
};
if (license_civ_vigilante) then {
	player setVariable ["isVigi",true,true];
};

if (__GETC__(oev_donator) > 0) then {
	player setVariable ["donlvl",__GETC__(oev_donator),true];
};
if (__GETC__(oev_civcouncil) > 0) then {
	player setVariable ["civcouncil",__GETC__(oev_civcouncil),true];
};
if (__GETC__(life_supportlevel) > 0) then {
	player setVariable ["supportteam",__GETC__(life_supportlevel),true];
};
