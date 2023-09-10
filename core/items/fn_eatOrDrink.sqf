//  File: fn_eatOrDrink.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Main handling system for eating food.
//  Needs to be revised and made more modular and more indept effects*

private["_item","_val","_sum","_thirstVal","_hungerVal","_perkTier"];
_item = param [0,"",[""]];
if(_item == "") exitWith {};

_thirstVal = 0;
_hungerVal = 0;
_sum = 0;

switch (_item) do
{
	case "apple": {_hungerVal = 5};
	case "salema": {_hungerVal = 30};
	case "ornate": {_hungerVal = 25};
	case "mackerel": {_hungerVal = 30};
	case "tuna": {_hungerVal = 50};
	case "mullet": {_hungerVal = 60};
	case "catshark": {_hungerVal = 70};
	case "turtle": {_hungerVal = 50};
	case "turtlesoup": {_hungerVal = 60};
	case "donuts": {_hungerVal = 30};
	case "tbacon": {_hungerVal = 40};
	case "peach": {_hungerVal = 5};
	case "burger": {_hungerVal = 40};
	case "mushroom": {_hungerVal = 5};
	case "cupcake": {_hungerVal = 10;
		[] spawn{
			if(((time - oev_redgull_effect) < (1.5 * 60))) exitWith {
				titleText["感觉到糖的冲击，你可以跑得更快更长！","PLAIN DOWN"];
				oev_redgull_effect = time;
				player setAnimSpeedCoef 1.1;
				player enableStamina false;
				waitUntil {!alive player || ((time - oev_redgull_effect) > (5 * 60))};
				player setAnimSpeedCoef 1;
				//if !(7 in life_loot) then {player enableFatigue true};
			};

			oev_redgull_effect = time;
			titleText["感觉到糖的冲击，你可以跑得更快更长！","PLAIN DOWN"];
			player setAnimSpeedCoef 1.1;
			player enableStamina false;
			waitUntil {!alive player || ((time - oev_redgull_effect) > (5 * 60))};
			player setAnimSpeedCoef 1;
			//if !(7 in life_loot) then {player enableFatigue true};

			if !(player getVariable ["restrained",false]) then {
				if(oev_thirst >= 20) then {
					oev_thirst = oev_thirst - 20;
				}else{
					oev_thirst = 0;
				};
				[] call OEC_fnc_hudUpdate;
			};
		};
	};
	case "water": {_thirstVal = 40};
	case "pepsi": {_thirstVal = 30};
	case "coffee": {_thirstVal = 25;
		[] spawn{
			private ["_coffeeTime"];
			if (playerSide isEqualTo west) then {
				_perkTier = ["all_distance"] call OEC_fnc_fetchStats;
				_coffeeTime = switch (_perkTier) do {
					case 1: {3.85};
					case 2: {4.375};
					default {3.5};
				};
			} else {
				_coffeeTime = 3.5;
			};
			if(((time - oev_redgull_effect) < (_coffeeTime * 60))) exitWith {
				titleText["哇哦咖啡因！你现在可以跑得更快更久！","PLAIN DOWN"];
				oev_redgull_effect = time;
				player setAnimSpeedCoef 1.1;
				player enableStamina false;
				waitUntil {!alive player || ((time - oev_redgull_effect) > (_coffeeTime * 60))};
				player setAnimSpeedCoef 1;
				//if !(7 in life_loot) then {player enableFatigue true};
			};
			oev_redgull_effect = time;
			titleText["哇哦咖啡因！你现在可以跑得更快更久！","PLAIN DOWN"];
			player setAnimSpeedCoef 1.1;
			player enableStamina false;
			waitUntil {!alive player || ((time - oev_redgull_effect) > (_coffeeTime * 60))};
			player setAnimSpeedCoef 1;
			//if !(7 in life_loot) then {player enableFatigue true};

			if !(player getVariable ["restrained",false]) then {
				if(oev_thirst >= 20) then {
					oev_thirst = oev_thirst - 20;
				}else{
					oev_thirst = 0;
				};
				[] call OEC_fnc_hudUpdate;
			};
		};
		["coffee",1] call OEC_fnc_statArrUp;
	};
	case "redgull": {_thirstVal = 15;
		[] spawn{
			private ["_redgullTime"];
			if (playerSide isEqualTo civilian) then {
				_perkTier = ["all_distance"] call OEC_fnc_fetchStats;
				_redgullTime = switch (_perkTier) do {
					case 1: {3.85};
					case 2: {4.375};
					default {3.5};
				};
			} else {
				_redgullTime = 3.5;
			};
			if(((time - oev_redgull_effect) < (_redgullTime * 60))) exitWith {
				titleText[localize "STR_ISTR_RedGullEffect","PLAIN DOWN"];
				oev_redgull_effect = time;
				player setAnimSpeedCoef 1.1;
				player enableStamina false;
				waitUntil {!alive player || ((time - oev_redgull_effect) > (_redgullTime * 60))};
				player setAnimSpeedCoef 1;
				player enableStamina true;
			};

			oev_redgull_effect = time;
			titleText[localize "STR_ISTR_RedGullEffect","PLAIN DOWN"];
			player setAnimSpeedCoef 1.1;
			player enableStamina false;
			waitUntil {!alive player || ((time - oev_redgull_effect) > (_redgullTime * 60))};
			player setAnimSpeedCoef 1;
			//if !(7 in life_loot) then {player enableFatigue true};

			if !(player getVariable ["restrained",false]) then {
				if(oev_thirst >= 20) then {
					oev_thirst = oev_thirst - 20;
				}else{
					oev_thirst = 0;
				};
				[] call OEC_fnc_hudUpdate;
			};
		};
		["redgull",1] call OEC_fnc_statArrUp;
	};
	case "lollypop": {_thirstVal = 15;
		[] spawn{
			if(((time - oev_redgull_effect) < (3.5 * 60))) exitWith {
				titleText[localize "STR_ISTR_RedGullEffect","PLAIN DOWN"];
				if((time - oev_lollypop_effect) > 10) then {
					_playerDamage = damage player;
					_dam_obj = player;
					_dam_obj setDamage (_playerDamage - 0.05);
					oev_lollypop_effect = time;
				};
				oev_redgull_effect = time;
				player setAnimSpeedCoef 1.1;
				player enableStamina false;
				waitUntil {!alive player || ((time - oev_redgull_effect) > (3.5 * 60))};
				player setAnimSpeedCoef 1;
				player enableStamina true;
			};

			titleText[localize "STR_ISTR_RedGullEffect","PLAIN DOWN"];
			if((time - oev_lollypop_effect) > 10) then {
				_playerDamage = damage player;
				_dam_obj = player;
				_dam_obj setDamage (_playerDamage - 0.05);
				oev_lollypop_effect = time;
			};
			oev_redgull_effect = time;
			player setAnimSpeedCoef 1.1;
			player enableStamina false;
			waitUntil {!alive player || ((time - oev_redgull_effect) > (3.5 * 60))};
			player setAnimSpeedCoef 1;
			player enableStamina true;

			if !(player getVariable ["restrained",false]) then {
				if(oev_thirst >= 20) then {
					oev_thirst = oev_thirst - 20;
				}else{
					oev_thirst = 0;
				};
				[] call OEC_fnc_hudUpdate;
			};
		};
	};
	case "potato": {_hungerVal = 25};
	case "cream": {
		[] spawn{
			if(((time - oev_redgull_effect) < (1.5 * 60))) exitWith {
				titleText["那是一些奶油冰淇淋！感觉一下糖！","PLAIN DOWN"];
				oev_redgull_effect = time;
				player setAnimSpeedCoef 1.1;
				player enableStamina false;
				waitUntil {!alive player || ((time - oev_redgull_effect) > (1.5 * 60))};
				player setAnimSpeedCoef 1;
				player enableStamina true;
			};

			oev_redgull_effect = time;
			titleText["那是一些奶油冰淇淋！感觉一下糖！","PLAIN DOWN"];
			player setAnimSpeedCoef 1.1;
			player enableStamina false;
			waitUntil {!alive player || ((time - oev_redgull_effect) > (1.5 * 60))};
			player setAnimSpeedCoef 1;
			player enableStamina true;

			if !(player getVariable ["restrained",false]) then {
				if(oev_thirst >= 20) then {
					oev_thirst = oev_thirst - 20;
				}else{
					oev_thirst = 0;
				};
				[] call OEC_fnc_hudUpdate;
			};
		};
	};
};

if(_thirstVal > 0) then {
	_sum = oev_thirst + _thirstVal;
	if(_sum > 100) then {_sum = 100;};
	oev_thirst = _sum;
};

if(_hungerVal > 0) then {
	_sum = oev_hunger + _hungerVal;
	if(_sum > 100) then {_sum = 100;};
	oev_hunger = _sum;
};

[] call OEC_fnc_hudUpdate;
