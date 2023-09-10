// File: fn_giveDopamine

private["_target"];
_target = cursorTarget;
private _payout = 0;

if(isNull _target || !(isPlayer _target)) then {
	_target = player;
};

if(_target == player) then {
	if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
	if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

	if(!(player getVariable["epiActive",false])) exitWith {hint "部署完成";};

	if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
		[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPosATL player]] call OEC_fnc_logIt;
		[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
		[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
		["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
	};
	if(playerside isEqualTo civilian) then {
		profileNamespace setVariable ["epiActive",false];
	};

	if(oev_atmcash < 15000 && oev_cash < 15000) exitWith {hint format[localize "STR_NOTF_HS_NoCash",15000];};

	titleText["Please stand still.\nReceiving Dopamine...","PLAIN DOWN"];
	uiSleep 8;
	if(player distance (_this select 0) > 5) exitWith {titleText[localize "STR_NOTF_HS_ToFar","PLAIN DOWN"]};
	titleText[localize "STR_NOTF_HS_Healed","PLAIN DOWN"];
	player setVariable ["epiActive", false, true];
	player setVariable ["lastShot", serverTime, true];
	player setVariable ["epiTime", nil];
	_dam_obj = player;
	_dam_obj setdamage 0;
	// Current price of dopamine is 15000. If changed please change in fn_clientwiretransfer
	if (oev_cash >= 15000) then {
		oev_cash = oev_cash - 15000;
		oev_cache_cash = oev_cache_cash - 15000;
	} else {
		oev_atmcash = oev_atmcash - 15000;
		oev_cache_atmcash = oev_cache_atmcash - 15000;
	};

	private _crate = nearestObject [player,"Land_Cargo10_yellow_F"];
	if (isNull _crate) exitWith {};
	private _uid = _crate getVariable ["owner",""];
	if (_uid isEqualTo "") exitWith {};

	private _playerObject = objNull;
	{
		if(isPlayer _x && getPlayerUID _x isEqualTo _uid) exitWith {
			_playerObject = _x;
		};
	} forEach playableUnits;
	if !(isNull _playerObject) then {
		// [[15000,player,1],"OEC_fnc_clientWireTransfer",_playerObject,false] spawn OEC_fnc_MP;
		//[15000,player,1] remoteExec ["OEC_fnc_clientWireTransfer", _playerObject, false];
		[[3,15000, name player],"OEC_fnc_payPlayer",_playerObject,false] spawn OEC_fnc_MP;
	};
} else {
	if(isNull _target) exitWith {};

	if(!(_target getVariable["epiActive",false])) exitWith {hint "This player does not require dopamine.";};

	if(player distance _target > 3) exitWith {}; //Not close enough.

	//Fetch their name so we can shout it.
	_targetName = _target getVariable["realname","Unknown"];
	_title = format["Providing Dopamine to %1",_targetName];
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

	private _exit = false;
	while {true} do	{
		uiSleep 0.15;
		_cP = _cP + 0.01;
		_progressBar progressSetPosition _cP;
		_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
		if(_cP >= 1 || !alive player) exitWith {};
		if(oev_interrupted) exitWith {};
		if((player getVariable["restrained",false])) exitWith {};
		if(player distance _target > 3) exitWith {_exit = true;};
		if(!(_target getVariable["epiActive",FALSE])) exitWith {};
		if(_target getVariable["Reviving",ObjNull] != player) exitWith {};
	};

	//Kill the UI display and check for various states
	5 cutText ["","PLAIN DOWN"];
	[] spawn OEC_fnc_handleAnim;
	oev_action_inUse = false;
	if(_target getVariable ["Reviving",ObjNull] != player) exitWith {hint "Someone is already providing medical assistance."};
	_target setVariable["Reviving",NIL,TRUE];
	if !(alive player) exitWith {};
	if(!(_target getVariable["epiActive",FALSE])) exitWith {hint "Target no longer requires dopamine."};
	if((player getVariable["restrained",false])) exitWith {};
	if(_exit) exitWith {titleText[localize "STR_Medic_TooFar","PLAIN DOWN"]};
	if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]};
	if (((player distance (getMarkerPos "fed_reserve_1") < 700) && fed_bank getVariable ["chargeplaced",false]) || ((player distance (getMarkerPos "bw_marker") < 700) && life_bwObj getVariable ["chargeplaced",false]) || ((player distance (getMarkerPos "jail_marker") < 700) && jailwall getVariable ["chargeplaced",false])) then {
		_payout = 5000;
	} else {
		_payout = 10000;
	};
	if (isNull life_buddyObj) then {
		oev_atmcash = oev_atmcash + _payout;
		oev_cache_atmcash = oev_cache_atmcash + _payout;
	} else {
		if (!([life_buddyPID] call OEC_fnc_isUIDActive) || ((life_buddyObj distance player) > 2000)) exitWith {
			life_buddyObj = objNull;
			life_buddyPID = "";
			hint "Buddy no longer exists on the server or is too far away from you. Removing data... You will receive solo pay for this revive!";
			oev_atmcash = oev_atmcash + _payout;
			oev_cache_atmcash = oev_cache_atmcash + _payout;
		};
		_payout = round(_payout * 0.5);
		oev_atmcash = oev_atmcash + _payout;
		oev_cache_atmcash = oev_cache_atmcash + _payout;
		[[4,_payout, name player],"OEC_fnc_payPlayer",life_buddyObj,false] spawn OEC_fnc_MP;
	};

	titleText[format["You have administered dopamine to %1 and received $%2 for your services.",_targetName,[_payout] call OEC_fnc_numberText],"PLAIN DOWN"];

	_target setVariable ["epiActive", false, true];
	_target setVariable ["epiTime", nil];
	_target setVariable ["lastShot", serverTime, true];
	_dam_obj = _target;
	_dam_obj setdamage 0;
};
