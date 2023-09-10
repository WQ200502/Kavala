//	Author: Bryan "Tonic" Boardwine
//	Description: Main initialization for gangs?

if !(playerSide isEqualTo civilian) exitWith {}; //What in the hell?
[player] join (createGroup civilian);
if ((count oev_gang_data) isEqualTo 0) exitWith {}; //Dafuq?

uiSleep 3 + round(random(6));

//Loop through to make sure there is not a group already created with the gang.
private _exitLoop = false;
private "_group";
{
	_groupName = _x getVariable "gang_name";
	if (!isNil "_groupName") then {
		_groupID = _x getVariable "gang_id";
		if(isNil "_groupID") exitWith {}; //Seriously?
		if((oev_gang_data select 0) isEqualTo _groupID) exitWith {_group = _x; _exitLoop = true;};
	};
} foreach allGroups;

if (!isNil "_group") then {
	[player] join _group;
	if((oev_gang_data select 2) isEqualTo 5) then {
		_group selectLeader player;
		[[player,_group],"OEC_fnc_clientGangLeader",(units _group),false] spawn OEC_fnc_MP;
	};
} else {
	_group = group player;
	_group setVariable ["gang_id",(oev_gang_data select 0),true];
	_group setVariable ["gang_name",(oev_gang_data select 1),true];
};
oev_action_inUse = false;

if (count oev_gang_data isEqualTo 4) then {
	[0] call OEC_fnc_gangBldgDraw;
};

[[player,(oev_gang_data select 0),(oev_gang_data select 1)],"OES_fnc_warGetEnemy",false,false] spawn OEC_fnc_MP;

private _units = [];
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
