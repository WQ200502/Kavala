//  File: fn_seizeObjects.sqf
//	Description: Deletes nearby guns

private["_nearOjbects","_counter"];
_nearObjects = nearestObjects [player,["weaponholder","GroundWeaponHolder","WeaponHolderSimulated"],3];
_counter = 0;
for "_i" from 0 to count _nearObjects - 1 do {
	if((netid (_nearObjects select _i) != "0:0")) then {
		_counter = _counter + 1;
		deleteVehicle (_nearObjects select _i);
	}else{
		hint format["Cannot seize object %1. Object is likely decoration, and not a usable item.",typeof (_nearObjects select _i)];
	};
};
titleText[format["Seized %1 ground objects in the vicinity.", _counter],"PLAIN DOWN"];
[
	["event","Seized Gound Objects"],
	["player",name player],
	["player_id",getPlayerUID player],
	["amount",_counter],
	["position",getPosATL player]
] call OEC_fnc_logIt;
