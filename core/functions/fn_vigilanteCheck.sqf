//  File: fn_vigilanteCheck.sqf
//	Author: Kurt

//	Description: If the person who tazed the unit had a vigi license then set the vigitase bool
params [
	["_victim",objNull,[objNull]]
];
if (isNull _victim) exitWith {};
if (license_civ_vigilante) then {
	_victim setVariable["tazedBy",[player,1],true];
} else {
	if (playerSide == west) then {
		_victim setVariable["tazedBy",[player,2],true];
	};
};



