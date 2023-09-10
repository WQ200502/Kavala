//	File: fn_syncData.sqf
//	Author: Bryan "Tonic" Boardwine"
//	Description: Used for player manual sync to the server. DESCRIPTIONEND

_fnc_scriptName = "Player Synchronization";
private["_exit"];
if(isNil "life_session_time") then {life_session_time = false;};
if(life_session_time) exitWith {hint localize "STR_Session_SyncdAlready";};

switch (typeName OEC_fnc_MP_packet) do
{
	case "ARRAY":
	{
		if(count OEC_fnc_MP_packet == 0) exitWith
		{
			_exit = true;
		};
	};

	default {_exit = true;};
};

if(!isNil "_exit") exitWith {hint localize "STR_Session_SyncCheater";};

[] call OEC_fnc_ClupdateRequest;
hint localize "STR_Session_SyncData";
[] spawn{
	life_session_time = true;
	uiSleep (5 * 60);
	life_session_time = false;
};
