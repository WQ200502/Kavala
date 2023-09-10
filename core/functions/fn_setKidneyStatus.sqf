//  File: fn_removeKidney.sqf
//	Author: Serpico
//	Description: Set the removed kidney status on the player

params [
	["_hostilePlayerName","",[""]]
];
player setVariable ["kidneyRemoved",true,true];
if(playerside isEqualTo civilian) then {
	profileNamespace setVariable ["kidneyRemoved",true];
};
private _dam_obj = player;
_dam_obj setDamage 0.5;

hint format["%1 has removed your kidney. Seek medical care go to a hospital.",_hostilePlayerName];

[] spawn{//kidney timer
	private["_uiDisp"];
	disableSerialization;
	11 cutRsc ["life_kidney_timer","PLAIN DOWN"];
	_uiDisp = uiNamespace getVariable "life_kidney_timer";

	while {true} do {
		if(isNull _uiDisp) then {
			11 cutRsc ["life_kidney_timer","PLAIN DOWN"];
			_uiDisp = uiNamespace getVariable "life_kidney_timer";
		};
		if(!(player getVariable["kidneyRemoved", false])) exitWith {
			if(playerside isEqualTo civilian) then {
				profileNamespace setVariable ["kidneyRemoved",false];
			};
		};
		if (getDammage player < 0.5) then {
			_dam_obj = player;
			_dam_obj setDamage 0.5;
		};
		uiSleep 1.5;
	};
	11 cutText["","PLAIN DOWN"];
};

[] call OEC_fnc_hudUpdate; //Request update of hud.
