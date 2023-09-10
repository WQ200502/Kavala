//  File: fn_civMarkers.sqf
//	Author: Bryan "Tonic" Boardwine
//	Modified: Jesse "tkcjesse" Schultz (code cleanup/vehicle Markers)

//	Description: Marks group units and tracked vehicles on the map.

private ["_markers","_units","_marker","_vehMarkers","_deadUnits"];
_markers = [];
_units = [];
_deadUnits = [];
_vehMarkers = [];
_deleteMarks = [];
waitUntil {visibleMap};
if (life_mapZoom) then {
	MapAnimAdd [0,0.08,player];
	MapAnimCommit;
};

if (visibleMap) then {
	{
		if ((side _x isEqualTo civilian) && !(player isEqualTo _x)) then {
			_units set[count _units,_x];
			if((_x getVariable["revive",false])) then { _deadUnits pushBack _x; };
		};
	} forEach (units(group player));

	{
		_marker = createMarkerLocal [format ["%1_marker", _x], visiblePositionASL _x];
		_marker setMarkerColorLocal "ColorWhite";
		_marker setMarkerTypeLocal "Mil_dot";
		_marker setMarkerTextLocal format ["%1", name _x];

		_markers pushBack [_marker, _x];
	} forEach _units;

	//private _deadUnits = allDeadMen select {_x in (units(group player))};
	//{deleteMarkerLocal (_x select 0);} foreach oev_death_markers;
	{

		if((_x getVariable["hasGPS", false])) then {
			if(count (_x getVariable["deathPosition", []]) > 0) then {
				_marker = createMarkerLocal [format ["%1_death_marker", _x], (_x getVariable["deathPosition", []])];
				_marker setMarkerColorLocal "ColorRed";
				_marker setMarkerTypeLocal "Mil_dot";
				_marker setMarkerTextLocal format ["%1 (Deceased)", name _x];
				_marker setMarkerPosLocal (_x getVariable["deathPosition", []]);
				oev_death_markers pushBack [_marker, _x];
				//systemChat format["OEV:%1",oev_death_markers];
			};
		};
	} forEach _deadUnits;

	if ((count oev_tracked_vehicles) > 0) then {
		{
			if !(alive _x && _x getVariable ["tracking",false]) exitWith {};
			_marker = createMarkerLocal [format ["%1_gpstracker",_x], visiblePositionASL _x];
			_marker setMarkerColorLocal "ColorYellow";
			_marker setMarkerTypeLocal "mil_dot";
			_marker setMarkerTextLocal format ["GPS Tracker %1",getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
			_marker setMarkerPosLocal getPos _x;

			_vehMarkers pushBack [_marker, _x];
		} forEach oev_tracked_vehicles;
	};

	private _vehicles = vehicles select {!(((_x getVariable ["etracking",[]]) find (group player)) isEqualTo -1)};
	{
		if !(alive _x) exitWith {};
		_marker = createMarkerLocal [format["%1_gpstracker",_x], visiblePositionASL _x];
		_marker setMarkerColorLocal "ColorYellow";
		_marker setMarkerTypeLocal "mil_triangle";
		_marker setMarkerTextLocal format ["GPS Tracker %1",getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
		_marker setMarkerPosLocal getPos _x;

		_vehMarkers pushBack [_marker, _x];
	} forEach _vehicles;

	while {visibleMap} do {
		_deleteMarks = [];
		{
			_x params ["_marker","_unit"];
			if (_unit getVariable ["restrained",false]) then {
				deleteMarkerLocal _marker;
				_deleteMarks pushBack _x;
			} else {
				if(!isNull _unit && !isNil "_unit" && (_unit in (units(group player)))) then {
					_marker setMarkerPosLocal (visiblePositionASL _unit);
				};
			};
			true
		} count _markers;
		_markers = _markers - _deleteMarks;
		_deleteMarks = [];
		{
			_x params ["_death_marker","_death_unit"];
			if (!(_death_unit getVariable ["revive",false]) || (count (getPlayerUID _death_unit) isEqualTo 0)) then {
				deleteMarkerLocal _death_marker;
				_deleteMarks pushBack _x;
			};
		} forEach oev_death_markers;
		oev_death_markers = oev_death_markers - _deleteMarks;
		{
			_x params ["_vehMarker","_vehicle"];
			if (_vehicle in oev_tracked_vehicles && {alive _vehicle} && {_vehicle getVariable ["tracking",false]}) then {
				_vehMarker setMarkerPosLocal (visiblePositionASL _vehicle);
			};
			if !(((_vehicle getVariable ["etracking",[]]) find (group player)) isEqualTo -1) then {
				_vehMarker setMarkerPosLocal (visiblePositionASL _vehicle);
			};
			true
		} count _vehMarkers;

		if (player getVariable ["restrained",false]) then {openMap false;};
		if (player getVariable ["blindfolded",false]) then {openMap false;};
		if (oev_isDowned) then {openMap false;};
		if (!visibleMap) exitWith {};
		uiSleep 0.02;
	};

	{deleteMarkerLocal (_x select 0); true} count _markers;
	{deleteMarkerLocal (_x select 0); true} count _vehMarkers;
	_markers = [];
	_units = [];
};
