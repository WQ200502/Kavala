#include "..\..\macro.h"
//  File: fn_onPlayerRespawn.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Does something but I won't know till I write it...
private["_unit","_corpse","_nameProfile","_namePlayer"];
_unit = _this select 0;
_corpse = _this select 1;
life_corpse = _corpse;

//Comment this code out if you want them to keep the weapon on the ground.
private["_containers"];
_containers = nearestObjects[getPosATL _corpse,["WeaponHolderSimulated"],5]; //Fetch list of containers (Simulated = weapons)
{deleteVehicle _x;} foreach _containers; //Delete the containers.

//Set some vars on our new body.
_unit setVariable ["restrained",false,true];
_unit setVariable ["zipTied",false,true];
_unit setVariable ["blindfolded",false,true];
_unit setVariable ["statBounty",O_stats_crimes select 0,true];
_unit setVariable ["Escorting",false,true];
_unit setVariable ["transporting",false,true]; //Again why the fuck am I setting this? Can anyone tell me?
_unit setVariable ["steam64id",(getPlayerUID player),true]; //Reset the UID.
_unit setVariable ["realname",profileName,true]; //Reset the players name.
_unit setVariable ["killStreak",0,true]; //Reset the players killstreak.
_unit setVariable ["kidneyHarvester",nil,true];
_unit setVariable ["oev_corpse", _corpse, true];
_unit setVariable ["infected",nil,true];


{ [_x, true] call OEC_fnc_neuterAction; } forEach [_unit, _corpse];

if(playerside isEqualTo civilian) then {
	profileNamespace setVariable ["epiActive",false];
	if (_unit getVariable ["kidneyRemoved",false]) then {
		_unit setVariable ["kidneyRemoved",false,true];
	};
};

if(profileName != name player) then {
	_namePlayer = toArray(name player);
	_nameProfile = toArray(profileName);
	if(count _namePlayer == (count _nameProfile) + 4 && _namePlayer select ((count _namePlayer) - 2) in [48,49,50,51,52,53,54,55,56,57]) then {
		_unit setVariable["realname", name player, true];
	} else {
		_unit setVariable["realname", profileName, true];
	};
} else {
	_unit setVariable["realname", profileName, true];
};

oev_respawned = false;

player setVariable["statBounty",O_stats_crimes select 0,true];
player playMoveNow "amovppnemstpsraswrfldnon";

player setCustomAimCoef 0.35;
player SetStamina 42;
player setAnimSpeedCoef 1;
//if !(7 in life_loot) then {player enableFatigue true};

[] call OEC_fnc_setupActions;
private _alvl = __GETC__(life_adminlevel);
[[_unit,false,playerSide,_alvl,oev_streamerMode,life_gangChat],"OES_fnc_managesc",false,false] spawn OEC_fnc_MP;
player enableFatigue (__GETC__(oev_enableFatigue));

if (O_stats_deaths < 5) then {
	hint parseText "<t color='#ffff00' size='2' align='center'>随机死亡匹配报告</t><br/><br/>随机杀人？玩家没有正确的攻击你并且你不在KOS区域内吗？向提交玩家报告:<br/> QQ群：870988619";
};
