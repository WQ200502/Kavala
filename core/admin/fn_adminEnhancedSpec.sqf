#include "..\..\macro.h"
// File: fn_adminEnhancedSpec.sqf
// Author: TheCmdrRex
// Description: Allows admins to spectate players using the newer arma spectate model.
// 			More confinent to find hackers, however it doesn't allow for keydown actions and it removes server UI.

if(__GETC__(life_adminlevel) < 2) exitWith {hint "Insufficient Permissions";};

private _settings = [
player, 	// target that spectates possible that this may be the first target at selection though
[], 		// Whitelisted sides, empty means all
true, 		// Whether AI can be viewed by the spectator
true, 		// Whether Free camera mode is available
true, 		// Whether 3th Person Perspective camera mode is available
false, 		// Whether to show Focus Info stats widget
true, 		// Whether or not to show camera buttons widget
true, 		// Whether to show controls helper widget
false, 		// Whether to show header widget
true 		// Whether to show entities / locations lists
];

["Initialize", _settings] call BIS_fnc_EGSpectator;
[[0,player],'OES_fnc_adminInvis',false,false] spawn OEC_fnc_MP;

hint format["You are now spectating using the Enhanced Spectating menu. \n Normal actions may not work in this spectate format.\n\n Press F10 to stop Spectating."];

uiSleep 2;

exitSpecEH = (findDisplay 60492) displayAddEventHandler ["KeyDown", {
	_key = _this select 1;
	_handled = false;
	if (_key isEqualTo ((actionKeys "User13") select 0)) exitWith {
		if(call(life_adminlevel) > 0) then {
			['life_admin_menu'] spawn OEC_fnc_createDialog;
		};
	};

	//F24 key
	if (_key in [118]) then {player setPosATL positionCameraToWorld [0,0,0]};

	if !(_key in [68]) exitWith {};
	(findDisplay 60492) displayRemoveEventHandler ["KeyDown", exitSpecEH];
	["Terminate"] call BIS_fnc_EGSpectator;
	if !(player getVariable ["invis", false]) then {
		[1,player] remoteExec ['OES_fnc_adminInvis',2];
	};
	hint "You have stopped spectating";
	_handled
}];

[
	["event", "ADMIN Enhanced Spectate On"],
	["player", name player],
	["player_id", getPlayerUID player],
	["position", getPos player]
] call OEC_fnc_logIt;
