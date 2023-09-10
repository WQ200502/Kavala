//  File: fn_payPlayer.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Modifcations: TheCmdrRex
//	Description: Adds a specific amount to a players bank account

params [
	["_mode",-1,[0]],
	["_payment",0,[0]],
	["_playerName","Unknown Player",[""]],
	["_drugs",false,[false]]
];

if (_mode == -1) exitWith {};
if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPosATL player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

switch (_mode) do {
	// Lottery Winnings
	case 1: {
		oev_atmcash = oev_atmcash + _payment;
		oev_cache_atmcash = oev_cache_atmcash + _payment;
		titleText[format ["$%1 has been added to your bank account for winning the lottery! Press ESC to sync.",[_payment] call OEC_fnc_numberText],"PLAIN DOWN"];
		[
			["event","Received Lottery $"],
			["player",name player],
			["player_id",getPlayerUID player],
			["amount",_payment]
		] call OEC_fnc_logIt;
		[1] call OEC_fnc_ClupdatePartial;
	};
	// Sell or Seize Escort
	case 2: {
		if (playerSide isEqualTo independent) exitWith {};
		oev_atmcash = oev_atmcash + _payment;
		oev_cache_atmcash = oev_cache_atmcash + _payment;
		titleText[format ["$%1 has been added to your bank account for an action performed by %2!",[_payment] call OEC_fnc_numberText,_playerName],"PLAIN DOWN"];
		[
			["event","Received Seize/Sold Pharma $"],
			["player",name player],
			["player_id",getPlayerUID player],
			["sender",_playerName],
			["amount",_payment],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
		[1] call OEC_fnc_ClupdatePartial;
	};
	// Dopamine Crate Purchase
	case 3: {
		if !(playerSide isEqualTo independent) exitWith {};
		oev_atmcash = oev_atmcash + _payment;
		oev_cache_atmcash = oev_cache_atmcash + _payment;
		systemChat format ["%1 has purchased $%2 worth of medical supplies from your dopamine crate.",_playerName,[_payment] call OEC_fnc_numberText];
		[
			["event","Received Dope Crate $"],
			["player",name player],
			["player_id",getPlayerUID player],
			["sender",_playerName],
			["amount",_payment],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
	};
	// Medic Buddy Payment
	case 4: {
		if !(playerSide isEqualTo independent) exitWith {};
		oev_atmcash = oev_atmcash + _payment;
		oev_cache_atmcash = oev_cache_atmcash + _payment;
		titleText[format ["$%1 has been added to your bank account for an action performed by %2!",[_payment] call OEC_fnc_numberText,_playerName],"PLAIN DOWN"];
	};
	// Officer Split Pay
	case 5: {
		if !(playerSide isEqualTo west) exitWith {};
		if (_drugs) then {
			private _perkBonus = 1;
			private _perkTier = ["cop_drugs"] call OEC_fnc_fetchStats;
			_perkBonus = switch (_perkTier) do {
				case 1: {1.02};
				case 2: {1.05};
				case 3: {1.08};
				case 4: {1.10};
				default {1};
			};
			_payment = _payment * _perkBonus;
			["drugs_seized_currency",(_payment / _perkBonus)] call OEC_fnc_statArrUp;
		};
		// Rank money reduction
		private _moneyReduction = 1;
		private _copLevel = player getVariable ["rank",0];
		_moneyReduction = switch (_copLevel) do {
			case 1: {0.4};
			case 2: {0.65};
			case 3: {0.85};
			default {1};
		};
		_payment = _payment * _moneyReduction;
		oev_atmcash = oev_atmcash + _payment;
		oev_cache_atmcash = oev_cache_atmcash + _payment;
		titleText[format ["$%1 has been added to your bank account for an action performed by %2!",[_payment] call OEC_fnc_numberText,_playerName],"PLAIN DOWN"];
		["copmoney",_payment] call OEC_fnc_statArrUp;
		[1] call OEC_fnc_ClupdatePartial;
	};
	// Vigilante Buddy Pay
	case 6: {
		if !(playerSide isEqualTo civilian) exitWith {};
		_payment = switch(true) do {
			case (oev_vigiarrests >= 100): {_payment * 0.75};
			case (oev_vigiarrests >= 50): {_payment * 0.6};
			case (oev_vigiarrests >= 25): {_payment * 0.45};
			default {_payment * 0.3};
		};
		if (_payment > 5000000) then {_payment = 5000000;};
		if (isNull oev_vigiBuddyObj) exitWith {hint "Vigi Buddy Machine Broke. No money for you";};
		oev_atmcash = oev_atmcash + _payment;
		oev_cache_atmcash = oev_cache_atmcash + _payment;
		titleText[format ["$%1 has been added to your bank account for an action performed by %2!",[_payment] call OEC_fnc_numberText,_playerName],"PLAIN DOWN"];
		[
			["event","Received Vigi Buddy $"],
			["player",name player],
			["player_id",getPlayerUID player],
			["buddy",_playerName],
			["amount",_payment],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
		[1] call OEC_fnc_ClupdatePartial;
	};
	// Hitman Contract Pay
	case 7: {
		if !(playerSide isEqualTo civilian) exitWith {};
		if (call oev_restrictions) then {_payment = (_payment / 2);};
		oev_atmcash = oev_atmcash + _payment;
		oev_cache_atmcash = oev_cache_atmcash + _payment;
		titleText[format ["$%1 has been added to your bank account for claiming the bounty on %2!",[_payment] call OEC_fnc_numberText,_playerName],"PLAIN DOWN"];
		[
			["event","Received Hitman $"],
			["player",name player],
			["player_id",getPlayerUID player],
			["target",_playerName],
			["amount",_payment],
			["position",getPosATL player]
		] call OEC_fnc_logIt;
		["hit_claimed",1] call OEC_fnc_statArrUp;
		[1] call OEC_fnc_ClupdatePartial;
	};
	//Ghawk lethal for gunner with driver (reduced by rank in fn_bountyReceive)
	case 8: {
	_payout = 0;
	if(_payment > 200000) then {
		_payout = 200000;
	} else {
		_payout = _payment;
	};
	titleText[format[localize "STR_Cop_BountyKill",[_payout] call OEC_fnc_numberText, [(_payment * 0.75) / 0.25] call OEC_fnc_numberText],"PLAIN DOWN"];
	oev_atmcash = oev_atmcash + _payout;
	oev_cache_atmcash = oev_cache_atmcash + _payout;
	["copmoney",_payout] call OEC_fnc_statArrUp;
	[1] call OEC_fnc_ClupdatePartial;
};
//Ghawk lethal for driver (reduced by rank in fn_bountyReceive)
case 9: {
	if !(playerSide isEqualTo west) exitWith {};
	if(_payment > 200000) then {
		_payment = 200000;
	};
	oev_atmcash = oev_atmcash + _payment;
	oev_cache_atmcash = oev_cache_atmcash + _payment;
	titleText[format ["$%1 has been added to your bank account for an action performed by %2!",[_payment] call OEC_fnc_numberText,_playerName],"PLAIN DOWN"];
	["copmoney",_payment] call OEC_fnc_statArrUp;
	[1] call OEC_fnc_ClupdatePartial;
};
//Regular cop lethal for nearby cops (reduced by rank in fn_bountyReceive)
case 10: {
	if !(playerSide isEqualTo west) exitWith {};
	if(_payment > 50000) then {
		_payment = 50000;
	};
	oev_atmcash = oev_atmcash + _payment;
	oev_cache_atmcash = oev_cache_atmcash + _payment;
	titleText[format ["$%1 has been added to your bank account for an action performed by %2!",[_payment] call OEC_fnc_numberText,_playerName],"PLAIN DOWN"];
	["copmoney",_payment] call OEC_fnc_statArrUp;
	[1] call OEC_fnc_ClupdatePartial;
};
//Regular cop lethal for lethaller
case 11: {
	if !(playerSide isEqualTo west) exitWith {};
	oev_atmcash = oev_atmcash + _payment;
	oev_cache_atmcash = oev_cache_atmcash + _payment;
	["copmoney",_payment] call OEC_fnc_statArrUp;
	[1] call OEC_fnc_ClupdatePartial;
};
//Ghawk lethal for gunner without driver (reduced by rank in fn_bountyReceive)
case 12: {
	_payout = 0;
	if(_payment > 400000) then {
		_payout = 400000;
	} else {
		_payout = _payment;
	};
	titleText[format[localize "STR_Cop_BountyKill",[_payout] call OEC_fnc_numberText, [(_payment * 0.75) / 0.50] call OEC_fnc_numberText],"PLAIN DOWN"];
	oev_atmcash = oev_atmcash + _payment;
	oev_cache_atmcash = oev_cache_atmcash + _payment;
	["copmoney",_payment] call OEC_fnc_statArrUp;
	[1] call OEC_fnc_ClupdatePartial;
};
//Reward players back the cost of the APD escort event.
case 13: {
	hint format["Since you started the escort, your purchase cost of $%1 has been rewarded back to you.",[_payment] call OEC_fnc_numberText];
	oev_atmcash = oev_atmcash + _payment;
	oev_cache_atmcash = oev_cache_atmcash + _payment;
	[1] call OEC_fnc_ClupdatePartial;
};
	default {};
};
