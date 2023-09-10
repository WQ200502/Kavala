// fn_flipAction.sqf

private["_veh, _newPos"];

_veh = cursorTarget;
if(isNull _veh) exitWith {};
if(_veh isKindOf "Air") exitWith {titleText["This is not a car.","PLAIN DOWN"];};
if({alive _x} count crew _veh > 0) exitWith {titleText["There is someone in the car.","PLAIN DOWN"];};
if(damage _veh > 0.85) exitWith {titleText["This car is too rekt to flip.","PLAIN DOWN"];};
if(surfaceIsWater position _veh && (typeOf cursorObject isEqualTo "I_MRAP_03_F")) exitWith {titleText["It is not possible to unflip a Strider in the water.","PLAIN DOWN"];};

if((playerSide isEqualTo independent) || (_veh getVariable ["isBlackwater",false]) || (_veh getVariable ["isEscort",false])) exitWith {
		titleText["Flipping car. Stand back...","PLAIN DOWN"];

		uiSleep 4;
		_newPos = getPosASL _veh;
		_newPos set [2, (_newPos select 2)+1];
		_veh setVectorUp (surfaceNormal _newPos);
		_veh setPosASL _newPos;
};

_vehData = _veh getVariable["vehicle_info_owners",[]];
if(count _vehData  > 0) then
{
	_keys = false;
	{
		if((getPlayerUID player) == (_x select 0)) exitWith{
			titleText["Flipping car. Stand back...","PLAIN DOWN"];

			uiSleep 4;
			_newPos = getPosASL _veh;
			_newPos set [2, (_newPos select 2)+1];
			_veh setVectorUp (surfaceNormal _newPos);
			_veh setPosASL _newPos;
			_keys = true;
		};
	} forEach _vehData;

	if(!(_keys)) exitWith {
		titleText["You do not have keys to this vehicle.","PLAIN DOWN"];
	};

};