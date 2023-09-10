// File: fn_updateStolenVehicleInfo.sqf
// Author: codeYeTi
// Description: updates stolen vehicle details UI
params [
	["_list", controlNull, [controlNull]],
	["_idx", -1, [-1]]
];
private ["_display", "_details", "_textLocation"];
if (_idx < 0) exitWith {};
if(count(oev_cop_stolenVehicles) < 1) exitWith {};
_display = findDisplay 51000;
_details = _display displayCtrl 51002;

private _report = oev_cop_stolenVehicles select _idx;
_report params [
	["_vehicle", objNull, [objNull]],
	["_pos", [], [[]]],
	["_reporter", "", [""]]
];

private _reward = parseNumber (_list lbData _idx);
_textLocation = nearestLocations [_pos, ["NameCity", "NameCityCapital", "NameVillage", "Airport"], 5000];
if (count _textLocation > 0) then {
	_textLocation = text (_textLocation select 0);
} else {
	_textLocation = "Unknown";
};
private _text = composeText [
	format ["Type: %1", getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")], lineBreak,
	format ["Color: %1", [_vehicle] call OEC_fnc_skinName], lineBreak,
	parseText format ["Reward: <t color='#00FF00'>$%1</t><br/>", [_reward] call OEC_fnc_numberText],
	format ["Reporter: %1", _reporter], lineBreak,
	parseText format ["Last Seen: <t color='#FFFF00'>%1</t>", _textLocation]
];
_details ctrlSetStructuredText _text;
