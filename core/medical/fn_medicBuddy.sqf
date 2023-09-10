// File: fn_medicBuddy.sqf
// Author: Jesse "tkcjesse" Schultz

params [
	["_inviter",objNull,[objNull]],
	["_pid","",[""]],
	["_mode",-1,[0]]
];

if (isNull _inviter || _pid isEqualTo "" || _mode isEqualTo -1) exitWith {};
if !(getPlayerUID _inviter isEqualTo _pid) exitWith {};
if !(playerSide isEqualTo independent) exitWith {};
if (!(isNull life_buddyObj) && _mode isEqualTo 0) exitWith {hint format ["%1 has invited you to buddy up. However you already have a buddy agreement with another player.",name _inviter];};

if (_mode isEqualTo 0) then {
	private _action = [
		format ["%1 has invited you to partner up. Would you like to accept the buddy agreement?",name _inviter],
		"Confirmation",
		"Yes",
		"No"
	] call BIS_fnc_guiMessage;

	if (_action) then {
		life_buddyObj = _inviter;
		life_buddyPID = _pid;
		[["life_buddyObj",player],"OEC_fnc_netSetVar",_inviter,false] spawn OEC_fnc_MP;
		[["life_buddyPID",getPlayerUid player],"OEC_fnc_netSetVar",_inviter,false] spawn OEC_fnc_MP;
		[[1,format["Your buddy request to %1 has been accepted.",name player]],"OEC_fnc_broadcast",_inviter,false] spawn OEC_fnc_MP;
	} else {
		[[1,format["Your buddy request to %1 has been declined.",name player]],"OEC_fnc_broadcast",_inviter,false] spawn OEC_fnc_MP;
	};
};

if (_mode isEqualTo 1) then {
	life_buddyObj = objNull;
	life_buddyPID = "";
	hint format ["%1 has ended their buddy agreement with you.",name _inviter];
	[[1,format["Your buddy agreement with %1 has been ended.",name player]],"OEC_fnc_broadcast",_inviter,false] spawn OEC_fnc_MP;
};