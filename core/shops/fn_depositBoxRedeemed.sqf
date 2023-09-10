//	File: fnDepositBoxRedeemed.sqf
//	Author: Zahzi
//	Description: Update client after redeeming deposit box balance

params [
  ["_status",false,[false]],
	["_amount",0,[0]],
  ["_message","",[""]]
];

if (remoteExecutedOwner != 2) exitWith {};
if (_message == "") exitWith {};

if (_status) then {
  // TODO log before and after cash
  [
    ["event", "Redeemed Deposit Box"],
    ["player_id", getPlayerUID player],
    ["value", [_amount] call OEC_fnc_numberText],
    ["old_bank", [oev_atmcash] call OEC_fnc_numberText],
    ["new_bank", [oev_atmcash + _amount] call OEC_fnc_numberText]
  ] call OEC_fnc_logIt;
  oev_atmcash = oev_atmcash + _amount;
  oev_cache_atmcash = oev_cache_atmcash + _amount;
  titleText[format[_message,[_amount] call OEC_fnc_numberText],"PLAIN"];
  [1] call OEC_fnc_ClupdatePartial; //Sync bank in database
} else {
  titleText[_message,"PLAIN"];
};
