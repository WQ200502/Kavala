//  File: fn_robReceive.sqf
//	Author: Bryan "Tonic" Boardwine

private["_cash","_robbedPlayer","_robbedPlayerUID"];
_cash = param [0,0,[0]];
_robbedPlayer = _this select 1;
_robbedPlayerUID = (getPlayerUID _robbedPlayer);
if(_cash == 0) exitWith {titleText[localize "STR_Civ_RobFail","PLAIN DOWN"]};

_lcl_log = {
	[
		["event","Rob Hack"],
		["player",name player],
		["player_id",getPlayerUID player],
		["target",name (_this select 0)],
		["target_id",_this select 1],
		["amount",[_this select 2] call OEC_fnc_numberText],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
};

if(isNil "_robbedPlayer" || {isNull _robbedPlayer} || {((count toArray(_robbedPlayerUID)) < 5)}) exitWith {
	[_robbedPlayer, _robbedPlayerUID, _cash] call _lcl_log;
	[profileName,format["Attempt to hack in cash detected: robbing nil player."]] remoteExec ["OEC_fnc_notifyAdmins",-2];
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

oev_cash = oev_cash + _cash;
oev_cache_cash = oev_cache_cash + _cash;
titleText[format[localize "STR_Civ_Robbed",[_cash] call OEC_fnc_numberText],"PLAIN DOWN"];
[_robbedPlayer, _robbedPlayerUID, _cash] call _lcl_log;
