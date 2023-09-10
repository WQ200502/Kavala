//  File: fn_robShopReset.sqf
//    Author: Stevo
//    Modified by Serpico
//    Description: Starts a server side reset of the shops in case of player(robber) disconnect.


private["_shop","_marker","_time"];

//Make sure it's only running on the server...
if !(isServer) exitWith {};

//Assignments and nil checks
_shop = _this select 0;
_marker = _this select 1;
_time = _this select 2;
if(isNil "_marker") exitwith {};
if(isNil "_time" || _time <= 0) exitWith {};

//Reset action after time delay
uiSleep _time;

deleteMarker _marker;
_shop setVariable["status",false,true];