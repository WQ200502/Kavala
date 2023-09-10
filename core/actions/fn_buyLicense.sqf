//  File: fn_buyLicense.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Called when purchasing a license. May need to be revised.
if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

private _action = false;
private _type = _this select 3;
private _price = [_type] call OEC_fnc_licensePrice;
private _license = [_type,0] call OEC_fnc_licenseType;

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPos player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if(oev_atmcash < _price && oev_cash < _price) exitWith {hint format[localize "STR_NOTF_NE_1",[_price] call OEC_fnc_numberText,_license select 1];};

if(_type isEqualTo "vigilante") then {
	if !(O_stats_playtime_civ >= 120) exitWith {hint "你必须有2个小时的服务器上购买协警许可证！";};
	_action = [
		"你确定要买私刑许可证吗？如果您有叛军或工人保护许可证，他们将在购买时被吊销。",
		"确认",
		"是",
		"否"
	] call BIS_fnc_guiMessage;

	if (_action) then {
		license_civ_rebel = false;
		license_civ_wpl = false;
		player setVariable ["isVigi",true,true];
		if ((player getVariable ["vigilanteArrests",-1]) isEqualTo -1) then {
			player setVariable ["vigilanteArrests",0,true];
			[[3,player],"OES_fnc_vigiGetSetArrests",false,false] spawn OEC_fnc_MP;
		} else {
			oev_vigiarrests = player getVariable ["vigilanteArrests",0];
		};
		hint "如果你有以下许可证：叛军，工人保护。他们现在被撤销了！";
		[2] call OEC_fnc_ClupdatePartial;
	};
};

if(_type isEqualTo "rebel") then {
	_action = [
		"你确定要买叛军执照吗？如果您有赏金猎人或工人保护许可证，购买后将被吊销。",
		"确认",
		"是",
		"否"
	] call BIS_fnc_guiMessage;

	if (_action) then {
		if (license_civ_vigilante) then {
			player setVariable ["isVigi",false,true];
			player setVariable ["vigilanteArrests",0,true];
			[[3,player],"OES_fnc_vigiGetSetArrests",false,false] spawn OEC_fnc_MP;
		};
		license_civ_vigilante = false;
		license_civ_wpl = false;
		hint "如果你有以下执照：赏金猎人，工人保护。他们现在被撤销了！";
		[2] call OEC_fnc_ClupdatePartial;
	};
};

if(_type isEqualTo "wpl") then {
	_action = [
		"您确定要购买工人保护许可证吗？如果你有私刑或叛乱许可证（s），他们将被吊销后购买。",
		"确认",
		"是",
		"否"
	] call BIS_fnc_guiMessage;

	if (_action) then {
		if (license_civ_vigilante) then {
			player setVariable ["isVigi",false,true];
			[[3,player],"OES_fnc_vigiGetSetArrests",false,false] spawn OEC_fnc_MP;
			player setVariable ["vigilanteArrests",0,true];
		};
		license_civ_vigilante = false;
		license_civ_rebel = false;
		hint "如果你有叛军或赏金猎人的执照现在就被吊销了！";
		[2] call OEC_fnc_ClupdatePartial;
	};
};

if(!_action && (_type in ["wpl","rebel","vigilante"])) exitWith {};


if(oev_cash >= _price) then {
	oev_cash = oev_cash - _price;
	oev_cache_cash = oev_cache_cash - _price;
}else{
	oev_atmcash = oev_atmcash - _price;
	oev_cache_atmcash = oev_cache_atmcash - _price;
};

titleText[format["你购买了 %1 花费 %2元. 按ESC即可同步！", _license select 1,[_price] call OEC_fnc_numberText],"PLAIN DOWN"];
missionNamespace setVariable[(_license select 0),true];

if (_action && (_type isEqualTo "vigilante") && !(oev_inCombat)) then {[] call OEC_fnc_vigiNotify;};
