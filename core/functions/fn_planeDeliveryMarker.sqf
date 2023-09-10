// File: fn_planeDeliveryMarker.sqf
// Authors: Kurt, Civak

params ["_vehicle"];
if (isNull _vehicle || !(typeOf _vehicle in ["C_Plane_Civil_01_F","C_Plane_Civil_01_racing_F"])) exitWith {};
uiSleep 3;

_fn_createMarker = {
	params ["_location", "_marker"];
	hint parseText format["<t color='#ffff00'><t size='2'>Cargo Found</t></t><br/><br/>This aircraft is loaded with cargo.<br/><br/>Head to the %1 to drop off the package.  The plane delivery marker has turned green for the location you are to deliver the cargo.", _location];
	private _mark = createMarkerLocal ["deliveryMarker", (getMarkerPos _marker)];
	_mark setMarkerShapeLocal "ICON";
	_mark setMarkerTypeLocal "mil_pickup";
	_mark setMarkerColorLocal "ColorGreen";
	_mark setMarkerTextLocal "Plane Delivery - Deliver Here!";
	oev_currentDeliveryMarker = _mark;
};

switch (_vehicle getVariable ["cargoDestination", 0]) do {
	case 1: {
		["airfield north-west of Athira", "plane_delivery_1"] call _fn_createMarker;
	};
	case 2: {
		["airfield south of Neochori", "plane_delivery_2"] call _fn_createMarker;
	};
	case 3: {
		["main airfield south of Athira", "plane_delivery_3"] call _fn_createMarker;
	};
	case 4: {
		["airfield south-east of Pyrgos", "plane_delivery_4"] call _fn_createMarker;
	};
	case 5: {
		["airfield on the salt flats south west of Sofia", "plane_delivery_5"] call _fn_createMarker;
	};
	case 6: {
		["airfield north of Sofia", "plane_delivery_6"] call _fn_createMarker;
	};
}