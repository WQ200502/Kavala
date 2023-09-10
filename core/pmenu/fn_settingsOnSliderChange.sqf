//  File: fn_settingsOnSliderChange.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Called when the slider is changed for any field and updates the view distance for it.
private["_mode","_value"];
_mode = _this param [0,-1,[0]];
_value = _this param [1,-1,[0]];
if(_mode == -1 || _value == -1) exitWith {};
disableSerialization;

switch (_mode) do {
	case 0: {
		tawvd_foot = round(_value);
		ctrlSetText[35001,format["%1",round(_value)]];
		[] call OEC_fnc_updateViewDistance;
	};

	case 1: {
		tawvd_car = round(_value);
		ctrlSetText[35002,format["%1",round(_value)]];
		[] call OEC_fnc_updateViewDistance;
	};

	case 2: {
		tawvd_air = round(_value);
		ctrlSetText[35003,format["%1",round(_value)]];
		[] call OEC_fnc_updateViewDistance;
	};

	case 3: {
		life_terrainDetail = round(50 - _value);
		ctrlSetText[35011,format["%1",round(_value)]];
		setTerrainGrid life_terrainDetail;
	};

	case 4: {
		life_decorationDetailSetting = round(_value);
		ctrlSetText[35013,format["%1%2",round(_value),"%"]];
	};

	case 5: {
		_value = [_value, 2] call BIS_fnc_cutDecimals;
		life_colorRGBA set [0, _value];
		ctrlSetText[9000, format["%1", _value]];
		((findDisplay 35000) displayCtrl 89675) ctrlSetTextColor life_colorRGBA;
		((findDisplay 35000) displayCtrl 784308) ctrlSetTextColor life_colorRGBA;
	};

	case 6: {
		_value = [_value, 2] call BIS_fnc_cutDecimals;
		life_colorRGBA set [1, _value];
		ctrlSetText[9001, format["%1", _value]];
		((findDisplay 35000) displayCtrl 89675) ctrlSetTextColor life_colorRGBA;
		((findDisplay 35000) displayCtrl 784308) ctrlSetTextColor life_colorRGBA;
	};

	case 7: {
		_value = [_value, 2] call BIS_fnc_cutDecimals;
		life_colorRGBA set [2, _value];
		ctrlSetText[9002, format["%1", _value]];
		((findDisplay 35000) displayCtrl 89675) ctrlSetTextColor life_colorRGBA;
		((findDisplay 35000) displayCtrl 784308) ctrlSetTextColor life_colorRGBA;
	};

	case 8: {
		_value = [_value, 2] call BIS_fnc_cutDecimals;
		life_colorRGBA set [3, _value];
		ctrlSetText[9003, format["%1", _value]];
		((findDisplay 35000) displayCtrl 89675) ctrlSetTextColor life_colorRGBA;
		((findDisplay 35000) displayCtrl 784308) ctrlSetTextColor life_colorRGBA;
	};
	case 9: {
		_value = [_value*10, 0] call BIS_fnc_cutDecimals;
		life_earplugs set[0,_value];
		ctrlSetText[35104, format["%1%2", _value, "%"]];

		//Put on partial earplugs
		oev_earVol = false;
		oev_earplugs = true;
		[] call OEC_fnc_hudUpdate;
		1 fadeSound ((life_earplugs select 0) / 100);
	};
	case 10: {
		_value = [_value*10, 0] call BIS_fnc_cutDecimals;
		life_earplugs set[1,_value];
		ctrlSetText[35105, format["%1%2", _value, "%"]];

		//Put on full earplugs
		oev_earVol = false;
		oev_earplugs = false;
		[] call OEC_fnc_hudUpdate;
		1 fadeSound ((life_earplugs select 1) / 100);
	};
};
