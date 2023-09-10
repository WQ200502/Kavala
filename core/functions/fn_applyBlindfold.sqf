//	File: fn_applyblindfold.sqf
//	Author: Serpico
//	Description: Applies the required blindfold and restrictions to the player
private["_nameColor", "_priorityColor", "_effectColor", "_colorHandle","_nameChrome", "_priorityChrome", "_effectChrome", "_chromeHandle","_oldGoggles","_hndlBlur","_hasGPS"];
disableSerialization;
params["_targetPlayer"];

if !(player isEqualTo _targetPlayer) exitWith {};

// Check if the player has a GPS, if yes, remove it
_hasGPS = false;
if ("ItemGPS" in (items player + assignedItems player)) then {
	_hasGPS = true;
	player unlinkItem "ItemGPS";
};

// Save current googles, apply blindfold and black out the players screen
_oldGoggles = goggles player;
player addGoggles "G_Blindfold_01_black_F";
player setVariable ["blindfolded", true, true];
player switchCamera "INTERNAL";
cutText["A blindfold is obscuring your vision.","PLAIN DOWN"];

_nameColor = "ColorCorrections";
_priorityColor = 1500;
_effectColor = [
    0.8, 
    0.01, 
    0, 
    0, 0, 0, 0, 
    1, 1, 1, 0, 
    1, 1, 1, 0 
]; 


_nameChrome = "ChromAberration";
_priorityChrome = 200;
_effectChrome = [0.1, 0.05, true];

_colorHandle = ppEffectCreate ["ColorCorrections", _priorityColor];
_colorHandle ppEffectEnable true;
_colorHandle ppEffectAdjust _effectColor;
_colorHandle ppEffectCommit 0;

_hndlBlur = ppEffectCreate ["DynamicBlur", 501];
_hndlBlur ppEffectEnable true;
_hndlBlur ppEffectAdjust [10];
_hndlBlur ppEffectCommit 0;
waitUntil {
    ppEffectCommitted _hndlBlur
};

while {true} do {
	waitUntil {!(player getVariable ["blindfolded",false]) || !((goggles player) isEqualTo "G_Blindfold_01_black_F") || cameraView isEqualTo "EXTERNAL" || !isNull (findDisplay 49)};
	_videoButton = (findDisplay 49) displayCtrl 301;
	_videoButton ctrlEnable false;
	if !((goggles player) isEqualTo "G_Blindfold_01_black_F") exitWith {
		player setVariable ["blindfolded",false,true];
	};
	if !(player getVariable ["blindfolded",false]) exitWith {
		removeGoggles player;
	};
    player switchCamera "INTERNAL";
};

// Restore player to their previous state
_colorHandle ppEffectEnable false;
ppEffectDestroy _colorHandle;
_hndlBlur ppEffectEnable false;
ppEffectDestroy _hndlBlur;

removeGoggles player;
player addGoggles _oldGoggles;
player setVariable ["blindfolded",false,true];

if (_hasGPS) then {
	player linkitem "ItemGPS"
};
