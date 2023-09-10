#include "..\..\macro.h"
//  File: fn_epirevived.sqf
//	Author: Bryan "Tonic" Boardwine

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPosATL player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if (oev_conqDeath > 0) then {
	["deathPrice", false, oev_conqDeath] remoteExec ["OES_fnc_conquestServer", 2];
	oev_conqDeath = 0;
};
player setUnitLoadout [oev_loadout,false];
if !(playerSide isEqualTo civilian) then {
	if (count oev_loadout >= 6) then { //Set max weight as they get revived to avoid items getting yeeted
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
[[life_corpse],"OEC_fnc_corpse",-2,false] spawn OEC_fnc_MP;
private _dir = getDir life_corpse;

closeDialog 0;
life_deathCamera cameraEffect ["TERMINATE","BACK"];
camDestroy life_deathCamera;

//Bring me back to life.
player setDir _dir;
player setPosASL (visiblePositionASL life_corpse);
life_corpse setVariable["Revive",nil,true];
life_corpse setVariable["allowEpi",false,true];
life_corpse setVariable["name",nil,true];
if (life_corpse getVariable ["lastShot", 0] != 0) then {
	player setVariable ["lastShot", life_corpse getVariable ["lastShot", 0], true];
};
[[life_corpse],"OEC_fnc_corpse",-2,false] spawn OEC_fnc_MP;

player setVariable["Revive",nil,true];
player setVariable["allowEpi",false,true];
player setVariable["name",nil,true];
player setVariable["Reviving",nil,true];

if(playerside isEqualTo civilian) then {
	profileNamespace setVariable ["epiActive",true];
};

player setVariable["epiActive",true, true];

if(count oev_deaths > 0) then {
	deleteMarkerLocal format["nlr_marker_%1", floor((oev_deaths select ((count oev_deaths) - 1)) select 1)];
	deleteMarkerLocal format["nlr_marker_text_%1", floor((oev_deaths select ((count oev_deaths) - 1)) select 1)];
};
private _dopamineChance = 101;
if (playerSide != independent) then {
	private _perkTier = ["civ_epiPens"] call OEC_fnc_fetchStats;
	_dopamineChance = switch (_perkTier) do {
		case 1: {95};
		case 2: {90};
		default {101};
	};
};
private _dice = random(100);
if (_dice < _dopamineChance) then {
	if (oev_lastkiller isEqualTo 1) then {
		player setVariable["epiTime",time + 420];
		hint "You're in critical condition, visit a hospital or medic within 7 minutes!";

		[] spawn{//epi pen timer
			private["_uiDisp","_time","_timer"];
			disableSerialization;
			10 cutRsc ["life_epi_timer","PLAIN DOWN"];
			_uiDisp = uiNamespace getVariable "life_epi_timer";
			_timer = _uiDisp displayCtrl 38303;

			while {true} do {
				_time = (player getVariable["epiTime",time + 5]);
				if(isNull _uiDisp) then {
					10 cutRsc ["life_epi_timer","PLAIN DOWN"];
					_uiDisp = uiNamespace getVariable "life_epi_timer";
					_timer = _uiDisp displayCtrl 38303;
				};

				if !(player getVariable["epiActive", false]) exitWith {
					if(playerside isEqualTo civilian) then {
						profileNamespace setVariable ["epiActive",false];
					};
				};
				if !(alive player) exitWith {};
				if (round(_time - time) < 1) exitWith {oev_epipen_damage = true; _dam_obj = player; _dam_obj setDamage 1;};

				_timer ctrlSetText format["%1",[(_time - time),"MM:SS"] call BIS_fnc_secondsToString];
				uiSleep 1;
			};
			10 cutText["","PLAIN DOWN"];
		};
	} else {
		player setVariable["epiTime",time + 14400];
		hint "You're in critical condition, visit a hospital or medic before server restart!";

		[] spawn{//epi pen timer
			private["_uiDisp","_time","_timer"];
			disableSerialization;
			10 cutRsc ["life_epi_timer","PLAIN DOWN"];
			_uiDisp = uiNamespace getVariable "life_epi_timer";
			_timer = _uiDisp displayCtrl 38303;

			while {true} do {
				_time = (player getVariable["epiTime",time + 5]);
				if(isNull _uiDisp) then {
					10 cutRsc ["life_epi_timer","PLAIN DOWN"];
					_uiDisp = uiNamespace getVariable "life_epi_timer";
					_timer = _uiDisp displayCtrl 38303;
				};

				if !(player getVariable["epiActive", false]) exitWith {
					if(playerside isEqualTo civilian) then {
						profileNamespace setVariable ["epiActive",false];
					};
				};
				if !(alive player) exitWith {};
				if (round(_time - time) < 1) exitWith {oev_epipen_damage = true; _dam_obj = player; _dam_obj setDamage 1;};

				_timer ctrlSetText format["%1",[(_time - time),"MM:SS"] call BIS_fnc_secondsToString];
				uiSleep 1;
			};
			10 cutText["","PLAIN DOWN"];
		};
	};
} else {
	// Not on Dope should be able to be revived at next death with an epi
	if(playerside != independent) then {
		profileNamespace setVariable ["epiActive",false];
	};

	player setVariable["epiActive",false, true];
};

oev_removeWanted = false;
[] call OEC_fnc_hudUpdate; //Request update of hud.

//Bring sidechat back if they had it enabled
private _alvl = __GETC__(life_adminlevel);
[[player,life_sidechat,playerSide,_alvl,oev_streamerMode,life_gangChat],"OES_fnc_managesc",false,false] spawn OEC_fnc_MP;

if !(playerSide isEqualTo civilian) exitWith {};

if(count oev_deaths > 0) then {
	oev_deaths deleteAt ((count oev_deaths) - 1)
};
