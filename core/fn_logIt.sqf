//  File: fn_logIt.sqf | Client
//	Author: Tech
//	Description: Sends log to HC if its on. Otherwise send to server

if(life_HC_isActive) then {
  _this remoteExec ["HC_fnc_logIt",HC_ID];
} else {
  _this remoteExec ["OES_fnc_logIt",2];
};
