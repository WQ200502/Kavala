#include "..\..\macro.h"
//	Author: Bryan "Tonic" Boardwine
// fn_captureHideout.sqf

private["_group","_hideout","_action","_cpRate","_cP","_progressBar","_title","_titleText","_ui","_flagTexture","_markername","_gangname2"];
_hideout = (nearestObjects[getPosATL player,["Land_u_Barracks_V2_F","Land_i_Barracks_V2_F"],25]) select 0;
_group = _hideout getVariable ["gangOwner",[0,""]];

if(isNil {oev_gang_data select 0}) exitWith {titleText[localize "STR_GNOTF_CreateGang","PLAIN DOWN"];};
if(_group select 0 == (oev_gang_data select 0)) exitWith {titleText[localize "STR_GNOTF_Controlled","PLAIN DOWN"]};
if((_hideout getVariable ["inCapture",FALSE])) exitWith {hint localize "STR_GNOTF_Captured";};
if(_group select 0 != 0) then {
	_gangName = (_group select 1);
	_action = [
		format[localize "STR_GNOTF_AlreadyControlled",_gangName],
		localize "STR_GNOTF_CurrentCapture",
		localize "STR_Global_Yes",
		localize "STR_Global_No"
	] call BIS_fnc_guiMessage;

	_cpRate = 0.0045;
} else {
	_cpRate = 0.0075;
};

if(!isNil "_action" && {!_action}) exitWith {titleText[localize "STR_GNOTF_CaptureCancel","PLAIN DOWN"];};
oev_action_inUse = true;

//Setup the progress bar
disableSerialization;
_title = localize "STR_GNOTF_Capturing";
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
while {true} do
{
	uiSleep 0.26;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	_cP = _cP + _cpRate;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	_hideout setVariable["inCapture",true,true];
	if(_cP >= 1 || !alive player) exitWith {_hideout setVariable["inCapture",false,true];};
	if(oev_interrupted) exitWith {_hideout setVariable["inCapture",false,true];};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN DOWN"];
[] spawn OEC_fnc_handleAnim;

if(!alive player) exitWith {oev_action_inUse = false;_hideout setVariable["inCapture",false,true];};
if((player getVariable["restrained",false])) exitWith {oev_action_inUse = false;_hideout setVariable["inCapture",false,true];};
if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_GNOTF_CaptureCancel","PLAIN DOWN"]; oev_action_inUse = false;_hideout setVariable["inCapture",false,true];};
oev_action_inUse = false;

titleText["Hideout has been captured.","PLAIN DOWN"];
_flagTexture = [
		"\A3\Data_F\Flags\Flag_red_CO.paa",
		"\A3\Data_F\Flags\Flag_green_CO.paa",
		"\A3\Data_F\Flags\Flag_blue_CO.paa",
		"\A3\Data_F\Flags\Flag_white_CO.paa",
		"\A3\Data_F\Flags\flag_fd_red_CO.paa",
		"\A3\Data_F\Flags\flag_fd_green_CO.paa",
		"\A3\Data_F\Flags\flag_fd_blue_CO.paa",
		"\A3\Data_F\Flags\flag_fd_orange_CO.paa"
	] call BIS_fnc_selectRandom;
_this select 0 setFlagTexture _flagTexture;
[[[0,1],"STR_GNOTF_CaptureSuccess",true,[name player,(oev_gang_data select 1)]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
// CREATE MARKER AT MAP BY Pictureclass

_markername = str(getPos _hideout);
_gangname2 = formatText["Captured by: %1",(oev_gang_data select 1)];
if (getMarkerColor _markername == "") then
{
	gang_owner_marker = createMarker [_markername, position player];
	_markername setMarkerShape "ICON";
	_markername setMarkerType "hd_warning";
	_markername setMarkerColor "ColorBlue";
	_markername setMarkerText str(_gangname2);
	gang_owner_marker = "";
}
else
{
	_markername setMarkerText str(_gangname2);
};
_hideout setVariable["inCapture",false,true];
_hideout setVariable["gangOwner",[(oev_gang_data select 0),(oev_gang_data select 1)],true];