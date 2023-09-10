#include <zmacro.h>
//	Description: Manage ranks

private["_mode","_unit","_unitID","_member","_gangID","_gangMember","_onlineMembers"];
_mode = _this param [0,0,[0]];
disableSerialization;
_gangID = oev_gang_data select 0;
_gangName = oev_gang_data select 1;

if((lbCurSel 37003) == -1) exitWith {hint "You must select a player first.";};
_unit = call compile format["%1",getSelData(37003)];
if(_unit select 0 == getPlayerUID player) exitWith {hint "You cannot modify your own rank.";};

if(_unit select 0 == "") exitWith {hint "Bad UID?"};
_member = objNull;
_onlineMembers = [_gangID] call OEC_fnc_getOnlineMembers;
_member = objNull;
{
	if(getPlayerUID _x == (_unit select 0)) exitWith {
		_member = _x;
	};
}foreach _onlineMembers;

switch(_mode) do {
	case 1: {//promote
		if(((_unit select 2) + 1) >= (oev_gang_data select 2)) exitWith {hint "Insufficient permissions."};
		if(isNull _member) then {
			[[1,(_unit select 0),_gangID,_gangName,((_unit select 2) + 1)],"OES_fnc_updateMember",false,false] spawn OEC_fnc_MP;
		} else {
			[[2,_member,_gangID,_gangName,((_unit select 2) + 1)],"OES_fnc_updateMember",false,false] spawn OEC_fnc_MP;
		};
	};

	case 2: {//demote
		if((((_unit select 2)) >= (oev_gang_data select 2)) || ((_unit select 2) - 1) < 0) exitWith {hint "Insufficient permissions."};
		if(isNull _member) then {
			[[1,(_unit select 0),_gangID,_gangName,((_unit select 2) - 1)],"OES_fnc_updateMember",false,false] spawn OEC_fnc_MP;
		} else {
			[[2,_member,_gangID,_gangName,((_unit select 2) - 1)],"OES_fnc_updateMember",false,false] spawn OEC_fnc_MP;
		};
	};
};

[] call OEC_fnc_gangMenu;