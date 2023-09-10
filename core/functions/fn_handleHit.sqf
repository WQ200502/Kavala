//  File: fn_handleHit.sqf
//	Author: TheCmdrRex
//	Description: Handles client side of the hitman target cause there isn't a better way to do this

params [
	["_issuer",objNull,[objNull]],
	["_bounty",-1,[0]],
	["_bountyTime",-1,[0]]
];

// Make sure we can continue
if (isNull _issuer) exitWith {};
if (_bounty < 200000 || _bounty > 50000000) exitWith {};

// Find Time and Issue hit on serverside
if !(_bountyTime > 0) then {
	titleText [format["%2 has issued a hit on you for $%1!",[_bounty] call OEC_fnc_numberText, name _issuer],"PLAIN DOWN"];
	["hit_placed",1] call OEC_fnc_statArrUp;
	oev_contractTime = (O_stats_playtime_cop + O_stats_playtime_civ) + 720;
	[[1,player,_issuer,_bounty,oev_contractTime],"OES_fnc_setGetHit",false,false] spawn OEC_fnc_MP;
} else {
	oev_contractTime = _bountyTime;
	titleText [format["You still have a hit on you for $%1!",[_bounty] call OEC_fnc_numberText],"PLAIN DOWN"];
};

// Handle hitman timer
[] spawn{
	waitUntil {uiSleep 5; ((player getVariable ["hitmanBounty",0]) > 0)};
	private _time = 0;
	while {true} do {
		_time = O_stats_playtime_cop + O_stats_playtime_civ;
		if (_time >= oev_contractTime) exitWith {
			titleText ["You have survived the length of the contract that was placed on you and you no longer have a bounty on your head!","PLAIN DOWN"];
			[[0,format["%1 has successfully escaped their hitman bounty of $%2.",name player,[(player getVariable ["hitmanBounty",0])] call OEC_fnc_numberText]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
			[[3,player],"OES_fnc_setGetHit",false,false] spawn OEC_fnc_MP;
			[
				["event","Escaped Hitman Contract"],
				["player",name player],
				["player_id",getPlayerUID player],
				["bounty",(player getVariable ["hitmanBounty",0])]
			] call OEC_fnc_logIt;
			oev_contractTime = 0;
		};
		if ((player getVariable ["hitmanBounty",0]) == 0) exitWith {oev_contractTime = 0;};
		uiSleep 60;
	};
};
