//  File: fn_setDispatchData.sqf
//	Author: Serpico

params [
	["_status","",[""]],
	["_responderName","",[""]],
	["_responseType",3,[3]]
];

if (_responseType in [1,2,4]) then {
	// The below condition is true when the players remaining respawn lockout time
	// has not been modified.
	if ((oev_respawn_timer_start + 450) isEqualTo oev_respawn_timer) then {
		oev_respawn_timer = 30;
	};
};

life_corpse setVariable ["dispatchStatus",_status,true];
life_corpse setVariable ["dispatchOwner",_responderName,true];
life_corpse setVariable ["responseType",_responseType,true];
