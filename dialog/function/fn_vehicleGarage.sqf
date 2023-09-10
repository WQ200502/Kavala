//  File: fn_vehicleGarage.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Handles where vehicles spawn in garages. Tanoa file in unused folder.

params [
	["_spawnPos",objNull,[objNull]],
	["_type","",[""]]
];

switch (typeof _spawnPos) do {
	case "Land_i_Shed_Ind_F": { // Uses file shedGarage now
		oev_garage_sp = [(_spawnPos modelToWorld [6,6.3,-1.5]),(getDir _spawnPos)+270];
	};

	default {
		oev_garage_sp = [(_spawnPos modelToWorld [-11.5,0,0]),(getDir _spawnPos)-90];
	};
};

oev_garage_type = _type;
[[getPlayerUID player,playerSide,_type,player],"OES_fnc_getVehicles",false,false] spawn OEC_fnc_MP;
["Life_impound_menu"] call OEC_fnc_createDialog;
disableSerialization;
ctrlSetText[2802,(localize "STR_ANOTF_QueryGarage")];