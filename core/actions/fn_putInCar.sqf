//  File: fn_putInCar.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Finds the nearest vehicle and loads the target into the vehicle.
params [
	["_unit",objNull,[objNull]]
];
private ["_playerVehSide", "_factionVehicles", "_nonFactionVehicles"];

_playerVehSide = switch (playerSide) do {
    case west: {
        "cop"
    };
    case civilian: {
        "civ"
    };
    case resistance: {
        "med"
    };
    default { "unknown" };
};

if(isNull _unit || !isPlayer _unit) exitWith {};

_nearestVehicle = nearestObjects[getPosATL player,["Car","Ship","Submarine","Air"],10,true];
_factionVehicles = [];
_nonFactionVehicles = [];
{
    if ((_x getVariable ["side", sideUnknown]) isEqualTo _playerVehSide) then {
        _factionVehicles pushBack _x;
    } else {
        _nonFactionVehicles pushBack _x;
    };
} forEach _nearestVehicle;
_nearestVehicle = if (count _factionVehicles <= 0) then {
    _nonFactionVehicles select 0
} else {
    _factionVehicles select 0
};

if(isNil "_nearestVehicle") exitWith {hint localize "STR_NOTF_VehicleNear"};

detach _unit;
[[_nearestVehicle],"OEC_fnc_moveIn",_unit,false] call OEC_fnc_MP;
_unit setVariable["Escorting",false,true];
_unit setVariable["transporting",true,true];
