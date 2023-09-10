//  File: fn_invPrice.sqf
//	Author: Astral
//	Description: Determines the price of a players y-inventory.

params [
	["_item","",[""]],
	["_amount",0,[0]],
	["_mode",0,[0]]
];

private _price = 0;

switch(_mode) do {
	case 1: {
		switch (_item) do {
			case "life_inv_barrier": {_price = 1000 * _amount;};
			case "life_inv_beer": {_price = 2000 * _amount;};
			case "life_inv_blastingcharge": {_price = 15000 * _amount;};
			case "life_inv_hackingterminal": {_price = 7000 * _amount;};
			case "life_inv_takeoverterminal": {_price = 10000 * _amount;};
			case "life_inv_boltcutter": {_price = 100 * _amount;};
			case "life_inv_fireaxe": {_price = 100 * _amount;};
			case "life_inv_burger": {_price = 500 * _amount;};
			case "life_inv_coffee": {_price = 1500 * _amount;};
			case "life_inv_cupcake": {_price = 2500 * _amount;};
			case "life_inv_defusekit": {_price = 2500 * _amount;};
			case "life_inv_donuts": {_price = 120 * _amount;};
			case "life_inv_fuelF": {_price = 850 * _amount;};
			case "life_inv_gpstracker": {_price = 15000 * _amount;};
			case "life_inv_egpstracker": {_price = 45000 * _amount;};
			case "life_inv_gpsjammer": {_price = 33000 * _amount;};
			case "life_inv_lockpick": {_price = 150 * _amount;};
			case "life_inv_lethalinjector": {_price = 250000 * _amount;};
			case "life_inv_pepsi": {_price = 500 * _amount;};
			case "life_inv_pickaxe": {_price = 1200 * _amount;};
			case "life_inv_redgull": {_price = 1500 * _amount;};
			case "life_inv_lollypop": {_price = 1500 * _amount;};
			case "life_inv_scalpel": {_price = 35000 * _amount;};
			case "life_inv_speedbomb": {_price = 700000 * _amount;};
			case "life_inv_spikeStrip": {_price = 2500 * _amount;};
			case "life_inv_storagebig": {_price = 150000 * _amount;};
			case "life_inv_storagesmall": {_price = 75000 * _amount;};
			case "life_inv_tbacon": {_price = 75 * _amount;};
			case "life_inv_turtlesoup": {_price = 2500 * _amount;};
			case "life_inv_water": {_price = 10 * _amount;};
			case "life_inv_ziptie": {_price = 500 * _amount;};
			case "life_inv_heliTowHook": {_price = 20000 * _amount;};
			case "life_inv_fireworks": {_price = 2000 * _amount;};
			case "life_inv_potato": {_price = 70 * _amount;};
			case "life_inv_cream": {_price = 50 * _amount;};
			case "life_inv_bloodbag": {_price = 7500 * _amount;};
			case "life_inv_epiPen": {_price = 15000 * _amount;};
			case "life_inv_dopeShot": {_price = 100000 * _amount;};
			case "life_inv_blindfold": {_price = 1000 * _amount;};
			case "life_inv_panicButton": {_price = 1000 * _amount;};
			case "life_inv_wplPanicButton": {_price = 20000 * _amount;};
			case "life_inv_roadKit": {_price = 1000 * _amount;};
			case "life_inv_vehAmmo": {_price = 20000 * _amount;};
			case "life_inv_baitcar": {_price = 30000 * _amount;};
			case "life_inv_excavationtools": {_price = 1200 * _amount;};
			case "life_inv_gokart": {_price = 25000 * _amount;};
			default {_price = 0;};
		};
	};
	case 2: {
		switch (_item) do {
			case "barrier": {_price = 1000 * _amount;};
			case "beer": {_price = 2000 * _amount;};
			case "blastingcharge": {_price = 15000 * _amount;};
			case "hackingterminal": {_price = 7000 * _amount;};
			case "takeoverterminal": {_price = 10000 * _amount;};
			case "boltcutter": {_price = 100 * _amount;};
			case "fireaxe": {_price = 100 * _amount;};
			case "burger": {_price = 500 * _amount;};
			case "coffee": {_price = 1500 * _amount;};
			case "cupcake": {_price = 2500 * _amount;};
			case "defusekit": {_price = 2500 * _amount;};
			case "donuts": {_price = 120 * _amount;};
			case "fuelF": {_price = 850 * _amount;};
			case "gpstracker": {_price = 15000 * _amount;};
			case "egpstracker": {_price = 45000 * _amount;};
			case "gpsjammer": {_price = 33000 * _amount;};
			case "lockpick": {_price = 150 * _amount;};
			case "lethalinjector": {_price = 250000 * _amount;};
			case "painkillers": {_price = 10000 * _amount;};
			case "pepsi": {_price = 500 * _amount;};
			case "pickaxe": {_price = 1200 * _amount;};
			case "redgull": {_price = 1500 * _amount;};
			case "lollypop": {_price = 1500 * _amount;};
			case "scalpel": {_price = 35000 * _amount;};
			case "speedbomb": {_price = 700000 * _amount;};
			case "spikeStrip": {_price = 2500 * _amount;};
			case "storagebig": {_price = 150000 * _amount;};
			case "storagesmall": {_price = 75000 * _amount;};
			case "tbacon": {_price = 75 * _amount;};
			case "turtlesoup": {_price = 2500 * _amount;};
			case "water": {_price = 10 * _amount;};
			case "ziptie": {_price = 500 * _amount;};
			case "heliTowHook": {_price = 20000 * _amount;};
			case "fireworks": {_price = 2000 * _amount;};
			case "potato": {_price = 70 * _amount;};
			case "cream": {_price = 50 * _amount;};
			case "bloodbag": {_price = 7500 * _amount;};
			case "epiPen": {_price = 15000 * _amount;};
			case "dopeShot": {_price = 100000 * _amount;};
			case "blindfold": {_price = 1000 * _amount;};
			case "panicButton": {_price = 1000 * _amount;};
			case "wplPanicButton": {_price = 20000 * _amount;};
			case "roadKit": {_price = 1000 * _amount;};
			case "vehAmmo": {_price = 20000 * _amount;};
			case "baitcar": {_price = 30000 * _amount;};
			case "excavationtools": {_price = 1200 * _amount;};
			case "gokart": {_price = 25000 * _amount;};
			default {_price = 0;};
		};
	};
};

_price;
