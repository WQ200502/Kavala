#include <zmacro.h>

//	Author: djwolf
//	Date: 4/2/2016
//	File: fn_services.sqf

//	Description: Performs the actions for the services UI
//	Organization: Olympus Entertainment

private "_mode";
_mode = param [0,-1,[0]];

if (isNil "_mode") exitWith {}; //bad data
if (_mode == -1) exitWith {}; //yet another check for bad data

waitUntil {!isNull (findDisplay 34300)}; //make sure that we aren't working with nothing here
if(__GETC__(life_adminlevel) < 1) then {
	((findDisplay 34300) displayCtrl 34321) ctrlShow false;
	((findDisplay 34300) displayCtrl 34322) ctrlShow false;
	((findDisplay 34300) displayCtrl 34323) ctrlShow false;
};
switch (_mode) do {
	case 0:
	{ //Load the services drop down menu
		{
			switch (_forEachIndex) do {
				case 2:
				{ //msg-to-staff
					if ((__GETC__(life_adminlevel) < 1)) then {
						lbAdd [34302,_x];
					};
				};
				case 3:
				{ //msg-to-eventpart
					if ((__GETC__(life_adminlevel) > 1)) then {
						lbAdd [34302,_x];
					};
				};
				case 4:
				{ //msg-to-eventall
					if ((__GETC__(life_adminlevel) > 1)) then {
						lbAdd [34302,_x];
					};
				};
				case 5:
				{ //msg-from-staff-to-all
					if ((__GETC__(life_adminlevel) > 0)) then {
						lbAdd [34302,_x];
					};
				};
				case 6:
				{ //msg-from-staff-to-civs
					if ((__GETC__(life_adminlevel) > 0)) then {
						lbAdd [34302,_x];
					};
				};
				default { //for all other cases
					lbAdd [34302,_x];
				};
			};
		} forEach ["警察","医生","管理员","事件部分","全部事件","所有玩家","所有平民"];
	};
	case 1:
	{ //this is for when we actually send out the service message
		switch (lbText [34302,(lbCurSel 34302)]) do {
			case "警察":
			{
				[2,-1,(ctrlText 34301)] call OEC_fnc_newMsg;
			};
			case "医生":
			{
				[4,-1,(ctrlText 34301)] call OEC_fnc_newMsg;
			};
			case "管理员":
			{
				[3,-1,(ctrlText 34301)] call OEC_fnc_newMsg;
			};
			case "事件部分":
			{
				[9,-1,(ctrlText 34301)] call OEC_fnc_newMsg;
			};
			case "全部事件":
			{
				[8,-1,(ctrlText 34301)] call OEC_fnc_newMsg;
			};
			case "所有玩家":
			{
				[6,-1,(ctrlText 34301)] call OEC_fnc_newMsg;
			};
			case "所有平民":
			{
				[7,-1,(ctrlText 34301)] call OEC_fnc_newMsg;
			};
			default {
				hint "发生意外错误。请稍后再试。";
				closeDialog 0;
			};
		};
	};
};
