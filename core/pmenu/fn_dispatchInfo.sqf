#include <zmacro.h>
//  File: fn_dispatchInfo.sqf
//	Author: Serpico

private["_serviceRequester","_responder","_display","_cancelBtn"];
disableSerialization;

_serviceRequester = lbData[49003,(lbCurSel 49003)];
_serviceRequester = call compile format["%1", _serviceRequester];
_display = findDisplay 49000;
_cancelBtn = _display displayCtrl 49010;

if (isNull _serviceRequester) exitWith {};

_responder = _serviceRequester getVariable ["dispatchOwner",""];
if (_responder isEqualTo "") then {
	ctrlSetText[49008,"Responder:"];
	ctrlSetText[49009,"Time:"];
	_cancelBtn ctrlEnable false;
} else {
	ctrlSetText[49008,format["Responder: %1", _responder]];
	ctrlSetText[49009,format["Time: %1",[(servertime - (_serviceRequester getVariable["hasRequested",0])),"MM:SS"] call BIS_fnc_secondsToString]];
	_cancelBtn ctrlEnable true;
};


