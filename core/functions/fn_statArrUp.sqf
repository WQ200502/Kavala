// File: fn_statArrUp.sqf
// Author: Jesse "tkcjesse" Schultz
// Description: Updates the stats array for the player.
// _this select 0 - index to update
// _this select 1 - value to update by
// 0-marijuana, 1-heroin, 2-cocaine, 3-meth, 4-mush, 5-frog, 6-oil, 7-iron, 8-diamond, 9-glass, 10-cement, 11-plat, 12-moon, 13-fishnum, 14-salt, 15-silver, 16-copper, 17-goldbar, 18-turtle, 19-redgull, 20-coffee, 21-lockpickfail, 22-lockpicksuc, 23-blastcharge, 24-epipen, 25-speedbomb, 26-salvagenum, 27-salvagemoney, 28-revives(med), 29-contraband, 30-copmoney, 31-bloodbag, 32-ticketspaid, 33-ticketsval, 34-defuses, 35-kidneys, 36-fishmon
// oev_tempStats = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

params [["_realItem","",[""]],["_value",-1,[0]]];
private ["_item"];
if (_realItem isEqualTo "" || _value isEqualTo -1) exitWith {};

// Convert double-processed drugs to single-processed variant
_item = switch (_realItem) do {
	case "hash": {"marijuana"};
	case "acid": {"frogp"};
	case "mushroomu": {"mmushroom"};
	case "crack": {"cocainep"};
	case "pheroin": {"heroinp"};
	default { _realItem };
};

private _index = -1;
switch (_item) do {
	case "marijuana": {_index = 0;oev_statsTable set [8,(oev_statsTable select 8) + _value];};
	case "heroinp": {_index = 1;oev_statsTable set [8,(oev_statsTable select 8) + _value];};
	case "cocainep": {_index = 2;oev_statsTable set [8,(oev_statsTable select 8) + _value];};
	case "crystalmeth": {_index = 3;oev_statsTable set [8,(oev_statsTable select 8) + _value];};
	case "mmushroom": {_index = 4;oev_statsTable set [8,(oev_statsTable select 8) + _value];};
	case "frogp": {_index = 5;oev_statsTable set [8,(oev_statsTable select 8) + _value];};
	case "oilp": {_index = 6;};
	case "ironr": {_index = 7;};
	case "diamondc": {_index = 8;};
	case "glass": {_index = 9;};
	case "cement": {_index = 10;};
	case "platinumr": {_index = 11;};
	case "moonshine": {_index = 12;oev_statsTable set [8,(oev_statsTable select 8) + _value];};
	case "fishnum": {_index = 13;};
	case "saltr": {_index = 14;};
	case "silverr": {_index = 15;};
	case "copperr": {_index = 16;};
	case "goldbar": {_index = 17;};
	case "turtle": {_index = 18;};
	case "redgull": {_index = 19;};
	case "coffee": {_index = 20;};
	case "lockpickfail": {_index = 21;};
	case "lockpicksuc": {_index = 22;oev_statsTable set [3,(oev_statsTable select 3) + _value];};
	case "blastfed": {_index = 23;oev_statsTable set [9,(oev_statsTable select 9) + _value];};
	case "epipen": {_index = 24;oev_statsTable set [2,(oev_statsTable select 2) + _value];};
	case "speedbomb": {_index = 25;};
	case "salvagenum": {_index = 26;};
	case "salvagemon": {_index = 27;};
	case "revive": {_index = 28;};
	case "contraband": {_index = 29;};
	case "copmoney": {_index = 30;};
	case "bloodbag": {_index = 31;};
	case "ticketpaid": {_index = 32;};
	case "ticketval": {_index = 33;};
	case "defuses": {_index = 34;oev_statsTable set [15,(oev_statsTable select 15) + _value];};
	case "kidney": {_index = 35;};
	case "fishmon": {_index = 36;};
	case "blastbw": {_index = 37;oev_statsTable set [9,(oev_statsTable select 9) + _value];};
	case "blastjail": {_index = 38;oev_statsTable set [9,(oev_statsTable select 9) + _value];};
	case "vigiarrest": {_index = 39;oev_statsTable set [19,(oev_statsTable select 19) + _value];};
	case "civ_kills": {_index = 40;oev_statsTable set [0,(oev_statsTable select 0) + _value];};
	case "cop_kills": {_index = 41;oev_statsTable set [1,(oev_statsTable select 1) + _value];};
	case "robberies": {_index = 42;oev_statsTable set [4,(oev_statsTable select 4) + _value];};
	case "prison_time": {_index = 43;oev_statsTable set [5,(oev_statsTable select 5) + _value];};
	case "sui_vest": {_index = 44;oev_statsTable set [6,(oev_statsTable select 6) + _value];};
	case "plane_kills": {_index = 45;oev_statsTable set [7,(oev_statsTable select 7) + _value];};
	case "AA_hacked": {_index = 46;oev_statsTable set [10,(oev_statsTable select 10) + _value];};
	case "cop_lethals": {_index = 47;oev_statsTable set [11,(oev_statsTable select 11) + _value];};
	case "pardons": {_index = 48;oev_statsTable set [12,(oev_statsTable select 12) + _value];};
	case "cop_arrests": {_index = 49;oev_statsTable set [13,(oev_statsTable select 13) + _value];};
	case "tickets_issued_paid": {_index = 50;oev_statsTable set [14,(oev_statsTable select 14) + _value];};
	case "donuts": {_index = 51;oev_statsTable set [16,(oev_statsTable select 16) + _value];};
	case "drugs_seized_currency": {_index = 52;oev_statsTable set [17,(oev_statsTable select 17) + _value];};
	case "gokart_time": {_index = 53;oev_statsTable set [20,_value];};
	case "med_toolkits": {_index = 54;oev_statsTable set [21,(oev_statsTable select 21) + _value];};
	case "AA_repaired": {_index = 55;oev_statsTable set [22,(oev_statsTable select 22) + _value];};
	case "med_impounds": {_index = 56;oev_statsTable set [23,(oev_statsTable select 23) + _value];};
	case "titan_hits": {_index = 57;oev_statsTable set [24,(oev_statsTable select 24) + _value];};
	case "hit_claimed": {_index = 58;oev_statsTable set [25,(oev_statsTable select 25) + _value];};
	case "hit_placed": {_index = 59;oev_statsTable set [26,(oev_statsTable select 26) + _value];};
	case "bets_won": {_index = 60;oev_statsTable set [27,(oev_statsTable select 27) + _value];};
	case "bets_lost": {_index = 61;oev_statsTable set [28,(oev_statsTable select 28) + _value];};
	case "bets_won_value": {_index = 62;oev_statsTable set [29,(oev_statsTable select 29) + _value];};
	case "bets_lost_value": {_index = 63;oev_statsTable set [30,(oev_statsTable select 30) + _value];};
	case "vehicles_chopped": {_index = 64;oev_statsTable set [31,(oev_statsTable select 31) + _value];};
	case "cops_robbed": {_index = 65;oev_statsTable set [32,(oev_statsTable select 32) + _value];};
	case "jail_escapes": {_index = 66;oev_statsTable set [33,(oev_statsTable select 33) + _value];};
	case "money_spent": {_index = 67;oev_statsTable set [34,(oev_statsTable select 34) + _value];};
	case "events_won": {_index = 68;oev_statsTable set [35,(oev_statsTable select 35) + _value];};
	case "blastbank": {_index = 69;oev_statsTable set [9,(oev_statsTable select 9) + _value];};
	case "kills_1km": {_index = 70;oev_statsTable set [36,(oev_statsTable select 36) + _value];};
	case "conq_kills": {_index = 71;oev_statsTable set [37,(oev_statsTable select 37) + _value];};
	case "conq_deaths": {_index = 72;oev_statsTable set [38,(oev_statsTable select 38) + _value];};
	case "conq_captures": {_index = 73;oev_statsTable set [39,(oev_statsTable select 39) + _value];};
	case "casino_winnings": {_index = 74;oev_statsTable set [40,(oev_statsTable select 40) + _value];};
	case "casino_losses": {_index = 75;oev_statsTable set [41,(oev_statsTable select 41) + _value];};
	case "casino_uses": {_index = 76;oev_statsTable set [42,(oev_statsTable select 42) + _value];};
	case "lethal_injections": {_index = 77;oev_statsTable set [43,(oev_statsTable select 43) + _value];};
	default {-1};
};

if (_index isEqualTo -1 || _value isEqualTo -1) exitWith {};

//Added code for time trial
private _curVal = if (_index isEqualTo 53) then {
	_value;
} else {
	(oev_tempStats select _index) + _value;
};

oev_tempStats set [_index,_curVal];

[] spawn OEC_fnc_titleNotification;
