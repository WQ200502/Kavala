//  File: fn_ctrlCreate.sqf
//	Author: Poseidon
//	Description: Expands functionality of engine command ctrlCreate to reduce lines of code when creating a control.
private["_display","_type","_idc","_control","_controlGroup","_return","_sizeAndPosition","_text"];
disableSerialization;

_display = param [0,displayNull,[displayNull]];
_type = param [1,"",[""]];
_idc = param [2,0,[0]];
_controlGroup = param [3,controlNull,[controlNull]];
_sizeAndPosition = param [4,[],[[]]];
_backgroundColor = param [5,[],[[]]];
_fade = param [6,false,[false]];
_text = param [7,"",[""]];
_return = controlNull;

if(isNull _display || _type == "" || _idc == 0 || _sizeAndPosition isEqualTo [] || _backgroundColor isEqualTo []) exitWith {hint format["Error: Control creation failed\n%1 - %2 - %3 - %4", _display, _type, _idc, _controlGroup]; _return};

if(isNull _controlGroup) then {
	_return = _display ctrlCreate [_type, _idc];
}else{
	_return = _display ctrlCreate [_type, _idc, _controlGroup];
};

_return ctrlSetPosition _sizeAndPosition;
_return ctrlSetBackgroundColor _backgroundColor;

if(_fade) then {
	_return ctrlSetFade 1;
	_return ctrlCommit 0;
};
_return ctrlSetFade 0;

switch(_type) do {
	case "RscButtonMenu":{
		_return ctrlSetText _text;

		if(_backgroundColor isEqualTo [0,0,0,0]) exitWith {
			_return ctrlSetFade 1;
		};

		if(_backgroundColor select 3 == 1) exitWith {
			_return ctrlSetFade 0;
		};

		_return ctrlSetFade 0.8;
	};

	case "RscStructuredText":{
		_return ctrlSetStructuredText parseText(_text);
	};

	case "RscObject":{
		_return ctrlSetText _text;
		_return ctrlSetModel _text;
	};

	default {
		_return ctrlSetText _text;
	};
};

if(_fade) then {
	_return ctrlCommit 0.4;
}else{
	_return ctrlCommit 0;
};

_return;//The created control is returned