//  File: fn_updateStat
//	Description: updates the selected stat.
private["_stat"];
_stat = param [0,"",[""]];

switch(_stat) do {
	case "stat_kills": {O_stats_kills = O_stats_kills + 1;};
};