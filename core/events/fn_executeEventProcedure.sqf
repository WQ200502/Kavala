//	Description: Performs the selected task for the event
private["_display","_eventType","_eventLocation","_eventVehicles","_eventProcedure","_selectedPlayer","_serverActions","_eventMarkerPosition","_dam_obj"];
disableSerialization;

_display = findDisplay 50000;
_eventType = lbData[50003,lbCurSel (50003)];
_eventLocation = lbData[50004,lbCurSel (50004)];
_eventVehicles = lbData[50005,lbCurSel (50005)];
_eventProcedure = lbData[50006,lbCurSel (50006)];
_selectedPlayer = lbData[50002,lbCurSel (50002)];

if(_eventProcedure == "-spacer-") exitWith {};

if(_eventLocation == "myPosition") then {
	_eventMarkerPosition = (position player);
}else{
	_eventMarker = format["eventMarker_%1_%2",_eventType,_eventLocation];
	_eventMarkerPosition = (getMarkerPos(_eventMarker));
};

_selectedPlayer = call compile format["%1", _selectedPlayer];

_serverActions = ["drainVehicles","cleanupVehicles","cleanupCrates","cleanupObjects","tpAllSelected","unlockVehicles","serviceVehicles","replenishParticipants","foodAndThirstParticipants","wipeParticipantsGear","spawnRaceGear","startEvent","cleanupEvent"];
if(_eventProcedure in _serverActions) exitWith {[[player,_eventType,_eventLocation,_eventProcedure],"OES_fnc_executeEventAction",false,false] spawn OEC_fnc_MP;};

[[player,_eventType,_eventLocation,_eventProcedure],"OES_fnc_executeEventAction",false,false] spawn OEC_fnc_MP;

switch (_eventProcedure) do {
	case "tpSelf": {
		vehicle player setPos _eventMarkerPosition;
	};

	case "tpHighlighted": {
		if(isNil "_selectedPlayer") exitwith {};
		if(isNull vehicle _selectedPlayer) exitWith {};
		if(_selectedPlayer getVariable["restrained",false]) exitWith {hint format["%1 is currently restrained and cannot be teleported.", name _selectedPlayer];};
		if(_selectedPlayer distance getMarkerPos("debug_island_marker") < 600) exitWith {hint format["%1 is currently on debug island (probably dead) and cannot be teleported.", name _selectedPlayer];};
		if(_selectedPlayer distance [20893.4,19227.5,0] < 29) exitWith {hint format["%1 is currently in or at jail and cannot be teleported.", name _selectedPlayer];};
		if(vehicle _selectedPlayer == _selectedPlayer) then {
			hint format ["Sending %1 to event.", name _selectedPlayer];
		} else {
			hint format ["Sending %1 and their vehicle %2 to event.", name _selectedPlayer, typeOf vehicle _selectedPlayer];
		};

		uiSleep 0.5;
		vehicle _selectedPlayer setPos _eventMarkerPosition;
	};

	case "killHighlighted": {
		if(isNil "_selectedPlayer") exitwith {};
		if(isNull vehicle _selectedPlayer) exitWith {};
		if(vehicle _selectedPlayer == _selectedPlayer) then {
			_dam_obj = _selectedPlayer;
			_dam_obj setDamage 1;
			[
				["event","EVENT Kill Switched"],
				["player",name player],
				["player_id",getPlayerUID player],
				["target",name _selectedPlayer],
				["target_id",getPlayerUID _selectedPlayer],
				["position",getPosATL player],
				["target_position",getPosATL _selectedPlayer]
			] call OEC_fnc_logIt;
		} else {
			_dam_obj = (vehicle _selectedPlayer);
			_dam_obj setDamage 1;
		};
	};

	case "serviceSelected":{
		if(isNil "_selectedPlayer") exitwith {};
		if(isNull vehicle _selectedPlayer) exitWith {};
		if(vehicle _selectedPlayer == _selectedPlayer) exitWith {hint format["%1 is not in a vehicle.", name _selectedPlayer];};

		[["refuelAndRearm"],"OEC_fnc_executeOnOwner",_selectedPlayer,false] spawn OEC_fnc_MP;
	};

	case "drainSelected":{
		if(isNil "_selectedPlayer") exitwith {};
		if(isNull vehicle _selectedPlayer) exitWith {};
		if(vehicle _selectedPlayer == _selectedPlayer) exitWith {hint format["%1 is not in a vehicle.", name _selectedPlayer];};

		[["drainFuel"],"OEC_fnc_executeOnOwner",_selectedPlayer,false] spawn OEC_fnc_MP;
	};

	case "toggleEventESP":{
		oev_eventESP = !oev_eventESP;

		_log_event = "EVENT ESP On";
		if(oev_eventESP) then {
			hint "Event ESP Enabled. Blue = regular player, orange = event member.";
		}else{
			hint "Event ESP Disabled.";
			_log_event = "EVENT ESP Off";
		};
		[
			["event",_log_event],
			["player",name player],
			["player_id",getPlayerUID player],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
	};



	//Spawn crates/vehicles/objects
	case "spawnVehicles": {
		[[player,_eventType,_eventLocation,_eventVehicles],"OES_fnc_spawnEventVehicles",false,false] spawn OEC_fnc_MP;
	};

	case "spawnObjects": {
		[[player,_eventType,_eventLocation],"OES_fnc_spawnEventObjects",false,false] spawn OEC_fnc_MP;
	};

	case "spawnCrateLastMan": {
		[[player,_eventType,_eventLocation,_eventVehicles],"OES_fnc_spawnEventCrates",false,false] spawn OEC_fnc_MP;
	};

	case "spawnCrateRace": {
		[[player,_eventType,_eventLocation,"[""raceGear""]"],"OES_fnc_spawnEventCrates",false,false] spawn OEC_fnc_MP;
	};

	case "spawnCrateEscort": {
		[[player,_eventType,_eventLocation,"[""escort""]"],"OES_fnc_spawnEventCrates",false,false] spawn OEC_fnc_MP;
	};

	case "setUp":{
		switch(_eventType) do {
			case "ctf":{
				[[player,false,true,false,_eventLocation],"OES_fnc_captureTheFlagServer",false] call OEC_fnc_mp;
			};
			case "roulette":{
				[[player,true],"OES_fnc_rouletteServer",false] call OEC_fnc_mp;
			};
		};
	};

	case "TP":{
		switch(_eventType) do {
			case "ctf":{
				[[player,false,false,true,_eventLocation],"OES_fnc_captureTheFlagServer",false] call OEC_fnc_mp;
			};
			case "roulette":{
				[[player,false,true],"OES_fnc_rouletteServer",false] call OEC_fnc_mp;
			};
		};
	};

	case "start":{
		switch(_eventType) do {
			case "ctf":{
				[[player,true],"OES_fnc_captureTheFlagServer",false] call OEC_fnc_mp;
			};
			case "roulette":{
				[[player],"OES_fnc_rouletteServer",false] call OEC_fnc_mp;
			};
		};
	};


};
