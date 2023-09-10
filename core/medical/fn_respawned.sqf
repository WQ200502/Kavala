#include "..\..\macro.h"
//  File: fn_respawned.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Sets the player up if he/she used the respawn option.
private["_handle"];

/**
 * if snapshot_life_gear exists then use it instead of
 * life_gear since player has died and is an officer or medic. /x00
 */
if (playerSide != civilian) then {
	player setUnitLoadout [oev_loadout,false];
};
if (call oev_civcouncil >= 1) then {player enableFatigue false};
//Reset our weight and other stuff
oev_use_atm = TRUE;
oev_hunger = 100;
oev_thirst = 100;
oev_carryWeight = 0;
oev_cash = 0; //Make sure we don't get our cash back.
oev_cache_cash = oev_random_cash_val;
oev_respawned = false;
oev_survival_damage = false;
oev_epipen_damage = false;
oev_conqDeath = 0;
player playMove "amovpercmstpsnonwnondnon";

life_corpse setVariable["Revive",nil,TRUE];
life_corpse setVariable["allowEpi",false,true];
life_corpse setVariable["name",nil,TRUE];
life_corpse setVariable["Reviving",nil,TRUE];
player setVariable["Revive",nil,TRUE];
player setVariable["allowEpi",false,true];
player setVariable["name",nil,TRUE];
player setVariable["Reviving",nil,TRUE];

if(playerside isEqualTo civilian) then {
	profileNamespace setVariable ["epiActive",false];
};

//Load gear for a 'new life'
switch(playerSide) do {
	case west: {
		_handle = [] spawn OEC_fnc_loadGear;
	};
	case civilian: {
		_handle = [] spawn OEC_fnc_civLoadout;
	};
	case independent: {
		_handle = [] spawn OEC_fnc_loadGear;
		//_handle = [] spawn OEC_fnc_medicLoadout;
	};
	waitUntil {scriptDone _handle};
};

//Cleanup of weapon containers near the body & hide it.
if(!isNull life_corpse) then {
	private["_containers"];
	life_corpse setVariable["Revive",TRUE,TRUE];
	life_corpse setVariable["allowEpi",false,true];
	_containers = nearestObjects[life_corpse,["WeaponHolderSimulated"],5];
	{deleteVehicle _x;} foreach _containers; //Delete the containers.
	deleteVehicle life_corpse;
};

//Destroy our camera...
life_deathCamera cameraEffect ["TERMINATE","BACK"];
camDestroy life_deathCamera;

//Bad boy
if((oev_is_arrested select 0) == 1) exitWith {
	hint localize "STR_Jail_Suicide";
	oev_is_arrested set[0,0];
	[player,TRUE] spawn OEC_fnc_jaill;
	[] call OEC_fnc_ClupdateRequest;
};

private _alvl = __GETC__(life_adminlevel);
[[player,life_sidechat,playerSide,_alvl,oev_streamerMode,life_gangChat],"OES_fnc_managesc",false,false] spawn OEC_fnc_MP;

if (oev_copDeathPay) then {
	[] call OEC_fnc_payDeathFee;
};

[] call OEC_fnc_ClupdateRequest;
[] call OEC_fnc_hudUpdate; //Request update of hud.
