//	Author: Poseidon
//	Description: Handles tilde name tag system
private["_target","_maxUnitDistance","_maxLandVehicleDistance","_maxAirVehicleDistance","_maxWaterVehicleDistance","_maxDistance","_lastException","_lastHintTime","_nextCleanup"];
oev_customTilde = !oev_customTilde;
if(!oev_customTilde) exitWith {};
_lastException = "";
_lastHintTime = time;
_nextCleanup = time + 10;

while{true} do {
	sleep 0.25;

	_target = vehicle cursorObject;
	_maxUnitDistance = 100;
	_maxLandVehicleDistance = 225;
	_maxAirVehicleDistance = 450;
	_maxWaterVehicleDistance = 750;
	_maxDistance = 1000;

	try {
		if(!isPlayer _target) then {
			throw "error_notPlayer";
		};

		if(_target == player || _target == vehicle player) then {
			throw "error_isMe";
		};

		if(_target isKindOf "Man" && _target distance player >= _maxUnitDistance) then {
			throw "error_unitTooFar";
		};

		if(_target isKindOf "LandVehicle" && _target distance player >= _maxLandVehicleDistance) then {
			throw "error_landVehicleTooFar";
		};

		if(_target isKindOf "Air" && _target distance player >= _maxAirVehicleDistance) then {
			throw "error_airVehicleTooFar";
		};

		if(_target isKindOf "Ship" && _target distance player >= _maxWaterVehicleDistance) then {
			throw "error_waterVehicleTooFar";
		};

		if(_target distance player >= _maxDistance) then {
			throw "error_otherTooFar";
		};

		_target setVariable ["lastSpottedTime", (time + 4.5)];
		oev_spottedPlayers pushBackUnique _target;
	} catch {

	};

	if(time > _nextCleanup) then {
		_nextCleanup = time + 5;

		{
			if(_x getVariable ["lastSpottedTime",0] < time) then {
				oev_spottedPlayers deleteAt _foreachindex;
			};
		}foreach oev_spottedPlayers;
	};


	if(!oev_customTilde) exitWith {};
};
