//	Author: djwolf
//	Date: 3/31/2016
//	File: fn_reply.sqf

//	Description: Performs the actions when the client clicks to reply to a message within the phone.
//	Organization: Olympus Entertainment

//initialize and instantiate variables
private ["_targetData","_curUnits","_data","_toID","_target"];
_targetData = param [0,"",[""]];
_data = (call compile format["%1",_targetData]);
_toID = (_data select 0);
_curUnits = [];

if (isNil "_targetData" || isNil "_data" || isNil "_toID") exitWith {}; //bad data
if (_targetData == "") exitWith {}; //another check for bad data

//loop through all units and find all human players
{
	if (isPlayer _x) then {
		_curUnits pushBack (getPlayerUID _x);
	};
} forEach playableUnits;

//check to see if the toID is in the array of players that are currently online
if (!(_toID in _curUnits)) exitWith {hint "The selected player is not online."};

//loop through again and find the actual player object we're looking to send the message to
{
	if ((getPlayerUID _x) == _toID) exitWith {
		_target = _x;
	};
} forEach playableUnits;

if (isNil "_target") exitWith {
	closeDialog 0;
	hint "An error has occured.";
};

[0,(format ["%1",_target])] spawn OEC_fnc_newMsg;
['Life_textMsg'] spawn OEC_fnc_createDialog;