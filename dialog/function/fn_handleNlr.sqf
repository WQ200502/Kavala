//	Author: djwolf
//	Date: 12/22/2015
//	File: fn_handleNlr.sqf
//	Description: Performs the actions for the automatic NLR system when the client dies.

private "_getTime";
life_nlr_threadActive = true;
while {(count life_death_markers) > 0} do {
	{
		if ((_x select 1) < 1) then {
			life_death_markers deleteAt _forEachIndex;
		} else {
			_getTime = _x select 1;
			_getTime = _getTime - 1;
			_x set [1,_getTime];
		};
	} forEach life_death_markers;
	sleep 1;
};
life_nlr_threadActive = false;