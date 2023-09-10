//	Author: Thomas Ryan, Heavily modified by Poseidon
//  File: fn_cameraStandby.sqf

private ["_tgt", "_txt", "_alt", "_rad", "_ang", "_dir","_date","_endTime"];
_txt = [_this, 0, "", [""]] call BIS_fnc_param;
_date = [_this, 1, date, [[]]] call BIS_fnc_param;
_endTime = [_this, 2, (time+30), [0]] call BIS_fnc_param;
_alt = 200;
_rad = 325;
_ang = random(360);
_dir = 0;

if(BIS_fnc_establishingShot_playing) exitWith {};
BIS_fnc_establishingShot_playing = true;

[] spawn{
	disableSerialization;
	while{true} do {
		waitUntil{!isNull (findDisplay 49) || !BIS_fnc_establishingShot_playing};
		if(!BIS_fnc_establishingShot_playing) exitWith {};
		((findDisplay 49) displayCtrl 301) ctrlEnable false;
		((findDisplay 49) displayCtrl 1010) ctrlEnable false;
		((findDisplay 49) displayCtrl 122) ctrlEnable false;
		((findDisplay 49) displayCtrl 1002) ctrlEnable false;
		((findDisplay 49) displayCtrl 103) ctrlEnable false;
		sleep 0.25;
	};
};

["BIS_fnc_establishingShot",false] call BIS_fnc_blackOut;

// Apply post-process effects
private ["_ppBlur"];
_ppBlur = ppEffectCreate ["RadialBlur", 2015];
_ppBlur ppEffectEnable true;
_ppBlur ppEffectAdjust [0.005, 0.005, 0, 0];
_ppBlur ppEffectCommit 0;

private ["_ppColor"];
_ppColor = ppEffectCreate ["colorCorrections", 1999];
_ppColor ppEffectEnable true;
_ppColor ppEffectAdjust [1, 1.075, -0.065, [0.4, 0.25, 0.2, -0.15], [0.8, 0.725, 0.625, 1.17], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];
_ppColor ppEffectCommit 0;

private ["_ppGrain"];
_ppGrain = ppEffectCreate ["filmGrain", 2012];
_ppGrain ppEffectEnable true;
_ppGrain ppEffectAdjust [0.1, 1, 1, 0, 1];
_ppGrain ppEffectCommit 0;

private ["_pos", "_coords","_availablePositions"];
_availablePositions = [
	[3581.3,13067.5,0],
	[16779.5,12688.7,0],
	[14043.6,18734.5,0]
];
_pos = (_availablePositions call BIS_fnc_selectRandom);
_tgt = nearestObject _pos;
_coords = [_pos, _rad, _ang] call BIS_fnc_relPos;
_coords set [2, _alt];

BIS_fnc_establishingShot_fakeUAV = "Camera" camCreate [10,10,10];
BIS_fnc_establishingShot_fakeUAV cameraEffect ["INTERNAL", "BACK"];

cameraEffectEnableHUD true;

BIS_fnc_establishingShot_fakeUAV camPrepareTarget _tgt;
BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
BIS_fnc_establishingShot_fakeUAV camPrepareFOV 0.700;
BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0;
BIS_fnc_establishingShot_fakeUAV camPreload 3;

showCinemaBorder false;

("BIS_layerEstShot" call BIS_fnc_rscLayer) cutRsc ["RscEstablishingShot", "PLAIN DOWN"];

waitUntil {!(isNull (uiNamespace getVariable "RscEstablishingShot"))};
waitUntil {camPreloaded BIS_fnc_establishingShot_fakeUAV};

// Create logic to play sounds
BIS_fnc_establishingShot_logic1 = "Land_ClutterCutter_small_F" createVehicleLocal [10,10,10];
BIS_fnc_establishingShot_logic2 = "Land_ClutterCutter_small_F" createVehicleLocal [10,10,10];
BIS_fnc_establishingShot_logic3 = "Land_ClutterCutter_small_F" createVehicleLocal [10,10,10];

[] spawn{
	scriptName "BIS_fnc_establishingShot: UAV sound loop";

	// Determine duration
	private ["_sound", "_duration"];
	_sound = "UAV_loop";
	_duration = getNumber (configFile >> "CfgSounds" >> _sound >> "duration");

	while {!(isNull BIS_fnc_establishingShot_logic1)} do {
		BIS_fnc_establishingShot_logic1 say _sound;
		sleep _duration;

		if (!(isNull BIS_fnc_establishingShot_logic2)) then {
			BIS_fnc_establishingShot_logic2 say _sound;
			sleep _duration;
		};
	};
};

[] spawn{
	scriptName "BIS_fnc_establishingShot: random sounds control";

	while {!(isNull BIS_fnc_establishingShot_logic3)} do {
		// Choose random sound
		private ["_sound", "_duration"];
		_sound = format ["UAV_0%1", round (1 + random 8)];
		_duration = getNumber (configFile >> "CfgSounds" >> _sound >> "duration");

		BIS_fnc_establishingShot_logic3 say _sound;

		sleep (_duration + (5 + random 5));
	};
};

// Move camera in a circle
[_pos, _alt, _rad, _ang, _dir] spawn{
	scriptName "BIS_fnc_establishingShot: camera control";

	private ["_pos", "_alt", "_rad", "_ang", "_dir"];
	_pos = _this select 0;
	_alt = _this select 1;
	_rad = _this select 2;
	_ang = _this select 3;
	_dir = _this select 4;

	while{BIS_fnc_establishingShot_playing} do {
		private ["_coords"];
		_coords = [_pos, _rad, _ang] call BIS_fnc_relPos;
		_coords set [2, _alt];

		BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
		BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0.05;

		waitUntil {!BIS_fnc_establishingShot_playing || {camCommitted BIS_fnc_establishingShot_fakeUAV}};
		if(!BIS_fnc_establishingShot_playing) exitWith {};

		BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
		BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0;

		_ang = if (_dir == 0) then {_ang - 0.1} else {_ang + 0.1};
	};
};

sleep 1;

enableEnvironment true;
2 fadeSound 1;

// Static fade-in
("BIS_layerStatic" call BIS_fnc_rscLayer) cutRsc ["RscStatic", "PLAIN DOWN"];
waitUntil {!(isNull (uiNamespace getVariable "RscStatic_display")) || !(isNil "BIS_fnc_establishingShot_skip")};
waitUntil {isNull (uiNamespace getVariable "RscStatic_display")  || !(isNil "BIS_fnc_establishingShot_skip")};

// Show interlacing
("BIS_layerInterlacing" call BIS_fnc_rscLayer) cutRsc ["RscInterlacing", "PLAIN DOWN"];

("BIS_fnc_blackOut" call BIS_fnc_rscLayer) cutText ["","PLAIN DOWN",10e10];

// Compile SITREP text
private ["_month", "_day", "_hour", "_minute"];
_month = str (_date select 1);
_day = str (_date select 2);
_hour = str (_date select 3);
_minute = str (_date select 4);

if (_date select 1 < 10) then {_month = format ["0%1", str (_date select 1)]};
if (_date select 2 < 10) then {_day = format ["0%1", str (_date select 2)]};
if (_date select 3 < 10) then {_hour = format ["0%1", str (_date select 3)]};
if (_date select 4 < 10) then {_minute = format ["0%1", str (_date select 4)]};

private ["_time", "_date"];
_time = format ["%1:%2 UTC", _hour, _minute];
_date = format ["%1-%2-%3", str(_date select 0), _month, _day];
_sideString = "";
switch(playerside) do {
	case civilian:{_sideString = "Civilian"};
	case west:{_sideString = "APD"};
	case independent:{_sideString = "Medic"};
	default {_sideString = ""};
};

_SITREP = [
	["Olympus Entertainment", ""],
	["", "<br/>"],
	[_date + " ", ""],
	[_time, "font = 'PuristaMedium'"],
	["", "<br/>"],
	[toUpper _txt, ""],
	["", "<br/>"],
	[toUpper _sideString,""]
];

//Display top left text
BIS_fnc_establishingShot_SITREP = [
	_SITREP,
	0.02 * safeZoneW + safeZoneX,
	0.02 * safeZoneH + safeZoneY,
	false,
	"<t align = 'left' size = '1.0' font = 'PuristaLight'>%1</t>"
] spawn BIS_fnc_typeText2;

waitUntil{time > _endTime};

if (!(isNil "BIS_fnc_establishingShot_SITREP")) then {
	terminate BIS_fnc_establishingShot_SITREP;
	["", 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
};

if (!(isNull (uiNamespace getVariable "RscEstablishingShot"))) then {
	((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlSetFade 1;
	((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlCommit 0;
};

{
	private ["_layer"];
	_layer = _x call BIS_fnc_rscLayer;
	_layer cutText ["", "PLAIN DOWN"];
} forEach ["BIS_layerEstShot", "BIS_layerStatic", "BIS_layerInterlacing"];

enableEnvironment false;


("BIS_fnc_blackOut" call BIS_fnc_rscLayer) cutText ["","BLACK FADED",10e10];

sleep 1;

BIS_fnc_establishingShot_fakeUAV cameraEffect ["TERMINATE", "BACK"];
BIS_fnc_establishingShot_playing = false;
ppEffectDestroy _ppColor;
ppEffectDestroy _ppGrain;
ppEffectDestroy _ppBlur;

camDestroy BIS_fnc_establishingShot_fakeUAV;

["BIS_fnc_establishingShot"] call BIS_fnc_blackIn;

enableEnvironment true;

{deleteVehicle _x;}forEach [BIS_fnc_establishingShot_logic1, BIS_fnc_establishingShot_logic2, BIS_fnc_establishingShot_logic3];

sleep 1;
BIS_fnc_establishingShot_fakeUAV = nil;