#include <zmacro.h>
//	Author: Bryan "Tonic" Boardwine
//	Description: 32 hours later...

private["_grp"];
if((oev_gang_data select 2) == 5) exitWith {hint localize "STR_GNOTF_LeaderLeave"};

if(!isNil {(group player) getVariable "gang_id"}) then {
	[player] joinSilent (createGroup civilian);
};

[[2,player,0,oev_gang_data select 1,-1],"OES_fnc_updateMember",false,false] spawn OEC_fnc_MP;
if (count oev_gang_data isEqualTo 4) then {
	[1] call OEC_fnc_gangBldgDraw;
	oev_gangShedPos = [];
};
oev_gang_data = [];
oev_gang_activeWars = [];
oev_gang_warIDs = [];
oev_gang_warAccptIDs = [];
player setVariable["gang_data",nil,true];

['yMenuCreateGang'] spawn OEC_fnc_createDialog;
