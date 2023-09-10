//  File: fn_setGroupLeader.sqf
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
if(leader(group player) != player) exitWith {hint "You don't have the ability to do that."};

_gang = randomized_life_gang_list select _index;
_name = _gang select 0;
_group = _gang select 1;
_locked = _gang select 2;
_ownerID = _gang select 3;
_password = _gang select 4;

randomized_life_gang_list set[_index,[_name,_group,_locked,getPlayerUID _data,_password]];
publicVariable "randomized_life_gang_list";

_group selectLeader _data;
[[_data,_group], "OEC_fnc_clientGroupLeader",_data,false] spawn OEC_fnc_MP;

player setRank "PRIVATE";

[false] spawn OEC_fnc_groupManagement;