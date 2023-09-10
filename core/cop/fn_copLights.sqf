//	Author: djwolf
//	Date: 6/4/2016
//	File: fn_copLights.sqf
//	Description: Adds the light effect to cop vehicles
//	Organization: Olympus Entertainment

private "_vehicle";
//,"_lightRed","_lightBlue","_lightWhite","_lightsleft","_lightsright","_leftRed","_attach","_brightnessHigh","_brightnessLow","_type","_attenuation","_sun"];
_vehicle = param [0,objNull,[objNull]];
if ((typeOf _vehicle) in ["C_Offroad_01_F","C_SUV_01_F","C_Hatchback_01_sport_F","B_MRAP_01_F","O_MRAP_02_F","I_MRAP_03_F","I_Truck_02_covered_F","C_Boat_Transport_02_F","C_Scooter_Transport_01_F","B_G_Van_02_transport_F","B_G_Van_02_vehicle_F","B_Quadbike_01_F","O_LSV_02_unarmed_viper_F","C_Plane_Civil_01_racing_F","I_C_Offroad_02_LMG_F","C_Plane_Civil_01_F","C_Offroad_01_comms_F","C_Offroad_01_covered_F","O_T_VTOL_02_infantry_F","B_SDV_01_F","C_Offroad_02_unarmed_F","B_LSV_01_unarmed_black_F","O_Heli_Transport_04_F""O_Heli_Transpot_04_bench_F","O_Heli_Transport_04_covered_F"]) then {
	private ["_lightRed","_lightBlue","_lightWhite","_lightsleft","_lightsright","_leftRed","_attach","_brightnessHigh","_brightnessLow","_type","_attenuation","_sun"];
	_type = typeOf _vehicle;
	_sun = (sunOrMoon < 1);
	if(isNil "_vehicle" || isNull _vehicle || !(_vehicle getVariable "lights")) exitWith {};
	_lightRed = [255, 0, 0];
	_lightWhite = [255, 255, 255];
	_lightBlue = [0, 0, 255];
	if (_sun) then
	{
		_brightnessLow = 0;
		_brightnessHigh = 5;
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
		_light setLightIntensity 500;
		_light setLightFlareSize 0.5;
		_light setLightFlareMaxDistance 150;
		_light setLightUseFlare true;
		_light setLightDayLight true;
		switch (_color) do
		{
			case "red": { _light setLightColor _lightRed; };
//			case "white": { _light setLightColor _lightWhite; };
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
			[false, "red", [0.75, -2.95, -0.25]] call _attach;
			[true, "red", [-0.8, -2.95, -0.25]] call _attach;
//			[false, "white", [0.61, 2.2825, -0.355]] call _attach;
//			[true, "white", [-0.695, 2.2825, -0.355]] call _attach;
		};
		case "C_Offroad_01_comms_F":
		{
			[false, "red", [-0.44, 0, 0.525]] call _attach;
			[true, "blue", [0.345, 0, 0.525]] call _attach;
			[false, "red", [0.75, -2.95, -0.25]] call _attach;
			[true, "red", [-0.8, -2.95, -0.25]] call _attach;
//			[false, "white", [0.61, 2.2825, -0.355]] call _attach;
//			[true, "white", [-0.695, 2.2825, -0.355]] call _attach;
		};
		case "C_Offroad_01_covered_F":
		{
			[false, "red", [-0.44, 0, 0.525]] call _attach;
			[true, "blue", [0.345, 0, 0.525]] call _attach;
			[false, "red", [0.75, -2.95, -0.25]] call _attach;
			[true, "red", [-0.8, -2.95, -0.25]] call _attach;
	//		[false, "white", [0.61, 2.2825, -0.355]] call _attach;
//			[true, "white", [-0.695, 2.2825, -0.355]] call _attach;
		};
		case "C_SUV_01_F":
		{
			[false, "red", [-0.39, 2.28, -0.52]] call _attach;
			[true, "blue", [0.38, 2.28, -0.52]] call _attach;
			[false, "red", [-0.86, -2.75, -0.18]] call _attach;
			[true, "red", [0.86, -2.75, -0.18]] call _attach;
//			[false, "white", [0.8, 1.95, -0.48]] call _attach;
//			[true, "white", [-0.8, 1.95, -0.48]] call _attach;

		};
		case "C_Hatchback_01_sport_F":
		{
			[false, "red", [-0.03, 0, 0.2]] call _attach;
			[true, "blue", [-0.03, 0, 0.2]] call _attach;
			[false, "red", [-0.8, -2.25, -0.3]] call _attach;
			[true, "red", [0.78, -2.25, -0.3]] call _attach;
//			[false, "white", [0.75, 1.615, -0.52]] call _attach;
//			[true, "white", [-0.8, 1.615, -0.525]] call _attach;
		};
		case "B_MRAP_01_F":
		{
			[false, "red", [-0.85, -0.9, 0.6]] call _attach;
			[true, "blue", [0.85, -0.9, 0.6]] call _attach;
			[true, "red", [-0.93, -2.8, 0.6]] call _attach;
			[false, "blue", [0.93, -2.8, 0.6]] call _attach;
//			[true, "white", [-0.85, 1.475, -0.75]] call _attach;
//			[false, "white", [0.85, 1.475, -0.75]] call _attach;
		};
		case "O_MRAP_02_F":
		 {
			[false, "red", [-0.85, -0.9, 0.6]] call _attach;// front left左前方
			[true, "blue", [0.85, -0.9, 0.6]] call _attach;//front right右前方
			[true, "red", [-0.93, -2.8, 0.6]] call _attach;// back left左后卫
			[false, "blue", [0.93, -2.8, 0.6]] call _attach;// back right右后方
			[false, "red",[-0.85, 1.475, -0.75]] call _attach; //left wing左翼
			[true, "blue",[0.85, 1.475, -0.75]] call _attach; //right wing右翼
		};
		case "I_MRAP_03_F":
		{
			[false, "red", [0.93, -3.2, 0]] call _attach; //right-back
			[false, "blue", [-1.3, 1.7, -0.2]] call _attach; //left-front
			[true, "red", [-0.93, -3.2, 0]] call _attach; //left-back
			[true, "red", [1.3, 1.7, -0.2]] call _attach; //right-front
	//		[true, "white", [-0.85, 2.35, -0.3]] call _attach; //left-front
	//		[false, "white", [0.85, 2.35, -0.3]] call _attach; //right-front
		};
		case "I_Truck_02_covered_F":
		{
			[false, "red", [0.7, -3.4, -1.25]] call _attach; //right-back
			[false, "blue", [-1.15, 2.4, -0.6]] call _attach; //left-front
			[true, "red", [-0.7, -3.4, -1.25]] call _attach; //left-back
			[true, "red", [1.15, 2.4, -0.6]] call _attach; //right-front
//			[true, "white", [-0.8, 3.6, -0.9]] call _attach; //left-front
//			[false, "white", [0.85, 3.6, -0.9]] call _attach; //right-front
		};
		case "C_Boat_Transport_02_F":
		{
			[false, "red", [-0.03, 0, 0]] call _attach;
			[true, "blue", [-0.03, 0, 0]] call _attach;
			[false, "red", [-0.8, -2.25, -0.3]] call _attach;
			[true, "red", [0.78, -2.25, -0.3]] call _attach;
	//		[false, "white", [0.75, 1.615, -0.52]] call _attach;
	//		[true, "white", [-0.8, 1.615, -0.525]] call _attach;
		};
		case "B_SDV_01_F": {
			[false, "red", [-.40812, 0, -.5]] call _attach;
			[false, "blue", [.40812, 0, -.5]] call _attach;
			[true, "red", [.40812, 0, -.5]] call _attach;
			[true, "blue", [-.40812, 0, -.5]] call _attach;
//			[true, "white", [-.40812, -2.75558, -1]] call _attach;
//			[false, "white", [.40812, -2.75558, -1]] call _attach;
		};
		case "C_Scooter_Transport_01_F":
		{
			[false, "red", [-0.18, 0.95, -0.55]] call _attach;
			[true, "blue", [0.12, 0.95, -0.55]] call _attach;
			[false, "red", [-0.15, -0.9, -0.8]] call _attach;
			[true, "blue", [0.09, -0.9, -0.8]] call _attach;
	//		[false, "white", [-0.18, 1.4, -0.75]] call _attach;
//			[true, "white", [0.12, 1.4, -0.75]] call _attach;
		};
		case "B_G_Van_02_vehicle_F": {
			[false, "red", [-0.57,-3.20,0.73]] call _attach; //right-back
			[false, "blue", [0.71,2.26,0.74]] call _attach; //left-front
			[true, "red", [-0.71,2.26,0.74]] call _attach; //left-front
			[true, "blue", [0.57,-3.20,0.73]] call _attach; //right-back
	//		[true, "white", [-0.74,3.88,-0.56]] call _attach; //left-front
	//		[false, "white", [0.74,3.88,-0.56]] call _attach; //right-front
		};
		case "B_G_Van_02_transport_F": {
			[false, "red", [-0.57,-3.20,0.73]] call _attach; //right-back
			[false, "blue", [0.71,2.26,0.74]] call _attach; //left-front
			[true, "red", [-0.71,2.26,0.74]] call _attach; //left-front
			[true, "blue", [0.57,-3.20,0.73]] call _attach; //right-back
//			[true, "white", [-0.74,3.88,-0.56]] call _attach; //left-front
//			[false, "white", [0.74,3.88,-0.56]] call _attach; //right-front
		};
		case "B_Quadbike_01_F": {
			[false, "red", [-0.32, 1, -0.65]] call _attach;
			[true, "blue",[0.32, 1, -0.65]] call _attach;
		};
		case "B_LSV_01_unarmed_black_F": {
			[false, "red", [0.77, 2.1, -0.9]] call _attach;// front right
			[true, "blue", [-0.7, 2.1, -0.9]] call _attach;//front left
			[false, "blue", [-.7, -2.1, -0.8]] call _attach;// back left
			[true, "red", [.8, -2.1, -0.8]] call _attach;// back right
		};
		case "O_LSV_02_unarmed_viper_F": {
			[false, "red", [0.5, 2.2, -0.45]] call _attach;// front right
			[true, "blue", [-0.8, 2.2, -0.45]] call _attach;//front left
			[false, "blue", [-1, -2.4, -0.45]] call _attach;// back left
			[true, "red", [.7, -2.4, -0.45]] call _attach;// back right
		};
		case "C_Plane_Civil_01_racing_F": {
			[false, "red", [-1.87, 1.34, -0.78]] call _attach;// front left
			[true, "blue", [1.9, 1.34, -0.78]] call _attach;//front right
		};
		case "C_Plane_Civil_01_F": {
			[false, "red", [-1.87, 1.34, -0.78]] call _attach;// front left
			[true, "blue", [1.9, 1.34, -0.78]] call _attach;//front right
		};
		case "I_C_Offroad_02_LMG_F": {
			[false, "red", [0.45,2,-1]] call _attach;// front right
			[true, "blue", [-0.55,2,-1]] call _attach;//front left
			[false, "blue", [-0.75,-1.65,-1]] call _attach;// back left
			[true, "red", [0.67,-1.65,-1]] call _attach;// back right
		};
		case "C_Offroad_02_unarmed_F": {
			[false, "red", [0.45,2,-1]] call _attach;// front right
			[true, "blue", [-0.55,2,-1]] call _attach;//front left
			[false, "blue", [-0.75,-1.65,-1]] call _attach;// back left
			[true, "red", [0.67,-1.65,-1]] call _attach;// back right
		};
		case "O_T_VTOL_02_infantry_F": {
			[false, "blue", [0.45,5.5,-1]] call _attach;// front left
			[true, "red", [-0.55,5.5,-1]] call _attach;//front right
			[false, "blue", [-1.4,-4.1,-1]] call _attach;// back left
			[true, "red", [1.4,-4.1,-1]] call _attach;// back right
			[false, "red",[-8.156,-0.708,-0.8]] call _attach; //left wing
			[true, "blue",[7.843,-0.854,-0.8]] call _attach; //right wing
		};
		case "O_Heli_Transport_04_F": {
			[false, "red", [-1.87, 1.34, -0.78]] call _attach;// front left
			[true, "blue", [1.9, 1.34, -0.78]] call _attach;//front right
		};
		case "O_Heli_Transport_04_bench_F": {
			[false, "red", [-1.87, 1.34, -0.78]] call _attach;// front left
			[true, "blue", [1.9, 1.34, -0.78]] call _attach;//front right
		};
		case "O_Heli_Transport_04_covered_F": {
			[false, "red", [-1.87, 1.34, -0.78]] call _attach;// front left
			[true, "blue", [1.9, 1.34, -0.78]] call _attach;//front right
		};
	};
	while {(alive _vehicle)} do
	{
		if (!(_vehicle getVariable ["lights",false])) exitWith {};
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
	{ deleteVehicle (_x select 0) } foreach _lightsLeft;
	{ deleteVehicle (_x select 0) } foreach _lightsRight;
	_lightsLeft = [];
	_lightsRight = [];
} else {
	private ["_lightRed","_lightBlue","_lightleft","_lightright","_leftRed"];
	if(isNil "_vehicle" || isNull _vehicle || !(_vehicle getVariable "lights")) exitWith {};
	_lightRed = [20, 0.1, 0.1];
	_lightBlue = [0.1, 0.1, 20];

	_lightleft = "#lightpoint" createVehicleLocal getpos _vehicle;
	uiSleep 0.2;
	_lightleft setLightColor _lightRed;
	_lightleft setLightBrightness 0.2;
	_lightleft setLightAmbient [0.1,0.1,1];

	switch (typeOf _vehicle) do
	{
		case "B_Heli_Light_01_F":		   {_lightleft lightAttachObject [_vehicle, [-0.37, 0.0, 0.56]];};
		case "B_Heli_Transport_01_F":	   {_lightleft lightAttachObject [_vehicle, [-0.75, -0.4, -1.5]];};
		case "I_Heli_light_03_unarmed_F":   {_lightleft lightAttachObject [_vehicle, [-0.55, 0.85, -1.5]];};
		case "O_Heli_Light_02_unarmed_F":   {_lightleft lightAttachObject [_vehicle, [-0.45, 1.5, -2]];};
		case "B_Heli_Transport_03_unarmed_green_F":   {_lightleft lightAttachObject [_vehicle, [-0.8, 1.5, -2]];};
		case "B_Heli_Transport_03_F":   {_lightleft lightAttachObject [_vehicle, [-0.8, 1.5, -2]];};
		case "I_Heli_light_03_dynamicLoadout_F":   {_lightleft lightAttachObject [_vehicle, [-0.55, 0.85, 1]];};
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
		case "B_Heli_Light_01_F":		   {_lightright lightAttachObject [_vehicle, [0.37, 0.0, 0.56]];};
		case "B_Heli_Transport_01_F":	   {_lightright lightAttachObject [_vehicle, [0.8, -0.4, -1.5]];};
		case "I_Heli_light_03_unarmed_F":   {_lightright lightAttachObject [_vehicle, [0.55, 0.85, -1.5]];};
		case "O_Heli_Light_02_unarmed_F":   {_lightright lightAttachObject [_vehicle, [0.45, 1.5, -2]];};
		case "B_Heli_Transport_03_unarmed_green_F":   {_lightright lightAttachObject [_vehicle, [0.8, 1.5, -2]];};
		case "B_Heli_Transport_03_F":   {_lightright lightAttachObject [_vehicle, [0.8, 1.5, -2]];};
		case "I_Heli_light_03_dynamicLoadout_F":   {_lightright lightAttachObject [_vehicle, [0.55, 0.85, 1]];};
	};

	_lightright setLightAttenuation [0.181, 0, 1000, 130];
	_lightright setLightIntensity 10;
	_lightright setLightFlareSize 0.38;
	_lightright setLightFlareMaxDistance 150;
	_lightright setLightUseFlare true;

	_lightleft setLightDayLight true;
	_lightright setLightDayLight true;

	_leftRed = true;
	while {(alive _vehicle)} do
	{
		if(!(_vehicle getVariable "lights")) exitWith {};
		if(_leftRed) then
		{
			_leftRed = false;
			_lightright setLightBrightness 0.0;
			_lightleft setLightBrightness 3;
			uiSleep 0.07;
		} else {
			_leftRed = true;
			_lightleft setLightBrightness 0.0;
			_lightright setLightBrightness 3;
			uiSleep 0.07;
		};
		uiSleep (_this select 1);
	};
	deleteVehicle _lightleft;
	deleteVehicle _lightright;
};
