//  File: fn_timerCheck.sqf
//	Author: Kurt

//	Description: Checks to see if there are any federal events in progress.

private ["_jail","_fedreserve","_altisBank","_blackwater","_timeRemainingJail","_timeRemainingFed","_timeRemainingBank","_timeRemainingBank1","_timeRemainingBank2","_timeRemainingBW"];

_jail = jailwall;
_fedreserve = fed_bank;
_bank = altis_bank;
_bank1 = altis_bank_1;
_bank2 = altis_bank_2;
_blackwater = nearestObject [[20898.6,19221.7,0.00143909],"Land_Dome_Big_F"];

//Check to see if there are any events in progress to trigger the timers
if ((_jail getVariable ["vaultTimer",0]) > serverTime) then {
	_timeRemainingJail = (_jail getVariable ["vaultTimer",0]) - serverTime;
	diag_log format ["vaultTimer: %1",_jail getVariable ["vaultTimer",0]];
	diag_log format ["Server Time: %1",serverTime];
	diag_log format ["Time: %1",time];
	[[_jail,_timeRemainingJail],"OEC_fnc_demoChargeTimer",player,false] spawn OEC_fnc_MP;
};

if ((_fedreserve getVariable ["vaultTimer",0]) > serverTime) then {
	_timeRemainingFed = (_fedreserve getVariable ["vaultTimer",0]) - serverTime;
	[[_fedreserve,_timeRemainingFed],"OEC_fnc_demoChargeTimer",player,false] spawn OEC_fnc_MP;
};

if ((_bank getVariable ["vaultTimer",0]) > serverTime) then {
	_timeRemainingBank = (_bank getVariable ["vaultTimer",0]) - serverTime;
	[[_bank,_timeRemainingBank],"OEC_fnc_demoChargeTimer",player,false] spawn OEC_fnc_MP;
};

if ((_bank1 getVariable ["vaultTimer",0]) > serverTime) then {
	_timeRemainingBank1 = (_bank1 getVariable ["vaultTimer",0]) - serverTime;
	[[_bank1,_timeRemainingBank1],"OEC_fnc_demoChargeTimer",player,false] spawn OEC_fnc_MP;
};

if ((_bank2 getVariable ["vaultTimer",0]) > serverTime) then {
	_timeRemainingBank2 = (_bank2 getVariable ["vaultTimer",0]) - serverTime;
	[[_bank2,_timeRemainingBank2],"OEC_fnc_demoChargeTimer",player,false] spawn OEC_fnc_MP;
};

// Subtracting 10 minutes (600s) since BW lasts 25 mins not 35
if (((_blackwater getVariable ["vaultTimer",0]) - 600) > serverTime) then {
	_timeRemainingBW = (_blackwater getVariable ["vaultTimer",0]) - serverTime;
	[[_blackwater,_timeRemainingBW],"OEC_fnc_demoChargeTimer",player,false] spawn OEC_fnc_MP;
};

