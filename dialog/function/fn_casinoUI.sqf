//  File: fn_casinoUI.sqf
//	Author: Tech
//	Description: Creates casino dialogs
params [
  ["_game","",[""]]
];

if(call oev_restrictions) exitWith {hint "赌场因限制而被禁止玩家使用。";};
if(player getVariable ["restrained", false]) exitWith {hint "你被束缚了。";};
if(!alive player) exitWith {hint "如何？";};
if(!isNull (objectParent player)) exitWith {hint "从车里出来才可以玩。";};
if(playerSide isEqualTo independent) exitWith {hint "Windows键";};


switch (_game) do {
  case "roulette": {["Casino_Roulette"] call OEC_fnc_createDialog;};
  case "slots": {["Casino_Slots"] call OEC_fnc_createDialog;};
  case "blackjack": {["Casino_Blackjack"] call OEC_fnc_createDialog;};
  default {hint "Bad data"}
};

//['roulette'] call OEC_fnc_casinoUI
//['slots'] call OEC_fnc_casinoUI
//['blackjack'] call OEC_fnc_casinoUI
//this addAction ['Play Roulette', {['roulette'] call OEC_fnc_casinoUI},nil,1.5,true,true,'','((playerSide isEqualTo civilian) || (playerSide isEqualTo west))',5];
//this addAction ['Play Slots', {['slots'] call OEC_fnc_casinoUI},nil,1.5,true,true,'','((playerSide isEqualTo civilian) || (playerSide isEqualTo west))',5];
//this addAction ['Play Blackjack', {['blackjack'] call OEC_fnc_casinoUI},nil,1.5,true,true,'','((playerSide isEqualTo civilian) || (playerSide isEqualTo west))',5];
