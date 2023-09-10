//  File:jip.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: JIP functionality for JIP required things like vehicles.

[] spawn{
	waitUntil{!isNil "olympusVehiclesLoaded"};
	waitUntil{olympusVehiclesLoaded};
	waitUntil{!isNil "olympusGangVehiclesLoaded"};
	waitUntil{olympusGangVehiclesLoaded};
	waitUntil{!isNil "oev_sesion_completed"};
	waitUntil{oev_session_completed};
	sleep 4;
	{
		if(isPlayer _x && _x != player) then {
			[_x,true] spawn OEC_fnc_skinUniform;
		};
	}foreach (allMissionObjects "Man");

	{
		_index = _x getVariable "oev_veh_color";
		if(!isNil "_index") then {
			[_x,_index] spawn OEC_fnc_colorVehicle;
		};
	}foreach allMissionObjects "Car";

	{
		_index = _x getVariable "oev_veh_color";
		if(!isNil "_index") then {
			[_x,_index] spawn OEC_fnc_colorVehicle;
		};
	}foreach allMissionObjects "Air";

	{
		_index = _x getVariable "oev_veh_color";
		if(!isNil "_index") then {
			[_x,_index] spawn OEC_fnc_colorVehicle;
		};
	}foreach allMissionObjects "Ship";
};
