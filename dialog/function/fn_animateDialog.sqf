#include <zmacro.h>
//  File: fn_animateDialog.sqf
//	Author: Poseidon
//	Description: Performs animations when a dialog is opened or closed

private["_dialogID","_dialogControl","_location","_mode","_closeDialogEVH"];//add local variables here
disableSerialization;
_dialogID = _this param [0,0,[0]];
_location = _this param [1,"",[""]];
_mode = _this param [2,true,[false]];//true for create, false for closing dialog

if(_dialogID == 0) exitWith {};//exit if bad dialog and you're trying to open it
_dialogControl = (findDisplay _dialogID);

if(playerSide != civilian) then {
	ctrlEnable[30907,false];
	ctrlEnable[30908,false];
};

if(!isNil "life_adminlevel") then {
	if(__GETC__(life_adminlevel) < 1) then{
		ctrlEnable[30912,false];
	};
};

if(_location == "noAnim") exitWith {if(!_mode) then {closeDialog 0;}else{{_x ctrlSetFade 0;_x ctrlCommit 0;}foreach (allControls (findDisplay _dialogID));};};//if no animation exit or close it if its open
if(isNull _dialogControl) exitWith {};

{
	_goodPos = ctrlPosition _x;
	_hiddenPos = switch(_location) do {
		case "top": {[(_goodPos select 0), (_goodPos select 1) - 1]};
		case "bottom":{[(_goodPos select 0), (_goodPos select 1) + 1]};
		case "left": {[(_goodPos select 0) - 1, (_goodPos select 1)]};
		case "right":{[(_goodPos select 0) + 1, (_goodPos select 1)]};
		case "fadeOnly": {[(_goodPos select 0), (_goodPos select 1)]};
		case "grow": {[(_goodPos select 0) + ((_goodPos select 2) / 2), (_goodPos select 1) + ((_goodPos select 3) / 2)]};
		case "leftAndRight": {if((_goodPos select 0) > (safeZoneW / 4)) then
			{//x position is on the right side of the screen
				[(_goodPos select 0) + 1, (_goodPos select 1)];
			} else{//x position is on the left side of the screen
				[(_goodPos select 0) - 1, (_goodPos select 1)];
			};
		};
		default {[(_goodPos select 0), (_goodPos select 1)]};
	};
	_goodPos = [_goodPos select 0, _goodPos select 1];

	if(_mode) then {
		if(_location == "grow") then {_x ctrlSetScale 0;};
		_x ctrlSetPosition _hiddenPos;
		_x ctrlSetFade 1;
		_x ctrlCommit 0;
		if(_location == "grow") then {_x ctrlSetScale 1;};
		_x ctrlSetPosition _goodPos;
		_x ctrlSetFade 0;
		_x ctrlCommit 0.275;
	}else{
		if(_location == "grow") then {_x ctrlSetScale 0;};
		_x ctrlSetPosition _hiddenPos;
		_x ctrlSetFade 1;
		_x ctrlCommit 0.14;
	};

}foreach (allControls _dialogControl);

if(!_mode) then {
	sleep 0.14;
	closeDialog 0;
};