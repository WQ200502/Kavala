/*

*/
private ["_waitTime","_vehicles"];
if(!oev_monitorVehicles) exitWith {};
while {oev_monitorVehicles} do {
	_vehicles = [15101.8,16846.1,0.00143814] nearEntities [["LandVehicle","Air","Ship"],20000];

	{
		if !(_x in oev_monitored_vehicles) then {
			oev_monitored_vehicles pushBack _x;
			if(netid _x != "0:0") then {
				[_x] execFSM "SpyGlass\monitorVehicle.fsm";
			};
		};
	}forEach _vehicles;

	{
		if !(_x in _vehicles) then {
			oev_monitored_vehicles deleteAt _forEachIndex;
		};
	}forEach oev_monitored_vehicles;

	_waitTime = diag_tickTime + 15;
	waitUntil{diag_tickTime > _waitTime};
};
