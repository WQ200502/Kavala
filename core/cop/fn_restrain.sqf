//  File: fn_restrain.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Retrains the client.

private["_cop","_player","_vehicle"];
_cop = param [0,Objnull,[Objnull]];
_player = player;
_vehicle = vehicle player;
_group = group player;
_index = [oev_my_gang,randomized_life_gang_list] call OEC_fnc_index;
_groupVars = randomized_life_gang_list select _index;
_inGroup = player getVariable ["inGroup", false];
if(isNull _cop) exitWith {};
oev_action_inUse = true;
if (dialog) then {closeDialog 0;};
openMap false;

oev_restrainMon = true;

//Monitor excessive restrainment
[] spawn{
	while {true} do	{
		private _time = time;
		waitUntil {uisleep 0.2; (((time - _time) > (15 * 60)) || !oev_restrainMon)};

		if !(oev_restrainMon) exitWith {oev_action_inUse = false;};
		if (!(player getVariable["restrained",false])) exitWith {oev_action_inUse = false;};
		if (!([west,getPos player,30] call OEC_fnc_nearUnits) && (player getVariable["restrained",false]) && isNull objectParent player) exitWith {
			player setVariable["restrained",false,true];
			player setVariable["Escorting",false,true];
			player setVariable["transporting",false,true];
			if (player getVariable["zipTied",false]) then {
				player setVariable["zipTied",false,true];
			};
			oev_action_inUse = false;
			detach player;
			titleText[localize "STR_Cop_ExcessiveRestrain","PLAIN DOWN"];
		};
	};
};

titleText[format[localize "STR_Cop_Retrained",_cop getVariable["realname",name _cop]],"PLAIN DOWN"];
player setVariable ["playerSurrender",false,true];

_groupUnits = units group _player - [player];

//Using _USER_DEFINED allows players to delete the marker locally, as it will never delete itself
_markName = format ["_USER_DEFINED #lastKnown_%1%2", player, time];
_realName = format["%1's Last Known Position", player getVariable["realName", name player]];
[_markName, getPos player, "ICON", "mil_objective",_realName,"ColorOrange",[0.5,0.5]] remoteExecCall ["OEC_fnc_createMarkerLocal", _groupUnits, false];

if(_inGroup) then {
	_new_owner = player;
	if(count (units(group player)) <= 1) then{
		randomized_life_gang_list set [_index,-1];
		randomized_life_gang_list = randomized_life_gang_list - [-1];
		publicVariable "randomized_life_gang_list";
	} else {
		{
			if(_x != player) exitWith {
				_new_owner = _x;
			};
		} foreach (units (group player));
		randomized_life_gang_list set[_index,[_groupVars select 0,_groupVars select 1,_groupVars select 2,(getPlayerUID _new_owner),_groupVars select 4]];
		publicVariable "randomized_life_gang_list";
		[[_new_owner,_groupVars select 1], "OEC_fnc_clientGroupLeader",_new_owner,false] spawn OEC_fnc_MP;
	};
};
[player] join grpNull;

oev_disable_getIn = true;
oev_disable_getOut = false;

while {player getVariable "restrained"} do {
	1 fadeSound 0.18;
	if (dialog) then {closeDialog 0;};
	if !(oev_action_inUse) then {oev_action_inUse = true;};
	if (currentWeapon player != "") then {
		life_curWep_h = currentWeapon player;
		player action ["SwitchWeapon", player, player, 100];
		player switchCamera cameraView;
		player selectWeapon "";
	};

	if(isNull objectParent player && !(player getVariable "Escorting")) then {
		player playMove "AmovPercMstpSnonWnonDnon_Ease";
	};

	_state = vehicle player;
	waitUntil {(animationState player != "AmovPercMstpSnonWnonDnon_Ease") || currentWeapon player != "" || !(player getvariable "restrained") || vehicle player != _state};

	if (!alive player) exitWith {
		player setVariable ["restrained",false,true];
		player setVariable ["Escorting",false,true];
		player setVariable ["transporting",false,true];
		oev_action_inUse = false;
		detach _player;
	};

	if (!(isNull objectParent player) && oev_disable_getIn) then {
		player action["eject",vehicle player];
	};

	if (!(isNull objectParent player) && !(vehicle player isEqualTo _vehicle)) then {
		_vehicle = vehicle player;
	};
		if (isNull objectParent player && oev_disable_getOut && alive player) then {
		player moveInCargo _vehicle;
	};

	if (!(isNull objectParent player) && oev_disable_getOut && (driver (vehicle player) isEqualTo player)) then {
		player action["eject",vehicle player];
		player moveInCargo _vehicle;
	};

	if (!(isNull objectParent player) && oev_disable_getOut && alive player) then {
		_turrets = [[-1]] + allTurrets _vehicle;
		{
			if (_vehicle turretUnit [_x select 0] isEqualTo player) then {
				player action["eject",vehicle player];
				sleep 1;
				player moveInCargo _vehicle;
			};
		} forEach _turrets;
	};
};

if (oev_earplugs) then {
	1 fadeSound 1;
};
if (playerSide isEqualTo civilian)then{
	if (_inGroup) exitWith {
		_groupName = _groupVars select 0;
		_xName = "";
		{
			_index = [_x,randomized_life_gang_list] call OEC_fnc_index;
			if (_index != (-1)) then {
				_xName = (randomized_life_gang_list select _index) select 0;
			};
			if(_xName == _groupName) exitWith {_group = _x;};
		} forEach allGroups;

		if (isNull (_group)) then {
			_group = createGroup civilian;
			randomized_life_gang_list pushBack [_groupName,_group,true,getPlayerUID player,_groupVars select 4];
			publicVariable "randomized_life_gang_list";
			hint "Re-creating normal group.";
		} else {
			hint "Re-joining normal group.";
		};
		[player] joinSilent _group;
		oev_my_gang = _group;
		player setVariable ["inGroup",true,true];
	};

	if (count oev_gang_data isEqualTo 0) then {
		_group = createGroup civilian;
		[player] joinSilent _group;
	} else {
		oev_action_inUse = true;
		[] spawn OEC_fnc_initGang;
		hint "Rejoining your gangs default group";
	};
};

if (playerSide isEqualTo west || playerSide isEqualTo independent) then {
	_side = [];
	if (playerSide isEqualTo west) then {_side = ["B", west]} else {_side = ["R", independent]};

	_group = grpNull;
	{
		if(str _x isEqualTo format ["%1 Alpha 1-1", _side select 0]) exitWith {_group = _x};
	}forEach allGroups select {str side _x isEqualTo (format ["%1", _side select 1])};

	if !(str group player isEqualTo format ["%1 Alpha 1-1", _side select 0]) then {
		if (!isNull _group) then {
			[player] join _group;
		} else {
			[player] join _group;
			_group setGroupIDGlobal ["Alpha 1-1"];
		};
	};
};

oev_restrainMon = false;
oev_action_inUse = false;
if (alive player) then {
	player switchMove "AmovPercMstpSlowWrflDnon_SaluteIn";
	player setVariable ["Escorting",false,true];
	player setVariable ["transporting",false,true];
	detach player;
};
