//  File: fn_loadEventTypes.sqf
//	Description: Loads all the available event types
private["_display","_eventTypeList"];
disableSerialization;
_display = findDisplay 50000;
_eventTypeList = _display displayCtrl 50003;

lbClear _eventTypeList;

//Maybe limit certain events to certain levels

_eventTypeList lbAdd "Demo Derby";
_eventTypeList lbSetData [(lbSize _eventTypeList) - 1,"derby"];

_eventTypeList lbAdd "Race";
_eventTypeList lbSetData [(lbSize _eventTypeList) - 1,"race"];

_eventTypeList lbAdd "Escort";
_eventTypeList lbSetData [(lbSize _eventTypeList) - 1,"escort"];

_eventTypeList lbAdd "Last Man";
_eventTypeList lbSetData [(lbSize _eventTypeList) - 1,"lastman"];

_eventTypeList lbAdd "Air Battles";
_eventTypeList lbSetData [(lbSize _eventTypeList) - 1,"dogfight"];

_eventTypeList lbAdd "Russian Roulette";
_eventTypeList lbSetData[(lbSize _eventTypeList) - 1, "roulette"];

_eventTypeList lbAdd "Tank Battle";
_eventTypeList lbSetData[(lbSize _eventTypeList) - 1, "tankbattle"];

_eventTypeList lbAdd "DONT USE: CTF";
_eventTypeList lbSetData [(lbSize _eventTypeList) - 1,"ctf"];

_eventTypeList lbSetCurSel (oev_eventMenuSelection select 0);
