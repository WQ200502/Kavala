//	Author: Bryan "Tonic" Boardwine
//	Description: Unlocks/locks the buildings virtual storage.

params [
	["_house",objNull,[objNull]]
];
if (isNull _house || !(_house isKindOf "House_F")) exitWith {};
private _state = _house getVariable ["locked",true];

if (_state) then {
	_house setVariable ["locked",false,true];
	titleText["Building storage is now unlocked.","PLAIN DOWN"];
} else {
	_house setVariable ["locked",true,true];
	titleText["Building storage is now locked.","PLAIN DOWN"];
};