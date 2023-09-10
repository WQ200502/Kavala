#include "..\..\macro.h"
//	Author: Bryan "Tonic" Boardwine
//	Description: Prompts the user about disbanding the gang and if the user accepts the gang will be
//	disbanded and removed from the database.

private["_action","_gangID","_onlineMembers"];
if ((oev_gang_data select 2) != 5) exitWith {hint "You are not the leader."};

_action = [
	localize "STR_GNOTF_DisbandWarn",
	localize "STR_Gang_Disband_Gang",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if (_action) then {
	hint localize "STR_GNOTF_DisbandGangPro";
	_gangID = oev_gang_data select 0;
	if (count oev_gang_data isEqualTo 4) then {
		private _building = nearestBuilding (oev_gang_data select 3);
		if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") then {
			// for gangsheds created with createVehicle
			_building = (oev_gang_data select 3) nearestObject "Land_i_Shed_Ind_F";
		};
		if !(typeOf _building isEqualTo "Land_i_Shed_Ind_F") exitWith {};
		oev_houseTransaction = true;
		oev_action_inUse = true;
		_building setVariable["house_sold",true,true];
		[_building,player] remoteExec ["OES_fnc_sellGangBldg",2];
	};
	_onlineMembers = [_gangID] call OEC_fnc_getOnlineMembers;
	[_onlineMembers,_gangID] remoteExec ["OES_fnc_removeGang",2];
	[player,2] remoteExec ["OEC_fnc_gangBldgMembers",_onlineMembers];
} else {
	hint localize "STR_GNOTF_DisbandGangCanc";
};
