//  File: fn_roulette.sqf
//	Author: Ozadu
//	Description: Russian Roulette inspired event. Players are given a zubr and a chance to get a bullet each round.

params[
	["_eventMaster",objNull,[objNull]],
	["_round",0,[0]],
	["_powerRound",0,[0]],
	["_remaining",0,[0]]
];

switch(_round) do {
	case 0:{
		hint format ["Welcome to Ozadu's Russian Roulette Event v2.0 hosted by %1!\n
			Each round will last 10 seconds so if you get a bullet use it or lose it.\n
			Odds of getting a bullet will increase as the player count goes down.\n",name _eventMaster];
		["Welcome to Ozadu's","Russian Roulette Event"] spawn BIS_fnc_infoText;
		removeAllWeapons player;
		removeVest player;
		player enableFatigue false;
		player removeMagazines "9Rnd_45ACP_Mag";
    player addWeapon "hgun_ACPC2_F";
		player addWeaponItem ["hgun_ACPC2_F", ["9Rnd_45ACP_Mag", 0]];
    player forceAddUniform "U_C_Scientist";
	};
	case _powerRound:{
		hint parseText format["Round: %1<br/>Players Remaining: %2<br/>POWER ROUND<br/><t color='#FFFF00'>EVERYONE HAS A BULLET!!!</t>", _round, _remaining];
		player setAmmo [handgunWeapon player, 1];
	};
	default {
		_odds = 5;
		if(_remaining < 15 && _remaining >= 10) then {
			_odds = 4;
		};
		if(_remaining < 10 && _remaining >= 8) then {
			_odds = 3;
		};
		if(_remaining < 8 && _remaining >= 5) then {
			_odds = 2;
		};
		if(_remaining < 5) then {
			_odds = 2;
		};
		player setAmmo [handgunWeapon player, 0];
		_rand = floor random _odds;
		if(_rand == 0) then {
			player setAmmo [handgunWeapon player, 1];
		};
		hint parseText format["Round: %1<br/>Players Remaining: %2<br/>Odds: 1/%3%4", _round, _remaining, _odds, if (_rand == 0) then {"<t color='#FFFF00'><br/>You got a bullet!</t>"} else {""}];
	};
};
