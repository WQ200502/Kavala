//  File: fn_loadingScreenIcon
//	handles loading icon for loading screen
private["_idc","_position","_controlGroup","_display","_control","_conditionVariable","_text","_loadingProgress"];
disableSerialization;

_idc = param [0,0,[0]];
_position = param [1,[],[[]]];
_controlGroup = param [2,controlNull,[controlNull]];
_conditionVariable = param [3,"",[""]];
_text = param [4,"",[""]];
_display = param [5,displayNull,[displayNull]];

if(isNull _display || isNull _controlGroup || _position isEqualTo [] || _idc == 0 || _conditionVariable == "") exitWith {hint format["Error: Failed to create loading icon/n%1 - %2 - %3 - %4", _display, _controlGroup, _position, _conditionVariable];};

_control = [_display, "RscPictureKeepAspect", _idc, _controlGroup, _position, [0, 0, 0, 0.5], true, "images\icons\load-1.paa"] call OEC_fnc_ctrlCreate;

_loadingProgress = [_display, "RscStructuredText", -1, _controlGroup, [safezoneW * 0.912, safezoneH*0.138, (safezoneH * 0.075), (safezoneH * 0.025)], [0, 0, 0, 0], true, format["<t align='center'>%1%2</t>",life_loadingProgress,"%"]] call OEC_fnc_ctrlCreate;

[_control, _conditionVariable, _loadingProgress] spawn{
	private["_control", "_conditionVar", "_iconNumber","_loadingProgress"];
	disableSerialization;

	_control = param [0,controlNull,[controlNull]];
	_conditionVar = param [1,"",[""]];
	_loadingProgress = param [2,controlNull,[controlNull]];

	_iconNumber = 1;

	if(isNull _control) exitWith {
		diag_log format["Error 2: Failed to create loading icon/n%1 - %2", _control, _conditionVar];
	};

	while{(call compile _conditionVar)} do {
		uiSleep 0.075;

		if(isNull _control) exitWith {};

		_control ctrlSetText format["images\icons\load-%1.paa",_iconNumber];
		_control ctrlCommit 0;

		_loadingProgress ctrlSetStructuredText (parseText format["<t align='center'>%1%2</t>",life_loadingProgress,"%"]);
		_loadingProgress ctrlCommit 0;

		_iconNumber = _iconNumber + 1;
		if(_iconNumber > 10) then {
			_iconNumber = 1;
		};
	};

	if(!isNull _control) then {
		_control ctrlSetFade 1;
		_control ctrlShow false;
		_control ctrlCommit 0;

		_loadingProgress ctrlSetFade 1;
		_loadingProgress ctrlShow false;
		_loadingProgress ctrlCommit 0;
	};
};
