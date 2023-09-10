#include "..\..\macro.h"
//	Description: give moeny to a selected player	DESCRIPTIONEND

if(__GETC__(life_adminlevel) < 1) exitWith {hint "Insufficient Permissions";};

private["_unit","_amount"];
_amount = parseNumber(ctrlText 2988);
if(_amount > 999999) exitWith {hint "You can't transfer more then $999,999";};
_unit = lbData[50002,lbCurSel (50002)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitWith {hint "The player selected doesn't seem to exist?"};
if((lbCurSel 50002) == -1) exitWith {hint "You need to select someone to transfer to from the players list on the left."};
if(!([str(_amount)] call OEC_fnc_isNumeric)) exitWith {hint "That isn't in an actual number format."};
if(isNull _unit) exitWith {};

[[1,format["%1 has received an award of $%2 for participating in a server event!", name _unit, [_amount] call OEC_fnc_numberText]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;

// [[_amount,player,0],"OEC_fnc_clientWireTransfer",_unit,false] spawn OEC_fnc_MP;
[_amount,player,0,clientOwner,true] remoteExec ["OEC_fnc_clientWireTransfer", _unit, false];
[
  ["event","EVENT Rewarded Cash"],
  ["player",name player],
  ["player_id",getPlayerUID player],
  ["target",name _unit],
  ["target_id",getPlayerUID _unit],
  ["amount",[_amount] call OEC_fnc_numberText],
  ["position",getPosATL player]
] call OEC_fnc_logIt;
