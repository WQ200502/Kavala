//  File: fn_chopShopBoatMenu.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Opens & initializes the boat chop shop menu.
if(oev_action_inUse) exitWith {hint localize "STR_NOTF_ActionInProc"};
disableSerialization;
private["_nearVehicles","_control","_vehicleDetails"];
_nearVehicles = nearestObjects [getMarkerPos (_this select 3),["Ship"],25];

life_chopShop = (_this select 3);
//Error check
if(count _nearVehicles == 0) exitWith {titleText[localize "STR_Shop_NoVehNear","PLAIN DOWN"];};
["Boat_Chop_Shop"] call OEC_fnc_createDialog;

_control = ((findDisplay 39404) displayCtrl 39406);
{
	if(alive _x) then {
		if(isNil {_x getVariable "eventVehicle"}) then {
			_className = typeOf _x;
			_displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");
			_picture = getText(configFile >> "CfgVehicles" >> _className >> "picture");

			_vehicleDetails = ["allVehicles", _className] call OEC_fnc_vehicleConfig;

			if((count _vehicleDetails > 0) && count crew _x == 0) then {
				_price = (_vehicleDetails select 6) * 0.4;
				_control lbAdd _displayName;
				_control lbSetData [(lbSize _control)-1,str(_forEachIndex)];
				_control lbSetPicture [(lbSize _control)-1,_picture];
				_control lbSetValue [(lbSize _control)-1,_price];
				_x setVariable ["chopListIndex", _forEachIndex];
			};
		} else {
			systemChat format["%1 is an event vehicle or medic vehicle and cannot be chopped.",(typeOf _x)];
		};
	};
} foreach _nearVehicles;