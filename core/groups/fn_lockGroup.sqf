//  File: fn_lockGroup.sqf
//	Author: Bryan "Tonic" Boardwine
private["_gang","_index","_name","_group","_ownerID","_password"];
_index = [oev_my_gang,randomized_life_gang_list] call OEC_fnc_index;
if(_index == -1) exitWith {};
_gang = randomized_life_gang_list select _index;
_name = _gang select 0;
_group = _gang select 1;
_ownerID = _gang select 3;
_password = _gang select 4;

switch (true) do
{
	case (player == leader(group player)) :
	{
		randomized_life_gang_list set[_index,[_name,_group,true,_ownerID,_password]];
		publicVariable "randomized_life_gang_list";
		ctrlShow[36004,false];
		ctrlShow[36005,true];
	};

	case (getPlayerUID player == _ownerID) :
	{
		randomized_life_gang_list set [_index,[_name,_group,true,_ownerID,_password]];
		publicVariable "randomized_life_gang_list"
		ctrlShow[36004,false];
		ctrlShow[36005,true];
	};
};

[false] spawn OEC_fnc_groupManagement;