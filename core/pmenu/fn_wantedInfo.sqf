#include <zmacro.h>
//  File: fn_wantedInfo.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Pulls back information about the wanted criminal.
private["_display","_list","_bounty","_mylist","_index"];
disableSerialization;

switch(playerSide) do{
	case west: {
		if((__GETC__(life_coplevel) < 2) && (__GETC__(life_adminlevel) < 1)) then{
			ctrlShow[39005,false];
			ctrlShow[39006,false];
		};
	};

	case civilian:{
		ctrlShow[39006,false];
		if(__GETC__(life_adminlevel) < 1) then{
			ctrlShow[39005,false];
		};
	};

	case independent:{
		ctrlShow[39006,false];
		if(__GETC__(life_adminlevel) < 1) then{
			ctrlShow[39005,false];
		};
	};
};

_display = findDisplay 39000;
_list = _display displayCtrl 39004;
_data = lbData[39003,(lbCurSel 39003)];
_data = call compile format["%1", _data];
_mylist = [];
lbClear _list;
ctrlSetText[39001,"****** ****"];
ctrlSetText[39002,"赏金: ***,***元"];
if(isNil "_data") exitWith {_list lbAdd "无法获取犯罪记录";};
if(typeName _data != "ARRAY") exitWith {_list lbAdd "无法获取犯罪记录";};
if(count _data == 0) exitWith {_list lbAdd "无法获取犯罪记录";};
lbClear _list;

_crimes = _data select 2;
_bounty = _data select 3;

if(count _crimes == 0) exitWith {_list lbAdd "无法获取犯罪记录";};

ctrlSetText[39001,format["%1", _data select 0]];
ctrlSetText[39002,format["赏金: %1元",[_bounty] call OEC_fnc_numberText]];

{
	_crime = _x;
	if(!(_crime in _mylist)) then
	{
		_mylist pushBack _crime;
		_index = _list lbAdd format["%1 x %2",_x select 1, _x select 0];
		_list lbSetData [_index, _x select 0];
	};
}foreach _crimes;
