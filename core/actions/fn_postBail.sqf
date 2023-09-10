//  File: fn_postBail.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Called when the player attempts to post bail.
//	Needs to be revised.
private["_unit"];
_unit = _this select 1;

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPos player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if(oev_bail_paid) exitWith {};
if(isNil {life_bail_amount}) then {life_bail_amount = 3500;};
if(!isNil "oev_canpay_bail") exitWith {hint localize "STR_NOTF_Bail_Post"};
if(oev_atmcash < life_bail_amount && oev_cash < life_bail_amount) exitWith {hint format[localize "STR_NOTF_Bail_NotEnough",life_bail_amount];};

if(oev_cash >= life_bail_amount) then {
	oev_cash = oev_cash - life_bail_amount;
	oev_cache_cash = oev_cache_cash - life_bail_amount;
}else{
	oev_atmcash = oev_atmcash - life_bail_amount;
	oev_cache_atmcash = oev_cache_atmcash - life_bail_amount;
};

oev_bail_paid = true;
[1] call OEC_fnc_ClupdatePartial;
[[0,"STR_NOTF_Bail_Bailed",true,[profileName]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
