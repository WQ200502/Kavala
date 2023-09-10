//  File: fn_medicMarkers.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Marks downed players on the map when it's open.
private["_units","_marker","_medics","_requested","_mark","_marks","_requestMarkerColor","_afkCheck","_denialRequest"];
_units = [];
_medics = [];
_marks = [];

waitUntil {visibleMap};
if (life_mapZoom) then {
	MapAnimAdd [0,0.08,player];
	MapAnimCommit;
};

if (visibleMap) then {
	{
		_requested = _x getVariable["hasRequested",0];
		if(_requested != 0) then {
			_afkCheck = _x getVariable ["afkCheck",serverTime];
			if((serverTime - _afkCheck) < 31) then {
				_name = _x getVariable "name";
				if(!isNil "_name") then {
					_units pushBack _x;
				};
			};
		};
	} forEach allDeadMen;

	//Loop through and create markers.
	{deleteMarkerLocal _x;} foreach oev_medic_markers;
	{
		_marker = createMarkerLocal [format["%1_dead_marker",_x],visiblePositionASL _x];
		_denialRequest = _x getVariable["denialRequest", false];
		if (_denialRequest) then {
			_requestMarkerColor = "ColorOrange"; // orange if requesting denial
		} else {
			_requestMarkerColor = "ColorWhite"; // white if normal request
		};

		switch (true) do {
			case ((_x getVariable ["responseType",3] == 0) && (_requestMarkerColor != "ColorOrange")) : {_requestMarkerColor = "ColorGreen";};
			case ((_x getVariable ["responseType",3] == 1) && (_requestMarkerColor != "ColorOrange")) : {_requestMarkerColor = "ColorEAST";};
			case ((_x getVariable ["responseType",3] == 2) && (_requestMarkerColor != "ColorOrange")) : {_requestMarkerColor = "ColorEAST";};
			case ((_x getVariable ["responseType",3] == 3) && (_requestMarkerColor != "ColorOrange")) : {_requestMarkerColor = "ColorWhite";}; // No type/status
			case ((_x getVariable ["responseType",3] == 4) && (_requestMarkerColor != "ColorOrange")) : {_requestMarkerColor = "ColorEAST";};
		};
		_marker setMarkerColorLocal _requestMarkerColor;
		_marker setMarkerTypeLocal "o_maint";
		_marker setMarkerTextLocal format["-!! REVIVE REQUESTED !!- %1 - Time: %2 %3",(_x getVariable["name","Unknown Player"]),[(servertime - (_x getVariable["hasRequested",0])),"MM:SS"] call BIS_fnc_secondsToString,(_x getVariable["dispatchStatus",""])];
		oev_medic_markers pushBack _marker;
	} forEach _units;

	{
		if ((side _x isEqualTo independent)  && (player != _x)) then {_medics pushBack _x;};
	} forEach playableUnits;

	{
		if (!(_x getVariable ["restrained",false])) then {
			_mark = createMarkerLocal [format["%1_marker",_x],visiblePositionASL _x];
			_mark setMarkerColorLocal "ColorGreen";
			_mark setMarkerTypeLocal "Mil_dot";
			_mark setMarkerTextLocal format["%1", _x getVariable["realname",name _x]];

			_marks pushBack [_mark,_x];
		}
	} forEach _medics;

	while {visibleMap} do {
		{
			private["_mark","_unit"];
			_mark = _x select 0;
			_unit = _x select 1;
			if(!isNil "_unit") then	{
				if(!isNull _unit) then {
					_mark setMarkerPosLocal (visiblePositionASL _unit);
				};
			};
		} forEach _marks;
		if(!visibleMap) exitWith {};
		uiSleep 0.02;
	};

	waitUntil{!visibleMap};
	{deleteMarkerLocal (_x select 0);} foreach _marks; // Medics
	_marks = [];
	_medics = [];
};