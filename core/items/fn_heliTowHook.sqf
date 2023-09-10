//	Description: used on a car, enables towing with helis

private["_vehicle"];
_vehicle = param [0,ObjNull,[ObjNull]];

if(isNull _vehicle) exitWith {[true,"heliTowHook",1] call OEC_fnc_handleInv;};
if(locked _vehicle != 0 && (side player isEqualTo civilian)) exitWith {hint "Vehicle must be unlocked to attach hooks.";[true,"heliTowHook",1] call OEC_fnc_handleInv;};
if(typeOf _vehicle in ["B_SDV_01_F","O_SDV_01_F","O_Truck_03_repair_F","O_Truck_03_ammo_F","B_Truck_01_ammo_F","O_LSV_02_armed_F"]) exitWith {hint "This vehicle cannot be sling loaded.";[true,"heliTowHook",1] call OEC_fnc_handleInv;};
if(_vehicle getVariable ["isEscort",false]) exitWith {hint "This vehicle cannot be sling loaded.";[true,"heliTowHook",1] call OEC_fnc_handleInv;};

[_vehicle] remoteExec["OES_fnc_enableVehicleSling",2];
hint "For best performance, always leave the vehicle you are slinging unoccupied. Otherwise, the sling rope may break!";

_vehicle spawn{
	uiSleep 10;
	if(!(ropeAttachEnabled _this)) then {
		hint "Unable to attach hooks to vehicle.";
		[true,"heliTowHook",1] call OEC_fnc_handleInv;
	};
};