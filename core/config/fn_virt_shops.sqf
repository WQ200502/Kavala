#include "..\..\macro.h"
//  File: fn_virt_shops.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Config for virtual shops.
private _shop = _this select 0;

switch (_shop) do {
	case "market": {
		if(__GETC__(oev_donator) >= 15 || life_freedom) then {
			if (license_civ_wpl) then {
				["Altis市场",["water","beer","apple","peach","redgull","tbacon","potato","pickaxe","excavationtools","fuelF","gokart","fireworks","sugar","corn","yeast","lithium","mushroom","wplPanicButton"]]
			} else {
				["Altis市场",["water","beer","apple","peach","redgull","tbacon","potato","pickaxe","excavationtools","fuelF","gokart","fireworks","sugar","corn","yeast","lithium","mushroom"]]
			};
		} else {
			if (license_civ_wpl) then {
				["Altis市场",["water","beer","apple","peach","redgull","tbacon","potato","excavationtools","pickaxe","fuelF","sugar","corn","yeast","lithium","mushroom","wplPanicButton"]]
			} else {
				["Altis市场",["water","beer","apple","peach","redgull","tbacon","potato","excavationtools","pickaxe","fuelF","sugar","corn","yeast","lithium","mushroom"]]
			};
		};
	};
	case "dopamine": {["Dopamine Crate",["epiPen","dopeShot","bloodbag","redgull","water","tbacon"]]}; // Price must match in fn_clientwiretransfer
	case "art": {["Painting Market",["paintingSm","paintingLg"]]};
	case "housing": {["Housing Supply",[]]};
	case "Wongs": {["Wongs Food Cart",["turtlesoup","turtle"]]};
	case "coffee": {["Stratis Coffee Club",["coffee","donuts"]]};
	case "heroin": {["Drug Dealer",["cocainep","heroinp","marijuana","frogp","crystalmeth","mmushroom","hash","crack","pheroin","mushroomu","acid","moneybag"]]};
	case "oil": {["Oil Trader",["oilp","pickaxe","fuelF"]]};
	case "gang": {["Gang Market",["water","apple","redgull","tbacon","lockpick","pickaxe","fuelF","peach","blastingcharge","boltcutter","bloodbag","epiPen","blindfold"]]};
	case "fishmarket": {["Altis Fish Market",["salema","ornate","mackerel","mullet","tuna","catshark"]]};
	case "glass": {["Altis Glass Dealer",["glass"]]};
	case "iron": {["Altis Industrial Trader",["ironr","copperr"]]};
	case "diamond": {["Diamond Dealer",["diamond","diamondc"]]};
	case "salt": {["Salt Dealer",["saltr"]]};
	case "cop": {
		switch (true) do {
			case (__GETC__(life_coplevel) isEqualTo 1): {
				["警察物品商店",["donuts","coffee","spikeStrip","water","fuelF","defusekit","gpstracker","egpstracker","bloodbag","epiPen","dopeShot","painkillers","tbacon","blindfold","heliTowHook","gokart"]]
			};
			case (__GETC__(life_coplevel) isEqualTo 2): {
				["警察物品商店",["donuts","coffee","spikeStrip","water","fuelF","defusekit","gpstracker","egpstracker","bloodbag","epiPen","dopeShot","painkillers","tbacon","blindfold","heliTowHook","gokart"]]
			};
			case (__GETC__(life_coplevel) isEqualTo 3): {
				["警察物品商店",["donuts","coffee","spikeStrip","water","fuelF","defusekit","gpstracker","egpstracker","bloodbag","epiPen","dopeShot","painkillers","tbacon","blindfold","heliTowHook","gokart","baitcar","vehAmmo"]]
			};
			case (__GETC__(life_coplevel) >= 4): {
				["警察物品商店",["donuts","coffee","spikeStrip","water","fuelF","defusekit","gpstracker","egpstracker","bloodbag","epiPen","dopeShot","painkillers","tbacon","blindfold","heliTowHook","gokart","baitcar","vehAmmo"]]
			};
		};
	};
	case "cement": {["Cement Dealer",["cement"]]};
	case "brew": {["Moonshine Brewery",["moonshine","rum"]]};
	case "platinum": {["Platinum Dealer",["platinum","platinumr"]]};
	case "silver": {["Silver Dealer",["silver","silverr"]]};
	case "rebel": {["Rebel Shop",["water","beer","epiPen","dopeShot","pheroin","redgull","tbacon","potato","lockpick","fuelF","ziptie","boltcutter","blastingcharge","hackingterminal","gpstracker","egpstracker","gpsjammer","speedbomb","heliTowHook","gokart","bloodbag","blindfold","kidney","lethalinjector","scalpel","vehAmmo","takeoverterminal"]]};

	case "medic": {
		if(__GETC__(life_medicLevel) >= 5) then {
			["医生商店",["water","lollypop","tbacon","potato","fuelF","heliTowHook","gokart","bloodbag","epiPen","painkillers","fireaxe"]]
		};
		if(__GETC__(life_medicLevel) >= 1) then {
			["医生商店",["water","lollypop","tbacon","potato","fuelF","heliTowHook","bloodbag","epiPen","painkillers","fireaxe"]]
		} else {
			["医生商店",["water","redgull","tbacon","potato","fuelF","heliTowHook","gokart","bloodbag","epiPen","dopeShot"]]
		};
	};
	case "vigilante": {["Vigilante Shop",["water","redgull","tbacon","potato","ziptie","blindfold","bloodbag","epiPen","dopeShot","boltcutter","gpstracker","gokart"]]};
	case "redburger": {["Red Burger Shop",["water","beer","redgull","pepsi","burger","cupcake"]]};
	case "admin": {["Admin Virtual Items",["apple","beer","blastingcharge","blindfold","bloodbag","boltcutter","burger","cannabis","catshark","cement","cocaine","cocainep","coffee","copperore","copperr","corn","crystalmeth","cupcake","defusekit","diamond","diamondc","donuts","egpstracker","ephedra","epiPen","dopeShot","fireworks","frog","frogp","fuelE","fuelF","glass","goldbar","gpsjammer","gpstracker","hackingterminal","heliTowHook","heroinp","heroinu","ironore","ironr","kidney","lethalinjector","lithium","lockpick","mackerel","marijuana","mmushroom","moonshine","mullet","mushroom","oilp","oilu","ornate","peach","pepsi","phosphorous","pickaxe","platinum","platinumr","potato","redgull","rock","salema","salt","saltr","sand","scalpel","silver","silverr","speedbomb","spikeStrip","moneybag","sugar","tbacon","tuna","turtle","vehAmmo","water","yeast","ziptie","topazr","wpearl","bpearl","amethyst","emerald","coin","scrap","hash","crack","pheroin","mushroomu","acid","gokart"]]};
	case "banana": {["Banana Trader",["bananap"]]};
	case "topaz": {["Topaz Trader",["topazr"]]};
	case "goldbar": {["Gold Trader",["goldbar"]]};
	case "cocoa": {["Cocoa Trader",["cocoap"]]};
	case "sugar": {["Sugar Trader",["sugarp"]]};
	case "lumber": {["Homie Depot",["lumber"]]};
	case "bananasplit": {["Banana Split Trader",["bananaSplit"]]};
	case "salvage": {["Salvage Trader",["excavationtools","topazr","wpearl","bpearl","amethyst","emerald","coin","scrap"]]};
	case "dive": {["Diving Item Shop",["excavationtools","water","redgull","tbacon","potato"]]};
};
