//  File: fn_casinoBlackjack.sqf
//	Author: Tech
//	Description: Casino blackjack

params [
  ["_type", "", [""]],
  ["_ctrl1", controlNull, [controlNull]]
];
private ["_display", "_text1", "_dealerValueText", "_playerValueText", "_stand", "_hit", "_doubledown", "_ctrlList", "_type", "_newBet", "_text", "_newBet", "_betChange", "_ctrls", "_newText", "_cardDir", "_cardData", "_cardNum", "_cardSuit", "_file", "_tex", "_card", "_pos", "_idc", "_pick", "_deck", "_owner", "_pos1", "_pos2", "_hidden", "_cardCtrl", "_value", "_aces", "_list", "_enable", "_amount", "_cards", "_playerDeck", "_dealerDeck", "_r", "_publicDealerValue", "_hiddenCard", "_array", "_exit", "_waitScript", "_data", "_msg", "_msg2", "_mult", "_msgScript", "_obj_main"];

oev_inCasino = true;

_display = findDisplay 20003;

_dealerValueText = _display displayCtrl 9000;
_playerValueText = _display displayCtrl 9001;

_obj_main = player;
if(_type isEqualTo "init") then {
  _display displaySetEventHandler ["KeyDown", "if ((_this select 1) isEqualTo 1) then {oev_inCasino = false;};player setVariable ['blackjackData', []];"];
  _obj_main setVariable ["blackjackData", []];
  _dealerValueText ctrlSetText "";
  _playerValueText ctrlSetText "";
};

if(_type != "deal" && _type != "hit" && _type != "stand" && _type != "doubledown") then {
  _text1 = _display displayCtrl 2000; //Your Money
  _text1 ctrlSetText format ["你的资金: $%1", [oev_atmcash] call OEC_fnc_numberText];
};

//All the action butttons
_stand = _display displayCtrl 8000;
_stand ctrlShow false;
_hit = _display displayCtrl 8001;
_hit ctrlShow false;
_doubledown = _display displayCtrl 8002;
_doubledown ctrlShow false;
//_split = _display displayCtrl 8003;
//_split ctrlShow false;

//List of ctrls that need disabling and enabling during the game
_ctrlList = [3000,1400,1900,1601,1602,1603,1604,1605,1606,1607,1701,1702,1703];

//Directory of all the card .paa's
_cardDir = "images\icons\casino\cards\";

//When you click a quickbet button
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


_lcl_UpdateQuickBetBtns = {
  params["_newText"];
  _ctrls = [1601, 1602, 1603, 1604, 1605, 1606, 1607];
  {
    _display displayCtrl (_ctrls select _forEachIndex) ctrlSetText _x;
  } forEach _newText;
};

//When you click a quickbetrange button
if(_type isEqualTo "updateQuickBetButtons") then {
  switch(ctrlText _ctrl1) do {
    case "20k-1M": {[["20k", "40k", "50k", "60k", "70k", "80k", "1M"]] call _lcl_UpdateQuickBetBtns};
    case "1M-5M": {[["1M", "1.5M", "2M", "2.5M", "3M", "4M", "5M"]] call _lcl_UpdateQuickBetBtns};
    case "5M-10M": {[["5M", "5.5M", "6M", "7M", "8M", "9M", "10M"]] call _lcl_UpdateQuickBetBtns};
    default {};
  };
};

//Card num. -1 - back | 2-10 - nums | 11 - ace | 12 - jack | 13 - queen | 14 - king
//Card suite. -1 - back | 0 - clubs | 1 - diamonds | 2 - hearts | 3 - spades | -1 - cardback
_lcl_GetCardTexture = {
  params ["_cardData"];
  _cardNum = _cardData select 0;
  _cardSuit = _cardData select 1;

  _return = [];

  switch(_cardNum) do {
    case -1: {_cardNum = "back"};
    case 11: {_cardNum = "a"};
    case 12: {_cardNum = "j"};
    case 13: {_cardNum = "q"};
    case 14: {_cardNum = "k"};
    default {_cardNum = (str _cardNum)};
  };

  switch(_cardSuit) do {
    case -1: {_cardSuit = "back"};
    case 0: {_cardSuit = "clubs"};
    case 1: {_cardSuit = "diamonds"};
    case 2: {_cardSuit = "hearts"};
    case 3: {_cardSuit = "spades"};
    default {_cardSuit = ""};
  };

  if(_cardNum isEqualTo "back" || _cardSuit isEqualTo "back") then {
    _return pushBack ([_cardDir, "back.paa"] joinString "");
  } else {
    if(_cardNum in ["j","q","k"] || (_cardNum isEqualTo "a" && _cardSuit isEqualTo "spades")) then {
      _return pushBack ([_cardDir, _cardNum, _cardSuit, ".paa"] joinString "");
    } else {
      _return pushBack ([_cardDir, "front.paa"] joinString "");
      _return pushBack ([_cardDir, _cardSuit, ".paa"] joinString "");
      _color = "";
      if(_cardSuit in ["clubs","spades"]) then {
        _color = "b.paa";
      } else {
        _color = "r.paa";
      };
      _return pushBack ([_cardDir, _cardNum, _color] joinString "");
    };
  };

  _return;
};

//Creates and returns card ctrl
_lcl_CreateCard = {
  params ["_pos", "_cardData", "_idc"];

  _tex = [_cardData] call _lcl_GetCardTexture;
  _return = [];

  if(count _tex isEqualTo 1) then {
    _cardCtrl = _display ctrlCreate ["Casino_RscPicture", _idc];
    _cardCtrl ctrlSetText (_tex select 0);
    _cardCtrl ctrlSetPosition [(_pos select 0), (_pos select 1), 0.21375, 0.285];
    _cardCtrl ctrlCommit 0;
    _return pushBack [[0,0,0.21375,0.285,false],_cardCtrl];
  } else {
    _front = _display ctrlCreate ["Casino_RscPicture", _idc];
    _front ctrlSetText (_tex select 0);
    _front ctrlSetPosition [(_pos select 0), (_pos select 1), 0.21375, 0.285];
    _front ctrlCommit 0;
    _return pushBack [[0,0,0.21375,0.285,false],_front];

    _symbols = [];

    _symbols pushBack [0.005,0.015,0.045,0.055,false];  //TL number
    _symbols pushBack [0.094,0.215,0.045,0.055,true];  //BR number

    _symbols pushBack [0.0075,0.049,0.025,0.035,false]; //under number
    _symbols pushBack [0.1125,0.2,0.025,0.035,true]; //above number

    switch (_cardData select 0) do {
      case 2: {
        _symbols pushBack [0.058,0.037,0.065,0.08,false]; //top
        _symbols pushBack [0.023,0.165,0.065,0.08,true]; //bottom
      };
      case 3: {
        _symbols pushBack [0.058,0.037,0.065,0.08,false]; //top
        _symbols pushBack [0.057,0.1225,0.065,0.08,false]; //middle
        _symbols pushBack [0.023,0.165,0.065,0.08,true]; //bottom
      };
      case 4: {
        _symbols pushBack [0.029,0.04,0.065,0.08,false]; //top left
        _symbols pushBack [0.0855,0.04,0.065,0.08,false]; //top right
        _symbols pushBack [-0.0045,0.165,0.065,0.08,true]; //bottom left
        _symbols pushBack [0.0525,0.165,0.065,0.08,true]; //bottom right
      };
      case 5: {
        _symbols pushBack [0.029,0.04,0.065,0.08,false]; //top left
        _symbols pushBack [0.0855,0.04,0.065,0.08,false]; //top right
        _symbols pushBack [-0.0045,0.165,0.065,0.08,true]; //bottom left
        _symbols pushBack [0.0525,0.165,0.065,0.08,true]; //bottom right
        _symbols pushBack [0.057,0.122,0.065,0.08,false]; //middle
      };
      case 6: {
        _symbols pushBack [0.029,0.04,0.065,0.08,false]; //top left
        _symbols pushBack [0.0855,0.04,0.065,0.08,false]; //top right
        _symbols pushBack [-0.0045,0.165,0.065,0.08,true]; //bottom left
        _symbols pushBack [0.0525,0.165,0.065,0.08,true]; //bottom right
        _symbols pushBack [0.029,0.122,0.065,0.08,false]; //middle left
        _symbols pushBack [0.0855,0.122,0.065,0.08,false]; //middle right
      };
      case 7: {
        _symbols pushBack [0.029,0.04,0.065,0.08,false]; //top left
        _symbols pushBack [0.0855,0.04,0.065,0.08,false]; //top right
        _symbols pushBack [-0.0045,0.165,0.065,0.08,true]; //bottom left
        _symbols pushBack [0.0525,0.165,0.065,0.08,true]; //bottom right
        _symbols pushBack [0.029,0.122,0.065,0.08,false]; //middle left
        _symbols pushBack [0.0855,0.122,0.065,0.08,false]; //middle right
        _symbols pushBack [0.0565,0.078,0.065,0.08,false]; //middle top
      };
      case 8: {
        _symbols pushBack [0.029,0.04,0.065,0.08,false]; //top left
        _symbols pushBack [0.0855,0.04,0.065,0.08,false]; //top right
        _symbols pushBack [-0.0045,0.165,0.065,0.08,true]; //bottom left
        _symbols pushBack [0.0525,0.165,0.065,0.08,true]; //bottom right
        _symbols pushBack [0.029,0.122,0.065,0.08,false]; //middle left
        _symbols pushBack [0.0855,0.122,0.065,0.08,false]; //middle right
        _symbols pushBack [0.057,0.078,0.065,0.08,false]; //middle top
        _symbols pushBack [0.024,0.128,0.065,0.08,true]; //middle bottom
      };
      case 9: {
        _symbols pushBack [0.029,0.04,0.065,0.08,false]; //top left
        _symbols pushBack [0.0855,0.04,0.065,0.08,false]; //top right
        _symbols pushBack [0.029,0.095,0.065,0.08,false]; //top left 2
        _symbols pushBack [0.0855,0.095,0.065,0.08,false]; //top right 2
        _symbols pushBack [-0.0045,0.165,0.065,0.08,true]; //bottom left
        _symbols pushBack [0.0525,0.165,0.065,0.08,true]; //bottom right
        _symbols pushBack [-0.0045,0.115,0.065,0.08,true]; //bottom left 2
        _symbols pushBack [0.0525,0.115,0.065,0.08,true]; //bottom right 2
        _symbols pushBack [0.057,0.122,0.065,0.08,false]; //middle
      };
      case 10: {
        _symbols pushBack [0.029,0.04,0.065,0.08,false]; //top left
        _symbols pushBack [0.0855,0.04,0.065,0.08,false]; //top right
        _symbols pushBack [0.029,0.095,0.065,0.08,false]; //top left 2
        _symbols pushBack [0.0855,0.095,0.065,0.08,false]; //top right 2
        _symbols pushBack [-0.0045,0.165,0.065,0.08,true]; //bottom left
        _symbols pushBack [0.0525,0.165,0.065,0.08,true]; //bottom right
        _symbols pushBack [-0.0045,0.115,0.065,0.08,true]; //bottom left 2
        _symbols pushBack [0.0525,0.115,0.065,0.08,true]; //bottom right 2
        _symbols pushBack [0.0565,0.078,0.065,0.08,false]; //middle top
        _symbols pushBack [0.024,0.128,0.065,0.08,true]; //middle bottom
      };
      case 11: {
        _symbols pushBack [0.054,0.113,0.08,0.1,false]; //mid
      };
      default {}
    };

    {
      _ctrl = _display ctrlCreate ["Casino_RscPicture", _idc];
      if(_forEachIndex <= 1) then {
        _ctrl ctrlSetText (_tex select 2);
      } else {
        _ctrl ctrlSetText (_tex select 1);
      };
      _ctrl ctrlSetPosition [(_pos select 0)+(_x select 0), (_pos select 1)+(_x select 1), (_x select 2), (_x select 3)];
      if(_x select 4) then {
        _ctrl ctrlSetAngle [180, 0.5, 0.5];
      };
      _ctrl ctrlCommit 0;
      _return pushBack [_x, _ctrl];
    } forEach _symbols;
  };


  _return;
};

//Moves card to location in .3 seconds
_lcl_MoveCard = {
  params ["_card","_pos"];

  _check = (_card select 0) select 1;

  {
    (_x select 1) ctrlSetPosition [(_pos select 0)+((_x select 0) select 0), (_pos select 1)+((_x select 0) select 1), ((_x select 0) select 2), ((_x select 0) select 3)];
    (_x select 1) ctrlCommit 0.24;
  } forEach _card;

  //_card ctrlSetPosition _pos;
  //_card ctrlCommit 0.24;
  waitUntil {ctrlCommitted _check;};
};

//Picks a random card out of the deck, then creates it at _pos1, and then moves it to _pos2. If hidden use the card back texture.
_lcl_DealCard = {
  params ["_deck", "_owner", "_pos1", "_pos2", "_hidden"];

  _pick = (floor (random (count _deck)));
  _cardData = _deck select _pick;
  _deck deleteAt _pick;

  _cardCtrl = controlNull;

  if(_hidden) then {
    _cardCtrl = [_pos1, [-1,-1], -1] call _lcl_CreateCard;
  } else {
    _cardCtrl = [_pos1, _cardData, -1] call _lcl_CreateCard;
  };

  _owner pushBack ([_cardCtrl, _cardData]);
  playSound (selectRandom ["cardFlick1", "cardFlick2"]);
  [_cardCtrl, _pos2] call _lcl_MoveCard;
  [_deck, _owner];
};

//Gets the deck value.
_lcl_GetDeckValue = {
  params [["_deck",[],[[]]],["_mode",0,[0]]];

  _return = 0;

  _value = 0;
  _aces = 0;
  _isSoft = false;

  {
    _cardData = _x select 1;
    _cardNum = _cardData select 0;

    switch(_cardNum) do {
      case 11: {_aces = _aces + 1;}; //Ace
      case 12: {_value = _value + 10;}; //Jack
      case 13: {_value = _value + 10;}; //Queen
      case 14: {_value = _value + 10;}; //King
      default {_value = _value + _cardNum;};
    };

  } forEach _deck;

  for "_i" from 1 to _aces do {
    if(_value+11 > 21) then {
      _value = _value + 1;
    } else {
      _value = _value + 11;
      _isSoft = true;
    };
  };
  _return = _value;

  if(_mode isEqualTo 1) then {
    _return = _isSoft;
  };

  _return;
};

//Moves array of cards into draw deck and deltes them. Cleans up the board.
_lcl_MoveCardsToDraw = {
  params ["_list"];
  {
    _ctrl = _x select 0;
    playSound (selectRandom ["cardSlide1", "cardSlide2", "cardSlide3"]);
    [_ctrl, [0.0,-0.05]] call _lcl_MoveCard;
    {
      ctrlDelete (_x select 1);
    } forEach _ctrl;
  } forEach _list;
};

//Enables/Disables list of ctrls
_lcl_ChangeCtrlEnable = {
  params["_list", "_enable"];
  {
    ctrlEnable [_x, _enable];
  } forEach _list;
};

//The static top-left draw deck.
if(isNull (_display displayCtrl 123)) then {
  [[0,-0.05], [-1, -1], 123] call _lcl_CreateCard;
};

//Deal button clicked
if(_type isEqualTo "deal") then {

  _obj_main setVariable ["blackjackData", []];

  _display displaySetEventHandler ["KeyDown", "if ((_this select 1) isEqualTo 1) then {true} else {false};"];

  //Bet check
  _amount = ctrlText 1400;
  if !(isNil _amount) exitWith {};
  if (!([_amount] call OEC_fnc_isNumeric)) exitWith {hint "Invalid number";};
  _amount = parseNumber _amount;
  if(_amount > oev_atmcash) exitWith {hint "资金不足";};
  if(_amount < 10000) exitWith {hint "最少下注1万";};
  if(_amount > 1000000) exitWith {hint "最大赌注是100万";};

  //Premptively subtract bet
  oev_atmcash = oev_atmcash - _amount;
  oev_cache_atmcash = oev_cache_atmcash - _amount;
  [1] call OEC_fnc_ClupdatePartial;

  _numString = [_amount] call OEC_fnc_numberText;
  [
    ["event","Player Bet Blackjack"],
    ["player",name player],
    ["player_id",getPlayerUID player],
    ["bet_lost",_amount],
    ["position",getPosATL player]
  ] call OEC_fnc_logIt;
  ["casino_uses",1] call OEC_fnc_statArrUp;

  //Disable all the ctrls that you shouldn't be able to mess with
  [_ctrlList, false] call _lcl_ChangeCtrlEnable;


  //Makes 3 Decks
  _cards = [];
  for "_deck" from 1 to 3 do {
    for "_suite" from 0 to 3 do {
      for "_num" from 2 to 14 do {
          _cards pushBack ([_num, _suite]);
      };
    };
  };

  _playerDeck = [];
  _dealerDeck = [];

  //Dealer hidden
  _r = [_cards, _dealerDeck, [0.0,-0.05], [0.4, -0.05], true] call _lcl_DealCard;
  _cards = _r select 0;
  _dealerDeck = _r select 1;

  //Player 1st card
  _r = [_cards, _playerDeck, [0.0,-0.05], [0.3, 0.45], false] call _lcl_DealCard;
  _cards = _r select 0;
  _playerDeck = _r select 1;

  //Dealer faceup card
  _r = [_cards, _dealerDeck, [0.0,-0.05], [0.45, -0.05], false] call _lcl_DealCard;
  _cards = _r select 0;
  _dealerDeck = _r select 1;

  //Player 2nd card
  _r = [_cards, _playerDeck, [0.0,-0.05], [0.45,0.45], false] call _lcl_DealCard;
  _cards = _r select 0;
  _playerDeck = _r select 1;

  _playerValue = [_playerDeck] call _lcl_GetDeckValue;
  _dealerValue = [_dealerDeck] call _lcl_GetDeckValue;
  //Since dealer has a hidden card, get the value of the faceup.
  _publicDealerValue = [[_dealerDeck select 1]] call _lcl_GetDeckValue;

  //Ryans PID
  //if((getPlayerUID _obj_main) isEqualTo "76561198120173072") then {
  //  _playerValue = 21;
  //  _dealerValue = 1;
  //};

  _playerValueText ctrlSetText (["玩家点数: ",(str _playerValue)] joinString "");
  _dealerValueText ctrlSetText (["庄家点数: ",(str _publicDealerValue)] joinString "");

  //Natural Blackjack check
  if(_playerValue isEqualTo 21) then {
    //Blackjack tie
    if(_dealerValue isEqualTo 21) then {

      _dealerValueText ctrlSetText (["庄家点数: ",(str _dealerValue)] joinString "");
      _playerValueText ctrlSetText (["玩家点数: ",(str _playerValue)] joinString "");

      //Flip face down card
      playSound (selectRandom ["cardSlide1", "cardSlide2", "cardSlide3"]);

      //Reveal hidden card
      _hiddenCard = _dealerDeck select 0;
      _tex = [(_hiddenCard select 1)] call _lcl_GetCardTexture;

      //New ctrl to replace hidden card
      _pos = ctrlPosition (((_hiddenCard select 0) select 0) select 1);
      _newCtrl = [[_pos select 0, _pos select 1], (_hiddenCard select 1), -1] call _lcl_CreateCard;
      {
        ctrlDelete (_x select 1);
      } forEach ((_dealerDeck select 0) select 0);
      (_dealerDeck select 0) set [0, _newCtrl];

      //New ctrl to fix layering issue
      _pos = ctrlPosition ((((_dealerDeck select 1) select 0) select 0) select 1);
      _newCtrl = [[_pos select 0, _pos select 1], ((_dealerDeck select 1) select 1), -1] call _lcl_CreateCard;
      {
        ctrlDelete (_x select 1);
      } forEach ((_dealerDeck select 1) select 0);
      (_dealerDeck select 1) set [0, _newCtrl];

      [((_dealerDeck select 0) select 0), [0.3,-0.05]] call _lcl_MoveCard;

      uiSleep 1.5;

      [_playerDeck] call _lcl_MoveCardsToDraw;
      [_dealerDeck] call _lcl_MoveCardsToDraw;
      [_ctrlList, true] call _lcl_ChangeCtrlEnable;
      _numString = [_amount] call OEC_fnc_numberText;
      hint "平局，退赌注！";
      oev_atmcash = oev_atmcash + (_amount);
      oev_cache_atmcash = oev_cache_atmcash + (_amount);
      [1] call OEC_fnc_ClupdatePartial;

      [
        ["event","Player Push Blackjack"],
        ["player",name player],
        ["player_id",getPlayerUID player],
        ["bet",_amount],
        ["position",getPosATL player]
      ] call OEC_fnc_logIt;

      _obj_main setVariable ["blackjackData", []];
      _display displayRemoveAllEventHandlers "KeyDown";
      if(true) exitWith {['init', controlNull] spawn OEC_fnc_casinoBlackjack;};
    } else {
      _dealerValueText ctrlSetText (["庄家点数: ",(str _dealerValue)] joinString "");
      _playerValueText ctrlSetText (["玩家点数: ",(str _playerValue)] joinString "");

      //Flip face down card
      playSound (selectRandom ["cardSlide1", "cardSlide2", "cardSlide3"]);

      //Reveal hidden card
      _hiddenCard = _dealerDeck select 0;
      _tex = [(_hiddenCard select 1)] call _lcl_GetCardTexture;

      //New ctrl to replace hidden card
      _pos = ctrlPosition (((_hiddenCard select 0) select 0) select 1);
      _newCtrl = [[_pos select 0, _pos select 1], (_hiddenCard select 1), -1] call _lcl_CreateCard;
      {
        ctrlDelete (_x select 1);
      } forEach ((_dealerDeck select 0) select 0);
      (_dealerDeck select 0) set [0, _newCtrl];

      //New ctrl to fix layering issue
      _pos = ctrlPosition ((((_dealerDeck select 1) select 0) select 0) select 1);
      _newCtrl = [[_pos select 0, _pos select 1], ((_dealerDeck select 1) select 1), -1] call _lcl_CreateCard;
      {
        ctrlDelete (_x select 1);
      } forEach ((_dealerDeck select 1) select 0);
      (_dealerDeck select 1) set [0, _newCtrl];

      [((_dealerDeck select 0) select 0), [0.3,-0.05]] call _lcl_MoveCard;

      uiSleep 1.5;

      [_playerDeck] call _lcl_MoveCardsToDraw;
      [_dealerDeck] call _lcl_MoveCardsToDraw;
      [_ctrlList, true] call _lcl_ChangeCtrlEnable;
      _numString = [_amount*1.5] call OEC_fnc_numberText;
      hint format ["你赢了%1元!", _numString];
      oev_atmcash = oev_atmcash + (_amount*2.5);
      oev_cache_atmcash = oev_cache_atmcash + (_amount*2.5);
      [1] call OEC_fnc_ClupdatePartial;

      [
        ["event","Player Won Blackjack Natural"],
        ["player",name player],
        ["player_id",getPlayerUID player],
        ["bet",_amount*1.5],
        ["position",getPosATL player]
      ] call OEC_fnc_logIt;
      ["casino_winnings",_amount] call OEC_fnc_statArrUp;

      if(_amount >= 1000000) then {
        _nearMsg = [name _obj_main, " 得到了一个自然的21点并且赢了", _numString, "元!"] joinString "";
        _inDist = ((position player nearEntities ["Man", 15]) select {isPlayer _x});
        [0, _nearMsg] remoteExecCall ["OEC_fnc_broadcast", _inDist];
        [player, "gamblingWin"] remoteExec ["OEC_fnc_say3D", _inDist];
      };

      _obj_main setVariable ["blackjackData", []];
      _display displayRemoveAllEventHandlers "KeyDown";
      if(true) exitWith {['init', controlNull] spawn OEC_fnc_casinoBlackjack;};
    };
  } else {
    //Dealer blackjack
    if(_dealerValue isEqualTo 21) then {
      [
        ["event","Player Lost Blackjack Natural"],
        ["player",name player],
        ["player_id",getPlayerUID player],
        ["bet_lost",_amount],
        ["position",getPosATL player]
      ] call OEC_fnc_logIt;
      ["casino_losses",_amount] call OEC_fnc_statArrUp;

      //Flip face down card
      playSound (selectRandom ["cardSlide1", "cardSlide2", "cardSlide3"]);

      //Reveal hidden card
      _hiddenCard = _dealerDeck select 0;
      _tex = [(_hiddenCard select 1)] call _lcl_GetCardTexture;

      //New ctrl to replace hidden card
      _pos = ctrlPosition (((_hiddenCard select 0) select 0) select 1);
      _newCtrl = [[_pos select 0, _pos select 1], (_hiddenCard select 1), -1] call _lcl_CreateCard;
      {
        ctrlDelete (_x select 1);
      } forEach ((_dealerDeck select 0) select 0);
      (_dealerDeck select 0) set [0, _newCtrl];

      //New ctrl to fix layering issue
      _pos = ctrlPosition ((((_dealerDeck select 1) select 0) select 0) select 1);
      _newCtrl = [[_pos select 0, _pos select 1], ((_dealerDeck select 1) select 1), -1] call _lcl_CreateCard;
      {
        ctrlDelete (_x select 1);
      } forEach ((_dealerDeck select 1) select 0);
      (_dealerDeck select 1) set [0, _newCtrl];

      [((_dealerDeck select 0) select 0), [0.3,-0.05]] call _lcl_MoveCard;

      _dealerValueText ctrlSetText (["庄家点数: ",(str _dealerValue)] joinString "");
      _playerValueText ctrlSetText (["玩家点数: ",(str _playerValue)] joinString "");

      uiSleep 1.5;

      _numString = [_amount] call OEC_fnc_numberText;
      if(_amount >= 5000000) then {
        _nearMsg = [name _obj_main, " 玩21点输了", _numString, "元因为庄家获得自然21点"] joinString "";
        _inDist = ((position player nearEntities ["Man", 15]) select {isPlayer _x});
        [0, _nearMsg] remoteExecCall ["OEC_fnc_broadcast", _inDist];
        [player, "gamblingLose"] remoteExec ["OEC_fnc_say3D", _inDist];
      };

      [_playerDeck] call _lcl_MoveCardsToDraw;
      [_dealerDeck] call _lcl_MoveCardsToDraw;
      [_ctrlList, true] call _lcl_ChangeCtrlEnable;
      hint "不 庄家自然二十一点";
      _obj_main setVariable ["blackjackData", []];
      _display displayRemoveAllEventHandlers "KeyDown";
      if(true) exitWith {['init', controlNull] spawn OEC_fnc_casinoBlackjack;}
    };
  };

  //Show action buttons
  _stand ctrlShow true;
  _hit ctrlShow true;

  if(_playerValue in [9,10,11]) then {
    if(_amount <= 5000000 && _amount <= oev_atmcash) then {
      _doubledown ctrlShow true;
    };
  };
  //Add splitting later lol
  //if((((_playerDeck select 0) select 1) select 0) isEqualTo (((_playerDeck select 1) select 1) select 0)) then {
  //  _split ctrlShow true;
  //};

  //Pass array of data to other parts of this script
  _obj_main setVariable ["blackjackData", [_amount, _playerDeck, _dealerDeck, _playerValue, _dealerValue, _cards]];
};

//When ran it plays against the players hand to the best of its ability. aka hitting until it wins or ties
_lcl_DealerAI = {
  params ["_data"];
  _data = _this select 0;
  _playerDeck = _data select 1;
  _dealerDeck = _data select 2;
  _playerValue = _data select 3;
  _dealerValue = _data select 4;
  _cards = _data select 5;

  _exit = false;

  while {!_exit} do {
    uiSleep 1;

    _isSoft = [_dealerDeck,1] call _lcl_GetDeckValue;

    //Bust, Win, Tie, or Stand on 17
    if((_dealerValue >= 17 && !_isSoft) || _dealerValue >= _playerValue) then {
      _exit = true;
    };

    //Hit below player
    if(!_exit) then {
      _r = [_cards, _dealerDeck, [0.0,-0.05], [0.3+((count _dealerDeck)*0.15),-0.05], false] call _lcl_DealCard;
      _cards = _r select 0;
      _dealerDeck = _r select 1;

      _dealerValue = [_dealerDeck] call _lcl_GetDeckValue;

      _dealerValueText ctrlSetText (["庄家点数: ",(str _dealerValue)] joinString "");
    };
  };

  //Return the decks
  [_dealerValue, _playerDeck, _dealerDeck];
};

//Stand button clicked
if(_type isEqualTo "stand") then {

  //Hide action buttons
  _stand ctrlShow false;
  _hit ctrlShow false;
  _doubledown ctrlShow false;
  //_split ctrlShow false;

  //Get all the data
  _data = _obj_main getVariable ["blackjackData", []];
  if((count _data) isEqualTo 0) exitWith {hint "Error";};

  _amount = _data select 0;
  _playerDeck = _data select 1;
  _dealerDeck = _data select 2;
  _playerValue = _data select 3;
  _dealerValue = _data select 4;

  //Reveal hidden card
  _hiddenCard = _dealerDeck select 0;
  _tex = [(_hiddenCard select 1)] call _lcl_GetCardTexture;

  //New ctrl to replace hidden card
  _pos = ctrlPosition (((_hiddenCard select 0) select 0) select 1);
  _newCtrl = [[_pos select 0, _pos select 1], (_hiddenCard select 1), -1] call _lcl_CreateCard;
  {
    ctrlDelete (_x select 1);
  } forEach ((_dealerDeck select 0) select 0);
  (_dealerDeck select 0) set [0, _newCtrl];

  //New ctrl to fix layering issue
  _pos = ctrlPosition ((((_dealerDeck select 1) select 0) select 0) select 1);
  _newCtrl = [[_pos select 0, _pos select 1], ((_dealerDeck select 1) select 1), -1] call _lcl_CreateCard;
  {
    ctrlDelete (_x select 1);
  } forEach ((_dealerDeck select 1) select 0);
  (_dealerDeck select 1) set [0, _newCtrl];

  [((_dealerDeck select 0) select 0), [0.3,-0.05]] call _lcl_MoveCard;

  //Reveal true dealer value
  _dealerValueText ctrlSetText (["庄家点数: ",(str _dealerValue)] joinString "");

  _playerValueText ctrlSetText (["玩家点数: ",(str _playerValue)] joinString "");

  //Bust
  if(_playerValue > 21) exitWith {
      hint "超过21点!";
      [
        ["event","Player Lost Bust Blackjack"],
        ["player",name player],
        ["player_id",getPlayerUID player],
        ["bet",_amount],
        ["position",getPosATL player]
      ] call OEC_fnc_logIt;
      ["casino_losses",_amount] call OEC_fnc_statArrUp;
      if(_amount >= 5000000) then {
        _numString = [_amount] call OEC_fnc_numberText;
        _nearMsg = [name _obj_main, " 玩21点输了", _numString, "元!"] joinString "";
        _inDist = ((position player nearEntities ["Man", 15]) select {isPlayer _x});
        [0, _nearMsg] remoteExecCall ["OEC_fnc_broadcast", _inDist];
        [player, "gamblingLose"] remoteExec ["OEC_fnc_say3D", _inDist];
      };

      [_playerDeck] call _lcl_MoveCardsToDraw;
      [_dealerDeck] call _lcl_MoveCardsToDraw;
      [_ctrlList, true] call _lcl_ChangeCtrlEnable;

      ['init', controlNull] spawn OEC_fnc_casinoBlackjack;
  };

  //Dealer plays
  _r = [_data] call _lcl_DealerAI;
  _result = _r select 0;
  _playerDeck = _r select 1;
  _dealerDeck = _r select 2;

  //Determine the outcome
  _msg = "";
  _msg2 = "";

  _mult = 2;

  if(_result isEqualTo _playerValue) then {
    _msg = "平局，退赌注";
    _numString = [_amount] call OEC_fnc_numberText;
    _msg2 = format ["退款%1元.", _numString];
    _mult = 1;
    [
      ["event","Player Push Blackjack"],
      ["player",name player],
      ["player_id",getPlayerUID player],
      ["bet",_amount],
      ["position",getPosATL player]
    ] call OEC_fnc_logIt;
  };
  if(_result < _playerValue) then {
    _msg = (format["你的点数%2大于庄家点数%1！", _result, _playerValue]);
    _numString = [_amount] call OEC_fnc_numberText;
    _msg2 = format ["你赢得了%1元!", _numString];
    _mult = 2;
    [
      ["event","Player Won Blackjack Player Wins"],
      ["player",name player],
      ["player_id",getPlayerUID player],
      ["bet_lost",_amount],
      ["position",getPosATL player]
    ] call OEC_fnc_logIt;
    ["casino_winnings",_amount] call OEC_fnc_statArrUp;
    if(_amount >= 5000000 && _playerValue <= 21) then {
      _nearMsg = [name _obj_main, " 玩21点赢了", _numString, "元!"] joinString "";
      _inDist = ((position player nearEntities ["Man", 15]) select {isPlayer _x});
      [0, _nearMsg] remoteExecCall ["OEC_fnc_broadcast", _inDist];
      [player, "gamblingWin"] remoteExec ["OEC_fnc_say3D", _inDist];
    };
  };
  if(_result > _playerValue) then {
    _msg = (format["庄家点数%1大于你的点数%2!", _result, _playerValue]);
    _numString = [_amount] call OEC_fnc_numberText;
    _msg2 = format ["你输了%1元.", _numString];
    _mult = 0;
    [
      ["event","Player Lost Blackjack Dealer Wins"],
      ["player",name player],
      ["player_id",getPlayerUID player],
      ["bet_lost",_amount],
      ["position",getPosATL player]
    ] call OEC_fnc_logIt;
    ["casino_losses",_amount] call OEC_fnc_statArrUp;
    if(_amount >= 5000000 && _result <= 21) then {
      _nearMsg = [name _obj_main, " 玩21点输了", _numString, "元!"] joinString "";
      _inDist = ((position player nearEntities ["Man", 15]) select {isPlayer _x});
      [0, _nearMsg] remoteExecCall ["OEC_fnc_broadcast", _inDist];
      [player, "gamblingLose"] remoteExec ["OEC_fnc_say3D", _inDist];
    };
  };
  if(_result > 21) then {
    _msg = "庄家超过21点！";
    _numString = [_amount] call OEC_fnc_numberText;
    _msg2 = format ["你赢了%1元!", _numString];
    _mult = 2;
    [
      ["event","Player Won Blackjack Dealer Bust"],
      ["player",name player],
      ["player_id",getPlayerUID player],
      ["bet",_amount],
      ["position",getPosATL player]
    ] call OEC_fnc_logIt;
    ["casino_winnings",_amount] call OEC_fnc_statArrUp;
    if(_amount >= 5000000) then {
      _nearMsg = [name _obj_main, " 玩21点赢了", _numString, "元!"] joinString "";
      _inDist = ((position player nearEntities ["Man", 15]) select {isPlayer _x});
      [0, _nearMsg] remoteExecCall ["OEC_fnc_broadcast", _inDist];
      [player, "gamblingWin"] remoteExec ["OEC_fnc_say3D", _inDist];
    };
  };

  hint _msg;
  uiSleep 2;
  hint _msg2;

  _dealerValueText ctrlSetText "";
  _playerValueText ctrlSetText "";

  if(_mult != 0) then {
    oev_atmcash = oev_atmcash + (_amount*_mult);
    oev_cache_atmcash = oev_cache_atmcash + (_amount*_mult);
    [1] call OEC_fnc_ClupdatePartial;
  };
  [_playerDeck] call _lcl_MoveCardsToDraw;
  [_dealerDeck] call _lcl_MoveCardsToDraw;
  [_ctrlList, true] call _lcl_ChangeCtrlEnable;
  _display displayRemoveAllEventHandlers "KeyDown";
  _obj_main setVariable ["blackjackData", []];
  if(true) exitWith {['init', controlNull] spawn OEC_fnc_casinoBlackjack;}

};

//Hit button clicked
if(_type isEqualTo "hit") then {

  //Hide action buttons
  _stand ctrlShow false;
  _hit ctrlShow false;
  _doubledown ctrlShow false;
  //_split ctrlShow false;

  //Get all the data
  _data = _obj_main getVariable ["blackjackData", []];
  if((count _data) isEqualTo 0) exitWith {hint "Error";};

  _amount = _data select 0;
  _playerDeck = _data select 1;
  _dealerDeck = _data select 2;
  _playerValue = _data select 3;
  _dealerValue = _data select 4;
  _cards = _data select 5;

  //Draw the card
  _r = [_cards, _playerDeck, [0.0,-0.05], [0.3+((count _playerDeck)*0.15),0.45], false] call _lcl_DealCard;
  _cards = _r select 0;
  _playerDeck = _r select 1;

  //Update the shit
  _playerValue = [_playerDeck] call _lcl_GetDeckValue;
  _playerValueText ctrlSetText (["玩家点数: ",(str _playerValue)] joinString "");

  //_dealerValueText ctrlSetText (["Dealer Value: ",(str _dealerValue)] joinString "");

  _obj_main setVariable ["blackjackData", [_amount, _playerDeck, _dealerDeck, _playerValue, _dealerValue, _cards]];

  uiSleep 1.5;

  //Bust
  if(_playerValue > 21) then {
    ['stand', controlNull] spawn OEC_fnc_casinoBlackjack;
  } else {
    //Show actions
    _stand ctrlShow true;
    _hit ctrlShow true;
  };
};

//Double down button clicked
if(_type isEqualTo "doubledown") then {

  //Hide actions
  _stand ctrlShow false;
  _hit ctrlShow false;
  _doubledown ctrlShow false;
  //_split ctrlShow false;

  //Get all the data
  _data = _obj_main getVariable ["blackjackData", []];
  if((count _data) isEqualTo 0) exitWith {hint "Error";};

  _amount = _data select 0;
  _playerDeck = _data select 1;
  _dealerDeck = _data select 2;
  _playerValue = _data select 3;
  _dealerValue = _data select 4;
  _cards = _data select 5;

  //Subtract the bet again.
  oev_atmcash = oev_atmcash - _amount;
  oev_cache_atmcash = oev_cache_atmcash - _amount;
  [1] call OEC_fnc_ClupdatePartial;

  //Double the bet
  _amount = _amount * 2;
  _numString = [_amount] call OEC_fnc_numberText;
  hint format["赌注加倍至%1元.", _numString];

  //Hit the card
  _r = [_cards, _playerDeck, [0.0,-0.05], [(0.45+0.15),0.45], false] call _lcl_DealCard;
  _cards = _r select 0;
  _playerDeck = _r select 1;

  //Update the shit
  _playerValue = [_playerDeck] call _lcl_GetDeckValue;

  _playerValueText ctrlSetText (["玩家点数: ",(str _playerValue)] joinString "");

  _dealerValueText ctrlSetText (["庄家点数: ",(str _dealerValue)] joinString "");

  _obj_main setVariable ["blackjackData", [_amount, _playerDeck, _dealerDeck, _playerValue, _dealerValue, _cards]];

  uiSleep 2;

  //Force stand
  ['stand', controlNull] spawn OEC_fnc_casinoBlackjack;
};

//["Casino_Blackjack"] call OEC_fnc_createDialog;

//Odds Script
// hitCard = {
//   params ["_deck", "_hand"];
//   _pick = (floor (random (count _deck)));
//   _cardData = _deck select _pick;
//   _hand pushBack _cardData;
//   _deck deleteAt _pick;
//   [_deck, _hand];
// };
//
// _lcl_GetDeckValue = {
//   params ["_deck"];
//
//   _value = 0;
//   _aces = 0;
//
//   {
//     _cardNum = _x select 0;
//
//     switch(_cardNum) do {
//       case 11: {_aces = _aces + 1;}; //Ace
//       case 12: {_value = _value + 10;}; //Jack
//       case 13: {_value = _value + 10;}; //Queen
//       case 14: {_value = _value + 10;}; //King
//       default {_value = _value + _cardNum;};
//     };
//
//   } forEach _deck;
//
//   for "_i" from 1 to _aces do {
//     if(_value+11 > 21) then {
//       _value = _value + 1;
//     } else {
//       _value = _value + 11;
//     };
//   };
//   _value;
// };
//
//
// _money = 0;
// _t = 100;
// _bet = 500000;
//
// for "_i" from 1 to _t do {
//   _exit = false;
//
//   _cards = [];
//   for "_deck" from 1 to 3 do {
//     for "_suite" from 0 to 3 do {
//       for "_num" from 2 to 14 do {
//           _cards pushBack ([_num, _suite]);
//       };
//     };
//   };
//
//   _playerDeck = [];
//   _dealerDeck = [];
//
//   //Player initial
//   _r = [_cards, _playerDeck] call hitCard;
//   _cards = _r select 0;
//   _playerDeck = _r select 1;
//
//   _r = [_cards, _playerDeck] call hitCard;
//   _cards = _r select 0;
//   _playerDeck = _r select 1;
//
//   //Dealer inital
//   _r = [_cards, _dealerDeck] call hitCard;
//   _cards = _r select 0;
//   _dealerDeck = _r select 1;
//
//   _r = [_cards, _dealerDeck] call hitCard;
//   _cards = _r select 0;
//   _dealerDeck = _r select 1;
//
//   _playerValue = [_playerDeck] call _lcl_GetDeckValue;
//   _dealerValue = [_dealerDeck] call _lcl_GetDeckValue;
//
//   if(_playerValue isEqualTo 21) then {
//     if(_dealerValue != 21) then {
//       _money = _money + (_bet*1.5);
//       _exit = true;
//     } else {
//       _exit = true;
//     };
//   } else {
//     if(_dealerValue isEqualTo 21) then {
//       _money = _money - _bet;
//       _exit = true;
//     };
//   };
//
//   while{_playerValue < 17 && !_exit} do {
//     _r = [_cards, _playerDeck] call hitCard;
//     _cards = _r select 0;
//     _playerDeck = _r select 1;
//     _playerValue = [_playerDeck] call _lcl_GetDeckValue;
//   };
//
//   if(_playerValue > 21 && !_exit) then {
//     _money = _money - _bet;
//     _exit = true;
//   };
//
//   while{_dealerValue < _playerValue && !_exit} do {
//     _r = [_cards, _dealerDeck] call hitCard;
//     _cards = _r select 0;
//     _dealerDeck = _r select 1;
//     _dealerValue = [_dealerDeck] call _lcl_GetDeckValue;
//   };
//
//   if(_dealerValue > 21 && !_exit) then {
//     _money = _money + _bet;
//     _exit = true;
//   };
//
//   if(_dealerValue isEqualTo _playerValue && !_exit) then {
//     _exit = true;
//   };
//
//   if(_playerValue > _dealerValue && !_exit) then {
//     _money = _money + _bet;
//     _exit = true;
//   } else {
//     _money = _money - _bet;
//     _exit = true;
//   };
// };
//
// systemChat (str _money);
