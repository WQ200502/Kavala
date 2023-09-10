//  File: fn_createGroup.sqf
//	Author: Bryan "Tonic" Boardwine
private["_gangName","_length","_group","_gangPassword"];

_gangName = ctrlText 36202;

if(_gangName == "") exitWith {hint "You must choose a name."};

_allowed = toArray("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ ");

_length = count (toArray(_gangName));
_chrByte = toArray (_gangName);
if(_length > 32) exitWith {hint "The maximum character limit for a group name is 32."};
_badChar = false;
{if(!(_x in _allowed)) exitWith {_badChar = true;};} foreach _chrByte;
if(_badChar) exitWith {hint "Invalid character in name, characters allowed are A-z,0-9, and _";};


_gangPassword = ctrlText 36205;
_length = count (toArray(_gangPassword));
_chrByte = toArray (_gangPassword);
if(_length > 16) exitWith {hint "The maximum character limit for a password is 16."};
_badChar = false;
{if(!(_x in _allowed)) exitWith {_badChar = true;};} foreach _chrByte;
if(_badChar) exitWith {hint "Invalid character in password, characters allowed are A-z,0-9, and _";};

if(isNil {randomized_life_gang_list}) exitWith {hint "Server failed to initiate gangs."};
if(([_gangName,randomized_life_gang_list] call OEC_fnc_index) != -1) exitWith {hint "That gang name is already taken!"};

_group = createGroup civilian;

randomized_life_gang_list pushBack [_gangName,_group,true,getPlayerUID player,_gangPassword];
publicVariable "randomized_life_gang_list";
[player] joinSilent _group;
player setRank "COLONEL";
oev_my_gang = _group;
	if(!isNull oev_my_gang) then {
		["yMenuGroups"] spawn OEC_fnc_createDialog;
		publicVariable "randomized_life_gang_list";
		player setVariable ["inGroup",true,true];
		player setVariable ["groupGang",[(leader group player getVariable "gang_data") select 0,(leader group player getVariable "gang_data") select 1]];
	};
