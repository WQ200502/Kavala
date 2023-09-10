#include <zmacro.h>
//  File: fn_newMsg.sqf
//	Author: Silex (Modified by djwolf)
private["_type","_playerData","_msg","_display","_cPlayerList","_msgToSendError","_privelageError"];
disableSerialization;

_type = _this param [0,-1];
_playerData = _this param [1,-1];
_msg = _this param [2,"",[""]];

_display = findDisplay 34000;
_cPlayerList = _display displayCtrl 34101;

//canned errors
_msgToSendError = "You must enter a message to send.";
_privelageError = "You are not allowed to use this feature.";

if((count (toArray(_msg))) > 400) exitWith {closeDialog 0; hint "Messages may not exceed 400 characters."};

if(__GETC__(life_adminlevel) < 2) then {
	ctrlShow[888997,false];
	ctrlShow[888998,false];
};

_lcl_log = {
	_event = _this select 0;
	_msg = _this select 1;
	[
		["event", _event],
		["player", getPlayerUID player],
		["message", _msg],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
};

switch(_type) do {
	case 0: {
		oev_smartphoneTarget = call compile format["%1",_playerData];
		waitUntil {!isNull (findDisplay 34200)};
		ctrlSetText[34201, format["Message to: %1", name oev_smartphoneTarget]];
		if ((__GETC__(life_adminlevel)) < 1) then {
			ctrlShow [34203,false];
		};
	};

	//normal message
	case 1: {
		if(isNull oev_smartphoneTarget) exitWith {hint "You must select a player.";};
		if(_msg == "") exitWith {hint format ["%1",_msgToSendError]};
		[oev_smartphoneTarget,_msg,player,0] remoteExecCall ["OES_fnc_handleMessages",2];
		hint format["You have sent %1 a message: %2",(name oev_smartphoneTarget),_msg];
		closeDialog 0;
	};

	//copmessage
	case 2: {
		if (((O_stats_crimes select 58) != 0) && playerSide isEqualTo civilian) exitWith {hint "You have recently received a Misuse of Emergency System charge. Due to this, you are unable to send another dispatch.";};
		if(({side _x isEqualTo west} count playableUnits) isEqualTo 0) exitWith {hint "The APD is currently unavailable. Please try again later.";};
		if (playerSide isEqualTo west) exitWith {hint "APD Members can not send dispatches to themselves.";};
		if(_msg == "") exitWith {hint format ["%1",_msgToSendError];};
		["APD Message", _msg] call _lcl_log;

		[ObjNull,_msg,player,1] remoteExecCall ["OES_fnc_handleMessages",2];
		hint format["You have sent The APD a message: %1",_msg];
		closeDialog 0;
	};

	//msgadmin
	case 3: {
		if(_msg == "") exitWith {hint format ["%1",_msgToSendError];};
		["Admin Message", _msg] call _lcl_log;

		[ObjNull,_msg,player,2] remoteExecCall ["OES_fnc_handleMessages",2];
		hint format["You have sent the Olympus Staff a message: %1",_msg];
		closeDialog 0;
	};

	//emsrequest
	case 4: {
		if(({side _x isEqualTo independent} count playableUnits) == 0) exitWith {hint format["Currently, there are no R&R units on duty. Please try again later."];};
		if(_msg == "") exitWith {hint format ["%1",_msgToSendError];};
		if (side player isEqualTo independent) exitWith {hint "RNR Members can not send dispatches to themselves.";};
		["EMS Message", _msg] call _lcl_log;

		[ObjNull,_msg,player,3] remoteExecCall ["OES_fnc_handleMessages",2];
		hint format["You have sent a message to all R.&.R. Units: %1",_msg];
		closeDialog 0;
	};


	//adminToPerson
	case 5: {
		if((__GETC__(life_adminlevel) < 1)) exitWith {hint format ["%1",_privelageError];};
		if(isNull oev_smartphoneTarget) exitWith {hint format["You must select a player."];};
		if(_msg == "") exitWith {hint format ["%1",_msgToSendError];};
		[oev_smartphoneTarget,_msg,player,4] remoteExecCall ["OES_fnc_handleMessages",2];
		hint format["Admin Message Sent To: %1 - Message: %2",(name oev_smartphoneTarget),_msg];
		["Admin Person Message", _msg] call _lcl_log;
		closeDialog 0;
	};

	//adminMsgAll
	case 6: {
		if((__GETC__(life_adminlevel) < 1)) exitWith {hint format ["%1",_privelageError];};
		if(_msg == "") exitWith {hint format ["%1",_msgToSendError];};
		["Admin All Message", _msg] call _lcl_log;

		[[ObjNull,_msg,player,5],"OES_fnc_handleMessages",false] spawn OEC_fnc_MP;
		hint format["A staff message has been sent to all players: %1",_msg];
		closeDialog 0;
	};

	//adminMsgCivs
	case 7: {
		if((__GETC__(life_adminlevel) < 1)) exitWith {hint format ["%1",_privelageError];};
		if(_msg == "") exitWith {hint format ["%1",_msgToSendError];};
		["Admin Civs Message", _msg] call _lcl_log;

		[ObjNull,_msg,player,11] remoteExecCall ["OES_fnc_handleMessages",2];
		hint format["A staff message has been sent to all civilians: %1",_msg];
		closeDialog 0;
	};

	//eventmesgall
	case 8:	{
		if(__GETC__(life_adminlevel) < 2) exitWith {hint format ["%1",_privelageError];};
		if(_msg == "") exitWith {hint format ["%1",_msgToSendError];};
		["Event All Message", _msg] call _lcl_log;
		[ObjNull,_msg,player,7] remoteExecCall ["OES_fnc_handleMessages",2];
		hint format["An event message has been sent to all players: %1",_msg];
		closeDialog 0;
	};

	//eventmesgpart
	case 9:	{
		if(__GETC__(life_adminlevel) < 2) exitWith {hint format ["%1",_privelageError];};
		if(_msg == "") exitWith {hint format ["%1",_msgToSendError];};
		["Event Part Message", _msg] call _lcl_log;
		[ObjNull,_msg,player,8] remoteExecCall ["OES_fnc_handleMessages",2];
		hint format["An event message has been sent to all event participants: %1",_msg];
		closeDialog 0;
	};
	//reply to message
	case 10: {
		_target = player getVariable ["lastMessageID",objNull];
		if(_msg == "") exitWith {hint format ["%1",_msgToSendError]};
		[_target,_msg,player,0] remoteExec ["OES_fnc_handleMessages",2];
		hint format["You have sent %1 a message: %2",name _target,_msg];
		systemChat format["You have sent %1 a message: %2",name _target,_msg];
	};
};
