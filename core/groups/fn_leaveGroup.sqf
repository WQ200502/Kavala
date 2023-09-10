//  File: fn_leaveGroup.sqf
//	Author: Bryan "Tonic" Boardwine
private["_index","_gang","_name","_group","_locked","_ownerID","_new_owner","_password"];
_index = [oev_my_gang,randomized_life_gang_list] call OEC_fnc_index;
if(_index == -1) exitWith {oev_my_gang = ObjNull;};

_gang = randomized_life_gang_list select _index;
_name = _gang select 0;
_group = _gang select 1;
_locked = _gang select 2;
_ownerID = _gang select 3;
_password = _gang select 4;

openMap false;

if(getPlayerUID player == _ownerID) then
{
	if(count (units(group player)) > 1) then
	{
		{
			if(_x != player) exitWith
			{
				_new_owner = _x;
			};
		} foreach (units (group player));

		randomized_life_gang_list set[_index,[_name,_group,_locked,(getPlayerUID _new_owner),_password]];
		publicVariable "randomized_life_gang_list";
		[[_new_owner,_group], "OEC_fnc_clientGroupLeader",_new_owner,false] spawn OEC_fnc_MP;

		{
			["lastGroup",[grpNull,"",_password,((count units group player) - 1),serverTime],profileNameSpace] remoteExec ["OEC_fnc_netSetVar",(owner _x),false];
		} forEach units group player;
	}
		else
	{
		randomized_life_gang_list set [_index,-1];
		randomized_life_gang_list = randomized_life_gang_list - [-1];
		publicVariable "randomized_life_gang_list";
	};
};

profileNameSpace setVariable ["lastGroup",[grpNull,"","",0,0]];
oev_my_gang = ObjNull;
player setVariable ["inGroup",false,true];
player setVariable ["groupGang",[0,""]];
if(rank player != "PRIVATE") then
{
	player setRank "PRIVATE";
};
[player] joinSilent (createGroup civilian);

if(isNil {(group player) getVariable "gang_id"} && (count oev_gang_data != 0)) then {
	oev_action_inUse = true;
	[] spawn OEC_fnc_initGang;
	hint "You have left your group. Rejoining your gangs default group";
}else{
	hint "You have left your group.";
};
[] spawn OEC_fnc_groupMenu;