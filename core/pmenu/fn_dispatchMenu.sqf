#include <zmacro.h>
//  File: fn_dispatchMenu.sqf
//	Author: Serpico

private["_display","_list","_name","_units","_requested"];
disableSerialization;

_display = findDisplay 49000;
_list = _display displayCtrl 49003;
lbClear _list;
_units = [];

ctrlSetText[49007,"Establishing connection..."];

_cancelBtn = _display displayCtrl 49010;
_cancelBtn ctrlEnable false;

{
	_requested = _x getVariable["hasRequested",0];
	if(!(_requested isEqualTo 0)) then {
		_afkCheck = _x getVariable ["afkCheck",serverTime];
		if((serverTime - _afkCheck) < 31) then {
			_units pushback _x;
		};
	};
} forEach allDeadMen;

_units = _units apply {[_x distance player,_x]};
_units sort true;

{
	_textColor = [1,1,1,1];
	_unit = _x select 1;
	if(faction _unit isEqualTo "BLU_F") then { //cop check (have to use faction since they are dead)
		_name = format["%1: COP",_unit getVariable ["realname",name _unit]];
	} else {
		_name = _unit getVariable ["realname",name _unit];
	};
	_status = _unit getVariable ["dispatchStatus",""];
	_responceType = _unit getVariable ["responseType",-1];
	switch (_responceType) do {
		case 0 : { _textColor = [0,0.8,0,1]; }; // green
		case 1 : { _textColor = [0.9,0,0,1]; }; // red
		case 2 : { _textColor = [0.9,0,0,1]; }; // red
		case 3 : { _textColor = [1,1,1,1]; }; // white
		case 4 : { _textColor = [0.9,0,0,1]; }; // red
		default { _textColor = [1,1,1,1]; };
	};
	_distance = _x select 0;
	if (_status isEqualTo "") then {
		_list lbAdd (format["%1 | %2m | Time: %3",_name, _distance,[(servertime - (_unit getVariable["hasRequested",0])),"MM:SS"] call BIS_fnc_secondsToString]);
	} else {
		_list lbAdd (format["%1 | %2m | Status: %3",_name, _distance,_unit getVariable ["dispatchStatus",""]]);
	};
	_list lbSetData [(lbSize _list)-1,str(_unit)];
	_list lbSetColor [(lbSize _list)-1,_textColor];
}foreach _units;

ctrlSetText[49007,"Connected to RnR Dispatch System"];

if(((lbSize _list)-1) isEqualTo -1) then
{
	_list lbAdd "No Dispatches";
};
