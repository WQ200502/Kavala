#include "..\..\macro.h"
//	Author: Bryan "Tonic" Boardwine
//	Description: Prompts the player about an invite.

private["_gangID","_gangName","_exitLoop","_newGroup","_index"];
params [
	["_name","",[""]],
	["_group",[],[[]]]
];
if (_name isEqualTo "" || count _group isEqualTo 0 || oev_inCasino) exitWith {};
if !(count oev_gang_data isEqualTo 0) exitWith {};

_gangID = _group select 0;
_gangName = _group select 1;
_action = [
	format[localize "STR_GNOTF_InviteMSG",_name,_gangName],
	localize "STR_Gang_Invitation",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;

private _units = [];

if(_action) then {
	[[0,player,_gangID,_gangName,0,_name],"OES_fnc_updateMember",false,false] spawn OEC_fnc_MP;
	oev_gang_data = [_gangID,_gangName,0];
	player setVariable["gang_data",oev_gang_data,true];
	if (count _group isEqualTo 4) then {
		oev_gang_data set [3, _group select 3];
		[0] call OEC_fnc_gangBldgDraw;
	};
	_index = [oev_my_gang,randomized_life_gang_list] call OEC_fnc_index;
	if(_index isEqualTo -1) then {
		_exitLoop = false;
		{
			_groupName = _x getVariable "gang_name";
			if(!isNil "_groupName") then {
				_groupID = _x getVariable "gang_id";
				if(isNil "_groupID") exitWith {}; //Seriously?
				if((oev_gang_data select 0) == _groupID) exitWith {_newGroup = _x; _exitLoop = true;};
			};
		} foreach allGroups;

		if(!isNil "_newGroup") then {
			[player] join _newGroup;
		} else {
			_newGroup = group player;
			_newGroup setVariable["gang_id",(oev_gang_data select 0),true];
			_newGroup setVariable["gang_name",(oev_gang_data select 1),true];
		};
		{_units pushBack (getPlayerUID _x);} forEach units player;
		[
			["event","Joined Gang Group"],
			["player",name player],
			["player_id",getPlayerUID player],
			["gang",(oev_gang_data select 1)],
			["gang_id",(oev_gang_data select 0)],
			["members",_units],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
	} else {
		systemChat "您未被放置到帮派默认组中，因为您当前处于组中。加入帮派组织就离开你现在的团伙。";
	};
	[player,(oev_gang_data select 0),(oev_gang_data select 1)] remoteExec ["OES_fnc_warGetEnemy",2];
} else {
	hint "帮派邀请被拒绝.";
};
