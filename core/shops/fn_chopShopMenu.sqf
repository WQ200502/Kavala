//  File: fn_chopShopMenu.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Opens & initializes the chop shop menu.
if(oev_action_inUse) exitWith {hint localize "STR_NOTF_ActionInProc"};
if(playerSide != civilian) exitWith {};
disableSerialization;
private _nearVehicles = nearestObjects [getMarkerPos (_this select 3),["Car","Truck","Air"],25];
private _nearUnits = (nearestObjects[player,["Man"],10]) arrayIntersect playableUnits;
if(count _nearUnits > 1) exitWith {hint "You can't chop a vehicle while a player is near!"};

life_chopShop = (_this select 3);
if (life_chopShop isEqualTo oev_conqChop) exitWith {hint "Out for lunch... Will be back 5 minutes after conquest ends.";};
//Error check
if(count _nearVehicles isEqualTo 0) exitWith {titleText[localize "STR_Shop_NoVehNear","PLAIN DOWN"];};
["Chop_Shop"] call OEC_fnc_createDialog;

private _control = ((findDisplay 39400) displayCtrl 39402);
{
	if(alive _x) then {
		if(((_x getVariable ["side",""]) != "med") && (isNil {_x getVariable "eventVehicle"})) then {
			_displayName = getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
			if !(_x getVariable ["customName",""] isEqualTo "") then {
				_displayName = _x getVariable ["customName",""];
			};
			_picture = getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "picture");

			private _vehicleDetails = ["allVehicles",(typeOf _x)] call OEC_fnc_vehicleConfig;
			if((count _vehicleDetails > 0) && (({alive _x} count crew _x) isEqualTo 0)) then {
				private _price = (_vehicleDetails select 6) * 0.4;
				_control lbAdd _displayName;
				_control lbSetData [(lbSize _control)-1,str(_forEachIndex)];
				_control lbSetPicture [(lbSize _control)-1,_picture];
				_control lbSetValue [(lbSize _control)-1,_price];
				_x setVariable ["chopListIndex", _forEachIndex];
			};
		} else {
			systemChat format["%1 is an event vehicle or medic vehicle and cannot be chopped.",getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
		};
	};
} foreach _nearVehicles;
