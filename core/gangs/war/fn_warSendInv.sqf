//  File: fn_warSendInv.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: spawned fromc civ interaction menu sends to opposing leader.

params [
	["_mode",-2,[0]],
	"_unit"
];

if (_mode isEqualTo -2) exitWith {};
if (_mode isEqualTo 1 && ((lbCurSel 37206) isEqualTo -1)) exitWith {hint "No gang was selected to war!";};
if (_mode isEqualTo 1) then {_unit = call compile format["%1",lbData[37206,lbCurSel(37206)]];};
if !(((_unit getVariable ["gang_data",[0,"",0]]) select 2) >= 3) exitWith {hint "The other person is not of sufficent rank to manage wars!";};
if ((oev_gang_data select 2) < 3) exitWith {hint "You're not of proper rank to start a war!";};
if (isNull _unit) exitWith {};
if (_unit isEqualTo player) exitWith {};
if ((count oev_gang_data) isEqualTo 0) exitWith {};
if (((_unit getVariable ["gang_data",[0,"",0]]) select 0) in oev_gang_warIDs) exitWith {hint "You are already at war with this gang!";};
if (((_unit getVariable ["gang_data",[0,"",0]]) select 0) isEqualTo 0) exitWith {hint "An error occured... Try again. Invalid gang data set on other player.";};
if (((_unit getVariable ["gang_data",[0,"",0]]) select 0) isEqualTo (oev_gang_data select 0)) exitWith {hint "You cannot start a war with someone in your own gang...";};
if (dialog && !(_mode isEqualTo 1)) exitWith {};
if(oev_sendWarCD > time) exitWith {hint "Please wait before sending another war invite!";};

private _gangName = ((_unit getVariable ["gang_data",[0,"",0]]) select 1);
if (_gangName isEqualTo "") exitWith {hint "Couldn't locate opposing gang leaders gang name. Try again.";};
if (((_unit getVariable ["gang_data",[0,"",0]]) select 0) in oev_declinedWars) exitWith {hint "You've already tried to war this gang and it was denied.";};

private _action = [
	format["Are you sure you want to start a war with the gang %1? The war will last until one side decides to end it. RDM Rules will not apply for engagements between the two gangs. Do you want to go to war?",_gangName],
	"Ready for War?",
	"Bring it",
	"Bail out"
] call BIS_fnc_guiMessage;

if (_action) then {
	if (_mode isEqualTo 1) then {
		[[1,player,(oev_gang_data select 0),(oev_gang_data select 1)],"OEC_fnc_warRecieveInv",_unit,false] spawn OEC_fnc_MP;
	} else {
		[[0,player,(oev_gang_data select 0),(oev_gang_data select 1)],"OEC_fnc_warRecieveInv",_unit,false] spawn OEC_fnc_MP;
	};
	oev_sendWarCD = time+1;
} else {
	hint "Gang war invitation cancelled.";
};
