#include <zmacro.h>
//	Author: Bryan "Tonic" Boardwine
//	Description: Pulls up the menu and creates the gang?

private["_gangName","_length","_badChar","_chrByte","_allowed"];
disableSerialization;

if((count oev_gang_data) > 0) exitWith {hint "You must leave or disband your current gang before creating a new one!"; ['yMenuCreateGang'] spawn OEC_fnc_createDialog;};
_index = [oev_my_gang,randomized_life_gang_list] call OEC_fnc_index;
if(_index != -1) then {systemChat "在团伙设置过程中，您已从组中删除。"; [] call OEC_fnc_leaveGroup;};

_gangName = ctrlText (getControl(37100,37103));
if(((_gangName find "call ") != -1) || ((_gangName find "spawn ") != -1) || ((_gangName find "execVM") != -1)) exitWith {hint "Invalid Gang Name"};
_length = count (toArray(_gangName));
_chrByte = toArray(_gangName);
_allowed = toArray("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ ");
if(_length > 32) exitWith {hint localize "STR_GNOTF_Over32"};
_badChar = false;
_hasLetters = false;
{if(!(_x in _allowed)) exitWith {_badChar = true;};} forEach _chrByte;
{if(_x in (_allowed - (toArray " "))) exitWith {_hasLetters = true;};} forEach _chrByte;
if(_badChar) exitWith {hint localize "STR_GNOTF_IncorrectChar";};
if(!_hasLetters) exitWith {hint "Put some letters in your name."};
if(oev_atmcash < (__GETC__(oev_gangPrice))) exitWith {hint format[localize "STR_GNOTF_NotEnoughMoney",[((__GETC__(oev_gangPrice))-oev_atmcash)] call OEC_fnc_numberText];};

[[player,getPlayerUID player,_gangName],"OES_fnc_insertGang",false,false] spawn OEC_fnc_MP;
hint localize "STR_NOTF_SendingData";

life_action_gangInUse = true;
