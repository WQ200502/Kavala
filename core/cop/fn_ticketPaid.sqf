//	Author: Bryan "Tonic" Boardwine
//	Description: Verifies that the ticket was paid.
params [
	["_value",5,[0]],
	["_unit",objNull,[objNull]],
	["_cop",objNull,[objNull]],
	["_mode",false,[false]]
];
if (isNull _unit || {_unit != life_ticket_unit}) exitWith {}; //NO
if (isNull _cop || {_cop != player}) exitWith {}; //Double NO

if (playerSide isEqualTo west) then {
	//Cop stat increase
	["tickets_issued_paid",1] spawn OEC_fnc_statArrUp;
	[player,_value,1,150] call OEC_fnc_splitPay;
} else {
	if (playerSide isEqualTo independent) then {
		//medic invoices
		private _payout = _value;
		if (isNull life_buddyObj) then {
			oev_atmcash = oev_atmcash + _payout;
			oev_cache_atmcash = oev_cache_atmcash + _payout;
		} else {
			if (!([life_buddyPID] call OEC_fnc_isUIDActive) || ((life_buddyObj distance player) > 2000)) exitWith {
				life_buddyObj = objNull;
				life_buddyPID = "";
				hint "Buddy no longer exists on the server or is too far away from you. Removing data... You will recieve solo pay for this revive!";
				oev_atmcash = oev_atmcash + _payout;
				oev_cache_atmcash = oev_cache_atmcash + _payout;
			};
			_payout = round(_payout * 0.5);
			oev_atmcash = oev_atmcash + _payout;
			oev_cache_atmcash = oev_cache_atmcash + _payout;
			[[4,_payout, name player],"OEC_fnc_payPlayer",life_buddyObj,false] spawn OEC_fnc_MP;
		};
	} else {
		if (!_mode) then {
			oev_atmcash = oev_atmcash + _value;
			oev_cache_atmcash = oev_cache_atmcash + _value;
		} else {
			oev_cash = oev_cash + _value;
			oev_cache_cash = oev_cache_cash + _value;
		};
	};
};

[1] call OEC_fnc_ClupdatePartial;
