// File: fn_localPardon.sqf
// Original Author: codeYeTi
// Description: Executes a pardon via the windows key menu

#include "..\..\macro.h"

params [
	["_officer", objNull, [objNull]],
	["_criminal", objNull, [objNull]]
];
if (isNull _officer || isNull _criminal) exitWith {};

private _criminalUID = getPlayerUID _criminal;
if (isNil "_criminalUID" || { _criminalUID == "" }) exitWith {
	hint "赦免失败，因为玩家的UID错误";
};

private _cGangID = (_criminal getVariable ["gang_data", [0, "", 0]]) select 0;
if (__GETC__(life_coplevel) < 3 && { count oev_cop_gangData > 0 } && { _cGangID != 0 } && { (oev_cop_gangData select 0) == _cGangID }) exitWith {
	hint "你不能赦免你自己的帮派成员。";
};

private _confirmed = [
	format ["你确定要赦免他们所有指控的%1吗？", name _criminal],
	"确认赦免",
	"是",
	"否",
	findDisplay 37400
] call BIS_fnc_guiMessage;
if !(_confirmed) exitWith {};

[1, format ["%1 赦免 %2", name _officer, name _criminal]] remoteExecCall ["OEC_fnc_broadcast", -2];
[_criminalUID] remoteExec ["OES_fnc_wantedPardon", 2];
["pardons", 1] spawn OEC_fnc_statArrUp;
[
	["event", "Pardoned"],
	["player", name player],
	["player_id", getPlayerUID player],
	["target", name _criminal],
	["target_id", _criminalUID],
	["position", getPos player]
]	call OEC_fnc_logIt;
