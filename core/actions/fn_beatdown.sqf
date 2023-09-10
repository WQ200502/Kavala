#include "..\..\macro.h"
//	Author: x00
//	File: fn_beatdown.sqf (OEC_fnc_beatdown)

private["_player","_unit"];

_player = param [0,ObjNull,[ObjNull]];
_unit = param [1,ObjNull,[ObjNull]];

if(isNull _player || isNull _unit) exitWith {};
if(!(_unit getVariable["restrained", false])) exitWith {};
if(currentWeapon _player != "") exitWith {hint "在打mofo之前，请把你的枪套好！"};

if (oev_beatdown_active) exitWith {hint "你至少要等2分钟再打mofo！"};

if (_player distance _unit < 1) then {
	oev_beatdown_active = true;
	player playMoveNow "AmovPercMstpSnonWnonDnon_AcrgPknlMstpSnonWnonDnon_getInLow";
	sleep 0.3;
	[[_unit,"AinjPfalMstpSnonWnonDf_carried_fallwc"],"OEC_fnc_animSync",-2,false] spawn OEC_fnc_MP;
	[[_unit,"kick_balls"],"OEC_fnc_say3D",-2,false] spawn OEC_fnc_MP;
	[[_unit], "OEC_fnc_handleBeatdown", _unit, false] spawn OEC_fnc_MP;
	//add charge of Assault
	if (side _player isEqualTo civilian) then {
		[[getPlayerUID _player,_player getVariable["realname",name _player],"4",_player],"OES_fnc_wantedAdd",false,false] spawn OEC_fnc_MP;
	};
};
uiSleep 120;
oev_beatdown_active = false;