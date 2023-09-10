#include "..\..\macro.h"
//	Description: give money to a selected player	DESCRIPTIONEND
//  File: fn_adminGiveMoney.sqf

if(__GETC__(life_adminlevel) < 3) exitWith {hint "Insufficient Permissions";};
if(scriptAvailable(3)) exitWith {hint "Please do not spam admin wire transfers";};
private["_unit","_amount"];
_amount = parseNumber(ctrlText 2988);
if(_amount > 999999) exitWith {hint "You can't transfer more then $999,999";};
_unit = lbData[2902,lbCurSel (2902)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitWith {hint "The player selected doesn't seem to exist?"};
if((lbCurSel 2902) == -1) exitWith {hint "You need to select someone to transfer to"};
if(!([str(_amount)] call OEC_fnc_isNumeric)) exitWith {hint "That isn't in an actual number format."};
if(isNull _unit) exitWith {};

// [[_amount,player,0],"OEC_fnc_clientWireTransfer",_unit,false] spawn OEC_fnc_MP;
[_amount,player,0,clientOwner,true] remoteExec ["OEC_fnc_clientWireTransfer", _unit, false];

[
  ["event", "ADMIN Give Money"],
  ["player", name player],
  ["player_id", getPlayerUID player],
  ["target", name _unit],
  ["target_id", getPlayerUID _unit],
  ["value", _amount],
  ["position", getPos player]
] call OEC_fnc_logIt;
