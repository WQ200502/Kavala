//  File: fn_medicLights.sqf
//	Author: [OS] Odin / djwolf
//	Link: forums.bistudio.com/showthread.php?157474-Offroad-Police-sirens-lights-and-underglow
//	Description: Adds the light effect to medic vehicles, specifically the offroad.

private ["_vehicle","_uiSleep"];
_vehicle = param [0,objNull,[objNull]];
_uiSleep = param [1,-1,[0]];

if (isNull _vehicle) exitWith {};

private ["_lightRed","_lightWhite","_lightYellow","_light1","_light2","_light3","_light4","_light5","_light6","_light7","_light8","_attach_fnc","_brightnessHigh","_brightnessLow","_attenuation","_sun"];

if(isNil "_vehicle" || isNull _vehicle || !(_vehicle getVariable "lights")) exitWith {};
_sun = (sunOrMoon < 1);
_lightRed = [255, 0, 0];
_lightWhite = [255, 255, 255];
_lightYellow = [255, 255, 255];
if (_sun) then {
	_brightnessLow = 0;
	_brightnessHigh = 7.5;
	_attenuation = [0.181, 3000, 0, 125000];
} else {
	_brightnessLow = 0;
	_brightnessHigh = 60;
	_attenuation = [0.181, 3000, 0, 500000];
};

_flashes = 3;
_flashOn = 0.1;
_flashOff = 0.001;
_lightsLeft = [];
_lightsRight = [];

_attach_fnc = {
	_isLight = _this select 0;
	_color = _this select 1;
	_position = _this select 2;
	_light = "#lightpoint" createVehicleLocal getPos _vehicle;
	_light setLightBrightness 0;
	_light setLightAmbient [0,0,0];
	_light setLightAttenuation _attenuation;
	_light setLightIntensity 1000;
	_light setLightFlareSize 1;
	_light setLightFlareMaxDistance 150;
	_light setLightUseFlare true;
	_light setLightDayLight true;
	switch (_color) do {
		case "red": { _light setLightColor _lightRed; };
		case "white": { _light setLightColor _lightWhite; };
		case "yellow": { _light setLightColor _lightYellow; };
	};
	if (_isLight) then {
		_lightsLeft pushBack [_light, _position];
	} else {
		_lightsRight pushBack [_light, _position];
	};
	_light lightAttachObject [_vehicle, _position];
};

switch (typeOf _vehicle) do {
	case "C_SUV_01_F": {
		[false, "red", [-0.39, 2.28, -0.52]] call _attach_fnc;
		[true, "yellow", [0.38, 2.28, -0.52]] call _attach_fnc;
		[false, "red", [-0.86, -2.75, -0.18]] call _attach_fnc;
		[true, "red", [0.86, -2.75, -0.18]] call _attach_fnc;
		[false, "white", [0.8, 1.95, -0.48]] call _attach_fnc;
		[true, "white", [-0.8, 1.95, -0.48]] call _attach_fnc;
	};
	case "C_Offroad_01_repair_F": {
		[false, "red", [-0.37, 0, 0.525]] call _attach_fnc;
		[true, "yellow", [0.37, 0, 0.525]] call _attach_fnc;
		[false, "red", [0.8, -2.97, -0.25]] call _attach_fnc;
		[true, "red", [-0.8, -2.97, -0.25]] call _attach_fnc;
		[false, "white", [-0.695, 2.2825, -0.355]] call _attach_fnc;
		[true, "white", [0.695, 2.2825, -0.355]] call _attach_fnc;
	};
	case "C_Offroad_01_comms_F": {
		[false, "red", [-0.37, 0, 0.525]] call _attach_fnc;
		[true, "yellow", [0.37, 0, 0.525]] call _attach_fnc;
		[false, "red", [0.8, -2.97, -0.25]] call _attach_fnc;
		[true, "red", [-0.8, -2.97, -0.25]] call _attach_fnc;
		[false, "white", [-0.695, 2.2825, -0.355]] call _attach_fnc;
		[true, "white", [0.695, 2.2825, -0.355]] call _attach_fnc;
	};
	case "I_MRAP_03_F": {
		[false, "red", [-0.93, -3.2, 0]] call _attach_fnc;
		[true, "red", [0.93, -3.2, 0]] call _attach_fnc;
		[true, "yellow", [-0.55, 0, 0.45]] call _attach_fnc;
		[false, "red", [0.55, 0, 0.45]] call _attach_fnc;
		[false, "white", [-0.85, 2.35, -0.3]] call _attach_fnc;
		[true, "white", [0.85, 2.35, -0.3]] call _attach_fnc;
	};
	case "O_LSV_02_unarmed_viper_F": {
		[false, "red", [0.5, 2.2, -0.45]] call _attach_fnc;
		[true, "yellow", [-0.8, 2.2, -0.45]] call _attach_fnc;
		[false, "yellow", [-1, -2.4, -0.45]] call _attach_fnc;
		[true, "red", [.7, -2.4, -0.45]] call _attach_fnc;
	};
	case "B_Quadbike_01_F": {
		[false, "red", [-0.32, 1, -0.65]] call _attach_fnc;
		[true, "yellow",[0.32, 1, -0.65]] call _attach_fnc;
	};
	case "C_Kart_01_green_F": {
		[false, "red", [-0.32, 1, -0.65]] call _attach_fnc;
		[true, "yellow",[0.32, 1, -0.65]] call _attach_fnc;
		[false, "red", [-0.32, -1, -0.65]] call _attach_fnc;
		[true, "yellow",[0.32, -1, -0.65]] call _attach_fnc;
	};
	case "C_Boat_Civil_01_F": {
		[false, "red", [-0.32, 1.25, 0.1]] call _attach_fnc;
		[true, "yellow",[0.32, 1.25, 0.1]] call _attach_fnc;
	};
	case "B_Heli_Transport_03_unarmed_F": {
		[false, "red", [-0.5, 4.75, -2.45]] call _attach_fnc;
		[true, "yellow",[0.5, 4.75, -2.45]] call _attach_fnc;
		[true, "red", [-0.5, -3.75, -2.55]] call _attach_fnc;
		[false, "yellow",[0.5, -3.75, -2.55]] call _attach_fnc;
	};
	case "C_Heli_Light_01_civil_F": {
		[false, "red", [-0.37, 0.0, 0.56]] call _attach_fnc;
		[true, "yellow",[0.37, 0.0, 0.56]] call _attach_fnc;
	};
	case "B_Heli_Light_01_F": {
		[false, "red", [-0.37, 0.0, 0.56]] call _attach_fnc;
		[true, "yellow",[0.37, 0.0, 0.56]] call _attach_fnc;
	};
	case "I_Heli_Transport_02_F": {
		[false, "red", [-0.5, 5.75, -2.85]] call _attach_fnc;
		[true, "yellow",[0.5, 5.75, -2.85]] call _attach_fnc;
	};
	case "O_Heli_Light_02_unarmed_F": {
		[false, "red", [-0.32, 3.25, -1.75]] call _attach_fnc;
		[true, "yellow",[0.32, 3.25, -1.75]] call _attach_fnc;
	};
	case "O_Heli_Transport_04_F": {
		[false, "red", [-0.32, 4.70, -2.1]] call _attach_fnc;
		[true, "yellow",[0.32, 4.70, -2.1]] call _attach_fnc;
	};
	case "O_Heli_Transport_04_repair_F": {
		[false, "red", [-0.32, 4.70, -2.1]] call _attach_fnc;
		[true, "yellow",[0.32, 4.70, -2.1]] call _attach_fnc;
	};
	case "B_Heli_Transport_01_F": {
		[false, "red", [-0.8, -0.4, -1.5]] call _attach_fnc;
		[true, "yellow",[0.8, -0.4, -1.5]] call _attach_fnc;
	};
	case "C_Hatchback_01_sport_F": {
		[false, "red", [-0.03, 0, 0.2]] call _attach_fnc;
		[true, "yellow", [-0.03, 0, 0.2]] call _attach_fnc;
		[false, "red", [-0.8, -2.25, -0.3]] call _attach_fnc;
		[true, "red", [0.75, -2.25, -0.3]] call _attach_fnc;
		[false, "white", [0.75, 1.615, -0.52]] call _attach_fnc;
		[true, "white", [-0.8, 1.615, -0.525]] call _attach_fnc;
	};
	case "B_Truck_01_transport_F": {
		[false ,"red",[-0.8, -5.1, -0.5]] call _attach_fnc;
		[true ,"red",[0.8, -5.1, -0.5]] call _attach_fnc;
		[false ,"yellow",[0.3, -5.1, -0.5]] call _attach_fnc;
		[true ,"yellow",[-0.3, -5.1, -0.5]] call _attach_fnc;
		[false ,"white",[-0.8, 5.1, -0.5]] call _attach_fnc;
		[true ,"white",[0.8, 5.1, -0.5]] call _attach_fnc;
	};
	case "B_Truck_01_flatbed_F": {
		[false ,"red",[-0.8, -5.1, -0.5]] call _attach_fnc;
		[true ,"red",[0.8, -5.1, -0.5]] call _attach_fnc;
		[false ,"yellow",[0.3, -5.1, -0.5]] call _attach_fnc;
		[true ,"yellow",[-0.3, -5.1, -0.5]] call _attach_fnc;
		[false ,"white",[-0.8, 5.1, -0.5]] call _attach_fnc;
		[true ,"white",[0.8, 5.1, -0.5]] call _attach_fnc;
	};
	case "C_Van_02_medevac_F": {
		[false, "red", [-0.57,-3.20,0.73]] call _attach_fnc;
		[false, "yellow", [0.71,2.26,0.74]] call _attach_fnc;
		[true, "red", [-0.71,2.26,0.74]] call _attach_fnc;
		[true, "yellow", [0.57,-3.20,0.73]] call _attach_fnc;
		[true, "white", [-0.74,3.88,-0.56]] call _attach_fnc;
		[false, "white", [0.74,3.88,-0.56]] call _attach_fnc;
	};
	case "I_Heli_light_03_unarmed_F": {
		[false, "red", [-0.55, 0.85, 1]] call _attach_fnc;
		[true, "yellow", [-0.55, 0.85, 1]] call _attach_fnc;
		[true, "red", [0.55, 0.85, 1]] call _attach_fnc;
		[false, "yellow", [0.55, 0.85, 1]] call _attach_fnc;
	};
	case "B_MRAP_01_F": {
		[false, "red", [-0.85, -0.9, 0.6]] call _attach_fnc;
		[false, "yellow", [0.93, -2.8, 0.6]] call _attach_fnc;
		[true, "red", [-0.93, -2.8, 0.6]] call _attach_fnc;
		[true, "yellow", [0.85, -0.9, 0.6]] call _attach_fnc;
		[true, "white", [-0.85, 1.475, -0.75]] call _attach_fnc;
		[false, "white", [0.85, 1.475, -0.75]] call _attach_fnc;
	};
	case "O_T_VTOL_02_vehicle_F": {
		[false, "yellow", [0.45,5.5,-1]] call _attach_fnc;// front left
		[true, "red", [-0.55,5.5,-1]] call _attach_fnc;//front right
		[false, "yellow", [-1.4,-4.1,-1]] call _attach_fnc;// back left
		[true, "red", [1.4,-4.1,-1]] call _attach_fnc;// back right
		[false, "red",[-8.156,-0.708,-0.8]] call _attach_fnc; //left wing
		[true, "yellow",[7.843,-0.854,-0.8]] call _attach_fnc; //right wing
	};
	case "C_Boat_Civil_01_rescue_F": {
		[false, "yellow", [-0.8, -2.25, -0.3]] call _attach_fnc;
		[true, "yellow", [0.75, -2.25, -0.3]] call _attach_fnc;
		[false, "red", [0.45, 2.415, -0.12]] call _attach_fnc;
		[true, "red", [-0.46, 2.415, -0.125]] call _attach_fnc;
	};
	case "B_SDV_01_F": {
		[false, "red", [-.40812, 0, -.5]] call _attach_fnc;
		[false, "yellow", [.40812, 0, -.5]] call _attach_fnc;
		[true, "red", [.40812, 0, -.5]] call _attach_fnc;
		[true, "yellow", [-.40812, 0, -.5]] call _attach_fnc;
		[true, "yellow", [-.40812, -2.75558, -1]] call _attach_fnc;
		[false, "yellow", [.40812, -2.75558, -1]] call _attach_fnc;
	};
	case "C_Boat_Transport_02_F": {
		[false, "red", [0.3, 3.398, 0]] call _attach_fnc;
		[false, "yellow", [-0.318, 3.395, 0]] call _attach_fnc;
		[true, "red", [-0.318, 3.395, 0]] call _attach_fnc;
		[true, "yellow", [0.3, 3.398, 0]] call _attach_fnc;
		[true, "yellow", [1.17, -2.414, -0.3]] call _attach_fnc;
		[false, "yellow", [-1.114, -2.414, -0.3]] call _attach_fnc;
	};
	case "I_Heli_light_03_dynamicLoadout_F": {
		[false, "red", [-0.55, 0.85, 1]] call _attach_fnc;
		[true, "yellow", [-0.55, 0.85, 1]] call _attach_fnc;
		[true, "red", [0.55, 0.85, 1]] call _attach_fnc;
		[false, "yellow", [0.55, 0.85, 1]] call _attach_fnc;
	};
};

while {(alive _vehicle)} do {
	if (!(_vehicle getVariable ["lights",false])) exitWith {};

	for [{_i=0}, {_i<_flashes}, {_i=_i+1}] do {
		{ (_x select 0) setLightBrightness _brightnessHigh; } forEach _lightsLeft;
		uiSleep _flashOn;
		{ (_x select 0) setLightBrightness _brightnessLow; } forEach _lightsLeft;
		uiSleep _flashOff;
	};
	{ (_x select 0) setLightBrightness 0; } forEach _lightsLeft;

	for [{_i=0}, {_i<_flashes}, {_i=_i+1}] do {
		{ (_x select 0) setLightBrightness _brightnessHigh; } forEach _lightsRight;
		uiSleep _flashOn;
		{ (_x select 0) setLightBrightness _brightnessLow; } forEach _lightsRight;
		uiSleep _flashOff;
	};
	{ (_x select 0) setLightBrightness 0; } forEach _lightsRight;
};

{ deleteVehicle (_x select 0) } foreach _lightsLeft;
{ deleteVehicle (_x select 0) } foreach _lightsRight;
_lightsLeft = [];
_lightsRight = [];
