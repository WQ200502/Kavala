//  File: fn_payHouseTax.sqf
//	Author: Tech
//	Description: Prompts the user to their house tax.

params [
  ["_house",objNull,[objNull]]
];

_houseID = _house getVariable ["house_id",-1];
_daysLeft = _house getVariable ["house_expire",-1];
if(isNull _house || _houseID isEqualTo -1 || _daysLeft isEqualTo -1) exitWith {hint "Invalid house."};

_houseTaxCost = [_house,0] call OEC_fnc_calcHouseTax;
_houseTaxCost = _houseTaxCost*(45-_daysLeft);


_prompt = [
  format["Your house has %1 days until expiration. It will cost you $%2 to bring you up to 45 days.",_daysLeft,[_houseTaxCost] call OEC_fnc_numberText],
  'Confirmation','Yes','No'
] call BIS_fnc_guiMessage;
if !(_prompt) exitWith {hint "House tax payment canceled.";};

if(_houseTaxCost > oev_atmcash) exitWith {hint "Not enough money";};
oev_atmcash = oev_atmcash - _houseTaxCost;
oev_cache_atmcash = oev_cache_atmcash - _houseTaxCost;
[1] call OEC_fnc_ClupdatePartial;
[
  ["event","Paid House Tax"],
  ["player",name player],
  ["player_id",getPlayerUID player],
  ["house_tax",_houseTaxCost],
  ["house_id",_houseID],
  ["position",getPosATL player]
] call OEC_fnc_logIt;

_house setVariable ["house_expire",45,true];
[_houseID,(45-_daysLeft)] remoteExec ["OES_fnc_updateHouseDeed",2];
