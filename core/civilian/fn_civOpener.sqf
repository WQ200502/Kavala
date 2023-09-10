// File: fn_civOpener.sqf
// Author: Matt "codeYeTi" Coffin
// Description: Key handler helper for civilian garage openers (gang sheds)

private ["_gangName","_house"];
_gangName = oev_gang_data param [1, "", [""]];
if (playerSide != civilian) exitWith {};
if (vehicle player isEqualTo player) exitWith {};
{
	_house = _x;
	private _bldgOwner = _x getVariable ["bldg_gangName", ""];
	if (_bldgOwner isEqualTo _gangName && count _bldgOwner > 0) then {
		private _doors = [[0], 1000];
		{
			private _sum = 0;
			{
				private _selectionPos = _house selectionPosition format ["Door_%1_trigger", _x];
				private _worldSpace = _house modelToWorld _selectionPos;
				private _doorDis = player distance _worldSpace;
				_sum = _sum + _doorDis
			} forEach _x;
			private _doorDis = _sum / (count _x);
			if (_doorDis < (_doors select 1)) then {
				_doors = [_x, _doorDis];
			};
		} forEach [[1, 2], [5, 6]];
		{
			private _lockVar = format ["bis_disabled_Door_%1", _x];
			private _lockState = _house getVariable [_lockVar, 0];
			private _targetState = if (_house animationSourcePhase format ["Door_%1_sound_source", _x] >= 0.5) then {
				0
			} else {
				1
			};
			if (_lockState != 0) then {
				_house setVariable [_lockVar, 0];
			};
			[_house, _x, _targetState] call BIS_fnc_Door;
			if (_lockState != 0) then {
				_house setVariable [_lockVar, _lockState];
			};
		} forEach (_doors select 0);
	};
} forEach (nearestObjects [player, ["Land_i_Shed_Ind_F"], 20]);
