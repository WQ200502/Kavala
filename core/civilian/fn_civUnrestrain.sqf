//  File: fn_civUnrestrain.sqf

private["_ui","_pgText","_cP","_progress","_esc","_sleep","_msg"];
params [
	["_targetPlayer",objNull,[objNull]]
];

if (player distance _targetPlayer > 4) exitWith {hint "You are too far away."};
_esc = false;
if (license_civ_vigilante) exitWith {
	//Start a progress bar to unrestrain
	disableSerialization;
	oev_action_inUse = true;
	"progressBar" cutRsc ["life_progress","PLAIN DOWN"];
	_ui = uiNamespace getVariable "life_progress";
	_progress = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText format ["Unrestraining (1%1)...","%"];
	_progress progressSetPosition 0.01;
	_cP = 0.01;

	for "_i" from 0 to 1 step 0 do {
	    if (animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
	        player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	    };

	    uiSleep 0.26;
	    _cP = _cP + 0.01;
	    _progress progressSetPosition _cP;
	    _pgText ctrlSetText format ["Unrestraining (%2%1)...","%",round(_cP * 100)];
	    if (_cP >= 1) exitWith {};
	    if (_targetPlayer getVariable ["downed",false]) exitWith {_esc = true;};
		if (player getVariable ["downed",false]) exitWith {_esc = true;};
	    if (!alive player) exitWith {_esc = true;};
	    if !(isNull objectParent player) exitWith {_esc = true;};
	    if (oev_interrupted) exitWith {_esc = true;};
	    if (player distance _targetPlayer > 4) exitWith {_esc = true;};
		if (vehicle player != player) exitWith {_esc = true;};
	};
	oev_action_inUse = false;
	"progressBar" cutText ["","PLAIN DOWN"];
	player playActionNow "stop";
	player playMoveNow "stop";
	if (oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
	if (_esc) exitWith {};
	[_targetPlayer] call OEC_fnc_unrest1rain;
	_targetPlayer setVariable["restrained",false,true];
	_targetPlayer setVariable["zipTied",false,true];
	_targetPlayer setVariable["Escorting",false,true];
	_targetPlayer setVariable["transporting",false,true];
	_targetPlayer setVariable ["playerSurrender",false,true];
};

if !(license_civ_vigilante) exitWith {
	closeDialog 0;
	if (_targetPlayer getVariable["zipTied",false]) then {
		//Start a progress bar to unrestrain
		disableSerialization;
		oev_action_inUse = true;
		"progressBar" cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
		_progress = _ui displayCtrl 38201;
		_pgText = _ui displayCtrl 38202;
		_pgText ctrlSetText format ["Unrestraining (1%1)...","%"];
		_progress progressSetPosition 0.01;
		_cP = 0.01;
		["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
		for "_i" from 0 to 1 step 0 do {
		    uiSleep 0.26;
		    _cP = _cP + 0.01;
		    _progress progressSetPosition _cP;
		    _pgText ctrlSetText format ["Unrestraining (%2%1)...","%",round(_cP * 100)];
		    if (_cP >= 1) exitWith {};
		    if (_targetPlayer getVariable ["downed",false]) exitWith {_esc = true;};
			if (player getVariable ["downed",false]) exitWith {_esc = true;};
		    if (!alive player) exitWith {_esc = true;};
		    if !(isNull objectParent player) exitWith {_esc = true;};
		    if (oev_interrupted) exitWith {_esc = true;};
		    if (player distance _targetPlayer > 4) exitWith {_esc = true;};
			if (vehicle player != player) exitWith {_esc = true;};
		};
		oev_action_inUse = false;
		"progressBar" cutText ["","PLAIN DOWN"];
		[] spawn OEC_fnc_handleAnim;
		if (oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
		if (_esc) exitWith {};
		[_targetPlayer] call OEC_fnc_unrest1rain;
		_targetPlayer setVariable["restrained",false,true];
		_targetPlayer setVariable["zipTied",false,true];
		_targetPlayer setVariable["Escorting",false,true];
		_targetPlayer setVariable["transporting",false,true];
		_targetPlayer setVariable ["playerSurrender",false,true];
	} else {
		_sleep = 1;
		_msg = "";
		if (life_inv_lockpick > 0) then {
			_sleep = 0.26;
			_msg = "Using lockpick";
		};
		if (life_inv_boltcutter > 0) then {
			_sleep = 0.195; //25% buff
			_msg = "Using boltcutter";
		};
		//No item
		if(_sleep isEqualTo 1) exitWith {hint "You do not have any lockpicks or boltcutters on you."};

		//Start a progress bar to unrestrain
		hint _msg;
		disableSerialization;
		oev_action_inUse = true;
		"progressBar" cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
		_progress = _ui displayCtrl 38201;
		_pgText = _ui displayCtrl 38202;
		_pgText ctrlSetText format ["Unrestraining (1%1)...","%"];
		_progress progressSetPosition 0.01;
		_cP = 0.01;
		["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
		for "_i" from 0 to 1 step 0 do {
				uiSleep _sleep;
				_cP = _cP + 0.01;
				_progress progressSetPosition _cP;
				_pgText ctrlSetText format ["Unrestraining (%2%1)...","%",round(_cP * 100)];
				if (_cP >= 1) exitWith {};
				if (_targetPlayer getVariable ["downed",false]) exitWith {_esc = true;};
			if (player getVariable ["downed",false]) exitWith {_esc = true;};
				if (!alive player) exitWith {_esc = true;};
				if !(isNull objectParent player) exitWith {_esc = true;};
				if (oev_interrupted) exitWith {_esc = true;};
				if (player distance _targetPlayer > 4) exitWith {_esc = true;};
			if (vehicle player != player) exitWith {_esc = true;};
		};
		oev_action_inUse = false;
		"progressBar" cutText ["","PLAIN DOWN"];
		[] spawn OEC_fnc_handleAnim;
		if (oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
		if(_sleep isEqualTo 0.26) then {
			if !([false,"lockpick",1] call OEC_fnc_handleInv) exitWith {_esc = true;};
		};
		if (_esc) exitWith {};
		[_targetPlayer] call OEC_fnc_unrest1rain;
		_targetPlayer setVariable["restrained",false,true];
		_targetPlayer setVariable["zipTied",false,true];
		_targetPlayer setVariable["Escorting",false,true];
		_targetPlayer setVariable["transporting",false,true];
		_targetPlayer setVariable ["playerSurrender",false,true];
	};
};
