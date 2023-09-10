//  File: fn_seizePlayerItems.sqf
//	Description: Removes players weapons and virtual inventory items that are illegal, also removes gun and vig license

private["_illegalGear", "_illegal", "_inv", "_seizePhys", "_seizeVirt","_seizeMon","_cashSeized"];
params [
	["_seizeType",0,[0]], // 0 is default seize all, 1 = seize virt items only, 2 = seize physical only, 3 = seize money only
	["_cop",objNull,[objNull]]
];

_illegalGear = oev_illegal_gear;

// Determine what is to be seized
switch (_seizeType) do {
	case 0 : {
		_seizePhys = true;
		_seizeVirt = true;
		_seizeMon = true;
	};
	case 1 : {
		_seizePhys = false;
		_seizeVirt = true;
		_seizeMon = false;
	};
	case 2 : {
		_seizePhys = true;
		_seizeVirt = false;
		_seizeMon = false;
	};
	case 3 : {
		_seizePhys = false;
		_seizeVirt = false;
		_seizeMon = true;
	};
	default {
		_seizePhys = true;
		_seizeVirt = true;
		_seizeMon = true;
	};
};

// Physical items
if (_seizePhys) then {
	/* remove weapons from inventory */
	{if !(_x in oev_fake_weapons) then {player removeWeapon _x};} forEach weapons player;
	{if !(_x in oev_fake_weapons) then {player removeItemFromBackpack _x};} forEach weapons player;
	{if !(_x in oev_fake_weapons) then {player removeItemFromVest _x};} forEach weapons player;

	/* remove magazines from inventory */
	{player removeMagazine _x} forEach magazines player;

	if (uniform player in _illegalGear) then {removeUniform player;};
	if (vest player in _illegalGear) then {removeVest player;};
	if (headgear player in _illegalGear) then {removeHeadgear player;};
	if (backpack player in _illegalGear) then {removeBackpack player;};
	if (hmd player in _illegalGear) then {private _hmd = hmd player; player unassignItem _hmd; player removeItem _hmd;};

	// Check backback for illegal items
	if (backPack player != "") then {
		{
		  if (_x in _illegalGear) then {
		  	player removeItemFromBackpack _x;
		  };
		} forEach backpackItems player;
	};

	// Check uniform for illegal items
	if (uniform player != "") then {
		{
		  if (_x in _illegalGear) then {
		  	player removeItemFromUniform  _x;
		  };
		} forEach uniformItems player;
	};

	// Check vest for illegal items
	if (vest player != "") then {
		{
		  if (_x in _illegalGear) then {
		  	player removeItemFromVest  _x;
		  };
		} forEach vestItems player;
	};
};

if (_seizeVirt) then {
	//Illegal items
	_illegal = 0;
	_inv = [];
	private _hasDrugs = false;
	{
		_var = [_x select 0,0] call OEC_fnc_varHandle;
		_val = missionNamespace getVariable _var;
		if(_val > 0) then
		{
			if ((_x select 0) in oev_illegal_drugs) then {
				_hasDrugs = true;
			};
			_inv pushBack [_x select 0,_val];
			[false,(_x select 0),_val] call OEC_fnc_handleInv;
			_illegal = _illegal + ((_x select 1) * _val);
		};
	} foreach oev_illegal_items;

	if(count _inv > 0) then {
		if (_hasDrugs) then {
			[[getPlayerUID player,player getVariable["realname",name player],"15",player],"OES_fnc_wantedAdd",false,false] spawn OEC_fnc_MP;
		};

		[[getPlayerUID player,player getVariable["realname",name player],"14",player],"OES_fnc_wantedAdd",false,false] spawn OEC_fnc_MP;
		[_cop,_illegal,1,150,true] call OEC_fnc_splitPay;
	};
};

if (_seizeMon) then {
	_cashSeized = 0;

	[[1,"Seizing cash of suspect...",false,[profileName]],"OEC_fnc_broadcast",_cop,false] spawn OEC_fnc_MP;

	uiSleep random(2); // Prevents cops doing this at same time to get double cash
	uiSleep random(2);

	if (oev_cash > 0) then {
		_cashSeized = oev_cash;

		oev_cash = 0;
		oev_cache_cash = oev_random_cash_val;
		[0] call OEC_fnc_ClupdatePartial;

		[[1,"Suspect Cash Seized",false,[profileName]],"OEC_fnc_broadcast",_cop,false] spawn OEC_fnc_MP;
		[_cop,_cashSeized,0.5,150,true] call OEC_fnc_splitPay;
		[[0,format["%1 has seized $%2 from %3",name _cop, [_cashSeized] call OEC_fnc_numberText, name player]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
	} else {
		[[1,"STR_NOTF_SeizeCashFail",true,[profileName]],"OEC_fnc_broadcast",_cop,false] spawn OEC_fnc_MP;
	};
};

[false] call OEC_fnc_saveGear;
if !(oev_newsTeam) then {
	[3] call OEC_fnc_ClupdatePartial;
};

if (_seizePhys) then {
	titleText["All of your illegal weapons and gear have been seized.","PLAIN DOWN"];
	[
		["event","Physical Items Seized"],
		["player",name player],
		["player_id",getPlayerUID player],
		["officer",name _cop],
		["officer_id",getPlayerUID _cop],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
};
if (_seizeVirt) then {
	titleText["All of your illegal contraband and drugs have been seized.","PLAIN DOWN"];
	[
		["event","Virtual Items Seized"],
		["player",name player],
		["player_id",getPlayerUID player],
		["officer",name _cop],
		["officer_id",getPlayerUID _cop],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
};
if (_seizeMon) then {
	titleText["All of your cash on hand has been seized.","PLAIN DOWN"];
	[
		["event","Cash Seized"],
		["player",name player],
		["player_id",getPlayerUID player],
		["officer",name _cop],
		["officer_id",getPlayerUID _cop],
		["amount",_cashSeized],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
};
