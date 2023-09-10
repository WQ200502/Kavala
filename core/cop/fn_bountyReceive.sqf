//  File: fn_bountyReceive.sqf
//	Author: Bryan "Tonic" Boardwine
// 	Modifications: TheCmdrRex
//	Description: Notifies the player he has received a bounty and gives him the cash.
params [
	["_val",0,[0]],
	["_total",0,[0]],
	["_civ",objNull,[objNull]]
];
private ["_officers","_multiplier","_officerUIDs"];

_tier = 0;
_targetbounty = _total;
_copLethalSplits = [];
_isWz = (getPos player) inPolygon oev_warzonePoly;
_killDist = player distance _civ;
_officerUIDs = [];
// vigi tier and total bounty before buddy system split

_lcl_log = {
	_arr = [
	["event", "Cop Arrest Bounty Split"],
	["player", name player],
	["player_id", getPlayerUID player],
	["target", name (_this select 0)],
	["target_id", getPlayerUID (_this select 0)],
	["bounty", _this select 4],
	["position", getPos player]
	];
	_arr2 = switch (_this select 9) do {
		case "copArrest": {[["officercount",_this select 2], ["officer_ids",_this select 3]]};
		case "vigiArrest": {[["buddy_id",oev_vigiBuddyPID], ["vigi_tier",_this select 5], ["payout",_this select 1]]};
		case "lethal": {[["distance",_this select 6], ["is_wz",_this select 7], ["payouts",_this select 8]]};
	};
	[_arr + _arr2] call OEC_fnc_logIt;
};

if (_val isEqualTo _total) then {
	// Normal Cop Payout for standard arrest
	if (playerSide isEqualTo west) then {
		_officers = {((_x distance player < 100) && (side _x isEqualTo west))} count playableUnits;
		_officerUIDs = [];
		{
			if ((_x distance player < 100) && (side _x isEqualTo west)) then {
				_officerUIDs pushBack (getPlayerUID	(_x));
			};
		} forEach playableUnits;
		_multiplier = switch (_officers) do {
			case 1: {0.22};
			case 2: {0.50};
			default {0.75};
		};
		private _copLevel = player getVariable ["rank",0];
		_deductionVal = switch (_copLevel) do {
			case 1: {0.4};
			case 2: {0.65};
			case 3: {0.85};
			default {1};
		};
		_deductionVal = (_total * _multiplier) * (_deductionVal);
		_val = (_total * _multiplier);
		if (_val > 5000000) then {_val = 5000000;};
		if (_deductionVal > 5000000) then {_deductionVal = 5000000;};
		titleText[format[localize "STR_Cop_BountyRecieve",[_deductionVal] call OEC_fnc_numberText],"PLAIN DOWN"];
		[_civ,_val,_officers,_officerUIDs,_targetbounty,_tier,_killDist,_isWz,_copLethalSplits, "copArrest", "Cop Arrest Bounty Split"] call _lcl_log;

		[player,_val,1,100] call OEC_fnc_splitPay;
	} else { // Vigilante Arrest Payout
		if (isNull oev_vigiBuddyObj) then { // If you got no vigi buddy
			_val = switch (true) do {
				case (oev_vigiarrests >= 100): {_total * 0.75};
				case (oev_vigiarrests >= 50): {_total * 0.6};
				case (oev_vigiarrests >= 25): {_total * 0.45};
				default {_total * 0.3};
			};
		} else {
			if (!([oev_vigiBuddyPID] call OEC_fnc_isUIDActive) || !(oev_vigiBuddyObj getVariable ["isVigi",false])) exitWith {
				oev_vigiBuddyObj = objNull;
				oev_vigiBuddyPID = "";
				hint "Buddy no longer exists on the server or no longer a vigilante. Removing data... You will recieve solo pay for this arrest!";
				_val = switch (true) do { // If you got no vigi buddy
					case (oev_vigiarrests >= 100): {_total * 0.75};
					case (oev_vigiarrests >= 50): {_total * 0.6};
					case (oev_vigiarrests >= 25): {_total * 0.45};
					default {_total * 0.3};
				};
			};
			_total = round(_total * 0.5); // If you got a happy little vigi friend
			_val = switch (true) do {
				case (oev_vigiarrests >= 100): {_total * 0.75};
				case (oev_vigiarrests >= 50): {_total * 0.6};
				case (oev_vigiarrests >= 25): {_total * 0.45};
				default {_total * 0.3};
			};
			[[6,_total, name player],"OEC_fnc_payPlayer",oev_vigiBuddyObj,false] spawn OEC_fnc_MP;
		};

		_tier = switch (true) do {
			case (oev_vigiarrests >= 200): {5};
			case (oev_vigiarrests >= 100): {4};
			case (oev_vigiarrests >= 50): {3};
			case (oev_vigiarrests >= 25): {2};
			default {1};
		};

		if (_val > 5000000) then {_val = 5000000;};
		titleText[format[localize "STR_Cop_BountyRecieve",[_val] call OEC_fnc_numberText],"PLAIN DOWN"];
		[_civ,_val,_officers,_officerUIDs,_targetbounty,_tier,_killDist,_isWz,_copLethalSplits, "vigiArrest", "Vigi Arrest Bounty Split"] call _lcl_log;
		oev_atmcash = oev_atmcash + _val;
		oev_cache_atmcash = oev_cache_atmcash + _val;
	};
} else {
	if(vehicle player == player || count assignedVehicleRole player isEqualTo 2 && {(assignedVehicleRole player select 0) isEqualTo "cargo"}) then {
		//Case of regular lethal or hummingbird/offroad etc. gunner
		//Log total bounty first & Put nearby cops into an array
		_officers = [];
		{
			if((_x distance player < 300) && (side _x isEqualTo west) && !(_x isEqualTo player)) then {
				_officers pushBack _x;
			};
  	} forEach playableUnits;

		_val = _val * 0.50;
		_leftOver = 0;
		_copLevel = player getVariable ["rank",0];
		//cant divide by 0 so exit and pay only the lethaller
		if(count _officers == 0) exitWith {
			_deductionVal = switch (_copLevel) do {
				case 1: {0.4};
				case 2: {0.65};
				case 3: {0.85};
				default {1};
			};
			_payout = _val * _deductionVal;
			if(_payout > 400000) then {
				_payout = 400000;
			};
			[[11,round(_val * _deductionVal),name player],"OEC_fnc_payPlayer",player,false] spawn OEC_fnc_MP;
			titleText[format[localize "STR_Cop_BountyKill",[round(_payout)] call OEC_fnc_numberText],"PLAIN DOWN"];
			_copLethalSplits pushback (compile (format['"player_id":"%1", "rank": %3, "value": %2', getPlayerUID player, round _payout, _copLevel]));
			[_civ,_val,_officers,_officerUIDs,_targetbounty,_tier,_killDist,_isWz,_copLethalSplits, "lethal", "Regular Lethal"] call _lcl_log;
		};

		//pay each cop their payout reduced by rank, which will be set to 50k if its over 50k in fn_payPlayer and the total given to cops will never exceed 400k
		_reportVal = _val;
		if(_val > 400000) then {
			_val = 400000;
		};
		_val = _val * 0.50;
		{
			_copLevel = _x getVariable ["rank",0];
			_deductionVal = switch (_copLevel) do {
				case 1: {0.4};
				case 2: {0.65};
				case 3: {0.85};
				default {1};
			};
			_payout = (_val/(count _officers)) * _deductionVal;
			if(_payout > 50000) then {
				_leftOver = _leftOver + (_payout - 50000);
			};
			[[10,round(_payout),name player],"OEC_fnc_payPlayer",_x,false] spawn OEC_fnc_MP;
			_copLethalSplits pushback (compile (format['"player_id":"%1", "rank": %3, "value": %2',getPlayerUID _x, round _payout, _copLevel]));
		} forEach _officers;

		//pay the lethalling officer the leftover money and their split of the bounty, which will be set to 400k if its over 400k in fn_payPlayer, reduce by rank
		_copLevel = player getVariable ["rank",0];
		_deductionVal = switch (_copLevel) do {
			case 1: {0.4};
			case 2: {0.65};
			case 3: {0.85};
			default {1};
		};
		_payout = (_val + _leftOver) * _deductionVal;
		[[11,round((_val + _leftOver) * _deductionVal),name player],"OEC_fnc_payPlayer",player,false] spawn OEC_fnc_MP;
		titleText[format[localize "STR_Cop_BountyKill",[round(_payout)] call OEC_fnc_numberText, [round(((_reportVal * 2.0) * 0.75) * _deductionVal)] call OEC_fnc_numberText],"PLAIN DOWN"];
		//Log cop lethal payment to all cops
		_copLethalSplits pushback (compile (format['"player_id":"%1", "rank": %3, "value": %2', getPlayerUID player, round _payout, _copLevel]));
		[_civ,_val,_officers,_officerUIDs,_targetbounty,_tier,_killDist,_isWz,_copLethalSplits, "lethal", "Regular Lethal"] call _lcl_log;
	} else {

	//cop is operating a vehicle gunner (ghawk lethal)
	if((vehicle player != player) && ((assignedVehicleRole player select 0) isEqualTo "Turret") || (assignedVehicleRole player select 0) isEqualTo "driver" && {typeOf vehicle player isEqualTo "C_Plane_Civil_01_racing_F"}) then {
		//does the vehicle driver exist? if so give 25% of bounty to gunner and driver, reduce by rank for each and log it
		if((name(driver(vehicle player))) != "Error: No vehicle" && (driver(vehicle player)) != player) then {
			//calculate reduction and pay driver
			private _copLevel = (driver(vehicle player)) getVariable ["rank",0];
			_deductionVal = switch (_copLevel) do {
				case 1: {0.4};
				case 2: {0.65};
				case 3: {0.85};
				default {1};
			};
			_payout = (_val * 0.25) * _deductionVal;
			[[9,round _payout,name player],"OEC_fnc_payPlayer",driver(vehicle player),false] spawn OEC_fnc_MP;
			_copLethalSplits pushback (compile (format['"player_id":"%1", "rank": %3, "value": %2',getPlayerUID (driver(vehicle player)), round _payout,_copLevel]));
			//calculate reduction and pay gunner
 			_copLevel = player getVariable ["rank",0];
			_deductionVal = switch (_copLevel) do {
				case 1: {0.4};
				case 2: {0.65};
				case 3: {0.85};
				default {1};
			};
			[[8,round((_val * 0.25) * _deductionVal),name player],"OEC_fnc_payPlayer",player,false] spawn OEC_fnc_MP;
			_copLethalSplits pushback (compile (format['"player_id":"%1", "rank": %3, "value": %2', getPlayerUID player, round _payout, _copLevel]));
			[_civ,_val,_officers,_officerUIDs,_targetbounty,_tier,_killDist,_isWz,_copLethalSplits, "lethal", "Ghawk Lethal"] call _lcl_log;
		} else {
			//if driver does not exist give 50% of bounty only to gunner, reduce by rank and log it
			private _copLevel = player getVariable ["rank",0];
			_deductionVal = switch (_copLevel) do {
				case 1: {0.4};
				case 2: {0.65};
				case 3: {0.85};
				default {1};
			};
			_payout = (_val * 0.50) * _deductionVal;
			[[12,round _payout,name player],"OEC_fnc_payPlayer",player,false] spawn OEC_fnc_MP;
			_copLethalSplits pushback (compile (format['"player_id":"%1", "rank": %3, "value": %2', getPlayerUID player, round _payout, _copLevel]));
			[_civ,_val,_officers,_officerUIDs,_targetbounty,_tier,_killDist,_isWz,_copLethalSplits, "lethal", "Ghawk Lethal"] call _lcl_log;
			};
		};
	};
};
