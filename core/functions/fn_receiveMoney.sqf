//  File: fn_receiveMoney.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Receives money
private["_unit","_val","_from"];
_unit = param [0,Objnull,[Objnull]];
_val = param [1,"",[""]];
_from = param [2,Objnull,[Objnull]];
if(isNull _unit || isNull _from || _val == "") exitWith {};
if(player != _unit) exitWith {};
if(!([_val] call OEC_fnc_isNumeric)) exitWith {};
if(_unit == _from) exitWith {}; //Bad boy, trying to exploit his way to riches.

hint format[localize "STR_NOTF_GivenMoney",_from getVariable["realname",name _from],[(parseNumber (_val))] call OEC_fnc_numberText];
oev_cash = oev_cash + (parseNumber(_val));
oev_cache_cash = oev_cache_cash + (parseNumber(_val));