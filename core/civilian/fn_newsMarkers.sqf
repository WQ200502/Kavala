//  File: fn_newsMarkers.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Marks group units on the map. Only initializes when the actual map is open.
private _markers = [];
private _units = [];

waitUntil {visibleMap};
MapAnimAdd [0,0.08,player];
MapAnimCommit;

if(visibleMap) then {
	{
		if((side _x isEqualTo independent) && (player != _x)) then {
			_units set[count _units,_x];
		}
	} forEach (units(group player)); //Fetch list of units

	//Create markers
	{
		_marker = createMarkerLocal [format["%1_marker",_x],visiblePositionASL _x];
		_marker setMarkerColorLocal "ColorWhite";
		_marker setMarkerTypeLocal "Mil_dot";
		_marker setMarkerTextLocal format["%1", name _x];

		_markers set[count _markers,[_marker,_x]];
	} foreach _units;

	while {visibleMap} do
	{
		{
			private["_marker","_unit"];
			_marker = _x select 0;
			_unit = _x select 1;
			if(!isNil "_unit") then
			{
				if(!isNull _unit) then
				{
					_marker setMarkerPosLocal (visiblePositionASL _unit);
				};
			};
		} foreach _markers;
		if(!visibleMap) exitWith {};
		uiSleep 0.02;
	};

	{deleteMarkerLocal (_x select 0);} foreach _markers;
	_markers = [];
	_units = [];
};