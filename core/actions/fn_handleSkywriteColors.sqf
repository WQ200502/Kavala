// File: fn_handleSkywriteColors.sqf
// Author: grar21 with civaks help

private _currentVehicle = vehicle player;
life_skywriteColor = profileNamespace getVariable ["life_skywriteColor", ["White",'SmokeShell']];
oev_lastSkywrite = time + 60;

_positions = (switch (typeOf _currentVehicle) do {
	case "C_Plane_Civil_01_F": { [ [-5.4,0.3,-0.6], [5.4,0.3,-0.6] ] }; // caesar
	case "C_Plane_Civil_01_racing_F": { [ [-5.4,0.3,-0.6], [5.4,0.3,-0.6] ] }; // caesar btt (racing) / armed
	case "B_T_VTOL_01_vehicle_F": { [ [-16.5,1.7,-1], [16.5,1.7,-1] ] }; // V-44 X Blackfish (Vehicle Transport)
	case "B_T_VTOL_01_infantry_F": { [ [-16.5,1.7,-1], [16.5,1.7,-1] ] }; // V-44 X Blackfish (Vehicle Transport)
	case "O_Plane_CAS_02_F": { [ [-6.4,-3.8,-1.3], [6.4,-3.8,-1.3] ] }; // To-199 Neophron (CAS)
	case "B_Plane_CAS_01_F": { [ [-8.7,-0.98,0.1], [8.7,-0.98,0.1] ] }; // A-164 Wipeout (CAS)
	case "I_Plane_Fighter_03_CAS_F": { [ [-4.91,-1.8,-1.2], [4.91,-1.8,-1.2] ] }; // A-143 Buzzard (CAS)
	case "I_Plane_Fighter_04_F": { [ [-4.15,-4.35,-0.58], [4.15,-4.35,-0.58] ] }; // A-149 Gryphon
	case "B_Plane_Fighter_01_F": { [ [-6.52,-4.74,-0.57], [6.55,-4.74,-0.57] ] }; // F/A-181 Black Wasp II
	case "O_Plane_Fighter_02_F": { [ [-7,-7.7,0], [7,-7.7,0] ] };
	default { [ [0,0,0], [0,0,0] ] };
});

_smokes = [];

for "_i" from 1 to 3 do {
	_smokeLeft = createVehicle [life_skywriteColor,getPos _currentVehicle,[],0,"CAN_COLLIDE"];
	_smokeLeft attachTo [_currentVehicle,_positions select 0,""];
	_smokeLeft hideObjectGlobal true;
	_smokes pushBack _smokeLeft;

	_smokeRight = createVehicle [life_skywriteColor,getPos _currentVehicle,[],0,"CAN_COLLIDE"];
	_smokeRight attachTo [_currentVehicle,_positions select 1,""];
	_smokeRight hideObjectGlobal true;
	_smokes pushBack _smokeRight;
};

for "_i" from 1 to 60 do {
	if (isNull _currentVehicle) exitWith {{deleteVehicle _x} forEach _smokes};
	if (isNull driver _currentVehicle) exitWith {{deleteVehicle _x} forEach _smokes};
	uiSleep 1;
};
