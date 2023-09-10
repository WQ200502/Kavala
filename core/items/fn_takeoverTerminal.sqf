//  File: fn_takeoverTerminal
//	Author: grar21
//	Modified by: Fraali
//	Description: Handles client-side actions for the HQ takeover

params [
["_mode", "", [""]],
["_obj_main", objNull, [objNull]],
["_hqNum", 0, [0]],
["_inHQ", "",[""]]
];

if (_mode == "addaction") exitWith {

	_obj_main addAction["Shutdown Terminal", {
		oev_action_inUse = true;
		_obj_main = _this select 0;
		_caller = _this select 1;
		_hqNum = _this select 3 select 0;
		_inHQ = _this select 3 select 1;
		5 cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable ["life_progress",displayNull];
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
		_title = "Shutting down HQ takeover terminal";
		_titleText ctrlSetText format["%2 (1%1)...","%",_title];
		_progressBar progressSetPosition 0.01;
		_cP = 0.01;
		["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
		for "_i" from 0 to 1 step 0 do {
			uisleep 0.3;
			_cP = _cP + 0.01;
			_progressBar progressSetPosition _cP;
			_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
			if (_cP >= 1) exitWith {
				[
					["event","Ended HQ Takeover"],
					["player",name _caller],
					["player_id", getPlayerUID _caller],
					["target_hq", _inHQ],
					["target_pos", getPos (_this select 0)],
					["servertime", round serverTime]
				] call OEC_fnc_logIt;
				(oev_hqtakeover select _hqNum) set [0, false];
				publicVariable "oev_hqtakeover";
			 };
			if (!alive player) exitWith {};
			if ((player distance _obj_main) > 4) exitWith {hint "你走得太远了！";};
			if (oev_interrupted) exitWith {oev_interrupted = false;titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"];};
			if (player getVariable["restrained",false]) exitWith {};
		};
		oev_action_inUse = false;
		5 cutText ["","PLAIN DOWN"];
		[] spawn OEC_fnc_handleAnim;
	},[_hqNum,_inHQ],1.5,false,false,"","!oev_action_inUse && (player distance _target) < 4 && vehicle player isEqualTo player"];
};
_obj_main = player;

takeoverObj = "Land_DataTerminal_01_F" createVehicleLocal [0,0,0]; // Create terminal clientside
[takeoverObj, "red","red","red"] call BIS_fnc_DataTerminalColor;
takeoverObj attachTo[_obj_main,[0,2,0.05]];

_inHQ = "";
_hqSelect = [false,0];
_terminalpos = getPosATL takeoverObj;
_terminalPos set [2,(_terminalPos select 2) - (getPos takeoverObj select 2)];
_terminaldir = getDir takeoverObj;
_termParams = {
	switch (true) do {
		case (_terminalpos inPolygon oev_kavalaHQPoly): {_inHQ = "Kavala"; _hqSelect = oev_hqtakeover select 0};
		case (_terminalpos inPolygon oev_pyrgosHQPoly): {_inHQ = "Pyrgos"; _hqSelect = oev_hqtakeover select 1};
		case (_terminalpos inPolygon oev_athiraHQPoly): {_inHQ = "Athira"; _hqSelect = oev_hqtakeover select 2};
		case (_terminalpos inPolygon oev_airHQPoly): {_inHQ = "Air"; _hqSelect = oev_hqtakeover select 3};
		case (_terminalpos inPolygon oev_sofiaHQPoly): {_inHQ = "Sofia"; _hqSelect = oev_hqtakeover select 4};
		case (_terminalpos inPolygon oev_neochoriHQPoly): {_inHQ = "Neochori"; _hqSelect = oev_hqtakeover select 5};
		case (_terminalpos inPolygon oev_bwHQPoly): {_inHQ = "Blackwater"; _hqSelect = oev_hqtakeover select 6};
		default {_inHQ = ""; _hqSelect = [false,0];};
	};
};
_remHQTerm = {
	detach takeoverObj;
	deleteVehicle takeoverObj;
	player removeAction life_startTakeover;
	player removeAction life_cancelTakeover;
	life_startTakeover = nil;
	life_cancelTakeover = nil;
};
call _termParams;
if (_hqSelect select 0 isEqualTo true) exitWith {hint "总部已经被接管了！";}; //Check if current HQ has an active takeover
if ((_hqSelect select 1) != 0 && ((_hqSelect select 1) + 900) >= serverTime) exitWith {hint "最近总部被接管了！"; call _remHQTerm;}; //If theres been an HQ takeover at the current HQ within the past 15 minutes, you cannot start it.
if (jailwall getVariable ["chargeplaced",false] || fed_bank getVariable ["chargeplaced",false] || (nearestObject [[20898.6,19221.7,0.00143909],"Land_Dome_Big_F"]) getVariable ["chargeplaced",false]) exitWith {hint "你不能用一个活跃的联邦事件来启动总部接管！"};
if (altis_bank getVariable ["chargeplaced",false] || altis_bank_1 getVariable ["chargeplaced",false] || altis_bank_2 getVariable ["chargeplaced",false] && _inHQ isEqualTo "Pyrgos") exitWith {hint "当一家银行活跃时，你不能在皮尔戈斯发起收购！"};
if !(isNull objectParent player) exitWith {hint "你不能把它放在车里！";};

oev_action_inUse = true;

life_startTakeover = _obj_main addAction["<t color='#00FF00'>放置终端</t>",{
	private ["_remHQTerm","_termParams"];
	_args = _this select 3;
	_remHQTerm = _args select 0;
	_termParams = _args select 1;
	_inHQ = "";
	_hqSelect = [false,0];
	_terminalpos = getPosATL takeoverObj;
	_terminalPos set [2,(_terminalPos select 2) - (getPos takeoverObj select 2)];
	_terminaldir = getDir takeoverObj;
	uiSleep random(1);
	if (_hqSelect select 0 isEqualTo true) exitWith {hint "总部已经被接管了！";}; //Check if current HQ has an active takeover
	if ((_hqSelect select 1) != 0 && ((_hqSelect select 1) + 900) >= serverTime) exitWith {hint "最近总部被接管了！";}; //If theres been an HQ takeover at the current HQ within the past 15 minutes, you cannot start it.
	if (jailwall getVariable ["chargeplaced",false] || fed_bank getVariable ["chargeplaced",false] || (nearestObject [[20898.6,19221.7,0.00143909],"Land_Dome_Big_F"]) getVariable ["chargeplaced",false]) exitWith {hint "你不能用一个活跃的联邦事件来启动总部接管！"};
	if (altis_bank getVariable ["chargeplaced",false] || altis_bank_1 getVariable ["chargeplaced",false] || altis_bank_2 getVariable ["chargeplaced",false] && _inHQ isEqualTo "Pyrgos") exitWith {hint "当一家银行活跃时，你不能在皮尔戈斯发起收购！"};
	if !(isNull objectParent player) exitWith {hint "你不能把它放在车里！";};
	call _termParams;
	_isColliding = [takeoverObj, [0.7,0.275,0.5]] call OEC_fnc_realCollide; // Is the terminal colliding
	_canSee = lineIntersectsSurfaces [[getPosASL player select 0,getPosASL player select 1,(getPosASL player select 2) + 1.4], [(getPosASL takeoverObj select 0),(getPosASL takeoverObj select 1),(getPosASL takeoverObj select 2) + 0.5], player, takeoverObj];
	if !((_hqSelect) select 0) then { // HQ Takeover not active
		if (_inHQ != "") then { // What HQ is being taken over
			if (!(_isColliding)) then {
				if (_canSee isEqualTo []) then {
					if !(surfaceIsWater _terminalPos) then {
						if ((getPos takeoverObj select 2) < 2) then {//If the object is more than 2m off the floor
							_close = false;
							[player, _terminalpos, _terminaldir, _inHQ] remoteExec ["OES_fnc_hqTakeover",2];
							[false,"takeoverterminal",1] call OEC_fnc_handleInv;
							call _remHQTerm;
						} else {
							hint "你不能把终端放在空中！";
						};
					} else {
						hint "您不能将终端机置于水下！";
					};
				} else {
					hint "您无法放置看不见的东西！";
				};
			} else {
				hint "对象与另一个对象相撞，放置被阻止。";
			};
		} else {
			hint "终端必须放置在总部内！";
		};
	} else { // if theres already one placed
		call _remHQTerm;
		hint "已经有一个活跃的总部接管！";
	};
	// outside checks?
},[_remHQTerm, _termParams],1.5,false,false,"","车辆玩家等同于玩家和活动玩家"];

life_cancelTakeover = _obj_main addAction ["<t color='#FF0000'>停止放置</t>", {
	private["_remHQTerm"];
	_remHQTerm = _this select 3 select 0;
	call _remHQTerm;
},[_remHQTerm],1.5,false,false,"","车辆玩家等同于玩家和活动玩家"];

while{true} do {
	if (!alive player) exitWith {call _remHQTerm; oev_action_inUse = false; false;};
	if (oev_restrainMon) exitWith {call _remHQTerm; false;};
	if (isNull takeoverObj) exitWith {oev_action_inUse = false; false;};
};
