#include <zmacro.h>
//  File: fn_dispatchNotify.sqf
//	Author: Serpico

private["_serviceRequester","_msg","_status","_responder","_responderName"];
params [["_responseType",-1,[0]]];
disableSerialization;

if (playerside != independent) exitWith {};

_msg = "";
_status = "";
_responder = player;
_responderName = _responder getVariable ["realName", name _responder];
_serviceRequester = lbData[49003,(lbCurSel 49003)];
_serviceRequester = call compile format["%1", _serviceRequester];

switch (_responseType) do {
	case 0 : {
		_status = format["On-Route - %1",profileName];
		_msg = format ["%1 is on route to your location.",profileName];
	};
	case 1 : {
		_status = format["RnR DNR - %1",profileName];
		_msg = format["Your request for medical assistance has been declined by %1.",profileName];
	};
	case 2 : {
		_status = format["3rd DNR - %1",profileName];
		_msg = "Your request for medical assistance has been denied by a third party.";
	};
	case 3 : {
		_msg = format["%1 cleared your latest dispatch status.",profileName];
	};
	case 4 : {
		_status = format["DNR Bug - %1",profileName];
		_msg = "Your request for medical assistance cannot be completed due to an issue out of our control.";
	};
};

if (_msg != "") then {
	[[_serviceRequester,_msg,_responder,10],"OES_fnc_handleMessages",false] spawn OEC_fnc_MP;
};

if (_responseType isEqualTo 3) then {
	_responderName = "";
	_responseType = -1;
};

_serviceRequester setVariable ["dispatchStatus",_status,true];
_serviceRequester setVariable ["dispatchOwner",_responderName,true];
_serviceRequester setVariable ["responseType",_responseType,true];

[[_status,_responderName,_responseType],"OEC_fnc_setDispatchData",_serviceRequester] spawn OEC_fnc_MP;

closeDialog 0;