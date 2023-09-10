#include "..\..\macro.h"
#include <zmacro.h>
//  File: fn_managePrisonWall.sqf
//	Description: This will allow cops to open and close the prison doors, and allow vigilantes to close the door as well.

private["_mode","_vault","_progressBar","_cP","_titleText"];
_mode = param [3,"",[""]];
_vault = jailwall;
if(_mode == "Close_Door" && playerSide != west && !license_civ_vigilante) exitWith {hint "Only vigilantes or police can repair the door!";};
if(_mode == "Open_Door" && (playerSide != west || (__GETC__(life_coplevel) < 3))) exitWith {
	if (playerSide isEqualTo west) then {
		hint "Only corporal and above can open the door!";
	} else {
		hint "Only police can open the door!";
	};
};
if(_vault getVariable["chargeplaced",false]) exitWith {hint "You cannot open or close the door until the charge is defused!";};

switch(_mode) do {
	case "Open_Door": {
		if(_vault getVariable["safe_open",false]) then {
			hint "The door is already open.";
		} else {
			_vault setVariable["safe_open",true,true];
			hint "The prison door is now open, make sure no one escapes!!!";
			[[0,jailwall],'OES_fnc_adminInvis',false,false] spawn OEC_fnc_MP;
			[[1,jailwall_destroyed],'OES_fnc_adminInvis',false,false] spawn OEC_fnc_MP;
		};
	};

	case "Close_Door": {
		if(_vault getVariable["safe_open",false]) then {
			disableSerialization;
			5 cutRsc ["life_progress","PLAIN DOWN"];
			_ui = uiNamespace getVariable "life_progress";
			_progressBar = _ui displayCtrl 38201;
			_titleText = _ui displayCtrl 38202;
			_titleText ctrlSetText format["%2 (1%1)...","%","Securing prison door..."];
			_progressBar progressSetPosition 0.01;
			_cP = 0.01;

			while {true} do
			{
				uiSleep 0.13;
				if(isNull _ui) then {
					5 cutRsc ["life_progress","PLAIN DOWN"];
					_ui = uiNamespace getVariable "life_progress";
					_progressBar = _ui displayCtrl 38201;
					_titleText = _ui displayCtrl 38202;
				};
				_cP = _cP + 0.01;
				_progressBar progressSetPosition _cP;
				_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%","Securing prison door..."];
				if(_cP >= 1 || !alive player) exitWith {};
				if(oev_interrupted) exitWith {};
			};

			//Kill the UI display and check for various states
			5 cutText ["","PLAIN DOWN"];
			if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"];};
			_vault setVariable["safe_open",false,true];
			hint "The prison door is now secure.";
			[[1,jailwall],'OES_fnc_adminInvis',false,false] spawn OEC_fnc_MP;
			[[0,jailwall_destroyed],'OES_fnc_adminInvis',false,false] spawn OEC_fnc_MP;
			[[4],"OES_fnc_handleComplexMarker"] spawn OEC_fnc_MP;
		} else {
			hint "The door is already secured.";
		};
	};
};
