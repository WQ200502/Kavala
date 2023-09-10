//  File: fn_keyDrop.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Drops the key.
private["_dialog","_list","_sel","_vehicle","_impounded","_owners","_index","_index2","_i","_thieves"];
disableSerialization;

_dialog = findDisplay 33000;
_list = _dialog displayCtrl 33001;
_sel = lbCurSel _list;
if(_sel isEqualTo -1) exitWith {hint "No Data Selected";};
if (player getVariable ["restrained",false]) exitWith {hint "You cannot remove keys while you are restrained.";};
_index = (parseNumber(_list lbData _sel));
_vehicle = oev_vehicles select _index;
if(_vehicle isKindOf "House_F") exitWith {hint "You can't remove the keys to your house!"};
_owners = _vehicle getVariable ["vehicle_info_owners",[]];
_thieves = _vehicle getVariable ["vehicle_info_lockpicked",[]];

_index2 = [(getPlayerUID player),_owners] call OEC_fnc_index;
oev_vehicles = oev_vehicles - [_vehicle];
_owners set [_index2,-1];
_owners = _owners - [-1];
_vehicle setVariable ["vehicle_info_owners",_owners,true];

{
	if ((getPlayerUID player) isEqualTo _x) exitWith {_thieves deleteAt _forEachIndex};
} forEach _thieves;
_vehicle setVariable ["vehicle_info_lockpicked",_thieves,true];
[] spawn OEC_fnc_updateKeyChainTab;