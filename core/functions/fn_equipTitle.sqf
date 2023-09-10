//	Original Author: Kurt
//	File: fn_equipTitle.sqf
#include <zmacro.h>
if(scriptAvailable(10)) exitWith {hint "You must wait 10 seconds before changing your title again.";};
disableSerialization;
if (!dialog) exitWith {diag_log "Could not find dialog."};

private _display = findDisplay 41250;
if (isNull _display) exitWith {};

//Getting selected title data
private _listBox = 41252;
private _listBoxControl = _display displayCtrl _listBox;
private _selectedIndex = lbCurSel _listBox;

private _index = _listBoxControl lbValue _selectedIndex;
private _faction = _listBoxControl lbData _selectedIndex;
private _copFaction = missionConfigFile >> "CfgTitleCop";
private _specialFaction = missionConfigFile >> "CfgTitleSpecial";
private _civFaction = missionConfigFile >> "CfgTitleCiv";
private _medicFaction = missionConfigFile >> "CfgTitleMedic";
private _serverBest = missionConfigFile >> "CfgTitleServerBest";

private _exit = false;
private _inUse = false;
switch(_faction) do {
	case "civ": {
		private _civTitle = getText(( _civFaction select _index) >> "title");
		if !(([getText((_civFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 0) exitWith {_exit = true;};
		if (_civTitle isEqualTo oev_currentTitle) exitWith {_inUse = true;};
		oev_currentTitle = _civTitle;
	};
	case "cop": {
		private _copTitle = getText(( _copFaction select _index) >> "title");
		if !(([getText((_copFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 0) exitWith {_exit = true;};
		if (_copTitle isEqualTo oev_currentTitle) exitWith {_inUse = true;};
		oev_currentTitle =_copTitle;
	};
	case "medic": {
		private _medicTitle = getText(( _medicFaction select _index) >> "title");
		if !(([getText((_medicFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 0) exitWith {_exit = true;};
		if (_medicTitle isEqualTo oev_currentTitle) exitWith {_inUse = true;};
		oev_currentTitle = _medicTitle;
	};
	case "special": {
		private _specialTitle = getText(( _specialFaction select _index) >> "title");
		if !(([getText((_specialFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 0) exitWith {_exit = true;};
		if (_specialTitle isEqualTo oev_currentTitle) exitWith {_inUse = true;};
		oev_currentTitle = _specialTitle;
	};
	case "server": {
		private _serverTitle = getText(( _serverBest select _index) >> "title");
		if !(([getText((_serverBest select _index) >> "title")] call OEC_fnc_titleCheck) select 0) exitWith {_exit = true;};
		if (_serverTitle isEqualTo oev_currentTitle) exitWith {_inUse = true;};
		oev_currentTitle = _serverTitle;
	};
};
if (_exit) exitWith {closeDialog 0;};
//Unequip if they select the same title
if (_inUse) then {
	oev_currentTitle = "";
	player setVariable ["currentTitle","",true];
	["", getplayerUID player] remoteExec ["OES_fnc_updateTitle",2];
	ctrlSetText [41256, format["Equip"]];
} else {
	player setVariable ["currentTitle",oev_currentTitle,true];
	[oev_currentTitle, getplayerUID player] remoteExec ["OES_fnc_updateTitle",2];
	ctrlSetText [41256, format["Unequip"]];
};

//Assign global variable to player


//Refresh menu
[] spawn OEC_fnc_refreshTitleView;
