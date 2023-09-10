//  File: fn_kickGroup.sqf
//	Author: Bryan "Tonic" Boardwine
private["_dialog","_index","_members","_sel","_user","_password"];
disableSerialization;

_dialog = findDisplay 36000;
_members = _dialog displayCtrl 36002;
_sel = lbCurSel 36002;
_data = _members lbData _sel;
_data = call compile format["%1", _data];

_index = [oev_my_gang,randomized_life_gang_list] call OEC_fnc_index;
if(_index == -1) exitWith {};
if(_data == player) exitWith {hint "You can't kick yourself"};

_gang = randomized_life_gang_list select _index;
_name = _gang select 0;
_group = _gang select 1;
_locked = _gang select 2;
_ownerID = _gang select 3;
_password = _gang select 4;

switch (true) do
{
	case ((getPlayerUID _data) == _ownerID) :
	{
		randomized_life_gang_list set [_index,[_name,_group,_locked,getPlayerUID player,_password]];
		publicVariable "randomized_life_gang_list";
	};
};
{
	["lastGroup",[_group,_name,_password,((count units group player) - 1),serverTime],profileNameSpace] remoteExec ["OEC_fnc_netSetVar",(owner _x),false];
} forEach units group player;
[[_data,_group], "OEC_fnc_clientGroupKick",_data,false] spawn OEC_fnc_MP;

[false] spawn OEC_fnc_groupManagement;