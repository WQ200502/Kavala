// File: fn_skinName.sqf
// Author: codeYeTi
// Description: gets the name of a skin on the given vehicle
params [
	["_veh", objNull, [objNull]]
];
private ["_skinName", "_color", "_index"];
if (isNull _veh) exitWith {""};
if !(alive _veh) exitWith {""};
_skinName = "";
_color = ["allSkins", typeOf _veh] call OEC_fnc_vehicleSkins;
if (count _color > 0) then {
	_index = (_veh getVariable ["oev_veh_color",[-1,0]]) select 0;
	if !(_index isEqualTo -1) then {
		{
			if (_index isEqualTo (_x select 0)) exitWith {
				_skinName = _x select 1;
			};
		}forEach _color;
	};
};
_skinName;
