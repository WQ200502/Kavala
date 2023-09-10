//  File: fn_copOpener.sqf
//  Author: Insane - www.tdc-clan.eu
//  Modifications: Fusah
//	Description: Opens gates.. duh

{
	switch(typeof _x) do {
		case "Land_BarGate_F":{
			if (_x animationPhase "Door_1_rot" == 1) then {
				_x animate ["Door_1_rot", 0];
			}
			else
			{
				_x animate ["Door_1_rot", 1];
			};
		};
		case "Land_BarGate_01_open_F":{
			if (_x animationPhase "Door_1_rot" == 1) then {
				_x animate ["Door_1_rot", 0];
			}
			else
			{
				_x animate ["Door_1_rot", 1];
			};
		};
		case "Land_ConcreteWall_01_m_gate_F";
		case "Land_ConcreteWall_01_l_gate_F":{
			if (_x animationPhase "Door_1_move" == 1) then {
				_x animate ["Door_1_move", 0];
			}
			else
			{
				_x animate ["Door_1_move", 1];
			};
		};
	};
} forEach (nearestObjects [player, ["Land_BarGate_F","Land_ConcreteWall_01_l_gate_F","Land_ConcreteWall_01_m_gate_F","Land_BarGate_01_open_F"], 20]);