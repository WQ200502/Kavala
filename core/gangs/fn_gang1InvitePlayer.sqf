#include <zmacro.h>

//	Author: Bryan "Tonic" Boardwine
//	Description: Starts the invite process?

private["_unit"];
disableSerialization;

if((lbCurSel 37009) == -1) exitWith {hint localize "STR_GNOTF_SelectPerson"};
_unit = call compile format["%1",getSelData(37009)];
if(isNull _unit) exitWith {hint "That player doesn't exist!"}; //Bad unit?
if(_unit == player) exitWith {hint localize "STR_GNOTF_InviteSelf"};
if(!isNil {_unit getVariable "gang_data"}) exitWith {hint "This player is already in a gang"}; //Added
if(format["%1",_unit] in ["civ_news_1","civ_news_2","civ_news_3","civ_news_4","civ_news_5","civ_news_6","civ_news_7","civ_news_8","civ_news_9","civ_news_10"]) exitWith {hint "You cannot invite active news team members."};


_action = [
	format[localize "STR_GNOTF_InvitePlayerMSG",_unit getVariable ["realname",name _unit]],
	localize "STR_Gang_Invitation",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if(_action) then {
	[profileName,oev_gang_data] remoteExec ["OEC_fnc_gangInvite",_unit];
	hint format[localize "STR_GNOTF_InviteSent",_unit getVariable["realname",name _unit]];
} else {
	hint localize "STR_GNOTF_InviteCancel";
};
