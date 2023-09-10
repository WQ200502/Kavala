//  File: fn_getEventInfo.sqf
//	Description: Called when a new event is selected and returns a description, then updates player list so that their distance is updated to the new event location
private["_display","_text","_eventType","_eventLocation","_eventMarkerName","_selectedPlayers","_availablePlayers","_eventInfo","_exit"];
disableSerialization;
_exit = false;
_eventInfo = ["Select an event","Location:...","Description:..."];
_display = findDisplay 50000;
_availablePlayers = _display displayCtrl 50001;
_selectedPlayers = _display displayCtrl 50002;
_eventType = lbData[50003,lbCurSel (50003)];
_eventLocation = lbData[50004,lbCurSel (50004)];
_eventMarkerName = format["eventMarker_%1_%2",_eventType,_eventLocation];
_text = _display displayCtrl 50010;
if(isNil "_eventMarkerName") then {_exit = true;};
if(((getMarkerPos(_eventMarkerName) distance [0,0,0]) < 100) && _eventLocation != "myPosition") then {_exit = true;};

oev_eventMenuSelection = [lbCurSel 50003, lbCurSel 50004];

if(!_exit) then {
	switch(_eventType) do {
		case "derby": {
			_eventInfo = ["Demolition Derby",_eventLocation,"Ram cars into one another."];
		};

		case "race":{
			_eventInfo = ["Race",_eventLocation,"Race from start to finish."];
		};

		case "escort":{
			_eventInfo = ["Escort",_eventLocation,"Protect the VIP as you travel to a destination."];
		};

		case "lastman":{
			_eventInfo = ["Last Man Standing",_eventLocation,"Players scavenge the selected island for loot, and kill each other."];
		};

		case "dogfight":{
			_eventInfo = ["Air Battles",_eventLocation,"Players use jets and other air vehicles to fight each other."];
		};

		case "ctf":{
			_eventInfo = ["Capture the Flag",_eventLocation,"Players must capture the opposing team's flag. First team to 3 captures wins."];
		};

		case "roulette":{
			_eventInfo = ["Russian Roulette",_eventLocation,"Players are given a zubr with a random chance of receiving a bullet each round. Last man alive wins."];
		};

		case "tankbattle":{
			_eventInfo = ["tank Battles",_eventLocation,"Players use tank to fight each other."];
		};
	};
	[] spawn OEC_fnc_updateEventPlayers;
};

_text ctrlSetStructuredText parseText format["<t color='#ADFF2F'>%1</t><br/>%2<br/>%3",_eventInfo select 0, _eventInfo select 1, _eventInfo select 2];
