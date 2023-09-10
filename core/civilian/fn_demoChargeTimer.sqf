//  File: fn_demoChargeTimer.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Displays counter for blasting charges.

params [
	["_vault",objNull,[objNull]],
	["_customTime",0]
];
private ["_display","_timer","_time","_color","_exit"];
_exit = false;

if (_customTime isEqualTo 0) then {
	switch (typeOf _vault) do {
		case "Land_CargoBox_V1_F": {
			_time = time + (60 * 35);
		};
		case "CargoNet_01_box_F": {
			_time = time + (60 * 15);
		};
		case "Land_Dome_Big_F": {
			_time = time + (60 * 25);
		};
		case "Land_Mil_WallBig_4m_battered_F": {
			_time = time + (60 * 15);
		};
	};
} else {
	_time = time + _customTime;
};

disableSerialization;

_color = switch (typeOf _vault) do {
	case "Land_CargoBox_V1_F": {[0.87,0.76,0,1]};
	case "Land_Dome_Big_F": {[1,0.4,0.01,1]};
	case "CargoNet_01_box_F": {[0.04,0.58,0,1]};
	case "Land_Mil_WallBig_4m_battered_F": {[0.04,0.06,0.7,1]};
	default {[1,1,1,1]};
};

waitUntil {_vault getVariable ["chargeplaced",false]};
hint localize "STR_ISTR_Blast_KeepOff";

if (!(typeOf _vault isEqualTo "Land_Mil_WallBig_4m_battered_F") && !(typeOf _vault isEqualTo "CargoNet_01_box_F")) then {
	6 cutRsc ["life_timer","PLAIN DOWN"];

	_display = uiNamespace getVariable "life_timer";
	_timer = _display displayCtrl 38301;
	_timer ctrlSetTextColor _color;

	while {true} do {
		if (isNull _display) then {
			6 cutRsc ["life_timer","PLAIN DOWN"];
			_display = uiNamespace getVariable "life_timer";
			_timer = _display displayCtrl 38301;
			_timer ctrlSetTextColor _color;
		};

		if (round(_time - time) < 1) exitWith {};
		if !(_vault getVariable ["chargeplaced",false] ) exitWith {
			hint localize "STR_ISTR_Blast_Disarmed";
			_exit = true;
		};
		_timer ctrlSetText format["%1",[(_time - time),"MM:SS"] call BIS_fnc_secondsToString];
		uiSleep 0.09;
	};

	6 cutText ["","PLAIN DOWN"];
} else {
	if (typeOf _vault isEqualTo "Land_Mil_WallBig_4m_battered_F") then {
		7 cutRsc ["jail_timer","PLAIN DOWN"];

		_display = uiNamespace getVariable "jail_timer";
		_timer = _display displayCtrl 38309;
		_timer ctrlSetTextColor _color;

		while {true} do {
			if (isNull _display) then {
				7 cutRsc ["jail_timer","PLAIN DOWN"];
				_display = uiNamespace getVariable "jail_timer";
				_timer = _display displayCtrl 38309;
				_timer ctrlSetTextColor _color;
			};

			if (round(_time - time) < 1) exitWith {};
			if !(_vault getVariable["chargeplaced",false] ) exitWith {
				hint localize "STR_ISTR_Blast_Disarmed";
				_exit = true;
			};
			_timer ctrlSetText format["%1",[(_time - time),"MM:SS"] call BIS_fnc_secondsToString];
			uiSleep 0.09;
		};

		7 cutText ["","PLAIN DOWN"];
	} else {
		9 cutRsc ["bank_timer","PLAIN DOWN"];

		_display = uiNamespace getVariable "bank_timer";
		_timer = _display displayCtrl 38315;
		_timer ctrlSetTextColor _color;

		while {true} do {
			if (isNull _display) then {
				7 cutRsc ["bank_timer","PLAIN DOWN"];
				_display = uiNamespace getVariable "bank_timer";
				_timer = _display displayCtrl 38315;
				_timer ctrlSetTextColor _color;
			};

			if !(_vault getVariable ["chargeplaced",false]) exitWith {
				hint localize "The APD has stopped the bank robbery!";
				_exit = true;
			};
			if (round(_time - time) < 1) exitWith {};
			_timer ctrlSetText format["%1",[(_time - time),"MM:SS"] call BIS_fnc_secondsToString];
			uiSleep 0.09;
		};
		9 cutText ["","PLAIN DOWN"];
		7 cutText ["","PLAIN DOWN"];
		[[13, _vault],"OES_fnc_handleComplexMarker"] spawn OEC_fnc_MP;
	};
};

if(_exit) exitWith {};

switch (typeOf _vault) do {
	case "Land_CargoBox_V1_F": {
		hint "Detonating Charge...";
		uiSleep 2.5;
		hint localize "STR_ISTR_Blast_Opened";
	};

	case "CargoNet_01_box_F": {
		hint "Detonating Charge...";
		uiSleep 2.5;
		hint "The Bank Vault has been broken into!";
	};

	case "Land_Dome_Big_F": {
		hint "Detonating Charge...";
		uisleep 2.5;
		hint "The Blackwater facility has been compromised!";
	};

	case "Land_Mil_WallBig_4m_battered_F": {
		hint "Detonating Charge...";
		uiSleep 2.5;
		hint "This prison door is destroyed, everyone can run free!";
	};
};
