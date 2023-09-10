//  File: fn_joinGroup.sqf
//	Author: Bryan "Tonic" Boardwine
private["_dialog","_sel","_gangs","_gang","_group","_locked","_password","_name"];
disableSerialization;

private _units = [];

_lcl_log = {
	[
		["event",_this select 0],
		["player", name player],
		["player_id", getPlayerUID player],
		["group_name", (_this select 1)],
		["location", getPos player]
	] call OEC_fnc_logIt;
};

if(isNull (findDisplay 36300)) then {
	_dialog = findDisplay 36100;
	_gangs = _dialog displayCtrl 36102;
	_sel = lbCurSel _gangs;
	_data = _gangs lbData _sel;

	_index = [_data,randomized_life_gang_list] call OEC_fnc_index;
	if(_index == -1) exitWith {hint "Couldn't find that group."};
	_gang = randomized_life_gang_list select _index;
	_name = _gang select 0;
	_group = _gang select 1;
	_locked = _gang select 2;

	if(!isNull _group) then{
		if(!_locked) then{
			[player] join _group;
			oev_my_gang = _group;
			player setVariable ["inGroup",true,true];
			hint format["You have joined the group: %1",_gang select 0];

			{_units pushBack (getPlayerUID _x);} forEach units player;
			// joining a group w/out password

			["Joined Group No PW", _gang select 0] call _lcl_log;

			[] spawn OEC_fnc_groupMenu;
		}else{
			oev_targetGroup = _gang;
			["yMenuJoinGroup"] spawn OEC_fnc_createDialog;

			{_units pushBack (getPlayerUID _x);} forEach units player;
			//creating a group
			["Create Group", _gang select 0] call _lcl_log;
		};
	}else{
		hint "Group is not valid";
	};
}else{
	_dialog = findDisplay 36300;
	_password = ctrlText 36302;

	_gang = oev_targetGroup;
	_group = _gang select 1;
	_locked = _gang select 2;

	if(!isNull _group) then{
		if(_password == _gang select 4 && _password != "") then {
			[player] join _group;
			oev_my_gang = _group;
			player setVariable ["inGroup",true,true];
			if (isNull leader group player) then {
				[] spawn{
					waitUntil {!(isNull leader group player);};
					player setVariable ["groupGang",[(leader group player getVariable "gang_data") select 0,(leader group player getVariable "gang_data") select 1]];
				};
			} else {player setVariable ["groupGang",[(leader group player getVariable "gang_data") select 0,(leader group player getVariable "gang_data") select 1]];};
			hint format["You have joined the group: %1",_gang select 0];

			{_units pushBack (getPlayerUID _x);} forEach units player;
			// joining a group w/ password
			["Joined Group With PW", _gang select 0] call _lcl_log;
		}else{
			hint "Incorrect password.";
		};

		[] spawn OEC_fnc_groupMenu;
	}else{
		hint "Group is not valid";
	};
};
