#include <zmacro.h>
//	Author: Bryan "Tonic" Boardwine
//	Description: Something about being a quitter.

private["_unit","_unitID","_members","_action","_index","_member","_gangID","_gangName","_onlineMembers"];
if((oev_gang_data select 2) != 5) exitWith {hint "You are not the leader."};
disableSerialization;

if((lbCurSel 37003) == -1) exitWith {hint localize "STR_GNOTF_TransferSelect"};
_unit = call compile format["%1",getSelData(37003)];
if(_unit select 0 == getPlayerUID player) exitWith {hint localize "STR_GNOTF_TransferSelf"};

_action = [
	format[localize "STR_GNOTF_TransferMSG",(_unit select 1)],
	localize "STR_Gang_Transfer",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if(_action) then {
	if(_unit select 0 == "") exitWith {hint "Bad UID?"}; //Unlikely?
	_gangID = oev_gang_data select 0;
	_gangName = oev_gang_data select 1;
	_onlineMembers = [_gangID] call OEC_fnc_getOnlineMembers;
	_member = objNull;
	{
		if(getPlayerUID _x == (_unit select 0)) exitWith {
			_member = _x;
		};
	}foreach _onlineMembers;

	[[2,player,_gangID,_gangName,4],"OES_fnc_updateMember",false,false] spawn OEC_fnc_MP;
	if(isNull _member) then {
		[[1,(_unit select 0),_gangID,_gangName,5],"OES_fnc_updateMember",false,false] spawn OEC_fnc_MP;
	} else {
		[[2,_member,_gangID,_gangName,5],"OES_fnc_updateMember",false,false] spawn OEC_fnc_MP;
		if(!isNil {(group player) getVariable "gang_id"}) then {
			playerGroup selectLeader _member;
			[[_member,playerGroup],"OEC_fnc_clientGangLeader",_onlineMembers,false] spawn OEC_fnc_MP;
		};
	};
} else {
	hint localize "STR_GNOTF_TransferCancel";
};

[] call OEC_fnc_gangMenu;