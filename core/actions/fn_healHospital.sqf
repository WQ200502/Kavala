//  File: fn_healHospital.sqf
//	Author: Bryan "Tonic" Boardwine
//	Modified: Jesse "tkcjesse" Schultz

//	Description: Script used on hospital NPCs to heal players back to full health
if (oev_action_inUse) exitWith {};
if (isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if (isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};
if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPos player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};
if (oev_atmcash < 1000 && oev_atmcash < 1000) exitWith {hint format[localize "STR_NOTF_HS_NoCash",[1000] call OEC_fnc_numberText];};

oev_action_inUse = true;
_action = [
	"Spend $1,000 to be fully healed?",
	"Olympus Medical Doctor",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if(_action) then {
	titleText[localize "STR_NOTF_HS_Healing","PLAIN DOWN"];
	closeDialog 0;
	uiSleep 6.3;
	if(player distance (_this select 0) > 5) exitWith {oev_action_inUse = false; titleText[localize "STR_NOTF_HS_ToFar","PLAIN DOWN"]};
	player setVariable["kidneyRemoved",false,true];
	uisleep 1.7;
	titleText[localize "STR_NOTF_HS_Healed","PLAIN DOWN"];
	private _dam_obj = player;
	_dam_obj setDamage 0;
	oev_hunger = 100;
	oev_thirst = 100;
	[] call OEC_fnc_hudUpdate;
	if (oev_cash >= 1000) then {
		oev_cash = oev_cash - 1000;
		oev_cache_cash = oev_cache_cash - 1000;
	} else {
		oev_atmcash = oev_atmcash - 1000;
		oev_cache_atmcash = oev_cache_atmcash - 1000;
	};
	oev_action_inUse = false;
} else {
	hint localize "STR_NOTF_ActionCancel";
	closeDialog 0;
	oev_action_inUse = false;
};
