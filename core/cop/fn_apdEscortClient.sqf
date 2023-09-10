//	File: fn_apdEscortClient.sqf
//	Author: Tech
//	Description: Handles the APD escort event on the client

params [
  ["_mode",-1,[0]],
  ["_vars",-1,[0,[]]]
];

_lcl_buyEscort = {
  params [
    ["_type",-1,[0]]
  ];
  if (serverTime < serv_apdEscortCooldown) exitWith {hint format["APD护卫队冷却%1秒。",serv_apdEscortCooldown-serverTime];};
  if (player getVariable ["rank",-1] < 8) exitWith {hint "你必须等级大于4才可以开始APD护送。"};

  _requiredPlayers = switch(_type) do {
    case 0: {45};
    case 1: {65};
    case 2: {80};
  };
  _requiredPlayers = 0;
  if(({(side group _x isEqualTo civilian)} count allPlayers - entities "HeadlessClient_F") < _requiredPlayers) exitWith {hint format["这种APD护送活动需要%1名玩家",_requiredPlayers];};

  if !(isNil "oev_apdEscort") exitWith {hint "APD护卫队已经开始行动了。"}; //Escort is already running
  _cost = -1;
  _cost = switch(_type) do {
    case 0: {250000};
    case 1: {500000};
    case 2: {750000};
    default {-1};
  };
  if(_cost isEqualTo -1) exitWith {};

  _prompt = [
    format["你确定要开始%1 APD护送吗。它将花费%2元。",["small","medium","large"] select _type,[_cost] call OEC_fnc_numberText],
    "确定",
    "是",
    "否"
  ] call BIS_fnc_guiMessage;

  if !(_prompt) exitWith {};

  if(_cost > oev_atmcash) exitWith {hint "钱不够";};
  oev_atmcash = oev_atmcash - _cost;
  oev_cache_atmcash = oev_cache_atmcash - _cost;
  [1] call OEC_fnc_ClupdatePartial;
  [
    ["event","Started APD Escort"],
    ["player",name player],
    ["player_id",getPlayerUID player],
    ["type",(["small","medium","large"] select _type)],
    ["position",getPosATL player]
  ] call OEC_fnc_logIt;

  [0,_type,player] remoteExec ["OES_fnc_apdEscortServer",2];
};

switch (_mode) do {
  case 0: {_vars call _lcl_buyEscort};
  case 1: {[1,_vars,player] remoteExec ["OES_fnc_apdEscortServer",2];};
  case 2: {[2,_vars,player] remoteExec ["OES_fnc_apdEscortServer",2];};
};
