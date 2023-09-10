#include <zmacro.h>

//	Author: Bryan "Tonic" Boardwine
//	Description: 31 hours of no uiSleep screw your description.

private["_ownerID","_gangBank","_gangMax","_gangName","_members","_allUnits","_ctrl","_gangID"];
disableSerialization;

(getControl(37000,37004)) ctrlEnable false; //Set New Leader
(getControl(37000,37005)) ctrlEnable false; // Kick
(getControl(37000,37008)) ctrlEnable false; //Invite Player
(getControl(37000,37007)) ctrlEnable false; //Disband Gang
(getControl(37000,37010)) ctrlEnable false; //promote
(getControl(37000,37011)) ctrlEnable false; //demote

_gangID = (oev_gang_data select 0);
_gangName = (oev_gang_data select 1);
_rank = (oev_gang_data select 2);
[[0,_gangID,player],"OES_fnc_getGangInfo",false,false] spawn OEC_fnc_MP;

(getControl(37000,37001)) ctrlSetText _gangName;
(getControl(37000,37002)) ctrlSetText format[(localize "STR_GNOTF_Funds")+ " $ : Loading :"];

//Loop through the players.
_members = getControl(37000,37003);
lbClear _members;
_members lbAdd "Loading...";
_members lbSetData [(lbSize _members)-1,str(["loading"])];

_grpMembers = [_gangID] call OEC_fnc_getOnlineMembers;
_allUnits = playableUnits;
//Clear out the list..
{
	if(_x in _grpMembers || side _x != civilian || !isNil {_x getVariable "gang_data"}) then {
		_allUnits set[_forEachIndex,-1];
	};
} forEach _allUnits;
_allUnits = _allUnits - [-1];

_ctrl = getControl(37000,37009);
lbClear _ctrl; //Purge the list
{
	_ctrl lbAdd format["%1",_x getVariable["realname",name _x]];
	_ctrl lbSetData [(lbSize _ctrl)-1,str(_x)];
} forEach _allUnits;