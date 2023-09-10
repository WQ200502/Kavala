#include <zmacro.h>
//	Original Author: Kurt
//  Colored Titles: ikiled
//	File: fn_refreshTitleView.sqf

disableSerialization;
if (!dialog) exitWith {diag_log "Could not find dialog."}; //cancel if no dlg

private _display = findDisplay 41250;
if (isNull _display) exitWith {};

private _listBox = 41252;
private _listBoxControl = _display displayCtrl _listBox;
private _coloredTitles = 41258;
private _coloredTitlesControl = _display displayCtrl _coloredTitles;
private _selectedIndex = lbCurSel _listBox;
private _copFaction = missionConfigFile >> "CfgTitleCop";
private _specialFaction = missionConfigFile >> "CfgTitleSpecial";
private _civFaction = missionConfigFile >> "CfgTitleCiv";
private _medicFaction = missionConfigFile >> "CfgTitleMedic";
private _serverBest = missionConfigFile >> "CfgTitleServerBest";

private _donorLevel = (__GETC__(oev_donator));
private _desApproved = (__GETC__(oev_designerlevel) >= 2);
private _devApproved = (__GETC__(oev_developerlevel) >= 2);
private _supApproved = (__GETC__(life_supportlevel) >= 1);
private _srStaffApproved = (__GETC__(life_adminlevel) isEqualTo 4);
private _staffApproved = (__GETC__(life_adminlevel) >= 3);
private _civCouncilApproved = (__GETC__(oev_civcouncil) > 0);

lbClear _coloredTitlesControl;
lbClear _listBox;
//Assembling the titles in the list box
//Civ
//private _factionIndex = lbAdd [_listBox, "-Civilian-"];
//lbSetColor [_listBox,_factionIndex,[0.8,0,0.8,1]];
//lbSetData [_listBox,_factionIndex,"title"];
for "_i" from 0 to ((count  _civFaction) - 1) do {
	//Get title information: 0 - (Bool) Does player have it? 1 - (int) What is their progress on it? i.e. Player has 15 epipen revives, 10 are required for a title; Result: [true,15]
	private _titleProgress = [getText(( _civFaction select _i) >> "title")] call OEC_fnc_titleCheck;
	if (_titleProgress select 0) then {
		private _index = lbAdd [_listBox, getText(( _civFaction select _i) >> "title")];
		lbSetPicture [_listBox,_index,"images\icons\unlockedicon.paa"];
		lbSetPictureColor [_listBox, _index, [0.6,0.6,0.6,0.9]];
		lbSetData [_listBox, _index, "civ"];
		lbSetValue [_listBox, _index, _i];
		if (!(oev_currentTitle isEqualTo "") && (oev_currentTitle isEqualTo (getText(( _civFaction select _i) >> "title")))) then {
			lbSetColor [_listBox,_index,[0,0.8,0,1]];
		};
		lbSetTooltip [_listBox, _index, getText(( _civFaction select _i) >> "perk")];
	} else {
		private _index = lbAdd [_listBox, "Locked - Civilian"];
		lbSetPicture [_listBox,_index,"images\icons\lockedicon.paa"];
		lbSetPictureColor [_listBox, _index, [0.4,0.4,0.4,0.9]];
		lbSetColor [_listBox,_index,[1,0,0,1]];
		lbSetData [_listBox, _index, "civ"];
		lbSetValue [_listBox, _index, _i];
		lbSetTooltip [_listBox, _index, getText(( _civFaction select _i) >> "perk")];
	};
};
//private _factionIndex = lbAdd [_listBox, "-Cop-"];
//lbSetColor [_listBox,_factionIndex,	[0,0,1,1]];
//lbSetData [_listBox,_factionIndex,"title"];
//Cop
for "_i" from 0 to ((count  _copFaction) - 1) do {
	private _titleProgress = [getText(( _copFaction select _i) >> "title")] call OEC_fnc_titleCheck;
	if (_titleProgress select 0) then {
		private _index = lbAdd [_listBox, getText(( _copFaction select _i) >> "title")];
		lbSetPicture [_listBox,_index,"images\icons\unlockedicon.paa"];
		lbSetPictureColor [_listBox, _index, [0.6,0.6,0.6,0.9]];
		lbSetData [_listBox, _index, "cop"];
		lbSetValue [_listBox, _index, _i];
		if (!(oev_currentTitle isEqualTo "") && (oev_currentTitle isEqualTo (getText(( _copFaction select _i) >> "title")))) then {
			lbSetColor [_listBox,_index,[0,0.8,0,1]];
		};
		lbSetTooltip [_listBox, _index, getText(( _copFaction select _i) >> "perk")];
	} else {
		private _index = lbAdd [_listBox, "Locked - Cop"];
		lbSetPicture [_listBox,_index,"images\icons\lockedicon.paa"];
		lbSetPictureColor [_listBox, _index, [0.4,0.4,0.4,0.9]];
		lbSetColor [_listBox,_index,[1,0,0,1]];
		lbSetData [_listBox, _index, "cop"];
		lbSetValue [_listBox, _index, _i];
		lbSetTooltip [_listBox, _index, getText(( _copFaction select _i) >> "perk")];
	};
};
//private _factionIndex = lbAdd [_listBox, "Medic"];
//lbSetColor [_listBox,_factionIndex,[0,0.8,0,1]];
//lbSetData [_listBox,_factionIndex,"title"];
//Medic
for "_i" from 0 to ((count  _medicFaction) - 1) do {
	private _titleProgress = [getText(( _medicFaction select _i) >> "title")] call OEC_fnc_titleCheck;
	if (_titleProgress select 0) then {
		private _index = lbAdd [_listBox, getText(( _medicFaction select _i) >> "title")];
		lbSetPicture [_listBox,_index,"images\icons\unlockedicon.paa"];
		lbSetPictureColor [_listBox, _index, [0.6,0.6,0.6,0.9]];
		lbSetData [_listBox, _index, "medic"];
		lbSetValue [_listBox, _index, _i];
		if (!(oev_currentTitle isEqualTo "") && (oev_currentTitle isEqualTo (getText(( _medicFaction select _i) >> "title")))) then {
			lbSetColor [_listBox,_index,[0,0.8,0,1]];
		};
		lbSetTooltip [_listBox, _index, getText(( _medicFaction select _i) >> "perk")];
	} else {
		private _index = lbAdd [_listBox, "Locked - Medic"];
		lbSetPicture [_listBox,_index,"images\icons\lockedicon.paa"];
		lbSetPictureColor [_listBox, _index, [0.4,0.4,0.4,0.9]];
		lbSetColor [_listBox,_index,[1,0,0,1]];
		lbSetData [_listBox, _index, "medic"];
		lbSetValue [_listBox, _index, _i];
		lbSetTooltip [_listBox, _index, getText(( _medicFaction select _i) >> "perk")];
	};
};
//private _factionIndex = lbAdd [_listBox, "Special"];
//lbSetColor [_listBox,_factionIndex,[0.85,0.4,0,1]];
//lbSetData [_listBox,_factionIndex,"title"];
//Special
for "_i" from 0 to ((count  _specialFaction) - 1) do {
	private _titleProgress = [getText(( _specialFaction select _i) >> "title")] call OEC_fnc_titleCheck;
	if (_titleProgress select 0) then {
		private _index = lbAdd [_listBox, getText(( _specialFaction select _i) >> "title")];
		lbSetPicture [_listBox,_index,"images\icons\unlockedicon.paa"];
		lbSetPictureColor [_listBox, _index, [0.6,0.6,0.6,0.9]];
		lbSetData [_listBox, _index, "special"];
		lbSetValue [_listBox, _index, _i];
		if (!(oev_currentTitle isEqualTo "") && (oev_currentTitle isEqualTo (getText(( _specialFaction select _i) >> "title")))) then {
			lbSetColor [_listBox,_index,[0,0.8,0,1]];
		};
		lbSetTooltip [_listBox, _index, getText(( _specialFaction select _i) >> "perk")];
	};
	//Unable to see locked special titles, uncomment below to change that
	//else {
	//	private _index = lbAdd [_listBox, "Locked"];
	//	lbSetColor [_listBox,_index,[1,0,0,1]];
	//	lbSetData [_listBox, _index, "special"];
	//	lbSetValue [_listBox, _index, _i];
	//};
};
for "_i" from 0 to ((count  _serverBest) - 1) do {
	private _titleProgress = [getText(( _serverBest select _i) >> "title")] call OEC_fnc_titleCheck;
	if (_titleProgress select 0) then {
		private _index = lbAdd [_listBox, getText(( _serverBest select _i) >> "title")];
		lbSetPicture [_listBox,_index,"images\icons\unlockedicon.paa"];
		lbSetPictureColor [_listBox, _index, [0.6,0.6,0.6,0.9]];
		lbSetData [_listBox, _index, "server"];
		lbSetValue [_listBox, _index, _i];
		if (!(oev_currentTitle isEqualTo "") && (oev_currentTitle isEqualTo (getText(( _serverBest select _i) >> "title")))) then {
			lbSetColor [_listBox,_index,[0,0.8,0,1]];
		};
		lbSetTooltip [_listBox, _index, getText(( _serverBest select _i) >> "perk")];
	};
	//Unable to see locked special titles, uncomment below to change that
	//else {
	//	private _index = lbAdd [_listBox, "Locked"];
	//	lbSetColor [_listBox,_index,[1,0,0,1]];
	//	lbSetData [_listBox, _index, "special"];
	//	lbSetValue [_listBox, _index, _i];
	//};
};
//Hide equip button
if (([oev_currentTitle] call OEC_fnc_titleCheck) select 0) then {
	(_display displayCtrl 41256) ctrlShow true;
};
if (_donorLevel < 15 && !(_srStaffApproved) && !(_desApproved) && !(_devApproved) && !(_supApproved) && !(_civCouncilApproved)) then {
	(_display displayCtrl 41259) ctrlEnable false;
};

_coloredTitlesList = [];

_coloredTitlesList append [["Default", '[217,217,217]']];

if (_desApproved) then {
	_coloredTitlesList append [["Designer",'[128,0,128]']];
};
if (_devApproved) then {
	_coloredTitlesList append [["Developer",'[0,204,102]']];
};
if (_supApproved || _srStaffApproved) then {
	_coloredTitlesList append [["Support Team",'[255,163,7]']];
};
if (_civCouncilApproved || _srStaffApproved) then {
	_coloredTitlesList append [["Civilian Council",'[147,29,121]']];
};
if (_staffApproved) then {
	_coloredTitlesList append [["Admin",'[251,0,0]']];
};


if (_donorLevel > 0 || _srStaffApproved) then {
	if (_donorLevel >= 15 || _srStaffApproved) then {
		_coloredTitlesList append [["Brown",'[76, 50, 26]']];
	};
	if (_donorLevel >= 30 || _srStaffApproved) then {
		_coloredTitlesList append [["Yellow",'[255,255,0]']];
	};
	if (_donorLevel >= 50 || _srStaffApproved) then {
		_coloredTitlesList append [["Blue",'[0,0,255]']];
		_coloredTitlesList append [["Dodger Blue",'[30,144,255]']];
		_coloredTitlesList append [["Light Blue",'[0,153,204]']];
		_coloredTitlesList append [["Turquoise",'[64,224,208]']];
	};
	if (_donorLevel >= 100 || _srStaffApproved) then {
		_coloredTitlesList append [["Hot Pink",'[255,105,180]']];
	};
	if (_donorLevel >= 250 || _srStaffApproved) then {
		_coloredTitlesList append [["Green",'[0,255,0]']];
	};
};
{
	private _index = _coloredTitlesControl lbAdd (_x select 0);
	_coloredTitlesControl lbSetData [_index,_x select 1];
} forEach _coloredTitlesList;
