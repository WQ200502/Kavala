//  File: fn_rest1rainAction.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Retrains the target.
#include "..\..\macro.h"

private _unit = cursorObject;
if(isNull _unit) exitWith {}; //Not valid
if(_unit getVariable "restrained") exitWith {};
if(player isEqualTo _unit) exitWith {};
if(!isPlayer _unit) exitWith {};
if (playerSide != west && ((currentWeapon player isEqualTo "") || (currentWeapon player in oev_fake_weapons))) exitWith {hint "你需要武器来拷人！";};

// Only Sgt or higher can restrain other officers - Ares requested. /x00
if ((__GETC__(life_coplevel)) < 4 && (side _unit isEqualTo west)) exitWith {};

//broadcast
[[_unit,"handcuff"],"OEC_fnc_say3D",-2,false] spawn OEC_fnc_MP;
[[], "OEC_fnc_closeMap", _unit, false] spawn OEC_fnc_MP;
uisleep 0.1;
_unit setVariable["restrained",true,true];

//For compensation on CLog
if(license_civ_vigilante) then {
	_unit setVariable["restrainedBy",[player,1],true];
} else {
	if(side player == west) then {
		_unit setVariable["restrainedBy",[player,2],true];
	};
};

[[player], "OEC_fnc_restrain", _unit, false] spawn OEC_fnc_MP;
[[0,"STR_NOTF_Restrained",true,[_unit getVariable["realname", name _unit], profileName]],"OEC_fnc_broadcast",west,false] spawn OEC_fnc_MP;
[
	["event","Restrained"],
	["player",name player],
	["player_id",getPlayerUID player],
	["target",name _unit],
	["target_id",getPlayerUID _unit],
	["location",getPosATL player]
] call OEC_fnc_logIt;
