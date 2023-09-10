#include "..\..\macro.h"
//  File: fn_poLethals.sqf
//	Author: ikiled
//	Description: Authorize PO lethals around the map

(_this select 3) params [
	["_mode",-1,[0]]
];
if (_mode isEqualTo -1) exitWith {};
if (playerSide != west) exitWith {};
if (__GETC__(life_coplevel) < 6) exitWith {};

if (oev_actions_cooldown > time) exitWith {hint "请等待几秒钟，然后再次尝试执行此操作。";};
private _type = "";

if (_mode isEqualTo 0) then {
	_type = "authorize";
	} else {
	_type = "deauthorize";
};

_areYouSure = [
	format ["您确定要在地图上为巡逻人员提供%1的杀伤力吗？",_type],
	"确认致命切换",
	"是",
	"否"
] call BIS_fnc_guiMessage;

if !(_areYouSure) exitWith {};
if (_mode isEqualTo 0) then {
	private _nearUnits = (nearestObjects[player,["Man"],100]) arrayIntersect playableUnits;
	private _officerUIDs = [];
	 if(count _nearUnits > 1) then {
	 	{
	  		if (((side _x) isEqualTo west) && ((_x getVariable "rank") isEqualTo 2)) then {
				_x setVariable ["lethalsPO", true, true];
				_officerUIDs pushBack (getPlayerUID _x);
			};
	 	} forEach _nearUnits;
 	};
	[
		["event","Auth PO Lethals"],
		["player",name player],
		["player_id",getPlayerUID player],
		["officer_count",count _nearUnits],
		["officers_id",_officerUIDs],
		["position",getPosATL player]
	] call OEC_fnc_logIt;

	[0,format["%1已授权出警警员使用实弹击毙罪犯，请大家注意防范。",name player]] remoteExecCall ["OEC_fnc_broadcast",-2];
};

if (_mode isEqualTo 1) then {
	{
		if ((side _x) isEqualTo west) then {
			_x setVariable ["lethalsPO", false, true];
		};
	} forEach playableUnits;
	[
		["event","Deauth PO Lethals"],
		["player",name player],
		["player_id",getPlayerUID player],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
	[0,format["%1 已取消巡逻人员的致命授权。",name player]] remoteExecCall ["OEC_fnc_broadcast",-2];
};

hint format ["您拥有所有巡逻人员的%1杀伤力。", _type];

oev_actions_cooldown = (time + 35);
