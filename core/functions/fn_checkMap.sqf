// File: fn_checkMap.sqf
// Author: Jesse "tkcjesse" Schultz
// https://community.bistudio.com/wiki/Arma_3:_Event_Handlers/addMissionEventHandler#Map
params [
	["_mapOpen",false,[false]],
	["_mapForced",false,[false]]
];

if (player getVariable ["restrained",false]) exitWith {openMap false;};
if (player getVariable ["blindfolded",false]) exitWith {openMap false;};
if (oev_isDowned) exitWith {openMap false;};

if (_mapOpen) then {
	switch (playerSide) do {
		case west: {[] spawn OEC_fnc_copMarkers;};
		case independent: {
			if !(oev_newsTeam) then {
				[] spawn OEC_fnc_medicMarkers;
			} else {
				[] spawn OEC_fnc_newsMarkers;
			};
		};
		case civilian: {[] spawn OEC_fnc_civMarkers;};
		default {};
	};
};