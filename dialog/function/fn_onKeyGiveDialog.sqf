//  File: fn_keyGiveV2.sqf
//	Author: Matt "codeYeTi" Coffin
//	Description: Gives a copy of the key for the selected vehicle to the selected player. (From interaction dialog)
params [
	["_unit", objNull, [objNull]]
];
disableSerialization;
private _control = (findDisplay 39500) displayCtrl 39502;
if (lbCurSel _control < 0) exitWith {
	hint localize "STR_Global_NoSelection";
};
if ((_control lbData (lbCurSel _control)) isEqualTo (str objNull)) exitWith {};
private _vehicle = oev_vehicles select (lbCurSel _control);
[_unit, _vehicle] call OEC_fnc_keyGiveV2;
