//  File: fn_playerCount.sqf
//	Author: TheCmdrRex
//	Description: Retrieves the amount of players on per side specified.

params [
	["_faction",civilian,[independent]],
	["_mode",-1,[0]]
];

switch (_mode) do {
	// For usage when people for some reason wanna use a script. Other than that this is fucking useless
	case 1: {
		{side _x isEqualTo _faction} count playableUnits;
	};

	// Federal Event Cop Count (Takes total cops minus training cops)
	case 2: {
		private _copCount = {side _x isEqualTo west} count playableUnits;
		private _trainingDome = nearestObject [[17402.2,13235.8,0.0014677],"Land_Dome_Small_F"];
		{
			// If player is cop AND EITHER is in the training dome OR is on debug and hasn't died playing (that is why afkCheck would be nil) then decrement the cop count
			// This prevents people from temporarily selecting cop slot to get an easy bomb down
			if ((side _x isEqualTo west) && ((_x distance _trainingDome < 29) || (_x distance getMarkerPos("debug_island_marker") < 600 && isNil {_x getVariable "afkCheck"}))) then {
				_copCount = _copCount - 1;
			};
		} forEach playableUnits;
		_copCount;
	};
};