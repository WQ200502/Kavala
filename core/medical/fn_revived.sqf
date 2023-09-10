#include "..\..\macro.h"
//  File: fn_revived.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: THANK YOU JESUS I WAS SAVED!
private["_medic","_dir","_reviveCost"];
params [
	["_medic", "Unknown Medic", [""]],
	["_isAdminRevive", false, [false]]
];

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPosATL player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};
if(O_stats_playtime_civ > 6000) then {
	_reviveCost = (call oev_revive_fee)
} else {
	_reviveCost = (call oev_reduced_revive_fee)
};
if (oev_conqDeath > 0) then {
	["deathPrice", false, oev_conqDeath] remoteExec ["OES_fnc_conquestServer", 2];
	oev_conqDeath = 0;
};
player setUnitLoadout [oev_loadout,false];
if !(playerSide isEqualTo civilian) then {
	if (count oev_loadout >= 6 && count (oev_loadout select 5) != 0) then { //Set max weight as they get revived to avoid items getting yeeted
		oev_maxWeight = ((getNumber(configFile >> "CfgVehicles" >> ((oev_loadout select 5) select 0) >> "maximumload"))/8) + oev_maxWeightT;
	};
	if(count oev_yInvItems > 1) then {
		if((oev_yInvItems select 0) isEqualType [] && count (oev_yInvItems select 0) > 0) then {
			{
				[true,(_x select 0),(_x select 1)] call OEC_fnc_handleInv;
			} forEach (oev_yInvItems select 0);
		};
	};
};

life_corpse setVariable["realname",nil,true]; //Should correct the double name sinking into the ground.
[[life_corpse],"OEC_fnc_corpse",-2,FALSE] spawn OEC_fnc_MP;
_dir = getDir life_corpse;
if (_isAdminRevive) then {
	hint format ["%1让你复活了。", _medic];
} else {
	hint format [localize "STR_Medic_RevivePay", _medic, [_reviveCost] call OEC_fnc_numberText];
};

closeDialog 0;
life_deathCamera cameraEffect ["TERMINATE","BACK"];
camDestroy life_deathCamera;

if !(_isAdminRevive) then {
	//Take fee for services.
	if(oev_atmcash > _reviveCost) then {
		oev_atmcash = oev_atmcash - _reviveCost;
		oev_cache_atmcash = oev_cache_atmcash - _reviveCost;
	} else {
		oev_atmcash = 0;
		oev_cache_atmcash = oev_random_cash_val;
	};
};

//Bring me back to life.
player setDir _dir;
player setPosASL (visiblePositionASL life_corpse);
life_corpse setVariable["Revive",nil,TRUE];
life_corpse setVariable["allowEpi",false,true];
life_corpse setVariable["name",nil,TRUE];
[[life_corpse],"OEC_fnc_corpse",-2,false] spawn OEC_fnc_MP;

player setVariable["Revive",nil,TRUE];
player setVariable["allowEpi",false,true];
player setVariable["name",nil,TRUE];
player setVariable["Reviving",nil,TRUE];
oev_removeWanted = false;
[] call OEC_fnc_hudUpdate; //Request update of hud.

private _alvl = __GETC__(life_adminlevel);
[[player,life_sidechat,playerSide,_alvl,oev_streamerMode,life_gangChat],"OES_fnc_managesc",false,false] spawn OEC_fnc_MP;

if (playerSide isEqualTo west) exitWith {};

if(count oev_deaths > 0) then {
	deleteMarkerLocal format["nlr_marker_%1", floor((oev_deaths select ((count oev_deaths) - 1)) select 1)];
	deleteMarkerLocal format["nlr_marker_text_%1", floor((oev_deaths select ((count oev_deaths) - 1)) select 1)];
	oev_deaths deleteAt ((count oev_deaths) - 1)
};

if (oev_earplugs) then {
	1 fadeSound 1;
};
