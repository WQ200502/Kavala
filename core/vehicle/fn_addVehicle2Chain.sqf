//	Author: Bryan "Tonic" Boardwine
//	Description: A short function for telling the player to add a vehicle to his keychain. DESCRIPTIONEND

params [
	["_vehicle",ObjNull,[ObjNull]],
	["_isGangVehicle",false,[false]]
];

if (_isGangVehicle) then {
	oev_vehicles pushBack _vehicle;
	[[getPlayerUID player,playerSide,_vehicle,1],"OES_fnc_keyManagement",false,false] spawn OEC_fnc_MP;
} else {
	if (!(_vehicle in oev_vehicles)) then {
		oev_vehicles pushBack _vehicle;
	};
};
