//  File: fn_impoundYardMenu.sqf
//	Author: [OS] Odin

//	Description: Opens & initializes the impound yard menu.
if(oev_action_inUse) exitWith {hint localize "STR_NOTF_ActionInProc"};
if(playerSide != independent) exitWith {hint "You must be a medic to use Impound Yards."; closeDialog 0;};
disableSerialization;
private["_nearVehicles","_control","_vehicleDetails"];
_nearVehicles = nearestObjects [getMarkerPos (_this select 3),["Car","Truck","Air"],5];

life_impoundYard = (_this select 3);
//Error check
if(count _nearVehicles isEqualTo 0) exitWith {hint "No vehicles nearby.";};
["Impound_Yard"] call OEC_fnc_createDialog;

_control = ((findDisplay 39600) displayCtrl 39602);

{
	if(alive _x) then {
		if(((_x getVariable ["side",""]) != "med") && (isNil {_x getVariable "eventVehicle"})) then {
			_className = typeOf _x;
			_displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");
			_picture = getText(configFile >> "CfgVehicles" >> _className >> "picture");

			_vehicleDetails = ["allVehicles", _className] call OEC_fnc_vehicleConfig;

			if((count _vehicleDetails > 0) && (({alive _x} count crew _x) isEqualTo 0)) then {
				_price = (_vehicleDetails select 6) * 0.1;
				_control lbAdd _displayName;
				_control lbSetData [(lbSize _control)-1,str(_forEachIndex)];
				_control lbSetPicture [(lbSize _control)-1,_picture];
				_control lbSetValue [(lbSize _control)-1,_price];
			};
		} else {
			hint "Medic and event vehicles may not be impounded here..."; closeDialog 0;
		};
	};
} forEach _nearVehicles;