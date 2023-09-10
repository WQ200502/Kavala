//  File: fn_civRestrain.sqf

params [
	["_targetPlayer",objNull,[objNull]]
];

if (player distance _targetPlayer > 4) exitWith {hint "You are too far away."};

if ((currentWeapon player != "") && !(currentWeapon player in oev_fake_weapons) && ((_targetPlayer getVariable["playerSurrender",false]) || (_targetPlayer getVariable["downed",false]))) then {
	if ([false,"ziptie",1] call OEC_fnc_handleInv) then {
		[[], "OEC_fnc_closeMap", _targetPlayer, false] spawn OEC_fnc_MP;
		uisleep 0.1;
		_targetPlayer setVariable["restrained",true,true];
		_targetPlayer setVariable["zipTied",true,true];
		[[player], "OEC_fnc_restrain", _targetPlayer, false] spawn OEC_fnc_MP;
		hint format["%1 restrained.", name _targetPlayer];
		if !(license_civ_vigilante) then {
			if !(side _targetPlayer isEqualTo civilian) then {
				[[getPlayerUID player,name player,"67",player],"OES_fnc_wantedAdd",false,false] spawn OEC_fnc_MP;
			} else {
				[[getPlayerUID player,name player,"9",player],"OES_fnc_wantedAdd",false,false] spawn OEC_fnc_MP;
			};
		} else {
			//For compensation on CLog
			_targetPlayer setVariable["restrainedBy",[player,1],true];
		};
		closeDialog 0;
	} else {
		hint "You have nothing to restrain them with.";
	};
};