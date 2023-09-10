#include "..\..\macro.h"
//	Author: Bryan "Tonic" Boardwine
//	Description:
//	Sends specific information to the server to update on the player,
//	meant to keep the network traffic down with large sums of data flowing
//	through OEC_fnc_MP DESCRIPTIONEND

private["_mode","_packet","_array","_flag","_totalItemsActual","_hackDetected","_hackedItemArray"];
_mode = param [0,0,[0]];

if(!isNil "life_shop_cam" && {!isNull life_shop_cam} && {_mode in [3]}) exitWith {};//cant sync gear while clothing shop open
if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};
if(oev_newsTeam && !(_mode in [0,1,6,8,9])) exitWith {};//if playing in news team slot, only allow certain stuffs
if(oev_inEvent && (_mode in [3])) exitWith {};//if in event, do not sync gear

_hackDetected = false;
if(_mode == 3) then {
	//------------------------------------------------------------------------
	//Code for checking of hacked in inventory items....
	_totalItemsActual = 0;
	{
		_totalItemsActual = _totalItemsActual + (missionNameSpace getVariable _x);
	}foreach oev_inv_items;

	if(_totalItemsActual > (oev_inventoryMonitor - oev_inventoryRandomVar) || _totalItemsActual >= 150) exitWith {
		_hackDetected = true;
		_hackedItemArray = [];

		{
			if((missionNameSpace getVariable _x) > 0) then {
				_hackedItemArray pushBack [_x, (missionNameSpace getVariable _x)];
			};
		}foreach oev_inv_items;

		[
			["event","Hacked Items"],
			["player_id",getPlayerUID player],
			["hackeditems", _hackedItemArray],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
		[profileName,format["Kicked for hacked items. (Items expected to have = %1) (Actual item count = %2)",(oev_inventoryMonitor - oev_inventoryRandomVar),_totalItemsActual]] remoteExec ["OEC_fnc_notifyAdmins",-2];
		["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
	};
	//------------------------------------------------------------------------
};
if(_hackDetected) exitWith {};

if(playerside != civilian && (_mode in [12])) exitWith {};//if not civilian, do not update player position

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",getPlayerUID player],["target","null"],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] call OEC_fnc_logIt;
	[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] remoteExecCall ["OEC_fnc_notifyAdmins",-2];
	[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] remoteExecCall ["OES_fnc_handleDisc",2];
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

_packet = [steamid,playerSide,nil,_mode];
_array = [];
_flag = switch(playerSide) do {case west: {"cop"}; case civilian: {"civ"}; case independent: {"med"};};

switch(_mode) do {
	case 0: {
		_packet set[2,oev_cash];
	};

	case 1: {
		_packet set[2,oev_atmcash];
	};

	case 2: {
		{
			if(_x select 1 == _flag) then
			{
				_array pushBack [_x select 0,(missionNamespace getVariable (_x select 0))];
			};
		} foreach oev_licenses;
		oev_lastSynced_licenses = format["%1",_array];
		_packet set[2,_array];
	};

	case 3: {
		oev_lastSynced_gear = format["%1",life_gear];
		_packet set[2,life_gear];
	};

	case 4: {
		//Not yet implemented
	};

	case 5: {
		_packet set[2,oev_is_arrested];
		[["event", "Contraband Sync"], ["player", getPlayerUID player],["contraband", profileNamespace getVariable ["contraband",0]]] call OEC_fnc_logIt;
	};

	case 6: {
		_packet set[2,oev_cash];
		_packet set[4,oev_atmcash];
	};

	case 8: {
		//no longer tracking aliases via DB
		//_packet set[2,life_aliases];
	};

	case 9: {
		_packet set[2,[O_stats_kills,O_stats_deaths,O_stats_revives,O_stats_distanceFoot,O_stats_distanceVehicle,O_stats_bountiesReceived,O_stats_arrestsMade,O_stats_playtime_civ,O_stats_playtime_cop,O_stats_playtime_med]];
	};

	case 10: {
		_packet set[2,O_stats_crimes];
	};

	case 11: {
		//player dead, all stuff handled server side
	};

	case 12: {
		profileNamespace setVariable["oev_thirst",oev_thirst];
		profileNamespace setVariable["oev_hunger",oev_hunger];
		profileNamespace setVariable["life_playerDir",getDir vehicle player];
		profileNamespace setVariable["life_playerDamage",getDammage player];

		if(alive player && ((player distance getMarkerPos("debug_island_marker")) > 700) && (player distance [0,0,0] > 500) && (player distance oev_jailPos1 > 300)) then {
			_posTemp = getPos player;
			_actPos = [_posTemp select 0, _posTemp select 1, (getPosATL player select 2) - (_posTemp select 2)];
			life_ses_last_pos = _actPos;
		};

		_packet set[2,life_ses_last_pos];
	};
	case 13: {
		_packet set[2, oev_warpts_count];
	};
};

_exec = if(life_HC_isActive && _mode != 7) then [{["HC_fnc_updatePartial", HC_ID]}, {["OES_fnc_updatePartial", 2]}];
_packet remoteExec _exec;
