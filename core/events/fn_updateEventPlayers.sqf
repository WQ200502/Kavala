//  File: fn_updateEventPlayers
//	Description: Updates the player lists in the event menu
private["_display","_text","_eventMarkerName","_eventLocation","_eventType","_selectedPlayers","_availablePlayers","_side","_sortedPlayers","_position"];
disableSerialization;
if(oev_eventMembersUpdating) exitWith {};
oev_eventMembersUpdating = true;

_display = findDisplay 50000;
_availablePlayers = _display displayCtrl 50001;
_selectedPlayers = _display displayCtrl 50002;
_eventType = lbData[50003,lbCurSel (50003)];
_eventLocation = lbData[50004,lbCurSel (50004)];
_eventMarkerName = format["eventMarker_%1_%2",_eventType,_eventLocation];
lbClear _availablePlayers;
lbClear _selectedPlayers;

_sortedPlayers = [];
{
	if(((_x getVariable ["isInEvent",["no"]]) select 0) == "no") then {
		_side = switch(side _x) do {case west: {"Cop"}; case civilian: {"Civ"}; case independent: {"Medic"}; default {"Unknown"};};
		_position = switch(true) do {
			case (_x distance getMarkerPos("debug_island_marker") < 500): {"Debug Island"};
			case (_x getVariable ["restrained",false]): {"Restrained"};
			case (_x distance [16697.6,13614.7,0] < 29): {"In Jail"};
			default {format["%1Km",(round(_x distance getMarkerPos(_eventMarkerName)) / 1000)]};
		};
		_sortedPlayers pushBack [format["%1 (%2) - %3", _x getVariable["realname",name _x],_side,_position],_x];
	};
}foreach playableUnits;
_sortedPlayers sort true;
{
	_availablePlayers lbAdd (_x select 0);
	_availablePlayers lbSetdata [(lbSize _availablePlayers)-1,str(_x select 1)];
}foreach _sortedPlayers;


_sortedPlayers = [];
{
	if(((_x getVariable ["isInEvent",["no"]]) select 0) != "no") then {
		_side = switch(side _x) do {case west: {"Cop"}; case civilian: {"Civ"}; case independent: {"Medic"}; default {"Unknown"};};
		_position = switch(true) do {
			case (_x distance getMarkerPos("debug_island_marker") < 500): {"Debug Island"};
			case (_x getVariable ["restrained",false]): {"Restrained"};
			case (_x distance [16697.6,13614.7,0] < 29): {"In Jail"};
			default {format["%1Km",(round(_x distance getMarkerPos(_eventMarkerName)) / 1000)]};
		};
		_sortedPlayers pushBack [format["%1 (%2) - %3 (%4)", _x getVariable["realname",name _x],_side,_position,((_x getVariable ["isInEvent", ["no"]]) select 0)],_x];
	};
}foreach playableUnits;
_sortedPlayers sort true;
{
	_selectedPlayers lbAdd (_x select 0);
	_selectedPlayers lbSetdata [(lbSize _selectedPlayers)-1,str(_x select 1)];
}foreach _sortedPlayers;

oev_eventMembersUpdating = false;

