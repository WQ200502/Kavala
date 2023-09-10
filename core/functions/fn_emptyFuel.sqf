/*
      Created by Mokomoko
      Date: 04.08.2014
      Related Forum Post: http://www.altisliferpg.com/topic/4812-tutorial-how-to-increase-the-fuel-usage/
*/

private["_vehicleToFuel","_velocityOfVehicle","_fuelConsumption"];

while {true} do {
	_vehicleToFuel = (vehicle player);
	if(isEngineOn _vehicleToFuel && ((driver _vehicleToFuel) == player) && (_vehicleToFuel != player)) then {
		_velocityOfVehicle = sqrt(((velocity _vehicleToFuel select 0)^2)+((velocity _vehicleToFuel select 1)^2))*3.6;

		_fuelConsumption = _velocityOfVehicle/100000 + 0.0001;
		if(_fuelConsumption > 0.002) then {
			if !(_vehicleToFuel isKindOf "Air") then {
				_fuelConsumption = 0.002;
			} else {
				_fuelConsumption = 0.001;
			};
		};
		_vehicleToFuel setFuel ((fuel _vehicleToFuel)-_fuelConsumption);

		if(fuel _vehicleToFuel < 0.2 && fuel _vehicleToFuel > 0.18) then {
			hint "Your gas tank is empty. Hurry to the next gas station!";
		} else {
			if(fuel _vehicleToFuel < 0.03) then	{
				hint "I hope you can run - because you just ran out of gas!";
			};
		};
	};
	if !(_vehicleToFuel isKindOf "Air") then {
		uiSleep 2;
	} else {
		uiSleep 3;
	};
};