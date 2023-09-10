//	Original Author: Kurt
//	File: fn_refreshTitleView.sqf

disableSerialization;
if (!dialog) exitWith {diag_log "Could not find dialog."}; //cancel if no dlg

private _display = findDisplay 41250;
if (isNull _display) exitWith {};

private _listBox = 41252;
private _listBoxControl = _display displayCtrl _listBox;
private _selectedIndex = lbCurSel _listBox;
private _copFaction = missionConfigFile >> "CfgTitleCop";
private _specialFaction = missionConfigFile >> "CfgTitleSpecial";
private _civFaction = missionConfigFile >> "CfgTitleCiv";
private _medicFaction = missionConfigFile >> "CfgTitleMedic";
private _serverFaction = missionConfigFile >> "CfgTitleServerBest";

if !(_selectedIndex isEqualTo -1) then {
	//Otherwise set data to selected entry
	private _index = _listBoxControl lbValue _selectedIndex;
	private _hasTitle = false;
	// Title info: 0 - Goal for title (int), 1 - Title description
	private _titleInfo = [0,""];
	// Title progress - Players current progress towards the title (if -1 then hides progress for non-int based titles)
	private _playerTitleProgress = 0;
	private _playerTitle = "";
	switch(_listBoxControl lbData _selectedIndex) do {
		case "civ": {
			//Set title info
			_titleInfo set [0,getNumber(( _civFaction select _index) >> "value")];
			_titleInfo set [1,getText(( _civFaction select _index) >> "desc")];
			if (([getText((_civFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 0) then {
				_hasTitle = true;
			};
			_playerTitleProgress = ([getText((_civFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 1;
			_playerTitle = getText((_civFaction select _index) >> "title");
		};
		case "cop": {
			_titleInfo set [0,getNumber(( _copFaction select _index) >> "value")];
			_titleInfo set [1,getText(( _copFaction select _index) >> "desc")];
			if (([getText((_copFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 0) then {
				_hasTitle = true;
			};
			_playerTitleProgress = ([getText((_copFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 1;
			_playerTitle = getText((_copFaction select _index) >> "title");
		};
		case "medic": {
			_titleInfo set [0,getNumber(( _medicFaction select _index) >> "value")];
			_titleInfo set [1,getText(( _medicFaction select _index) >> "desc")];
			if (([getText((_medicFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 0) then {
				_hasTitle = true;
			};
			_playerTitleProgress = ([getText((_medicFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 1;
			_playerTitle = getText((_medicFaction select _index) >> "title");
		};
		case "special": {
			_titleInfo set [0,getNumber(( _specialFaction select _index) >> "value")];
			_titleInfo set [1,getText(( _specialFaction select _index) >> "desc")];
			if (([getText((_specialFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 0) then {
				_hasTitle = true;
			};
			_playerTitleProgress = ([getText((_specialFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 1;
			_playerTitle = getText((_specialFaction select _index) >> "title");
		};
		case "server": {
			_titleInfo set [0,getNumber(( _serverFaction select _index) >> "value")];
			_titleInfo set [1,getText(( _serverFaction select _index) >> "desc")];
			if (([getText((_serverFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 0) then {
				_hasTitle = true;
			};
			_playerTitleProgress = ([getText((_serverFaction select _index) >> "title")] call OEC_fnc_titleCheck) select 1;
			_playerTitle = getText((_serverFaction select _index) >> "title");
		};
	};
	//Check whether or not they have the title to show the Equip button
	if (_hasTitle) then {
		ctrlSetText [41254, format["描述: %1", _titleInfo select 1]];
		if (_playerTitleProgress isEqualTo -1) then {
			ctrlSetText [41255, format[""]];
		} else {
			ctrlSetText [41255, format["进展: %1/%1", [_titleInfo select 0] call OEC_fnc_numberText]];
		};
		if (oev_currentTitle isEqualTo _playerTitle) then {
			ctrlSetText [41256, format["取消装备"]];
		} else {
			ctrlSetText [41256, format["装备"]];
		};
		(_display displayCtrl 41256) ctrlShow true;
	} else {
		if ((_listBoxControl lbData _selectedIndex) isEqualTo "title") then {
			ctrlSetText [41254, format[""]];
			ctrlSetText [41255, format[""]];
			_listBoxControl lbSetSelected [-1, true];
		} else {
			ctrlSetText [41254, format["描述: %1", _titleInfo select 1]];
			if (_playerTitleProgress isEqualTo -1) then {
				ctrlSetText [41255, format[""]];
			} else {
				ctrlSetText [41255, format["进展: %2/%1", [_titleInfo select 0] call OEC_fnc_numberText,[_playerTitleProgress] call OEC_fnc_numberText]];
			};
		};
		(_display displayCtrl 41256) ctrlShow false;
	};
};