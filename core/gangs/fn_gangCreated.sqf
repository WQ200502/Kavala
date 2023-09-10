#include "..\..\macro.h"

//	Author: Bryan "Tonic" Boardwine
//	Description: Tells the player that the gang is created and throws him into it.

private["_group"];
life_action_gangInUse = nil;

if(oev_atmcash < (__GETC__(oev_gangPrice))) exitWith {
	hint format[localize "STR_GNOTF_NotEnoughMoney",[((__GETC__(oev_gangPrice))-oev_atmcash)] call OEC_fnc_numberText];
	{(group player) setVariable[_x,nil,true];} foreach ["gang_id","gang_name"];
};

__SUB__(oev_atmcash,(__GETC__(oev_gangPrice)));
__SUB__(oev_cache_atmcash,(__GETC__(oev_gangPrice)));

[] spawn{uiSleep 1; oev_gang_data = [grpPlayer getVariable ["gang_id",(oev_gang_data select 0)],grpPlayer getVariable ["gang_name",(oev_gang_data select 1)],5]};
player setVariable["gang_data",oev_gang_data,true];

hint format[localize "STR_GNOTF_CreateSuccess",(group player) getVariable "gang_name",[(__GETC__(oev_gangPrice))] call OEC_fnc_numberText];
['yMenuGangs'] spawn OEC_fnc_createDialog;
