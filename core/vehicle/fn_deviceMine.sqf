//  File: fn_deviceMine.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Starts automated mining of resource from the tempest device. DESCRIPTIONEND

private["_vehicle","_resourceZones","_zone","_weight","_item","_vInv","_itemIndex","_trunkUpgrade","_mods","_startPos"];
_vehicle = param [0,ObjNull,[ObjNull]];
if(isNull _vehicle) exitWith {}; //Null was passed?
if(!isNil {_vehicle getVariable "mining"}) exitWith {hint localize "STR_NOTF_DeviceIsMining";}; //Mining is already in process..
//if(!isNull (isVehicleCargo _vehicle)) exitWith {};
closeDialog 0; //Close the interaction menu.
oev_action_inUse = true; //Lock out the interaction menu for a bit..
_zone = "";
_resourceZones = [];
_inZoneIndex = -1;

oev_trunk_vehicle = _vehicle;
_mods = oev_trunk_vehicle getVariable["modifications",[0,0,0,0,0,0,0,0]];
_weight = [_vehicle] call OEC_fnc_vehicle1Weight;
_trunkUpgrade = round((_mods select 1) * ((_weight select 0) * 0.05));
_weight set[0,((_weight select 0) + _trunkUpgrade)];
if((_weight select 1) >= (_weight select 0)) exitWith {hint localize "STR_NOTF_DeviceFull"; oev_action_inUse = false;};


{
	for "_i" from 0 to ((count (_x select 1)) - 1) do {
		_resourceZones pushBackUnique ((_x select 1) select _i);
	};
}foreach oev_resourceConfig;

//Find out what zone we're near
{
	if(_vehicle distance2d (getMarkerPos _x) < 300) exitWith {_zone = _x;};
}foreach _resourceZones;

if(_zone == "") exitWith {
	hint localize "STR_NOTF_notNearResource";
	oev_action_inUse = false;
};

{
	if(_zone in (_x select 1)) exitWith {
		_inZoneIndex = _foreachindex;
	};
}foreach oev_resourceConfig;

if(_inZoneIndex == -1) exitWith {};
_selectedZone = (oev_resourceConfig select _inZoneIndex);

if(_vehicle distance (getMarkerPos _zone) > (_selectedZone select 3)) exitWith {
	hint "You're too far away from the resource zone.";
	oev_action_inUse = false;
};

_startPos = getPosATL _vehicle;
_item = (_selectedZone select 0);

if(_item == "") exitWith {hint "Bad Resource?"; oev_action_inUse = false;};
_vehicle setVariable ["mining",true,true]; //Lock the device
[[_vehicle,"tempestDevice"],"OEC_fnc_say3D",-2,false] spawn OEC_fnc_MP;

oev_action_inUse = false; //Unlock it since it's going to do it's own thing...

while {true} do {
	if(!alive _vehicle || isNull _vehicle) exitWith {};
	if(isEngineOn _vehicle || (_vehicle distance _startPos > 5)) exitWith {titleText[localize "STR_NOTF_MiningStopped","PLAIN DOWN"];};
	if(fuel _vehicle == 0) exitWith {titleText[localize "STR_NOTF_OutOfFuel","PLAIN DOWN"];};
	if(!isNull (isVehicleCargo _vehicle)) exitWith {};
	titleText[localize "STR_NOTF_DeviceMining","PLAIN DOWN"];
	_time = time + 27;

	//Wait for 27 seconds with a 'delta-time' wait.
	waitUntil {
		if(isEngineOn _vehicle || (_vehicle distance _startPos > 5)) exitWith {titleText[localize "STR_NOTF_MiningStopped","PLAIN DOWN"]; true};
		if(!isNull (isVehicleCargo _vehicle)) exitWith {true};
		if(round(_time - time) < 1) exitWith {true};
		uiSleep 0.2;
		false
	};

	if(isEngineOn _vehicle || (_vehicle distance _startPos > 5)) exitWith {titleText[localize "STR_NOTF_MiningStopped","PLAIN DOWN"];};
	_vInv = _vehicle getVariable ["Trunk",[[],0]];
	_items = _vInv select 0;
	_space = _vInv select 1;
	_itemIndex = [_item,_items] call OEC_fnc_index;
	_weight = [_vehicle] call OEC_fnc_vehicle1Weight;
	_weight set[0,((_weight select 0) + _trunkUpgrade)];
	_sum = [_item,15,_weight select 1,_weight select 0] call OEC_fnc_calWeightDiff; //Get a sum base of the remaining weight..
	if(_sum < 1) exitWith {titleText[localize "STR_NOTF_DeviceFull","PLAIN DOWN"];};
	_itemWeight = ([_item] call OEC_fnc_itemWeight) * _sum;
	if(_itemIndex == -1) then {
		_items pushBack [_item,_sum];
	} else {
		_val = _items select _itemIndex select 1;
		_items set[_itemIndex,[_item,_val + _sum]];
	};

	if(fuel _vehicle == 0) exitWith {titleText[localize "STR_NOTF_OutOfFuel","PLAIN DOWN"];};

	//Locality checks...
	if(local _vehicle) then {
		_vehicle setFuel (fuel _vehicle)-0.045;
	} else {
		[[_vehicle,(fuel _vehicle)-0.04],"OEC_fnc_setFuel",_vehicle,false] spawn OEC_fnc_MP;
	};

	if(!isNull (isVehicleCargo _vehicle)) exitWith {};
	if(fuel _vehicle == 0) exitWith {titleText[localize "STR_NOTF_OutOfFuel","PLAIN DOWN"];};
	titleText[format[localize "STR_NOTF_DeviceMined",_sum],"PLAIN DOWN"];
	_vehicle setVariable["Trunk",[_items,_space + _itemWeight],true];
	_weight = [_vehicle] call OEC_fnc_vehicle1Weight;
	_weight set[0,((_weight select 0) + _trunkUpgrade)];
	_sum = [_item,15,_weight select 1,_weight select 0] call OEC_fnc_calWeightDiff; //Get a sum base of the remaining weight..
	if(_sum < 1) exitWith {titleText[localize "STR_NOTF_DeviceFull","PLAIN DOWN"];};
	uiSleep 2;
};

_vehicle setVariable["mining",nil,true];