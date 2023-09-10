//  File: fn_updateViewDistance.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Updates the view distance dependant on whether the player is on foot, a car or an aircraft.
private _v = vehicle player;
if !(isNull (isVehicleCargo _v)) then {
	_v = isVehicleCargo _v;
};
switch (true) do {
	case (_v isKindOf "Man"): {setViewDistance tawvd_foot};
	case (_v isKindOf "LandVehicle"): {setViewDistance tawvd_car};
	case (_v isKindOf "Ship"): {setViewDistance tawvd_car};
	case (_v isKindOf "Air"): {setViewDistance tawvd_air};
	default {setViewDistance tawvd_foot};
};
