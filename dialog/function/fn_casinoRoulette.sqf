//  File: fn_casinoRoulette.sqf
//	Author: Tech
//	Description: Function called in roulette screen

params [
  ["_type", "", [""]],
  ["_ctrl1", controlNull, [controlNull]],
  ["_color", -1, [0]],
  ["_betAmount", -1, [0]]
];
private ["_display", "_text1", "_type", "_newBet", "_text", "_betChange", "_newText", "_ctrls", "_enable", "_list", "_betInput", "_amount", "_num", "_color", "_ctrlList", "_ctrl1", "_table", "_ball", "_positions", "_redIndexes", "_blackIndexes", "_greenIndexes", "_going", "_a", "_tableAngle", "_i", "_pick", "_check", "_betAmount", "_numString"];


oev_inCasino = true;

_display = findDisplay 20001;
if(_type isEqualTo "init") then {
  _display displaySetEventHandler ["KeyDown", "if ((_this select 1) isEqualTo 1) then {oev_inCasino = false;};"];
};

if(_type != "spin") then {
  _text1 = _display displayCtrl 2000; //Your Money
  _text1 ctrlSetText format ["你的资金: $%1", [oev_atmcash] call OEC_fnc_numberText];
};

if(_type isEqualTo "updateBet") then {
  _newBet = "0";
  _text = (ctrlText _ctrl1);
  switch(_text) do {
    case "20k": {_newBet = "20000";};
    case "40k": {_newBet = "40000";};
    case "50k": {_newBet = "50000";};
    case "60k": {_newBet = "60000";};
    case "70k": {_newBet = "70000";};
    case "80k": {_newBet = "80000";};
    case "1M": {_newBet = "100000";};

    case "1.5M": {_newBet = "150000";};
    case "2M": {_newBet = "200000";};
    case "2.5M": {_newBet = "250000";};
    case "3M": {_newBet = "300000";};
    case "4M": {_newBet = "400000";};
    case "5M": {_newBet = "500000";};

    case "5.5M": {_newBet = "550000";};
    case "6M": {_newBet = "600000";};
    case "7M": {_newBet = "700000";};
    case "8M": {_newBet = "800000";};
    case "9M": {_newBet = "900000";};
    case "10M": {_newBet = "1000000";};

    default {_newBet = "0";};
  };

  _betChange = _display displayCtrl 1400;
  _betChange ctrlSetText _newBet;
};

_lclUpdateQuickBetBtns = {
  params["_newText"];
  _ctrls = [1601, 1602, 1603, 1604, 1605, 1606, 1607];
  {
    _display displayCtrl (_ctrls select _forEachIndex) ctrlSetText _x;
  } forEach _newText;
};

if(_type isEqualTo "updateQuickBetButtons") then {
  switch(ctrlText _ctrl1) do {
    case "20k-1M": {[["20k", "40k", "50k", "60k", "70k", "80k", "1M"]] call _lclUpdateQuickBetBtns};
    case "1M-5M": {[["1M", "1.5M", "2M", "2.5M", "3M", "4M", "5M"]] call _lclUpdateQuickBetBtns};
    case "5M-10M": {[["5M", "5.5M", "6M", "7M", "8M", "9M", "10M"]] call _lclUpdateQuickBetBtns};
    default {};
  };
};

_lclChangeCtrlEnable = {
  params["_list", "_enable"];
  {
    ctrlEnable [_x, _enable];
  } forEach _list;
};

//Real roulette odds
if(_type isEqualTo "bet") then {
  _betInput = _display displayCtrl 1400;
  _amount = ctrlText _betInput;
  if !(isNil _amount) exitWith {};
  if (!([_amount] call OEC_fnc_isNumeric)) exitWith {hint "Invalid number";};
  _amount = parseNumber _amount;
  if(_amount > oev_atmcash) exitWith {hint "没有足够的资金";};
  if(_amount < 10000) exitWith {hint "最少下注1万";};
  if(_amount > 1000000) exitWith {hint "最大下注是100万";};

  oev_atmcash = oev_atmcash - _amount;
  oev_cache_atmcash = oev_cache_atmcash - _amount;
  [1] call OEC_fnc_ClupdatePartial;

  _numString = [_amount] call OEC_fnc_numberText;
  [
    ["event","Player Bet Roulette"],
    ["player",name player],
    ["player_id",getPlayerUID player],
    ["bet_lost",_amount],
    ["position",getPosATL player]
  ] call OEC_fnc_logIt;
  ["casino_uses",1] call OEC_fnc_statArrUp;

  _num = floor (random 38);
  _color = -1;
  if(_num isEqualTo 0 || _num isEqualTo 37) then {
    _color = 2;
  } else {
    if((_num >= 1 && _num <= 10) || (_num >= 19 && _num <= 28)) then {
      if (_num % 2 isEqualTo 0) then {
        _color = 1;
      } else {
        _color = 0;
      };
    } else {
      if (_num % 2 isEqualTo 0) then {
        _color = 0;
      } else {
        _color = 1;
      };
    };
  };
  _ctrlList = [1400,1601,1602,1603,1604,1605,1606,1607,1701,1702,1703,1801,1802,1803,1900];
  if(true) exitWith {[_ctrlList, false] call _lclChangeCtrlEnable; ['spin', _ctrl1, _color, _amount] spawn OEC_fnc_casinoRoulette;};
};

//spinny spin
if(_type isEqualTo "spin") then {

  _table = _display displayCtrl 4000;
  _ball = _display displayCtrl 4001;
  _display displaySetEventHandler ["KeyDown", "if ((_this select 1) isEqualTo 1) then {true} else {false};"];

  //Arma math sucks dick. I used a python script to generate these. If you ever update this you can ask me about these
  _positions = [[0.241396,0.181162],[0.254907,0.18457],[0.265692,0.19],[0.285,0.197133],[0.290171,0.205602],[0.299641,0.215048],[0.307917,0.225152],[0.312028,0.235653],[0.321149,0.246351],[0.32629,0.257105],[0.33058,0.267823],[0.334111,0.278448],[0.336965,0.288956],[0.339209,0.301341],[0.340898,0.309615],[0.342076,0.319797],[0.34277,0.329915],[0.343,0.34],[0.34277,0.352085],
  [0.342076,0.360203],[0.340898,0.370385],[0.339209,0.380659],[0.336965,0.391044],[0.334111,0.403552],[0.33058,0.412177],[0.32629,0.426895],[0.321149,0.433649],[0.313058,0.444347],[0.307917,0.454848],[0.299641,0.464952],[0.290171,0.474398],[0.2795,0.482867],[0.266292,0.49],[0.254907,0.49543],[0.241396,0.498838],[0.2275,0.5],[0.213604,0.498838],[0.200093,0.49543],[0.189308,0.49],
  [0.1755,0.482867],[0.164829,0.474398],[0.155359,0.464952],[0.147083,0.454848],[0.139942,0.444347],[0.133851,0.433649],[0.12871,0.422895],[0.12442,0.412177],[0.120889,0.403552],[0.118035,0.391044],[0.115791,0.376659],[0.114102,0.370385],[0.112924,0.360203],[0.11223,0.352585],[0.112,0.34],[0.11223,0.327915],[0.112924,0.319797],[0.114102,0.309615],[0.115791,0.300341],[0.118035,0.288956],
  [0.120889,0.278448],[0.12442,0.267823],[0.12871,0.257105],[0.133851,0.246351],[0.141942,0.232653],[0.147083,0.225152],[0.155359,0.215048],[0.164829,0.205602],[0.1755,0.197133],[0.187308,0.19],[0.200093,0.18457],[0.213604,0.181162],[0.2275,0.18]];
  //These indexes are where these positions lined up perfectly with the board
  _redIndexes = [3, 7, 11, 16, 21, 25, 32, 38, 41, 49, 54, 59, 63];
  _blackIndexes = [2, 5, 13, 18, 23, 27, 47, 52, 57, 65];
  _greenIndexes = [35, 71];

  _going = 0;
  switch(_color) do {
    case 0: {_going = selectRandom _redIndexes;};
    case 1: {_going = selectRandom _blackIndexes;};
    case 2: {_going = selectRandom _greenIndexes;};
  };

  for "_i" from 1 to 3 do {
    _a = 0;
    _tableAngle = 0;
    {
      //Rotate the table 5 degrees until 360 and reset to 0
      _tableAngle = 5*_forEachIndex-_a;
      if (_tableAngle isEqualTo 360) then {
        _a = _a + 360;
      };

      //Last spin
      if(_i isEqualTo 3) then {
        //This is so if its the green at the top it doesnt spin all the way around again.
        if(_going isEqualTo 71) then {
          _table ctrlSetAngle [0, 0.5, 0.5];
          _ball ctrlSetPosition [(_positions#71)#0, (_positions#71)#1];
        } else {
          //Go around in the circle until it lands on _going index
          if(_forEachIndex < _going+1) then {
            _table ctrlSetAngle [0, 0.5, 0.5];
            _ball ctrlSetPosition [_x#0, _x#1];
          };
        };
      } else {
        //How it spins normally
        _table ctrlSetAngle [360-_tableAngle, 0.5, 0.5];
        _ball ctrlSetPosition [_x#0, _x#1];
      };
      _ball ctrlCommit 0;
      uiSleep 0.0125;
    } forEach _positions;
  };

  //Get what color was picked
  _pick = -1;
  _check = (ctrlIDC _ctrl1);
  switch (_check) do {
      case 1801: {_pick = 0;};
      case 1802: {_pick = 1;};
      case 1803: {_pick = 2;};
      default {_pick = -1}
  };

  //Win, lose
  if(_pick isEqualTo _color) then {
    if(_pick isEqualTo 2 && _color isEqualTo 2) then {
        _numString = [_betAmount*14] call OEC_fnc_numberText;
        hint format ["您赢了%1元!", _numString];
        oev_atmcash = oev_atmcash + (_betAmount*14);
        oev_cache_atmcash = oev_atmcash + (_betAmount*14);
        [
          ["event","Player Won Roulette Green"],
          ["player",name player],
          ["player_id",getPlayerUID player],
          ["bet",_betAmount*14],
          ["position",getPosATL player]
        ] call OEC_fnc_logIt;
        ["casino_winnings",_betAmount*13] call OEC_fnc_statArrUp;
        if(_betAmount >= 500000) then {
          _nearMsg = [name player, " 在轮盘赌中落在绿色上赢了", _numString, "元!"] joinString "";
          _inDist = ((position player nearEntities ["Man", 15]) select {isPlayer _x});
          [0, _nearMsg] remoteExecCall ["OEC_fnc_broadcast", _inDist];
          [player, "gamblingWin"] remoteExec ["OEC_fnc_say3D", _inDist];
        };
    }
    else {
      _numString = [_betAmount] call OEC_fnc_numberText;
      hint format ["你赢了%1元!", _numString];
      oev_atmcash = oev_atmcash + (_betAmount*2);
      oev_cache_atmcash = oev_cache_atmcash + (_betAmount*2);
      [1] call OEC_fnc_ClupdatePartial;
      [
        ["event","Player Won Roulette"],
        ["player",name player],
        ["player_id",getPlayerUID player],
        ["bet",_betAmount],
        ["position",getPosATL player]
      ] call OEC_fnc_logIt;
      ["casino_winnings",_betAmount] call OEC_fnc_statArrUp;
      if(_betAmount >= 5000000) then {
        _nearMsg = [name player, " 玩轮盘赌赢了", _numString, "元!"] joinString "";
        _inDist = ((position player nearEntities ["Man", 15]) select {isPlayer _x});
        [0, _nearMsg] remoteExecCall ["OEC_fnc_broadcast", _inDist];
        [player, "gamblingWin"] remoteExec ["OEC_fnc_say3D", _inDist];
      };
    };
  } else {
    _numString = [_betAmount] call OEC_fnc_numberText;
    hint "你输了！";
    [1] call OEC_fnc_ClupdatePartial;
    [
      ["event","Player Lost Roulette"],
      ["player",name player],
      ["player_id",getPlayerUID player],
      ["bet",_betAmount],
      ["position",getPosATL player]
    ] call OEC_fnc_logIt;
    ["casino_losses",_betAmount] call OEC_fnc_statArrUp;
    if(_betAmount >= 5000000) then {
      _nearMsg = [name player, " 玩轮盘赌输了", _numString, "元!"] joinString "";
      _inDist = ((position player nearEntities ["Man", 15]) select {isPlayer _x});
      [0, _nearMsg] remoteExecCall ["OEC_fnc_broadcast", _inDist];
      [player, "gamblingLose"] remoteExec ["OEC_fnc_say3D", _inDist];
    };
  };


  _ctrlList = [1400,1601,1602,1603,1604,1605,1606,1607,1701,1702,1703,1801,1802,1803,1900];
  if(true) exitWith {
    [_ctrlList, true] call _lclChangeCtrlEnable;
    ["init"] spawn OEC_fnc_casinoRoulette;
  };
};

//["Casino_Roulette"] call OEC_fnc_createDialog;


//probability test
// _redCount = 0;
// _blackCount = 0;
// _greenCount = 0;
// _test = 100000;
// _bet = 500000;
// _money = 0;
// for "_i" from 0 to _test do {
// _num = floor (random 38);
//  _color = -1;
//  if(_num isEqualTo 0 || _num isEqualTo 37) then {
//    _greenCount = _greenCount + 1;
//    _money = _money - _bet;
//  } else {
//    if((_num >= 1 && _num <= 10) || (_num >= 19 && _num <= 28)) then {
//      if (_num % 2 isEqualTo 0) then {
//        _blackCount = _blackCount + 1;
//        _money = _money + _bet;
//      } else {
//        _redCount = _redCount + 1;
//        _money = _money - _bet;
//      };
//    } else {
//      if (_num % 2 isEqualTo 0) then {
//        _redCount = _redCount + 1;
//        _money = _money - _bet;
//
//      } else {
//        _blackCount = _blackCount + 1;
//        _money = _money + _bet;
//      };
//    };
//  };
// };
//
// systemChat "--------";
// systemChat format ["Red: %1%%", _redCount/_test*100];
// systemChat format ["Black: %1%%", _blackCount/_test*100];
// systemChat format ["Green: %1%%", _greenCount/_test*100];
// _numString = [_money] call OEC_fnc_numberText;
// systemChat format ["Money made: %1", _numString];
