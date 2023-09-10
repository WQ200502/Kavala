//  File: fn_serviceChopper.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Main functionality for the chopper service paid, to be replaced in later version.
disableSerialization;
private["_search","_ui","_progress","_cP","_pgText","_title"];

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPosATL player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if(oev_action_inUse) exitWith {hint localize "STR_NOTF_Action"};
_search = nearestObjects[getPos air_sp, ["Air"],5];
if(count _search == 0) exitWith {hint localize "STR_Service_Chopper_NoAir"};
if(oev_atmcash < 1000 && oev_cash < 1000) exitWith {hint localize "STR_Serive_Chopper_NotEnough"};

if(oev_cash >= 1000) then {
	oev_cash = oev_cash - 1000;
	oev_cache_cash = oev_cache_cash - 1000;
}else{
	oev_atmcash = oev_atmcash - 1000;
	oev_cache_atmcash = oev_cache_atmcash - 1000;
};

oev_action_inUse = true;
_title = localize "STR_Service_Chopper_Servicing";
5 cutRsc ["life_progress","PLAIN DOWN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_title];
_progress progressSetPosition 0.01;
_cP = 0.01;

while {true} do
{
	uiSleep  0.2;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%2 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1) exitWith {};
};

if(!alive (_search select 0) || (_search select 0) distance air_sp > 10) exitWith {oev_action_inUse = false; hint localize "STR_Service_Chopper_Missing"};
if(!local (_search select 0)) then
{
	[[(_search select 0),1],"OEC_fnc_setFuel",(_search select 0),false] spawn OEC_fnc_MP;
}
	else
{
	(_search select 0) setFuel 1;
};
_dam_obj = (_search select 0);
_dam_obj setDamage 0;

5 cutText ["","PLAIN DOWN"];
titleText [localize "STR_Service_Chopper_Done","PLAIN DOWN"];
oev_action_inUse = false;
