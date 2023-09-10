//  File: fn_loadEventActions
//	Description: Populates the actions list for the specified event
private["_display","_eventProcedureList","_eventMarkerName","_eventLocation","_eventType","_selectedPlayers","_availablePlayers","_side"];
disableSerialization;

_display = findDisplay 50000;
_eventType = lbData[50003,lbCurSel (50003)];
_eventLocation = lbData[50004,lbCurSel (50004)];
_eventProcedureList = _display displayCtrl 50006;
_eventMarkerName = format["eventMarker_%1_%2",_eventType,_eventLocation];

lbClear _eventProcedureList;

_eventProcedureList lbAdd "TP Selected Player";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"tpHighlighted"];

_eventProcedureList lbAdd "TP ALL Participants";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"tpAllSelected"];

_eventProcedureList lbAdd "Kill Selected Player";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"killHighlighted"];

_eventProcedureList lbAdd "Heal and Force Feed Participants";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"replenishParticipants"];

_eventProcedureList lbAdd "Service Selected Players Vehicle";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"serviceSelected"];

_eventProcedureList lbAdd "Drain Selected Players Fuel";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"drainSelected"];


switch (_eventType) do {
	case "derby": {
		_eventProcedureList lbAdd "--------------------------------------";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

		_eventProcedureList lbAdd "~~ Spawn Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"spawnVehicles"];

		_eventProcedureList lbAdd "--------------------------------------";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

		_eventProcedureList lbAdd "Unlock Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"unlockVehicles"];

		_eventProcedureList lbAdd "Service Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"serviceVehicles"];

		//_eventProcedureList lbAdd "Drain Vehicles Fuel";
		//_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"drainVehicles"];
	};

	case "race": {
		_eventProcedureList lbAdd "--------------------------------------";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

		_eventProcedureList lbAdd "~~ Spawn Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"spawnVehicles"];

		_eventProcedureList lbAdd "~~ Spawn Race Gear Crate";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"spawnCrateRace"];

		_eventProcedureList lbAdd "~~ Spawn Race Objects";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"spawnObjects"];

		_eventProcedureList lbAdd "--------------------------------------";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

		_eventProcedureList lbAdd "Unlock Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"unlockVehicles"];

		_eventProcedureList lbAdd "Service Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"serviceVehicles"];

		//_eventProcedureList lbAdd "Drain Vehicles Fuel";
		//_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"drainVehicles"];
	};

	case "escort": {
		_eventProcedureList lbAdd "--------------------------------------";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

		_eventProcedureList lbAdd "~~ Spawn Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"spawnVehicles"];

		_eventProcedureList lbAdd "~~ Spawn Escort Gear";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"spawnCrateEscort"];

		_eventProcedureList lbAdd "--------------------------------------";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

		_eventProcedureList lbAdd "Unlock Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"unlockVehicles"];

		_eventProcedureList lbAdd "Service Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"serviceVehicles"];

		//_eventProcedureList lbAdd "Drain Vehicles Fuel";
		//_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"drainVehicles"];
	};

	case "lastman": {
		_eventProcedureList lbAdd "Wipe Participants Gear";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"wipeParticipantsGear"];

		_eventProcedureList lbAdd "--------------------------------------";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

		_eventProcedureList lbAdd "~~ Spawn Selected Crates";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"spawnCrateLastMan"];

	};

	case "dogfight": {
		_eventProcedureList lbAdd "--------------------------------------";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

		_eventProcedureList lbAdd "~~ Spawn Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"spawnVehicles"];

		_eventProcedureList lbAdd "--------------------------------------";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

		_eventProcedureList lbAdd "Unlock Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"unlockVehicles"];

		_eventProcedureList lbAdd "Service Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"serviceVehicles"];

		//_eventProcedureList lbAdd "Drain Vehicles Fuel";
		//_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"drainVehicles"];
	};



	case "tankbattle": {
		_eventProcedureList lbAdd "--------------------------------------";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

		_eventProcedureList lbAdd "~~ Spawn Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"spawnVehicles"];

		_eventProcedureList lbAdd "--------------------------------------";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

		_eventProcedureList lbAdd "Unlock Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"unlockVehicles"];

		_eventProcedureList lbAdd "Service Vehicles";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"serviceVehicles"];

	};



	case "ctf":{
		lbClear _eventProcedureList;

		_eventProcedureList lbAdd "TELEPORT PLAYERS TO EVENT";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"TP"];

		_eventProcedureList lbAdd "SET UP EVENT";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"setUp"];

		_eventProcedureList lbAdd "START EVENT";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"start"];

	};

	case "roulette":{
		lbClear _eventProcedureList;

		_eventProcedureList lbAdd "SPAWN EVENT DOME";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"setUp"];

		_eventProcedureList lbAdd "TELEPORT PLAYERS TO EVENT";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"TP"];

		_eventProcedureList lbAdd "START EVENT";
		_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"start"];
	};
};

_eventProcedureList lbAdd "--------------------------------------";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

_eventProcedureList lbAdd "Toggle Event ESP";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"toggleEventESP"];

_eventProcedureList lbAdd "--------------------------------------";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"-spacer-"];

_eventProcedureList lbAdd "Cleanup Event Vehicles";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"cleanupVehicles"];

_eventProcedureList lbAdd "Cleanup Event Crates";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"cleanupCrates"];

_eventProcedureList lbAdd "Cleanup Event Objects";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"cleanupObjects"];

_eventProcedureList lbAdd "Cleanup Entire Event";
_eventProcedureList lbSetData [(lbSize _eventProcedureList) - 1,"cleanupEvent"];

_eventProcedureList lbSetCurSel 0;
