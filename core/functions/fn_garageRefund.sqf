//	Description: Server calls this on client, refunds their payment.
//  fn_garageRefund.sqf

_price = _this select 0;
_unit = _this select 1;
if(_unit != player) exitWith {};
oev_atmcash = oev_atmcash + _price;
oev_cache_atmcash = oev_cache_atmcash + _price;

[
  ["event","Garage Retrieval Refund"],
  ["player",name player],
  ["player_id",getPlayerUID player],
  ["value",_price],
  ["position",getPosATL player]
] call OEC_fnc_logIt;
