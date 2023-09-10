//  File: fn_revokePlayerLicense.sqf

//	Description: Removes the selected license

params [
	["_selection",0,[0]],
	["_revoker",objNull,[objNull]]
];

_log_event = "";
switch ( _selection ) do {
	case 1 : {
		license_civ_driver = false;
		titleText["Your drivers license has been revoked.","PLAIN DOWN"];
	};
	case 2 : {
		license_civ_gun = false;
		titleText["Your firearms license has been revoked.","PLAIN DOWN"];
	};
	case 3 : {
		license_civ_wpl = false;
		titleText["Your workers protection license has been revoked.","PLAIN DOWN"];
	};
	case 4 : {
		license_civ_vigilante = false;
		player setVariable ["isVigi",false,true];
		[[3,player],"OES_fnc_vigiGetSetArrests",false,false] spawn OEC_fnc_MP;

		_log_event = "Revoked Vigi License";
		titleText["Your vigilante license has been revoked.","PLAIN DOWN"];
	};
	case 5 : {
		[[2,player],"OES_fnc_vigiGetSetArrests",false,false] spawn OEC_fnc_MP;

		_log_event = "Lowered Vigi Tier";
		titleText["Your Vigilante tier has been downgraded.","PLAIN DOWN"];
	};
	default {};
};

if(_log_event != "") then {
	[
		["event",_log_event],
		["player",name player],
		["player_id",getPlayerUID player],
		["by",name _revoker],
		["by_id",getPlayerUID _revoker],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
};
