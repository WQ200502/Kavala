//  File: fn_sellLicense.sqf
//	Author: [OS] Odin
//	Description: Called when selling a license. May need to be revised.
private["_type"];

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

_type = _this select 3;

_price = [_type] call OEC_fnc_licensePrice;
_license = [_type,0] call OEC_fnc_licenseType;

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPosATL player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if(_type == "wpl") then {
	if(license_civ_wpl) then {
		license_civ_wpl = false;
		hint "您的工人保护证已半价退还。";
	};
};

oev_atmcash = oev_atmcash + (_price * 0.5);
oev_cache_atmcash = oev_cache_atmcash + (_price * 0.5);
titleText[format[localize "STR_NOTF_S_1", _license select 1,[(_price * 0.5)] call OEC_fnc_numberText],"PLAIN DOWN"];
