private["_flag","_coolDownVal","_uids10m","_uidsOnCap"];
_flag = _this select 0;

if(currentWeapon player == "") exitWith {
	hint "你需要一个武器来清除车辆的盖子！";
};

if(serverTime < (_flag getVariable["clearCooldown",0])) exitWith {
	hint "这顶帽子最近已经被清除了！";
};

_uids10m = [];
_uidsOnCap = [];
{
	if(_x distance _flag <= 10) then {
		_uids10m pushBack getPlayerUID _x;
	};
	if(_x distance _flag <= 150) then {
		_uidsOnCap pushBack getPlayerUID _x;
	};
} forEach playableUnits;

if(count _uids10m < ((count _uidsOnCap)*3.0)/4.0) exitWith {hint "没有足够的人站在旗子旁边！";};

[_flag] remoteExec["OES_fnc_clearCap",2];
[
	["event","Cartel Cleared"],
	["player",getPlayerUID player],
	["players_near_flag",_uids10m],
	["players_on_cap",_uidsOnCap],
	["cap",_flag]
] call OEC_fnc_logIt;
hint "贩毒集团已经清除了所有合法车辆!";
