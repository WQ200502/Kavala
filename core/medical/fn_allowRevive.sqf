//  File: fn_allowRevive.sqf
//	Author: Serpico
//	Description: Sets the player in a state that allows their faction to revive them without alerting RnR.

life_corpse setVariable["revive",FALSE,TRUE];
life_corpse setVariable["allowEpi",true,TRUE];

disableSerialization;
((findDisplay 7300) displayCtrl 7307) ctrlEnable false;