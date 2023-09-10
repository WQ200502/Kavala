//  File: fn_casinoSlots.sqf
//	Author: Tech
//	Description: Casino slots

params [
  ["_type", "", [""]]
];

private ["_display", "_itemPrefix", "_iconList", "_text1", "_enable", "_list", "_symbol", "_symbols", "_pos", "_wait", "_symbol1", "_symbol2", "_symbol3", "_symbol1Odds", "_symbol2Odds", "_symbol3Odds", "_indexes", "_count", "_check", "_middle", "_ctrl", "_return", "_pick", "_countArray", "_multiply", "_amount", "_landOn", "_current", "_final", "_spinScript", "_new", "_allCtrls", "_numString"];

oev_inCasino = true;

_display = findDisplay 20002;
if(_type isEqualTo "init") then {
  _display displaySetEventHandler ["KeyDown", "if ((_this select 1) isEqualTo 1) then {oev_inCasino = false;};"];
};

_itemPrefix = "images\icons\items\";

_iconList = ["images\icons\olympus.paa", "images\icons\money.paa", "redgull.paa", "apple.paa", "goldbar.paa", "blastingcharge.paa", "crystalmeth.paa", "epiPen.paa", "defib.paa", "emerald.paa", "frog.paa"];

_ctrlList = [3001, 3002, 2000];

if(_type != "spin") then {
  _text1 = _display displayCtrl 3000; //Your Money
  _text1 ctrlSetText format ["你的资金 $%1", [oev_atmcash] call OEC_fnc_numberText];
};

_lclChangeCtrlEnable = {
  params["_list", "_enable"];
  {
    ctrlEnable [_x, _enable];
  } forEach _list;
};

_lclMoveSymbol = {
  params ["_symbol","_pos","_wait"];
  _symbol ctrlSetPosition _pos;
  _symbol ctrlCommit 0.2;
  if(_wait) then {
    waitUntil {ctrlCommitted _symbol;};
  };
};

_lclGetResult = {
  _symbol1 = -1;
  _symbol2 = -1;
  _symbol3 = -1;

  for "_i" from 0 to (ceil (random 20)) do {
    _symbol1 = ceil (random 99);
  };
  for "_i" from 0 to (ceil (random 20)) do {
    _symbol2 = ceil (random 99);
  };
  for "_i" from 0 to (ceil (random 20)) do {
    _symbol3 = ceil (random 99);
  };

  _symbol1Odds = [1, 7, 10, 30, 3, 10, 10, 10, 9, 6, 4]; //totals to 100
  _symbol2Odds = [7, 2, 10, 30, 3, 6, 12, 10, 10, 6, 4];
  _symbol3Odds = [1, 6, 13, 30, 3, 10, 9, 10, 11, 3, 4];


  _indexes = [];
  {
    _count = 1;
    _check = -1;
    switch (_forEachIndex) do {
        case 0: {_check = _symbol1;};
        case 1: {_check = _symbol2;};
        case 2: {_check = _symbol3;};
    };
    {
      if(_check >= _count && _check < _count+_x) exitWith {
        _indexes pushBack _forEachIndex;
      };
      _count = _count + _x;
    } forEach _x;
  } forEach [_symbol1Odds, _symbol2Odds, _symbol3Odds];

  _indexes;
  //systemChat ([str _symbol1, str _index] joinString " - ");
};

_lclSymbolSpin = {
  params["_middle", "_display", "_iconList", "_itemPrefix"];
  _return = [];

  //Move middle out of the way
  {
    switch(_forEachIndex) do {
      case 0: {[_x, [0.365+(0.134*_forEachIndex), 0.65], false] call _lclMoveSymbol;};
      case 1: {[_x, [0.365+(0.134*_forEachIndex), 0.35], false] call _lclMoveSymbol;};
      case 2: {[_x, [0.365+(0.134*_forEachIndex), 0.65], false] call _lclMoveSymbol;};
    };
  } forEach _middle;


  //Incoming image
  {
    _ctrl = _display ctrlCreate ["Casino_RscPicture", -1];
    _return pushBack _ctrl;
    if(_x isEqualTo 2) then {
      ['background'] spawn OEC_fnc_casinoSlotsCreate;
    };
    _pick = (floor (random (count _iconList)));
    if(_pick > 1) then {
      _pick = ([_itemPrefix, (_iconList select _pick)] joinString "");
    } else {
      _pick = _iconList select _pick;
    };
    //Wait to prevent 1 frame layer issue
    [_ctrl, _pick] spawn{
      uiSleep 0.005;
      (_this select 0) ctrlSetText (_this select 1);
    };

    switch(_x) do {
      case 0: {_ctrl ctrlSetPosition [0.365+(0.134*_x), 0.35, 0.08, 0.105];};
      case 1: {_ctrl ctrlSetPosition [0.365+(0.134*_x), 0.65, 0.08, 0.105];};
      case 2: {_ctrl ctrlSetPosition [0.365+(0.134*_x), 0.35, 0.08, 0.105];};
    };
    _ctrl ctrlCommit 0;
    switch(_x) do {
      case 0: {[_ctrl, [0.365+(0.134*_x), 0.5], false] call _lclMoveSymbol;};
      case 1: {[_ctrl, [0.365+(0.134*_x), 0.5], false] call _lclMoveSymbol;};
      case 2: {[_ctrl, [0.365+(0.134*_x), 0.5], true] call _lclMoveSymbol};
    }
  } forEach [0,1,2];

  _return;
};

_lclGetPattern = {
  params ["_symbols"];

  _countArray = [];
  for "_i" from 0 to (count _iconList) do {
    _countArray pushBack [_i, 0];
  };

  for "_i" from 0 to (count _iconList) do {
    {
      if(_x isEqualTo ((_countArray select _i) select 0)) then {
        (_countArray select _i) set [1, (((_countArray select _i) select 1) + 1)];
        //((_countArray select _i) select 1)  = ((_countArray select _i) select 1) + 1;
      };
    } forEach _symbols;
  };

  _multiply = 0;
  //0 - olympus | 1 - money | 2 - redgull | 3 - apple | 4 - goldbar | 5 - blastingcharge | 6 - crystalmeth | 7 - epiPen | 8 - dope shot | 9 - emerald | 10 - frog |
  if(((_countArray select 0) select 1) isEqualTo 3) then {_multiply = 2;}; //Jackpot

  if(((_countArray select 1) select 1) isEqualTo 2) then {_multiply = 2;}; //2 Money
  if(((_countArray select 1) select 1) isEqualTo 3) then {_multiply = 2;}; //3 Money

  if(((_countArray select 2) select 1) isEqualTo 1) then {_multiply = 2;}; //1 Redgull
  if(((_countArray select 2) select 1) isEqualTo 2) then {_multiply = 2;}; //2 Redgull
  if(((_countArray select 2) select 1) isEqualTo 3) then {_multiply = 2;}; //3 Redgull

  if(((_countArray select 3) select 1) isEqualTo 3) then {_multiply = 2;}; //3 Apple

  if(((_countArray select 4) select 1) isEqualTo 2) then {_multiply = 2;}; //2 Fed Goldbar
  if(((_countArray select 4) select 1) isEqualTo 3) then {_multiply = 2;}; //3 Fed Goldbar

  if(((_countArray select 5) select 1) isEqualTo 2) then {_multiply = 2;}; //2 Blasting Charge
  if(((_countArray select 5) select 1) isEqualTo 3) then {_multiply = 2;}; //3 Blasting Charge

  if(((_countArray select 6) select 1) isEqualTo 3) then {_multiply = 2;}; //3 Meth. Aka meth run

  if(((_countArray select 7) select 1) isEqualTo 2) then {_multiply = 2;}; //2 Epipen
  if(((_countArray select 7) select 1) isEqualTo 3) then {_multiply = 2;}; //3 Epipen

  if(((_countArray select 8) select 1) isEqualTo 2) then {_multiply = 2;}; //2 Dope shot
  if(((_countArray select 8) select 1) isEqualTo 3) then {_multiply = 2;}; //3 Dope shot

  if(((_countArray select 9) select 1) isEqualTo 3) then {_multiply = 2;}; //3 Emeralds

  if(((_countArray select 10) select 1) isEqualTo 3) then {_multiply = 2;}; //3 Frogs. Aka frog run

  //FederaL reserve robbery. Blasting Charge - Gold - Gold
  if((_symbols select 0) isEqualTo 5 && (_symbols select 1) isEqualTo 4 && (_symbols select 2) isEqualTo 4) then {_multiply = 2;};

  _multiply;
};

if(_type isEqualTo "spin") then {

  [_ctrlList, true] call _lclChangeCtrlEnable;
  
  _amount = ctrlText 2000;
  if !(isNil _amount) exitWith {};
  if (!([_amount] call OEC_fnc_isNumeric)) exitWith {hint "无效号码";};
  _amount = parseNumber _amount;
  if(_amount > oev_atmcash) exitWith {hint "没有足够的资金";};
  if(_amount < 1000) exitWith {hint "最低下注是1000";};
  if(_amount > 10000) exitWith {hint "最高下注是100,00";};

  [_ctrlList, false] call _lclChangeCtrlEnable;
  _display displaySetEventHandler ["KeyDown", "if ((_this select 1) isEqualto 1) then {true} else {false};"];

  oev_atmcash = oev_atmcash - _amount;
  oev_cache_atmcash = oev_cache_atmcash - _amount;
  [1] call OEC_fnc_ClupdatePartial;

  _numString = [_amount] call OEC_fnc_numberText;
  [
    ["event","Player Bet Slots"],
    ["player",name player],
    ["player_id",getPlayerUID player],
    ["bet_lost",_amount],
    ["position",getPosATL player]
  ] call OEC_fnc_logIt;
  ["casino_uses",1] call OEC_fnc_statArrUp;

  playSound "slotsRoll";

  _landOn = [] call _lclGetResult;

  _current = [];

  //if(!isNull (_display displayCtrl 700)) then {
  for "_i" from 0 to 2 do {
    _current pushBack (_display displayCtrl 700+_i);
  };
  //};

  if(count _current isEqualTo 0) exitWith {hint "错误";};

  _final = [] call _lclGetResult;

  _new = [_current, _display, _iconList, _itemPrefix] call _lclSymbolSpin;
  for "_i" from 0 to 10 do {
    _new = [_new, _display, _iconList, _itemPrefix] call _lclSymbolSpin;
  };

  _allCtrls = allControls _display;
  {
    if(ctrlIDC _x in [700,701,702]) then {
      ctrlDelete _x;
    };
  } forEach _allCtrls;

  {
    switch(_forEachIndex) do {
      case 0: {[_x, [0.365+(0.134*_forEachIndex), 0.65], false] call _lclMoveSymbol;};
      case 1: {[_x, [0.365+(0.134*_forEachIndex), 0.35], false] call _lclMoveSymbol;};
      case 2: {[_x, [0.365+(0.134*_forEachIndex), 0.65], false] call _lclMoveSymbol;};
    };
  } forEach _new;

  {
    _ctrl = _display ctrlCreate ["Casino_RscPicture", 700+_x];
    if(_x isEqualTo 2) then {
      ['background'] spawn OEC_fnc_casinoSlotsCreate;
    };
    _pick = (_final select _x);
    if(_pick > 1) then {
      _pick = ([_itemPrefix, (_iconList select _pick)] joinString "");
    } else {
      _pick = _iconList select _pick;
    };
    //Wait to prevent 1 frame layer issue
    [_ctrl, _pick] spawn{
      uiSleep 0.005;
      (_this select 0) ctrlSetText (_this select 1);
    };

    switch(_x) do {
      case 0: {_ctrl ctrlSetPosition [0.365+(0.134*_x), 0.35, 0.08, 0.105];};
      case 1: {_ctrl ctrlSetPosition [0.365+(0.134*_x), 0.65, 0.08, 0.105];};
      case 2: {_ctrl ctrlSetPosition [0.365+(0.134*_x), 0.35, 0.08, 0.105];};
    };
    _ctrl ctrlCommit 0;
    switch(_x) do {
      case 0: {[_ctrl, [0.365+(0.134*_x), 0.5], false] call _lclMoveSymbol;};
      case 1: {[_ctrl, [0.365+(0.134*_x), 0.5], false] call _lclMoveSymbol;};
      case 2: {[_ctrl, [0.365+(0.134*_x), 0.5], true] call _lclMoveSymbol;};
    };
  } forEach [0,1,2];

  _allCtrls = allControls _display;
  {
    if(ctrlIDC _x isEqualTo -1) then {
      ctrlDelete _x;
    };
  } forEach _allCtrls;

  _multiply = [_final] call _lclGetPattern;

  if(_multiply != 0) then {
    _numString = [_amount*_multiply] call OEC_fnc_numberText;
    hint (format ["你赢了%1元！",_numString]);
    oev_atmcash = oev_atmcash + (_amount*_multiply);
    oev_cache_atmcash = oev_cache_atmcash + (_amount*_multiply);
    [1] call OEC_fnc_ClupdatePartial;
    [
      ["event","Player Won Slots"],
      ["player",name player],
      ["player_id",getPlayerUID player],
      ["bet",_amount*_multiply],
      ["money_won",_amount*_multiply],
      ["position",getPosATL player]
    ] call OEC_fnc_logIt;
    ["casino_winnings",_amount] call OEC_fnc_statArrUp;
    if(_amount isEqualTo 100000) then {
      _nearMsg = [name player, " 玩老虎机赢了", _numString, "元!"] joinString "";
      _inDist = ((position player nearEntities ["Man", 15]) select {isPlayer _x});
      [0, _nearMsg] remoteExecCall ["OEC_fnc_broadcast", _inDist];
      [player, "gamblingWin"] remoteExec ["OEC_fnc_say3D", _inDist];
    };
  } else {
    hint ("你输了！");
    [
      ["event","Player Lost Slots"],
      ["player",name player],
      ["player_id",getPlayerUID player],
      ["bet",_amount*_multiply],
      ["position",getPosATL player]
    ] call OEC_fnc_logIt;
    ["casino_losses",_amount] call OEC_fnc_statArrUp;
  };

  [_ctrlList, true] call _lclChangeCtrlEnable;
  ['init'] spawn OEC_fnc_casinoSlots;
};

//["Casino_Slots"] call OEC_fnc_createDialog;

//Odds script
//_final = [] call _lclGetResult;

//_t = 1000;
//_bet = 50000;
//_m = 0;
//_multiply = 0;
//for "_i" from 0 to _t do {
//  _multiply = [_final] call _lclGetPattern;
//  _m = _m - _bet + (_bet * _multiply);
//};

//_m;
