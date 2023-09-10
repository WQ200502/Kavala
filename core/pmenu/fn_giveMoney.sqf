//  File: fn_giveMoney.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Gives the selected amount of money to the selected player.
private["_unit","_amount"];

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPosATL player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

_amount = ctrlText 30006;
if((lbCurSel 30007) == -1) exitWith {hint "No one was selected!"};
_unit = lbData [30007,lbCurSel 30007];
_unit = call compile format["%1",_unit];
/*
if(isNil "_unit") exitWith {ctrlShow[2001,true];};
if(_unit == player) exitWith {ctrlShow[2001,true];};
if(isNull _unit) exitWith {ctrlShow[2001,true];};
*/

//A series of checks *ugh*
if(!oev_use_atm) exitWith {hint "You recently robbed the gas station! You can't give money away just yet."};
if (player getVariable ["restrained",false]) exitWith {hint "You cannot give money while restrained.";};
if(call oev_restrictions) exitWith {hint "You are under player restrictions and cannot perform this action! Contact an administrator if you feel this is an error.";};
if(!([_amount] call OEC_fnc_isNumeric)) exitWith {hint "You didn't enter an actual number format."};
if(parseNumber(_amount) <= 0) exitWith {hint "You need to enter an actual amount you want to give."};
if(parseNumber(_amount) > oev_cash) exitWith {hint "You don't have that much to give!"};
if(isNull _unit) exitWith {};
if(isNil "_unit") exitWith {hint "The selected player is not within range"};
if (_unit getVariable ["restrained",false]) exitWith {hint "You cannot give money to restrained individuals.";};
if(_unit getVariable ["restrictions", false]) exitWith {hint "This player is under player restrictions and cannot recieve money transfers.";};
hint format["You gave $%1 to %2",[(parseNumber(_amount))] call OEC_fnc_numberText,_unit getVariable["realname",name _unit]];
oev_cash = oev_cash - (parseNumber(_amount));
oev_cache_cash = oev_cache_cash - (parseNumber(_amount));

[
	["event","Cash Transfer"],
	["player",name player],
	["player_id",getPlayerUID player],
	["target",name _unit],
	["target_id",getPlayerUID _unit],
	["value",parseNumber(_amount)],
	["position",getPosATL player]
] call OEC_fnc_logIt;

[0] call OEC_fnc_ClupdatePartial;
[[_unit,_amount,player],"OEC_fnc_receiveMoney",_unit,false] spawn OEC_fnc_MP;
