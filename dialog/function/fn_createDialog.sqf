#include <zmacro.h>
if(scriptAvailable(0.275)) exitWith {};
//  File: fn_createDialog.sqf
//	Author: Poseidon
//	Description: Creates a dialog if it's not already open, if specified dialog is already open, it closes with an animation. This allows for the button that opens a menu to also close it

private["_dialogName","_dialogID","_location","_closeDialogEVH","_animate","_asDisplay","_closeLast"];//add local variables here
disableSerialization;
_dialogName = _this param [0,"",[""]];

_esc = false;
if(!isNil "oev_inCasino") then {
	if(oev_inCasino) then {
		if(!(_dialogName in ["Casino_Roulette", "Casino_Slots", "Casino_Blackjack"])) exitWith {_esc = true;};
	};
};
if(_esc) exitWith {};

_asDisplay = _this param [1,false,[false]];
_closeLast = _this param [2,true,[false]];
_dialogID = getNumber(missionconfigfile >> _dialogName >> "idd");
_location = getText(missionconfigfile >> _dialogName >> "location");
_animate = true;
if(_dialogName == "" || _dialogID == 0) exitWith {systemChat "无法创建菜单，数据错误";};
_dialogControl = (findDisplay _dialogID);

if(!isNull _dialogControl) then {
	//Smoothly close dialog if it's already open
	[_dialogID, _location, false] spawn OEC_fnc_animateDialog;
}else{
	if(life_lastDisplay != _dialogID) then {
		if(!isNull (findDisplay life_lastDisplay) && _closeLast) then {
			(findDisplay life_lastDisplay) closeDisplay 0;
			while{!((findDisplay life_lastDisplay) isEqualTo (findDisplay 656546))} do {};
			if((life_lastDisplay >= 30000 && life_lastDisplay <= 40000 && _dialogID >= 30000 && _dialogID <= 40000) || life_lastDisplay in [41250,87432] || _dialogID in [41250,87432]) then {_animate = false;};//no animation if opening a submenu of Y menu
			if(life_lastDisplay >= 70000 && life_lastDisplay <= 75000 && _dialogID >= 70000 && _dialogID <= 75000) then {_animate = false;};
		};
	};

	if(_asDisplay) then {
		(findDisplay 46) createDisplay _dialogName;
	};

	if(!_asDisplay && {!(createDialog _dialogName)}) exitWith {systemChat "无法创建对话框";};

	life_lastDisplay = _dialogID;
	//waitUntil{!isNull (findDisplay _dialogID)};

	if(_animate) then {
		if(_dialogID >= 30000 && _dialogID <= 40000) then {
			setMousePosition [0.85, 0.45];
		}else{
			setMousePosition [0.5, 0.5];
		};
		[_dialogID,_location, true] spawn OEC_fnc_animateDialog;
	}else{
		[_dialogID,"noAnim", true] spawn OEC_fnc_animateDialog;
	};

	_closeDialogEVH = compile format["{
			_dialog = _this select 0;_key = _this select 1;_handled = (_key == 0x01);_location = %1; _noEscape = %2;
			if(_handled && !_noEscape) then {[(ctrlIDD _dialog), _location, false] spawn OEC_fnc_animateDialog;};
			_handled;
	}",str(_location),(isNumber(missionconfigfile >> _dialogName >> "noEVH"))];

	(findDisplay _dialogID) displayAddEventHandler ["keyDown", _this call _closeDialogEVH];
};
