// File: fn_replaceKidney

private["_target"];
_target = cursorTarget;

if(isNull _target || !(isPlayer _target)) then {
	_target = player;
};

if(_target == player) then {
	if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
	if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

	if(!(player getVariable["kidneyRemoved",false])) exitWith {hint "You already have a kidney!";};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPosATL player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

	if(playerside isEqualTo civilian) then {
		profileNamespace setVariable ["kidneyRemoved",false];
	};

	if(oev_atmcash < 1000 && oev_cash < 1000) exitWith {hint format[localize "STR_NOTF_HS_NoCash",1000];};

	titleText["Please stand still.\nReceiving a new kidney...","PLAIN DOWN"];
	uiSleep 8;
	if(player distance (_this select 0) > 5) exitWith {titleText[localize "STR_NOTF_HS_ToFar","PLAIN DOWN"]};
	titleText[localize "STR_NOTF_HS_Healed","PLAIN DOWN"];
	player setVariable["kidneyRemoved",false, true];
	_dam_obj = player;
	_dam_obj setdamage 0;

	if(oev_cash >= 1000) then {
		oev_cash = oev_cash - 1000;
		oev_cache_cash = oev_cache_cash - 1000;
	}else{
		oev_atmcash = oev_atmcash - 1000;
		oev_cache_atmcash = oev_cache_atmcash - 1000;
	};
}else{
	if(isNull _target) exitWith {};

	if(!(_target getVariable["kidneyRemoved",false])) exitWith {hint "This player does not require a kidney transplant.";};

	if(player distance _target > 3) exitWith {}; //Not close enough.

	//Fetch their name so we can shout it.
	_targetName = _target getVariable["realname","Unknown"];
	_title = format["Transplanting a new kidney to %1",_targetName];
	oev_action_inUse = true; //Lockout the controls.

	_target setVariable["Reviving",player,TRUE];
	//Setup our progress bar
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN DOWN"];
	_ui = uiNamespace getVariable ["life_progress",displayNull];
	_progressBar = _ui displayCtrl 38201;
	_titleText = _ui displayCtrl 38202;
	_titleText ctrlSetText format["%2 (1%1)...","%",_title];
	_progressBar progressSetPosition 0.01;
	_cP = 0.01;

	["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
	while {true} do
	{
		uiSleep 0.15;
		_cP = _cP + 0.01;
		_progressBar progressSetPosition _cP;
		_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
		if(_cP >= 1 || !alive player) exitWith {};
		if(oev_interrupted) exitWith {};
		if((player getVariable["restrained",false])) exitWith {};
		if(player distance _target > 4) exitWith {_badDistance = true;};
		if(!(_target getVariable["kidneyRemoved",false])) exitWith {};
		if(_target getVariable["Reviving",ObjNull] != player) exitWith {};
	};

	//Kill the UI display and check for various states
	5 cutText ["","PLAIN DOWN"];
	[] spawn OEC_fnc_handleAnim;
	if(_target getVariable ["Reviving",ObjNull] != player) exitWith {hint "Someone is already providing medical assistance."};
	_target setVariable["Reviving",NIL,TRUE];
	if !(alive player) exitWith {oev_action_inUse = false;};
	if(!(_target getVariable["kidneyRemoved",false])) exitWith {hint "Target no longer requires a kidney transplant."};
	if(player getVariable["restrained",false]) exitWith {oev_action_inUse = false;};
	if(!isNil "_badDistance") exitWith {titleText[localize "STR_Medic_TooFar","PLAIN DOWN"]; oev_action_inUse = false;};
	if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};

	private _payout = 2500;
	if (isNull life_buddyObj) then {
		oev_atmcash = oev_atmcash + _payout;
		oev_cache_atmcash = oev_cache_atmcash + _payout;
	} else {
		if (!([life_buddyPID] call OEC_fnc_isUIDActive) || ((life_buddyObj distance player) > 2000)) exitWith {
			life_buddyObj = objNull;
			life_buddyPID = "";
			hint "Buddy no longer exists on the server or is too far away from you. Removing data... You will recieve solo pay for this revive!";
			oev_atmcash = oev_atmcash + _payout;
			oev_cache_atmcash = oev_cache_atmcash + _payout;
		};
		_payout = round(_payout * 0.5);
		oev_atmcash = oev_atmcash + _payout;
		oev_cache_atmcash = oev_cache_atmcash + _payout;
		[[4,_payout, name player],"OEC_fnc_payPlayer",life_buddyObj,false] spawn OEC_fnc_MP;
	};
	titleText[format["You have replaced %1's kidney and received $%2 for your services.",_targetName,[_payout] call OEC_fnc_numberText],"PLAIN DOWN"];

	oev_action_inUse = false;

	_target setVariable["kidneyRemoved", false, true];
	_target setVariable["kidneyTime",nil];
	_dam_obj = _target;
	_dam_obj setdamage 0;
};
