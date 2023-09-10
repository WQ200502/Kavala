//	File: fnDepositBoxRedeemed.sqf
//	Author: Zahzi
//	Description: Call deposit box server side

#include "..\..\macro.h"
if(scriptAvailable(60)) exitWith {
  hint "You cannot check your deposit box balance again for 60 seconds.";
};

[player] remoteExec ["OES_fnc_redeemDepositBox",2,false];
