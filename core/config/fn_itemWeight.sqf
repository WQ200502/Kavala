//  File: fn_itemWeight.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Gets the items weight and returns it.
private["_item"];
_item = param [0,"",[""]];
if(_item == "") exitWith {};

switch (_item) do {
	case "lethalinjector": {10};
	case "oilu": {3};
	case "oilp": {2};
	case "heroinu": {2};
	case "heroinp": {1};
	case "pheroin": {1};
	case "painkillers": {1};
	case "cannabis": {2};
	case "fireworks": {1};
	case "marijuana": {1};
	case "hash": {1};
	case "apple": {1};
	case "water": {1};
	case "salema": {2};
	case "ornate": {2};
	case "mackerel": {3};
	case "tuna": {4};
	case "mullet": {3};
	case "catshark": {4};
	case "turtle": {3};
	case "fishing": {2};
	case "turtlesoup": {2};
	case "donuts": {1};
	case "coffee": {1};
	case "fuelE": {2};
	case "fuelF": {5};
	case "money": {0};
	case "pickaxe": {2};
	case "copperore": {2};
	case "ironore": {2};
	case "copperr": {1};
	case "ironr": {1};
	case "sand": {2};
	case "salt": {2};
	case "saltr": {1};
	case "glass": {1};
	case "diamond": {2};
	case "diamondc": {1};
	case "cocaine": {2};
	case "cocainep": {1};
	case "crack": {1};
	case "spikeStrip": {10};
	case "rock": {3};
	case "cement": {2};
	case "goldbar": {6};
	case "moneybag": {6};
	case "blastingcharge": {15};
	case "hackingterminal": {7};
	case "takeoverterminal": {7};
	case "boltcutter": {5};
	case "fireaxe": {5};
	case "defusekit": {2};
	case "storagesmall": {5};
	case "oilbarrel": {5};
	case "storagebig": {10};
	case "frog": {2};
	case "frogp": {1};
	case "acid": {1};
	case "crystalmeth": {3};
	case "methu": {3};
	case "phosphorous": {2};
	case "ephedra": {2};
	case "lithium": {2};
	case "moonshine": {3};
	case "rum": {3};
	case "mashu": {3};
	case "corn": {2};
	case "sugar": {2};
	case "yeast": {2};
	case "platinum": {2};
	case "platinumr": {1};
	case "silver": {2};
	case "silverr": {1};
	case "beer": {1};
	case "cupcake": {1};
	case "pepsi": {1};
	case "burger": {1};
	case "mushroom": {2};
	case "mmushroom": {1};
	case "mmushroomp": {1};
	case "mushroomu": {1};
	case "gpstracker": {2};
	case "egpstracker": {2};
	case "gpsjammer": {3};
	case "ccocaine": {1};
	case "kidney": {25};
	case "scalpel": {4};
	case "barrier": {20};
	case "speedbomb": {10};
	case "potato": {1};
	case "cream": {1};
	case "bloodbag": {5};
	case "epiPen": {10};
	case "dopeShot": {10};
	case "baitcar": {1};
	case "vehAmmo": {5};
	case "woodLog": {3};
	case "lumber": {2};
	case "bananau": {2};
	case "bananap": {1};
	case "topaz": {2};
	case "topazr": {1};
	case "scrap": {1};
	case "emearld": {2};
	case "amethyst": {2};
	case "coin": {2};
	case "wpearl": {1};
	case "bpearl": {1};
	case "cocoau": {2};
	case "cocoap": {1};
	case "bananaSplit": {2};
	case "sugarp": {1};
	case "blindfold": {1};
	case "panicButton": {1};
	case "wplPanicButton": {15};
	case "roadKit": {1};
	case "excavationtools": {1};
	case "stire": {1};
	case "rubber": {1};
	case "alumore": {1};
	case "coal": {1};
	case "ltire": {1};
	case "fibers": {1};
	case "window": {1};
	case "rglass": {1};
	case "vdoor": {1};
	case "electronics": {1};
	case "smetal": {1};
	case "splating": {1};
	case "alumalloy": {1};
	case "bcremote": {0};
	case "paintingSm": {33};
	case "paintingLg": {50};
	case "gokart": {25};
	default {1};
};
