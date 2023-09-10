//	File: fn_handleGlowLights.sqf
//	Author: Fusah
//	Description: Handles the light object for underglow.

params [
	["_pos",[0,0,0]],
	["_color",[0,0,0]],
	["_veh",objNull]
];

if (_pos isEqualTo [0,0,0]) then {
	switch (true) do {
		case (typeOf _veh in ["C_Hatchback_01_F","C_Hatchback_01_sport_F"]): {_pos = [0,-.3,-1.01]};
		case (typeOf _veh in ["C_Offroad_01_F","C_Offroad_01_repair_F","C_Offroad_02_unarmed_F","I_G_Offroad_01_AT_F"]): {_pos = [0,-0.3,-1.1]};
		case (typeOf _veh isEqualTo "C_SUV_01_F"): {_pos = [0,-0.2,-1.1]};
		case (typeOf _veh isEqualTo "O_MRAP_02_F"): {_pos = [0,-1.5,-1.01]};
		case (typeOf _veh isEqualTo "B_Quadbike_01_F"): {_pos = [0,0,0]};
		case (typeof _veh isEqualTo "I_MRAP_03_F"): {_pos = [0,-.4,-1.01]};
		case (typeof _veh isEqualTo "B_MRAP_01_F"): {_pos = [0,-1.6,-1.2]};
	};
};

private _light = "#lightpoint" createVehicleLocal [0,0,0];
_light setLightBrightness 1;
_light setLightAmbient [0,0,0];
_light setLightAttenuation [0.01,0,0,0];
private _sun = (sunOrMoon < 1);
if !(_sun) then {_light setLightIntensity 100} else {_light setLightIntensity 5};
_light setLightFlareSize 1;
_light setLightFlareMaxDistance 50;
_light setLightUseFlare false;
_light setLightDayLight true;
_light setLightColor _color;
_light attachTo [_veh, _pos];

uiSleep 0.5;


while {true} do {
	if (isNull _veh) exitWith {deleteVehicle _light};
	if !(_veh getVariable ['underActive',false]) exitWith {deleteVehicle _light};
	if (isNull _light) exitWith {[_pos,_color,_veh] spawn OEC_fnc_handleGlowLights}; //If glow randomly dissapears.
	private _sun = (sunOrMoon < 1);
	if !(_sun) then {_light setLightIntensity 100} else {_light setLightIntensity 5};
	uiSleep 1;
};
