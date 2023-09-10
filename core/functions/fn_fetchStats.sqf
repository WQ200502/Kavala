//	File: fn_fetchStats.sqf
//	Author: TheCmdrRex
//	Description: Returns tier of stat obtained for specific stats
//  FOR USE: call a _tier variable and set it equal to calling the function. Example: _perkTier = ["cop_kills"] call OEC_fnc_fetchStats;

params [
	["_stat","",[""]]
];
private ["_tier","_value"];

if (_stat isEqualTo "") exitWith {};
_tier = 0;
_value = 0;
if (call oev_restrictions) exitWith {_tier = 0; _tier;};

// 0 - Civilian kills, 1 - Cop kills, 2 - Epipens used, 3 - Lockpicked vehicles, 4 - Players robbed, 5 - Prison time spent, 6 - Suicide vests used, 7 - Armed plane kills, 8 - Drugs sold, 9 - Bombs planted, 10 - AA Hacked, 11 - Cop lethals, 12 - Pardons issued, 13 - Cop arrests, 14 - Tickets issued that were paid, 15 - Bombs defused, 16 - Donuts eaten, 17 - Drugs seized (currency), 18 - Warkills, 19 - Vigilante arrests, 20 - Gokart time (time trial), 21 - Toolkits used on medic, 22 - AA Repairs, 23 - Medic Impounds (not windows key)
// O_stats_kills,O_stats_deaths,O_stats_revives,O_stats_distanceFoot,O_stats_distanceVehicle,O_stats_bountiesReceived,O_stats_arrestsMade,O_stats_playtime_civ,O_stats_playtime_cop,O_stats_playtime_med

switch (_stat) do {
	// **************************  CIVILAN PERKS  ************************** \\

	case "civ_minutes": {
		_value = O_stats_playtime_civ;
		switch (true) do {
			case (_value >= 15000 && _value < 30000): {_tier = 1;};
			case (_value >= 30000 && _value < 60000): {_tier = 2;};
			case (_value >= 60000): {_tier = 3;};
			default {_tier = 0};
		};
	};

	case "civ_kills": {
		_value = oev_statsTable select 0;
		switch (true) do {
			case (_value >= 1000 && _value < 2500): {_tier = 1;};
			case (_value >= 2500 && _value < 5000): {_tier = 2;};
			case (_value >= 5000 && _value < 7500): {_tier = 3;};
			case (_value >= 7500 && _value < 10000): {_tier = 4;};
			case (_value >= 10000): {_tier = 5;};
			default {_tier = 0};
		};
	};

	case "civ_deaths": {
		_value = O_stats_deaths;
		switch (true) do {
			case (_value >= 500): {_tier = 1;};
			default {_tier = 0};
		};
	};

	case "civ_warKills": {
		_value = oev_statsTable select 18;
		switch (true) do {
			case (_value >= 250 && _value < 500): {_tier = 1;};
			case (_value >= 500 && _value < 1000): {_tier = 2;};
			case (_value >= 1000 && _value < 2500): {_tier = 3;};
			case (_value >= 2500 && _value < 5000): {_tier = 4;};
			case (_value >= 5000 && _value < 10000): {_tier = 5;};
			case (_value >= 10000): {_tier = 6;};
			default {_tier = 0};
		};
	};

	case "civ_epiPens": {
		_value = oev_statsTable select 2;
		switch (true) do {
			case (_value >= 50 && _value < 250): {_tier = 1;};
			case (_value >= 250): {_tier = 2;};
			default {_tier = 0};
		};
	};
	case "civ_lockpicks": {
		_value = oev_statsTable select 3;
		switch (true) do {
			case (_value >= 100 && _value < 250): {_tier = 1;};
			case (_value >= 250): {_tier = 2;};
			default {_tier = 0};
		};
	};
	case "civ_jailTime": {
		_value = oev_statsTable select 5;
		switch (true) do {
			case (_value >= 5 && _value < 25): {_tier = 1;};
			case (_value >= 25 && _value < 150): {_tier = 2;};
			case (_value >= 150): {_tier = 3;};
			default {_tier = 0};
		};
	};
	case "civ_suicideVests": {
		_value = oev_statsTable select 6;
		switch (true) do {
			case (_value >= 5 && _value < 25): {_tier = 1;};
			case (_value >= 25): {_tier = 2;};
			default {_tier = 0};
		};
	};
	case "civ_planeKills": {
		_value = oev_statsTable select 7;
		switch (true) do {
			case (_value >= 10 && _value < 50): {_tier = 1;};
			case (_value >= 50 && _value < 100): {_tier = 2;};
			case (_value >= 100 && _value < 250): {_tier = 3;};
			case (_value >= 250 && _value < 500): {_tier = 4;};
			case (_value >= 500): {_tier = 5;};
			default {_tier = 0};
		};
	};
	case "civ_drugsSold": {
		_value = oev_statsTable select 8;
		switch (true) do {
			case (_value >= 100000): {_tier = 1;};
			default {_tier = 0};
		};
	};
	case "civ_bombsPlanted": {
		_value = oev_statsTable select 9;
		switch (true) do {
			case (_value >= 5 && _value < 25): {_tier = 1;};
			case (_value >= 25 && _value < 50): {_tier = 2;};
			case (_value >= 50): {_tier = 3;};
			default {_tier = 0};
		};
	};
	case "civ_hackedAAs": {
		_value = oev_statsTable select 10;
		switch (true) do {
			case (_value >= 5 && _value < 25): {_tier = 1;};
			case (_value >= 25 && _value < 50): {_tier = 2;};
			case (_value >= 50): {_tier = 3;};
			default {_tier = 0};
		};
	};
	case "civ_vigiArrests": {
		_value = oev_statsTable select 19;
		switch (true) do {
			case (_value >= 100 && _value < 150): {_tier = 1;};
			case (_value >= 150 && _value < 200): {_tier = 2;};
			case (_value >= 200): {_tier = 3;};
			default {_tier = 0};
		};
	};
	case "civ_copKills": {
		_value = oev_statsTable select 1;
		switch (true) do {
			case (_value >= 50 && _value < 100): {_tier = 1;};
			case (_value >= 100 && _value < 500): {_tier = 2;};
			case (_value >= 500 && _value < 1000): {_tier = 3;};
			case (_value >= 1000 && _value < 5000): {_tier = 4;};
			case (_value >= 5000): {_tier = 5;};
			default {_tier = 0};
		};
	};
	case "civ_lethal_injections": {
		_value = oev_statsTable select 43;
		switch (true) do {
			case (_value >= 10 && _value < 25): {_tier = 1;};
			case (_value >= 25 && _value < 50): {_tier = 2;};
			case (_value >= 50 && _value < 100): {_tier = 3;};
			case (_value >= 100): {_tier = 4;};
			default {_tier = 0};
		};
	};

	// **************************  MEDIC PERKS  ************************** \\
	case "med_minutes": {
		_value = O_stats_playtime_med;
		switch (true) do {
			case (_value >= 1000 && _value < 2000): {_tier = 1;};
			case (_value >= 2000 && _value < 4000): {_tier = 2;};
			case (_value >= 4000 && _value < 7000): {_tier = 3;};
			case (_value >= 7000 && _value < 10000): {_tier = 4;};
			case (_value >= 10000 && _value < 20000): {_tier = 5;};
			case (_value >= 20000 && _value < 30000): {_tier = 6;};
			case (_value >= 30000 && _value < 40000): {_tier = 7;};
			case (_value >= 40000 && _value < 60000): {_tier = 8;};
			case (_value >= 60000): {_tier = 9;};
			default {_tier = 0};
		};
	};
	case "med_revives": {
		_value = O_stats_revives;
		switch (true) do {
			case (_value >= 1000 && _value < 1500): {_tier = 1;};
			case (_value >= 1500 && _value < 2500): {_tier = 2;};
			case (_value >= 2500 && _value < 3500): {_tier = 3;};
			case (_value >= 3500 && _value < 4500): {_tier = 4;};
			case (_value >= 4500 && _value < 5500): {_tier = 5;};
			case (_value >= 5500 && _value < 7000): {_tier = 6;};
			case (_value >= 7000 && _value < 8500): {_tier = 7;};
			case (_value >= 8500 && _value < 10000): {_tier = 8;};
			case (_value >= 10000): {_tier = 9;};
			default {_tier = 0};
		};
	};
	case "med_toolkits": {
		_value = oev_statsTable select 21;
		switch (true) do {
			case (_value >= 50 && _value < 100): {_tier = 1;};
			case (_value >= 100 && _value < 200): {_tier = 2;};
			case (_value >= 200 && _value < 350): {_tier = 3;};
			case (_value >= 350 && _value < 500): {_tier = 4;};
			case (_value >= 500): {_tier = 5;};
			default {_tier = 0};
		};
	};
	case "med_impounds": {
		_value = oev_statsTable select 23;
		switch (true) do {
			case (_value >= 50 && _value < 100): {_tier = 1;};
			case (_value >= 100 && _value < 200): {_tier = 2;};
			case (_value >= 200 && _value < 350): {_tier = 3;};
			case (_value >= 350 && _value < 500): {_tier = 4;};
			case (_value >= 500): {_tier = 5;};
			default {_tier = 0};
		};
	};
	// **************************  COP PERKS  ************************** \\
	case "cop_drugs": {
		_value = oev_statsTable select 17;
		switch (true) do {
			case (_value >= 1250000 && _value < 5000000): {_tier = 1;};
			case (_value >= 5000000 && _value < 12500000): {_tier = 2;};
			case (_value >= 12500000 && _value < 20000000): {_tier = 3;};
			case (_value >= 20000000): {_tier = 4;};
			default {_tier = 0};
		};
	};
	case "cop_lethals": {
		_value = oev_statsTable select 11;
		switch (true) do {
			case (_value >= 100 && _value < 250): {_tier = 1;};
			case (_value >= 250 && _value < 500): {_tier = 2;};
			case (_value >= 500 && _value < 1000): {_tier = 3;};
			case (_value >= 1000 && _value < 2000): {_tier = 4;};
			case (_value >= 2000): {_tier = 5;};
			default {_tier = 0};
		};
	};
	case "cop_pardons": {
		_value = oev_statsTable select 12;
		switch (true) do {
			case (_value >= 50 && _value < 100): {_tier = 1;};
			case (_value >= 100 && _value < 250): {_tier = 2;};
			case (_value < 250): {_tier = 3;};
			case (_value >= 500): {_tier = 4;};
			default {_tier = 0};
		};
	};
	case "cop_defuses": {
		_value = oev_statsTable select 15;
		switch (true) do {
			case (_value >= 5 && _value < 10): {_tier = 1;};
			case (_value >= 10 && _value < 20): {_tier = 2;};
			case (_value >= 20 && _value < 30): {_tier = 3;};
			case (_value >= 30 && _value < 50): {_tier = 4;};
			case (_value >= 50): {_tier = 5;};
			default {_tier = 0};
		};
	};
	case "cop_minutes": {
		_value = O_stats_playtime_cop;
		switch (true) do {
			case (_value >= 9000 && _value < 15000): {_tier = 1;};
			case (_value >= 15000 && _value < 45000): {_tier = 2;};
			case (_value >= 45000 && _value < 60000): {_tier = 3;};
			case (_value >= 60000 && _value < 78000): {_tier = 4;};
			case (_value >= 78000): {_tier = 5;};
			default {_tier = 0};
		};
	};
	case "cop_tickets": {
		_value = oev_statsTable select 14;
		switch (true) do {
			case (_value >= 50 && _value < 100): {_tier = 1;};
			case (_value >= 100 && _value < 200): {_tier = 2;};
			case (_value >= 200 && _value < 500): {_tier = 3;};
			case (_value >= 500): {_tier = 4;};
			default {_tier = 0};
		};
	};

	case "cop_repairedAAs": {
		_value = oev_statsTable select 22;
		switch (true) do {
			case (_value >= 5 && _value < 10): {_tier = 1;};
			case (_value >= 10 && _value < 20): {_tier = 2;};
			case (_value >= 20 && _value < 30): {_tier = 3;};
			case (_value >= 30 && _value < 50): {_tier = 4;};
			case (_value >= 50): {_tier = 5;};
			default {_tier = 0};
		};
	};

	// **************************  PERKS FOR ALL  ************************** \\

	case "all_distance": {
		_value = round((O_stats_distanceFoot)/1000);
		switch (true) do {
			case (_value >= 100 && _value < 1000): {_tier = 1;};
			case (_value >= 1000): {_tier = 2;};
			default {_tier = 0};
		};
	};

	// **************************  SERVER BEST  ************************** \\
	case "srv_revives": {
		if ((getplayerUID player) isEqualTo (oev_title_pid select 14/* NEW SERVER BEST STAT NOT 14*/ )) then {_tier = 1;} else {_tier = 0;};
	};
	case "srv_med_minutes": {
		if ((getplayerUID player) isEqualTo (oev_title_pid select 14/* NEW SERVER BEST STAT NOT 14*/ )) then {_tier = 1;} else {_tier = 0;};
	};
	case "srv_med_impounds": {
		if ((getplayerUID player) isEqualTo (oev_title_pid select 14/* NEW SERVER BEST STAT NOT 14*/ )) then {_tier = 1;} else {_tier = 0;};
	};
	case "srv_med_toolkits": {
		if ((getplayerUID player) isEqualTo (oev_title_pid select 14/* NEW SERVER BEST STAT NOT 14*/ )) then {_tier = 1;} else {_tier = 0;};
	};
	default {hint "ERROR: Stat not found!";};
};

_tier;
