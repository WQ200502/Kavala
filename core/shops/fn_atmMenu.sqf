#include "..\..\macro.h"
//  File: fn_atmMenu.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Opens and manages the bank menu.
params [
	["_target", objNull, [objNull]],
	["_caller", objNull, [objNull]],
	["_actionId", -1, [-1]],
	["_arguments", "", [""]],
	["_bankMode", 0, [0]]
];
private["_display","_text","_units","_type","_sortedPlayers","_toggleButton"];

if(!oev_use_atm) exitWith
{
	hint localize "STR_Shop_ATMRobbed";
};

if(!dialog) then
{
	["Life_atm_management"] call OEC_fnc_createDialog;
};

disableSerialization;

_display = findDisplay 2700;
_text = _display displayCtrl 2701;
_units = _display displayCtrl 2703;
_toggleButton = _display displayCtrl 2706;
(getControl(2700,2704)) ctrlEnable false;

lbClear _units;

switch (_bankMode) do {
	// Money Mode
	case 0: {
		_text ctrlSetStructuredText parseText format["<img size='1.7' image='images\icons\bank.paa'/> $%1<br/><img size='1.6' image='images\icons\money.paa'/> $%2",[oev_atmcash] call OEC_fnc_numberText,[oev_cash] call OEC_fnc_numberText];
	};
	// War Points Mode
	default {
		_text ctrlSetStructuredText parseText format["<img size='1.7' image='images\icons\Skull.paa'/> %1",[oev_warpts_count] call OEC_fnc_numberText];
	};
};

_sortedPlayers = [];
{
	if(alive _x && _x != player) then
	{
		switch (side _x) do
		{
			case west: {_type = "Cop"};
			case civilian: {_type = "Civ"};
			case independent: {_type = "RnR"};
		};
		_sortedPlayers pushBack [format["%1 (%2)",_x getVariable["realname",name _x],_type],_x];
	};
}foreach playableUnits;

_sortedPlayers sort true;

{
	_units lbAdd (_x select 0);
	_units lbSetData [(lbSize _units)-1,str(_x select 1)];
}foreach _sortedPlayers;

lbSetCurSel [2703,0];

if !(playerSide isEqualTo civilian) then {
	_toggleButton ctrlEnable false;
};

if((count oev_gang_data) != 0) then {
	(getControl(2700,2704)) ctrlEnable true;
};
