//  File: fn_hudSetup.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Setups the hud for the player?
private["_display","_ui"];
if(isServer && isDedicated) exitWith {};
disableSerialization;
_display = findDisplay 46;

2 cutRsc ["playerHUD","PLAIN DOWN"];
[] call OEC_fnc_hudUpdate;

if(oev_hudSetup) exitWith {};
oev_hudSetup = true;
LIFE_ID_PlayerTags = ["LIFE_PlayerTags","onEachFrame","OEC_fnc_playerTags"] call BIS_fnc_addStackedEventHandler;

[] spawn{
	private ["_dam","_eventStatus","_food","_water","_weight"];
	while {true} do{
		_dam = damage player;
		_eventStatus = (player getVariable ["isInEvent",["no"]]) select 0;
		_food = oev_hunger;
		_water = oev_thirst;
		_weight = oev_carryWeight;
		waitUntil {uiSleep 0.25; damage player != _dam || (player getVariable ["isInEvent",["no"]]) select 0 != _eventStatus || oev_hunger != _food || oev_thirst != _water || oev_carryWeight != _weight};
		[] call OEC_fnc_hudUpdate;
	};
};

[] spawn{
	_alvl = call life_adminlevel;
	_dlvl = call oev_developerlevel;
	while {_alvl > 0 || _dlvl > 0} do{
		private["_god","_esp","_stream","_fly","_invis","_stase"];
		_god = oev_godmode;
		_esp = oev_eventESP;
		_stream = oev_streamerMode;
		_fly = player getVariable["fly",false];
		_invis = player getVariable ["invis", false];
		_stase = player getVariable ["superTaze", false];
		waitUntil {uiSleep 1; (!(oev_godmode isEqualTo _god) || !(oev_eventESP isEqualTo _esp) || !(oev_streamerMode isEqualTo _stream) || !(player getVariable["fly",false] isEqualTo _fly) || !(player getVariable ["invis", false] isEqualTo _invis) || !(player getVariable ["superTaze", false] isEqualTo _stase))};
		[] call OEC_fnc_hudUpdate;
	};
};

"oev_conquestData" addPublicVariableEventHandler {
	if (alive player) then {
		if (oev_conquestData select 0 && getPos player inPolygon (oev_conquestData select 1 select 1)) then {
			if (uiNamespace getVariable ["conqHUD", displayNull] isEqualType displayNull) then {
				"conq" cutRsc ["conqHUD", "PLAIN"];
			};
			_ui = uiNamespace getVariable ["conqHUD", displayNull];
			(_ui displayCtrl 23800) ctrlSetText format["$%1", [oev_conquestData select 4] call OEC_fnc_numberText];
			if !(oev_gang_data isEqualTo [] || {(oev_conquestData select 2) find (oev_gang_data select 0) < 0}) then {
				(_ui displayCtrl 23804) ctrlSetText format["%1 - %2", oev_gang_data select 1, oev_conquestData select 3 select ((oev_conquestData select 2) find (oev_gang_data select 0))];
			};
			if ((((oev_conquestData select 6) select 0) select 0) != -1) then { //1st Place name
				(_ui displayCtrl 23801) ctrlSetText format["%1 - %2", ((oev_conquestData select 6) select 0) select 2, ((oev_conquestData select 6) select 0) select 1];
			} else {
				(_ui displayCtrl 23801) ctrlSetText "";
			};
			if ((((oev_conquestData select 6) select 1) select 0) != -1) then { //2nd Place name
				(_ui displayCtrl 23802) ctrlSetText format["%1 - %2", ((oev_conquestData select 6) select 1) select 2, ((oev_conquestData select 6) select 1) select 1];
			} else {
 				(_ui displayCtrl 23802) ctrlSetText "";
 			};
			if ((((oev_conquestData select 6) select 2) select 0) != -1) then { //3rd place name
				(_ui displayCtrl 23803) ctrlSetText format["%1 - %2", ((oev_conquestData select 6) select 2) select 2, ((oev_conquestData select 6) select 2) select 1];
			} else {
 				(_ui displayCtrl 23803) ctrlSetText "";
 			};
		} else {
			"conq" cutText ["", "PLAIN"];
		};
	};
};
