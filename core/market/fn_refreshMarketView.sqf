//	Original Author Unknown
//	Modified by djwolf
//	Date Modified: 4/8/2016
//	File: fn_refreshMarketView.sqf
//	Description: Performs the refreshing actions for the market UI
//	Organization: Olympus Entertainment

disableSerialization;
if (!dialog) exitWith {diag_log "Could not find dialog."}; //cancel if no dlg

private _display = findDisplay 38000;
if (isNull _display) exitWith {diag_log "Market UI not open! Failed to properly load market UI!"};

private _listBox = 38002;
private _selectedIndex = lbCurSel _listBox;

if (_selectedIndex isEqualTo -1) then { //If selected index is -1 create the list of stuff
	if (oev_refresh_delay > 0) exitWith {};
	oev_refresh_delay = oev_refresh_delay + 1;
	[] spawn{uiSleep 2; oev_refresh_delay = oev_refresh_delay - 1};

	lbSetCurSel [_listBox, 1];
	lbClear _listBox;

	private "_index";
	{
		_entry = _x;
		_found = false;

		for [{private "_i"; _i = 0},{_i <= (lbSize _listBox)},{_i = _i + 1}] do {
			if (_entry isEqualTo lbData [_listBox,_i]) exitWith {_found = true};
		};

		if (!_found) then {
			_index = lbAdd [_listBox, [[_entry, 0] call OEC_fnc_varHandle] call OEC_fnc_varToStr];
			lbSetData [_listBox, _index, _entry];
			lbSetPicture [_listBox,((lbSize _listBox) - 1),([([_entry,0] call OEC_fnc_varHandle)] call OEC_fnc_iconConfig)];
		};
	} foreach oev_market_arr;

	lbSetCurSel [_listBox, 1];
} else { //Otherwise set data to selected entry
	private _curPrice = ((serv_market_current select _selectedIndex) select 0);
	private _adjustment = ((serv_market_current select _selectedIndex) select 1);

	ctrlSetText [38004, format["%1元", [_curPrice] call OEC_fnc_numberText]];

	if (_adjustment >= 0) then {
		ctrlSetText [38007, "images\icons\trendup.paa"];
	} else {
		_adjustment = _adjustment * -1;
		ctrlSetText [38007, "images\icons\trenddown.paa"];
	};

	ctrlSetText [38008, format["%1元", [_adjustment] call OEC_fnc_numberText]];
};