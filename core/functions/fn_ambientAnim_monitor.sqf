//	Author: Poseidon
//	Copyright 2015 Olympus Entertainment
//	This file is not to be used outside of Olympus servers.
//	Description: Does stuff
private["_nearUnits"];
oev_npcAnimations = !oev_npcAnimations;//turn em on, or cff if called again

enableEnvironment oev_npcAnimations;//disable environment if animations disabled

while{oev_npcAnimations} do {
	_nearUnits = ((position player) nearEntities ["Man",40]);

	{
		if(!isPlayer _x) then {
			if(!(_x in oev_animatedNpcs)) then {
				if(_x getVariable ["BIS_fnc_ambientAnim__time",-1] != -1) then {
					(attachedTo _x) enableSimulation true;
					oev_animatedNpcs pushBack _x;
				};
			};
		};
	}foreach _nearUnits;

	{
		if(!(_x in _nearUnits)) then {
			(attachedTo _x) enableSimulation false;
			oev_animatedNpcs = oev_animatedNpcs - [_x];
		};
	}foreach oev_animatedNpcs;

	sleep 2;

	if(!oev_npcAnimations) then {//animations was turned off, so lets disable simulation on any ojects that have it right now.
		if(count oev_animatedNpcs < 0) then {
			{
				(attachedTo _x) enableSimulation false;
			}foreach oev_animatedNpcs;
		};
	};
};