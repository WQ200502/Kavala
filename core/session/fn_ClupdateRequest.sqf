//  File: fn_ClupdateRequest.sqf
//	Author: Tonic

private["_packet","_array","_flag","_totalItemsActual","_hackedItemArray"];

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[
	["event","Hacked Cash"],
	["player",getPlayerUID player],
	["target","null"],
	["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],
	["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]
	] call OEC_fnc_logIt;
	[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] remoteExec ["OEC_fnc_notifyAdmins",-2];
	[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] remoteExec ["OES_fnc_handleDisc",2];
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

//------------------------------------------------------------------------
//Code for checking of hacked in inventory items....
_totalItemsActual = 0;
{
	_totalItemsActual = _totalItemsActual + (missionNameSpace getVariable _x);
}foreach oev_inv_items;

if(_totalItemsActual > (oev_inventoryMonitor - oev_inventoryRandomVar) || _totalItemsActual >= 150) exitWith {
	_hackedItemArray = [];

	{
		if((missionNameSpace getVariable _x) > 0) then {
			_hackedItemArray pushBack [_x, (missionNameSpace getVariable _x)];
		};
	}foreach oev_inv_items;

	[
		["event","Hacked Items"],
		["player_id",getPlayerUID player],
		["hackeditems",_hackedItemArray],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
	[profileName,format["Kicked for hacked items. (Items expected to have = %1) (Actual item count = %2)",(oev_inventoryMonitor - oev_inventoryRandomVar),_totalItemsActual]] remoteExec ["OEC_fnc_notifyAdmins",-2];
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};
//------------------------------------------------------------------------

if(!((player distance getMarkerPos("debug_island_marker")) > 600)) exitWith {};

_packet = [getPlayerUID player,(profileName),playerSide,oev_cash,oev_atmcash];

/* Moved this down below _packet so we can reuse it instead of creating a new one.
 * Updates the newsTeam's money only /x00
 */
if(oev_newsTeam && (oev_lastUpdateRequest != format["%1",_packet])) exitWith {
	oev_lastUpdateRequest = format["%1",_packet];
	[6] call OEC_fnc_ClupdatePartial;
};

_array = [];
_flag = switch(playerSide) do {case west: {"cop"}; case civilian: {"civ"}; case independent: {"med"};};
{
	if(_x select 1 == _flag) then
	{
		_array pushBack [_x select 0,(missionNamespace getVariable (_x select 0))];
	};
} foreach oev_licenses;
if(oev_lastSynced_licenses != format["%1",_array]) then {[2] call OEC_fnc_ClupdatePartial;};

[false] call OEC_fnc_saveGear;
if(oev_lastSynced_gear != format["%1",life_gear]) then {
	if !(oev_newsTeam) then {
		[3] call OEC_fnc_ClupdatePartial;
	};
};


if !(oev_tempStats isEqualTo oev_savedStats) then {
	if ((oev_tempStats select 53) isEqualTo 0) then {oev_tempStats set[53,(oev_statsTable select 20)];};
	oev_savedStats = oev_tempStats;
	[getPlayerUID player,oev_tempStats] remoteExec ["OES_fnc_statTableUp",2,false];
	oev_tempStats = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
	oev_savedStats = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
};



switch (playerSide) do {
	case west: {
	};
 	case independent: {
	};
	case civilian: {
		profileNamespace setVariable["oev_thirst",oev_thirst];
		profileNamespace setVariable["oev_hunger",oev_hunger];
		profileNamespace setVariable["life_playerDir",getDir vehicle player];
		profileNamespace setVariable["life_playerDamage",getDammage player];

		//saves player pos if they're not on debug island, if they die or are on debug island when it's called last pos is wiped so they respawn
		if(alive player && ((player distance getMarkerPos("debug_island_marker")) > 700) && (player distance [0,0,0] > 500) && (player distance oev_jailPos1 > 300) && !oev_inEvent) then {
			_posTemp = getPos player;
			_actPos = [_posTemp select 0, _posTemp select 1, (getPosATL player select 2) - (_posTemp select 2)];
			life_ses_last_pos = _actPos;
			_packet pushBack _actPos;
		} else {
			_packet pushBack life_ses_last_pos;
		};
	};
};

if(oev_lastUpdateRequest == format["%1",_packet]) exitWith {};
oev_lastUpdateRequest = format["%1",_packet];
_exec = if(life_HC_isActive) then [{["HC_fnc_updateRequest", HC_ID]}, {["OES_fnc_updateRequest", 2]}];
_packet remoteExec _exec;
