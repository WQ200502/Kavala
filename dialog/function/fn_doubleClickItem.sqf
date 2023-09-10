//  File: fn_doubleClickItem.sqf
//	Author: Serpico
//	Description: Allows the user to double click an item in truck or shop sell to auto fill the full quantity.

params[
	["_list",0,[0]], // List the item is in
	["_box",0,[0]], // Box to contain the item qty
	["_remove",false,[false]], // true = taking from storage, false = putting storage/selling
	["_physicalStorage",false,[false]] // true = physical storage, false = virtual storage
];

disableSerialization;
_ctrl = lbData[_list,(lbCurSel _list)];
private _num = 1;
if !(_physicalStorage) then {
	if (_remove) then {
		_index = [_ctrl,((oev_trunk_vehicle getVariable "Trunk") select 0)] call OEC_fnc_index;
		_data = (oev_trunk_vehicle getVariable "Trunk") select 0;
		_num = _data select _index select 1;
	} else {
		_var = [_ctrl,0] call OEC_fnc_varHandle;
		_num = missionNamespace getVariable _var;
	};
} else {
	if (_remove) then {
		_index = [_ctrl,((oev_trunk_vehicle getVariable "PhysicalTrunk") select 0)] call OEC_fnc_index;
		_data = (oev_trunk_vehicle getVariable "PhysicalTrunk") select 0;
		_num = _data select _index select 1;
	} else {
		_num = lbValue [_list,(lbCurSel _list)];
	};
};
ctrlSetText [_box, format["%1",_num]];