//  File: fn_deployVehicleTeargas.sqf
// 	Author: ikiled
//	Description: Deploys teargas between 1 second intervals from a vehicle.

if(!(playerSide isEqualTo west) || !((player getVariable ["rank",3]) > 4)) exitWith {hint "You cannot deploy teargas.";};

private _vehicle = vehicle player;
private _numCans = 3; // Amount of smoke screens to deploy per deployment

if ((_vehicle getVariable ["teargasCans", 0]) >= _numCans) then {

	_vehicle setVariable ["teargasCans", ((_vehicle getVariable ["teargasCans", 0])-(_numCans)), true];

	for "_i" from 0 to 2 do {
	  private  _smoke1 = createVehicle ["SmokeShellOrange", position _vehicle, [], 0 , ""];
	  uiSleep 1;
	};

	hint parseText format ["<t color='#FF9933' align='center' size='1.8'><t ><t >Plane Ammunition</t><br/><t color='#ffffff' size='1.1'>You have %1 teargas canisters remaining.</t>", _vehicle getVariable ["teargasCans", 0]];
} else {

	hint parseText format ["<t color='#FF9933' align='center' size='1.8'><t ><t >Plane Ammunition</t><br/><t color='#ffffff' size='1.1'>You do not have enough teargas remaining.</t>"];
};
