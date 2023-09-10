//    File: fn_copLights.sqf
//    Author: mindstorm, modified by Adanteh
//    Link: forums.bistudio.com/showthread.php?157474-Offroad-Police-sirens-lights-and-underglow

//    Description: Adds the light effect to cop vehicles, specifically the offroad.

private ["_vehicle","_lightRed","_lightBlue","_lightWhite","_lightsleft","_lightsright","_leftRed","_attach","_brightnessHigh","_brightnessLow","_type","_attenuation","_sun"];
_vehicle = param [0,objNull,[objNull]];
_type = typeOf _vehicle;
_sun = (sunOrMoon < 1);
if(isNil "_vehicle" || isNull _vehicle || !(_vehicle getVariable "lights")) exitWith {};
_lightRed = [255, 0, 0];
_lightWhite = [255, 255, 255];
_lightBlue = [0, 0, 255];
if (_sun) then
{
    _brightnessLow = 0;
    _brightnessHigh = 10;
    _attenuation = [0.001, 3000, 0, 125000];
} else {
    _brightnessLow = 0;
    _brightnessHigh = 60;
    _attenuation = [0.001, 3000, 0, 500000];
};
_flashes = 3;
_flashOn = 0.1;
_flashOff = 0.001;
_lightsLeft = [];
_lightsRight = [];
_attach =
{
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
    switch (_color) do
    {
        case "red": { _light setLightColor _lightRed; };
        case "white": { _light setLightColor _lightWhite; };
        case "blue": { _light setLightColor _lightBlue; };
    };
    if (_isLight) then
    {
        _lightsLeft pushBack [_light, _position];
    } else {
        _lightsRight pushBack [_light, _position];
    };
    _light lightAttachObject [_vehicle, _position];
};
switch (_type) do
{
    case "C_Offroad_01_F":
    {
        [false, "red", [-0.44, 0, 0.525]] call _attach;
        [true, "blue", [0.345, 0, 0.525]] call _attach;
        [false, "red", [0.575, -2.95, -0.77]] call _attach;
        [true, "blue", [-0.645, -2.95, -0.77]] call _attach;
        [false, "white", [0.61, 2.2825, -0.355]] call _attach;
        [true, "white", [-0.695, 2.2825, -0.355]] call _attach;
    };
    case "C_SUV_01_F":
    {
        [false, "red", [-0.39, 2.28, -0.52]] call _attach;
        [true, "blue", [0.38, 2.28, -0.52]] call _attach;
        [false, "red", [-0.86, -2.75, -0.18]] call _attach;
        [true, "blue", [0.86, -2.75, -0.18]] call _attach;
        [false, "white", [0.8, 1.95, -0.48]] call _attach;
        [true, "white", [-0.8, 1.95, -0.48]] call _attach;

    };
    case "C_Hatchback_01_sport_F":
    {
        [false, "red", [-0.03, -0, 0.2]] call _attach;
        [true, "blue", [-0.03, -0, 0.2]] call _attach;
        [false, "red", [-0.8, -2.25, -0.3]] call _attach;
        [true, "blue", [0.78, -2.25, -0.3]] call _attach;
        [false, "white", [0.75, 1.615, -0.52]] call _attach;
        [true, "white", [-0.8, 1.615, -0.525]] call _attach;
    };
    case "B_MRAP_01_F":
    {
        [false, "red", [-0.85, -0.9, 0.6]] call _attach;
        [true, "blue", [0.85, -0.9, 0.6]] call _attach;
        [true, "red", [-0.93, -2.8, 0.6]] call _attach;
        [false, "blue", [0.93, -2.8, 0.6]] call _attach;
        [true, "white", [-0.85, 1.475, -0.75]] call _attach;
        [false, "white", [0.85, 1.475, -0.75]] call _attach;
    };
    case "O_MRAP_02_F":
    {
        [false, "red", [-0.85, -0.9, 0.6]] call _attach;
        [true, "blue", [0.85, -0.9, 0.6]] call _attach;
        [true, "red", [-0.93, -2.8, 0.6]] call _attach;
        [false, "blue", [0.93, -2.8, 0.6]] call _attach;
        [true, "white", [-0.85, 1.475, -0.75]] call _attach;
        [false, "white", [0.85, 1.475, -0.75]] call _attach;
    };
};
_lightsOn = true;
while {(alive _vehicle)} do
{
    if (!(_vehicle getVariable "lights")) exitWith {};
    if (_lightsOn) then
    {
        for [{_i=0}, {_i<_flashes}, {_i=_i+1}] do
        {
            { (_x select 0) setLightBrightness _brightnessHigh; } forEach _lightsLeft;
            uiSleep _flashOn;
            { (_x select 0) setLightBrightness _brightnessLow; } forEach _lightsLeft;
            uiSleep _flashOff;
        };
        { (_x select 0) setLightBrightness 0; } forEach _lightsLeft;
        for [{_i=0}, {_i<_flashes}, {_i=_i+1}] do
        {
            { (_x select 0) setLightBrightness _brightnessHigh; } forEach _lightsRight;
            uiSleep _flashOn;
            { (_x select 0) setLightBrightness _brightnessLow; } forEach _lightsRight;
            uiSleep _flashOff;
        };
        { (_x select 0) setLightBrightness 0; } forEach _lightsRight;
    };
};
{ deleteVehicle (_x select 0) } foreach _lightsLeft;
{ deleteVehicle (_x select 0) } foreach _lightsRight;
_lightsLeft = [];
_lightsRight = [];
//point
/*
_lightleft = "#lightpoint" createVehicleLocal getpos _vehicle;
uiSleep 0.2;
_lightleft setLightColor _lightRed;
_lightleft setLightBrightness 0.2;
_lightleft setLightAmbient [0.1,0.1,1];

switch (typeOf _vehicle) do
{
    case "C_Offroad_01_F":              {_lightleft lightAttachObject [_vehicle, [-0.37, 0.0, 0.56]];};
    case "C_SUV_01_F":                  {_lightleft lightAttachObject [_vehicle, [-0.37,-1.2,0.42]];};
    case "B_MRAP_01_F":                 {_lightleft lightAttachObject [_vehicle, [-0.37, -1.9, 0.7]];};
    case "C_Hatchback_01_sport_F":      {_lightleft lightAttachObject [_vehicle, [-0.6, 2, -0.95]];};
    case "B_Heli_Light_01_F":           {_lightleft lightAttachObject [_vehicle, [-0.37, 0.0, 0.56]];};
    case "B_Heli_Transport_01_F":       {_lightleft lightAttachObject [_vehicle, [-0.75, -0.4, -1.5]];};
    case "I_MRAP_03_F":                 {_lightleft lightAttachObject [_vehicle, [-0.37, 0.0, 0.56]];};
    case "B_Truck_01_transport_F":      {_lightleft lightAttachObject [_vehicle, [-0.37, 0.0, 0.56]];};
    case "I_Heli_light_03_unarmed_F":   {_lightleft lightAttachObject [_vehicle, [-0.55, 0.85, -0.85]];};
    case "I_Truck_02_covered_F":        {_lightleft lightAttachObject [_vehicle, [-0.55, 0.85, 0.85]];};
};

_lightleft setLightAttenuation [0.181, 0, 1000, 130];
_lightleft setLightIntensity 10;
_lightleft setLightFlareSize 0.38;
_lightleft setLightFlareMaxDistance 150;
_lightleft setLightUseFlare true;

_lightright = "#lightpoint" createVehicleLocal getpos _vehicle;
uiSleep 0.2;
_lightright setLightColor _lightBlue;
_lightright setLightBrightness 0.2;
_lightright setLightAmbient [0.1,0.1,1];

switch (typeOf _vehicle) do
{
    case "C_Offroad_01_F":              {_lightright lightAttachObject [_vehicle, [0.37, 0.0, 0.56]];};
    case "C_SUV_01_F":                  {_lightright lightAttachObject [_vehicle, [0.37,-1.2,0.42]];};
    case "B_MRAP_01_F":                 {_lightright lightAttachObject [_vehicle, [0.37, -1.9, 0.7]];};
    case "C_Hatchback_01_sport_F":      {_lightright lightAttachObject [_vehicle, [0.6, 2, -0.95]];};
    case "B_Heli_Light_01_F":           {_lightright lightAttachObject [_vehicle, [0.37, 0.0, 0.56]];};
    case "B_Heli_Transport_01_F":       {_lightright lightAttachObject [_vehicle, [0.8, -0.4, -1.5]];};
    case "I_MRAP_03_F":                 {_lightright lightAttachObject [_vehicle, [0.37, 0.0, 0.56]];};
    case "B_Truck_01_transport_F":      {_lightright lightAttachObject [_vehicle, [0.37, 0.0, 0.56]];};
    case "I_Heli_light_03_unarmed_F":   {_lightright lightAttachObject [_vehicle, [0.55, 0.85, -0.85]];};
    case "I_Truck_02_covered_F":        {_lightright lightAttachObject [_vehicle, [0.55, 0.85, 0.85]];};
};

_lightright setLightAttenuation [0.181, 0, 1000, 130];
_lightright setLightIntensity 10;
_lightright setLightFlareSize 0.38;
_lightright setLightFlareMaxDistance 150;
_lightright setLightUseFlare true;

_lightleft setLightDayLight true;
_lightright setLightDayLight true;

_leftRed = true;
while{ (alive _vehicle)} do
{
    if(!(_vehicle getVariable "lights")) exitWith {};
    if(_leftRed) then
    {
        _leftRed = false;
        _lightright setLightBrightness 0.0;
        _lightleft setLightBrightness 6;
        uiSleep 0.07;
    }
        else
    {
        _leftRed = true;
        _lightleft setLightBrightness 0.0;
        _lightright setLightBrightness 6;
        uiSleep 0.07;
    };
    uiSleep (_this select 1);
};
deleteVehicle _lightleft;
deleteVehicle _lightright;
*/