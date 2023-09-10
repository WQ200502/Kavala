//  File: fn_copMarkers.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Marks cops on the map for other cops. Only initializes when the actual map is open.
private["_markers","_cops","_deadUnits","_marker","_vehMarkers"];
_markers = [];
_cops = [];
_deadUnits = [];
_vehMarkers = [];

waitUntil {visibleMap};
if (life_mapZoom) then {
	MapAnimAdd [0,0.08,player];
	MapAnimCommit;
};

if(visibleMap) then {
	{
		if ((side _x isEqualTo west)  && !(player isEqualTo _x)) then {
			_cops pushBack _x;
			if((_x getVariable["revive",false])) then {
				_deadUnits pushBack _x;
			};
		};
	} forEach (units(group player));

	{
		if (!(_x getVariable ["restrained",false])) then {
			_marker = createMarkerLocal [format["%1_marker",_x],visiblePositionASL _x];
			_marker setMarkerColorLocal "ColorBlue";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerTextLocal format["%1", _x getVariable["realname",name _x]];

			_markers pushBack [_marker,_x];
		}
	} forEach _cops;

	{
		if((_x getVariable["hasGPS", false])) then {
			if(count (_x getVariable["deathPosition", []]) > 0) then {
				_marker = createMarkerLocal [format ["%1_death_marker", _x], (_x getVariable["deathPosition", []])];
				_marker setMarkerColorLocal "ColorRed";
				_marker setMarkerTypeLocal "Mil_dot";
				_marker setMarkerTextLocal format ["%1 (Code 999: Officer Down)", name _x];
				_marker setMarkerPosLocal (_x getVariable["deathPosition", []]);
				oev_death_markers pushBack [_marker, _x];
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
		{
			_x params ["_marker","_unit"];
			if(!isNull _unit && !isNil "_unit") then {
				_marker setMarkerPosLocal (visiblePositionASL _unit);
			};
			true
		} count _markers;

		{
			_x params ["_death_marker","_death_unit"];
			if (!(_death_unit getVariable ["revive",false]) || (count (getPlayerUID _death_unit) isEqualTo 0)) then {
				deleteMarkerLocal _death_marker;
				oev_death_markers deleteAt _forEachIndex;
			};
		} forEach oev_death_markers;

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
	_vehMarkers = [];
	_cops = [];
};
