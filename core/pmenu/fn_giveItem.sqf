//  File: fn_giveItem.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Gives the selected item & amount to the selected player and
//	removes the item & amount of it from the players virtual
//	inventory.
private["_unit","_val","_type"];
_val = ctrlText 31012;
ctrlEnable[31008,false];
if((lbCurSel 31011) == -1) exitWith {hint "No one was selected!";ctrlEnable[31008,true];};
_unit = lbData [31011,lbCurSel 31011];
_unit = call compile format["%1",_unit];
if((lbCurSel 31010) == -1) exitWith {hint "You didn't select an item you wanted to give.";ctrlEnable[31008,true];};
_item = lbData [31010,(lbCurSel 31010)];
if(isNil "_unit") exitWith {ctrlEnable[31008,true];};
if(_unit == player) exitWith {ctrlEnable[31008,true];};
if(isNull _unit) exitWith {ctrlEnable[31008,true];};
if(_unit getVariable ["restrained",false]) exitWith {hint "You cannot give a restrained player items.";ctrlEnable[31008,true];};
if(player getVariable ["restrained",false]) exitWith {hint "You cannot give items while restrained.";ctrlEnable[31008,true];};

//parsed number should be the same length as the original text
if(count (format["%1",parseNumber _val]) != count _val) exitWith {hint "You need to enter an actual amount you want to give.";ctrlEnable[31008,true];};
if(!([_val] call OEC_fnc_isNumeric)) exitWith {hint "You didn't enter an actual number format.";ctrlEnable[31008,true];};
//A series of checks *ugh*
if(parseNumber(_value) <= 0 || parseNumber(_value) != round(parseNumber(_value))) exitWith {hint "You need to enter an actual amount you want to give.";ctrlEnable[31008,true];};
if(isNil "_unit") exitWith {ctrlEnable[31008,true]; hint "The selected player is not within range";};
if(!([false,_item,(parseNumber _val)] call OEC_fnc_handleInv)) exitWith {hint "Couldn't give that much of that item, maybe you don't have that amount?";ctrlEnable[31008,true];};
if((parseNumber(_value) mod 1) != 0) exitWith {hint "You can't give a fraction of an item...!";ctrlEnable[31008,true];};
//if((count (str _value)) > 15) exitWith {hint "You cannot give a player that high of a number! (Or stop pressing 0 so many times.....)";ctrlEnable[31008,true];};

_type = [_item,0] call OEC_fnc_varHandle;
_type = [_type] call OEC_fnc_varToStr;
if (oev_is_processing) exitWith {
	closeDialog 0;
	[
		["event","Item Give Exploit"],
		["player",name player],
		["player_id",getPlayerUID player],
		["target",name _unit],
		["target_id",getPlayerUID _unit],
		["item",_type],
		["amount",_val]
	] call OEC_fnc_logIt;
};

[[_unit,_val,_item,player],"OEC_fnc_receiveItem",_unit,false] spawn OEC_fnc_MP;

hint format["You gave %1 %2 %3",_unit getVariable["realname",name _unit],_val,_type];

[
	["event","Item Transfer"],
	["player",name player],
	["player_id",getPlayerUID player],
	["target",name _unit],
	["target_id",getPlayerUID _unit],
	["item",_type],
	["amount",_val]
] call OEC_fnc_logIt;


[false] call OEC_fnc_saveGear;

if !(oev_newsTeam) then {
	[3] call OEC_fnc_ClupdatePartial;
};

ctrlEnable[31008,true];

[] call OEC_fnc_updateInventoryTab;
