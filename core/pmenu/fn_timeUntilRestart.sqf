private ["_ttr"];
_ttr = if (isNil "serverStartTime") then {
	round((144000 - serverTime) / 60)
} else {
	round((serverCycleLength - (serverTime - serverStartTime)) / 60)
};
_ttr
