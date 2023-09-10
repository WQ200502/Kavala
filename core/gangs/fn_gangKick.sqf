#include <zmacro.h>
//	Author: Bryan "Tonic" Boardwine
//	Description: 32 hours...

private["_unit","_unitID","_member"];
disableSerialization;

if((lbCurSel 37003) == -1) exitWith {hint localize "STR_GNOTF_SelectKick"};
_unit = call compile format["%1",getSelData(37003)];
if(_unit select 0 == getPlayerUID player) exitWith {hint localize "STR_GNOTF_KickSelf"};

if((_unit select 2) >= (oev_gang_data select 2)) exitWith {hint "Insufficient permissions."};

if(_unit select 0 == "") exitWith {hint "Bad UID?"};
_member = objNull;
{
	if(getPlayerUID _x == (_unit select 0)) exitWith {
		_member = _x;
	};
}foreach playableUnits;

if(isNull _member) then {
	[[1,(_unit select 0),0,oev_gang_data select 1,-1],"OES_fnc_updateMember",false,false] spawn OEC_fnc_MP;
} else {
	[[2,_member,0,oev_gang_data select 1,-1],"OES_fnc_updateMember",false,false] spawn OEC_fnc_MP;
};
[] call OEC_fnc_gangMenu;
