//  File: fn_handleDowned.sqf
//	Description: Downed state for rubber bullets

private["_obj","_inVehicle","_time","_downed","_hndlBlur","_hndlBlack","_eff1","_eff2","_effects","_dead","_magazine"];
params [
	["_source",objNull,[objNull]]
];

if (visibleMap) then {
	openMap false;
};

private _dam_obj = player;
if (player getVariable ["restrained",false] && player != vehicle player) exitWith {};
if (player getVariable ["restrained",false]) exitWith {_dam_obj setDamage 0.9;};
if (player getVariable ["downed",false]) exitWith {_dam_obj setDamage 0.9;};

_dam_obj setDamage 0;

if (isNull((_source getVariable ["tazedBy",[objNull,0]]) select 0)) then {
	if (_source getVariable ["isVigi",false]) then {
		player setVariable["tazedBy",[_source,1],true];
	};
	if (side _source == west) then {
		player setVariable["tazedBy",[_source,2],true];
	};
};

if !(oev_isDowned) then {
	//Stops movement
	(findDisplay 46) displaySetEventHandler ["KeyDown","if !([(_this select 1)] in [(actionKeys 'voiceOverNet'),(actionKeys 'pushToTalk')]) then {true}else{false}"];
	_mouseZHandle = (findDisplay 46) displayAddEventHandler ["MouseZchanged",{true;}];

	oev_isDowned = true;
	_inVehicle = false;

	player setVariable["downed",true,true];
	player setVariable["receiveFirstAid",false,false];

	if (isNull objectParent player) then {
		_obj = "Land_ClutterCutter_small_F" createVehicle (getPosATL player);
		_obj setPosATL (getPosATL player);
		player attachTo [_obj,[0,0,0]];
		[[player,"AinjPfalMstpSnonWnonDf_carried_fallwc"],"OEC_fnc_animSync",-2,false] spawn OEC_fnc_MP;
		_inVehicle = false;
	} else {
		_inVehicle = true;
	};

	_hndlBlur = ppEffectCreate ["DynamicBlur", 501];
	_hndlBlur ppEffectEnable true;
	_hndlBlur ppEffectAdjust [5];
	_hndlBlur ppEffectCommit 0;

	_hndlBlack = ppEffectCreate ["colorCorrections", 1501];
	_hndlBlack ppEffectEnable true;
	_hndlBlack ppEffectAdjust [1.0, 1.0, 0.0, [0, 0, 0, 0.9], [1.0, 1.0, 1.0, 1.0],[1.0, 1.0, 1.0, 0.0]];
	_hndlBlack ppEffectCommit 0;
	_effects = true;
	_eff1 = 5;
	_eff2 = 0.9;
	_time = 0;
	_downed = true;
	_dead = false;

	private _logTemplate = if (_source call OEC_fnc_isAtWar) then {
		"STR_NOTF_EnemyTaze"
	} else {
		"STR_NOTF_Tazed"
	};

	[0,_logTemplate,true,[profileName, _source getVariable["realname",name _source]]] remoteExec ["OEC_fnc_broadcast",-2];
	[
		["event", "Player Tase"],
		["player", name _source],
		["player_id", getPlayerUID _source],
		["player_side", side _source],
		["player_position", getPos _source],
		["target", name player],
		["target_id", getPlayerUID player],
		["target_position", getPos player]
	] call OEC_fnc_logIt;

	while {_downed} do {
		if !(alive player) then {downed = false; _dead = true};
		if (player getVariable ["restrained",false]) then {_downed = false};
		if !(_inVehicle) then {
			if (_time isEqualTo 5) then {player playMoveNow "AinjPpneMstpSnonWnonDnon"};
			if (_time isEqualTo 30) then {player playMoveNow "AmovPpneMstpSnonWnonDnon"};
		};
		if (isNull objectParent player && _inVehicle) then {
			_obj = "Land_ClutterCutter_small_F" createVehicle (getPosATL player);
			_obj setPosATL (getPosATL player);
			player attachTo [_obj,[0,0,0]];
			[[player,"AinjPfalMstpSnonWnonDf_carried_fallwc"],"OEC_fnc_animSync",-2,false] spawn OEC_fnc_MP;
			_inVehicle = false;
		};
		if (_time isEqualTo 30) exitWith {_downed = false};
		_time = _time + 1;
		uiSleep 1;
	};

	[_hndlBlur,_hndlBlack,_eff1,_eff2,_effects] spawn{
		_hndlBlur = _this select 0;
		_hndlBlack = _this select 1;
		_eff1 = _this select 2;
		_eff2 = _this select 3;
		_effects = _this select 4;

		while {_effects} do {
			_eff1 = _eff1 - 0.025;
			_eff2 = _eff2 - 0.0045;

			_hndlBlur ppEffectAdjust [_eff1];
			_hndlBlur ppEffectCommit 0;

			_hndlBlack ppEffectAdjust [1.0, 1.0, 0.0, [0, 0, 0, _eff2], [1.0, 1.0, 1.0, 1.0],[1.0, 1.0, 1.0, 0.0]];
			_hndlBlack ppEffectCommit 0;

			uiSleep 0.01;
			if (_eff2 <= 0) then {_effects = false;};
		};
		ppEffectDestroy _hndlBlur;
		ppEffectDestroy _hndlBlack;
	};
	if !(_inVehicle) then{
		detach player;
		deleteVehicle _obj;
	};

	if !(_dead) then {
		_dam_obj setDamage 0.9;
	};
	oev_isDowned = false;
	oev_action_inUse = false;
	player setVariable["downed",false,true];
	player setVariable ["tazedBy",[objNull,0],true];

// Re-enables movement
	(findDisplay 46) displaySetEventHandler ["KeyDown", "_this call OEC_fnc_keyHandler"];
	(findDisplay 46) displayRemoveEventHandler ["MouseZchanged",_mouseZHandle];
};
