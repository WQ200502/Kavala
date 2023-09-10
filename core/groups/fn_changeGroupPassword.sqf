//  File: fn_changeGroupPassword.sqf
//	Author: grar21 (not developer)
params [ 
	["_newPassword", "", [""]]
];
disableSerialization;

if(leader(group player) != player) exitWith {hint "You don't have the ability to do that."}; // check if group leader
if(_newPassword == "") exitWith {hint "You must enter a new password"}; // check for empty password
_index = [oev_my_gang,randomized_life_gang_list] call OEC_fnc_index; // setup an index
if(_index == -1) exitWith {}; // if we didn't return anything let's quit and retry

_gang = randomized_life_gang_list select _index; // grabbing our gang
_name = _gang select 0; // grabbing our name
_group = _gang select 1; // grabbing our group
_locked = _gang select 2; // grabbing if group is locked or not
_ownerID = _gang select 3; // grabbing ownerID of group(creator)
_oldPassword = _gang select 4; // the old password for the group

if (_oldPassword == "") then { // if we didn't have a group password, let's set it something that can be read
	_oldPassword = "N/A";
};

// allowed characters in password
_allowed = toArray("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ "); // our whitelist
_length = count (toArray(_newPassword)); // getting the length of the password with "count"
_chrByte = toArray (_newPassword); // you already know
_badChar = false;

{if(!(_x in _allowed)) exitWith {_badChar = true;};} foreach _chrByte; // checking each individual character
if(_length > 16) exitWith {hint "The maximum character limit for a password is 16."}; // max character limit for group
if(_badChar) exitWith {hint "Invalid character in password, characters allowed are A-z,0-9, and _";}; // invalid character in password

randomized_life_gang_list set[_index,[_name,_group,_locked,_ownerID,_newPassword]]; // actually setting the new password
publicVariable "randomized_life_gang_list"; // communicate it to other clients while updating it on the server

hint format ['You have changed the group password from "%1" to "%2"', _oldPassword, _newPassword];// let's notify them their old password, cause why not?