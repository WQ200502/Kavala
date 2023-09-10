//  File: fn_copMarkers.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Marks cops on the map for other cops. Only initializes when the actual map is open.
private["_markers","_medics"];
_markers = [];
_medics = [];

uiSleep 0.5;
if(visibleMap) then {
	{if(side _x isEqualTo independent) then {_medics pushBack _x;}} foreach playableUnits; //Fetch list of cops / blufor

	//Create markers
	{
		_marker = createMarkerLocal [format["%1_marker",_x],visiblePositionASL _x];
		_marker setMarkerColorLocal "ColorGreen";
		_marker setMarkerTypeLocal "Mil_dot";
		_marker setMarkerTextLocal format["%1", _x getVariable["realname",name _x]];

		_markers pushBack [_marker,_x];
	} foreach _medics;

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

		if (player getVariable ["restrained",false]) then {openMap false;};
		if (player getVariable ["blindfolded",false]) then {openMap false;};
		if (oev_isDowned) then {openMap false;};
		if(!visibleMap) exitWith {};
		uiSleep 0.02;
	};

	{deleteMarkerLocal (_x select 0);} foreach _markers;
	_markers = [];
	_medics = [];
};