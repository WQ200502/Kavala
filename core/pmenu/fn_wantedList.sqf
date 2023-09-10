//	Copyright © 2013 Bryan "Tonic" Boardwine, All rights reserved
//	See armafiles.info/life/list.txt for servers that are permitted to use this code.
//	File: fn_wantedList.sqf
//	Author: Bryan "Tonic" Boardwine"

//	Description:
//	Displays wanted list information sent from the server. DESCRIPTIONEND

private["_info","_display","_list","_units","_entry"];
disableSerialization;
_info = param [0,[],[[]]];
_display = findDisplay 39000;
_list = _display displayctrl 39003;

_units = [];
{
	_units pushBack (_x getVariable["realname",name _x]);
} foreach playableUnits;

_info sort true;
{
	_entry = _x;
	if((_entry select 0) in _units) then
	{
		_list lbAdd format["%1", _entry select 0];
		_list lbSetData [(lbSize _list)-1,str(_entry)];
	};
}foreach _info;

ctrlSetText[39007,"连接到通缉名单库"];

if(((lbSize _list)-1) == -1) then
{
	_list lbAdd "没有罪犯";
};
