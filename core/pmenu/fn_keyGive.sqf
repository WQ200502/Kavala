//  File: fn_keyGive.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Gives a copy of the key for the selected vehicle to the selected player.
//	Player must be within range.
disableSerialization;

private _dialog = findDisplay 33000;
private _list = _dialog displayCtrl 33001;
private _plist = _dialog displayCtrl 33004;
private _sel = lbCurSel _list;
private _vehicle = _list lbData _sel;
_vehicle = oev_vehicles select parseNumber(_vehicle);

_sel = lbCurSel _plist;
private _unit = _plist lbData _sel;
_unit = call compile format["%1", _unit];
if(isNull _unit || isNil "_unit") exitWith {};
[_unit, _vehicle] call OEC_fnc_keyGiveV2;
