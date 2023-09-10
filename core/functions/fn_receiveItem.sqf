//  File: fn_receiveItem.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Receive an item from a player.
private["_unit","_val","_item","_from","_diff"];
_unit = _this select 0;
if(_unit != player) exitWith {};
_val = _this select 1;
_item = _this select 2;
_from = _this select 3;

_diff = [_item,(parseNumber _val),oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;

if(_diff != (parseNumber _val)) then
{
	if(([true,_item,_diff] call OEC_fnc_handleInv)) then
	{
		hint format[localize "STR_MISC_TooMuch_3",_from getVariable["realname",name _from],_val,_diff,((parseNumber _val) - _diff)];
		[[_from,_item,str((parseNumber _val) - _diff),_unit],"OEC_fnc_giveDiff",_from,false] spawn OEC_fnc_MP;
	}
		else
	{
		[[_from,_item,_val,_unit,false],"OEC_fnc_giveDiff",_from,false] spawn OEC_fnc_MP;
	};
}
	else
{
	if(([true,_item,(parseNumber _val)] call OEC_fnc_handleInv)) then
	{
		private["_type"];
		_type = [_item,0] call OEC_fnc_varHandle;
		_type = [_type] call OEC_fnc_varToStr;
		hint format[localize "STR_NOTF_GivenItem",_from getVariable["realname",name _from],(parseNumber _val),_type];
	}
		else
	{
		[[_from,_item,_val,_unit,false],"OEC_fnc_giveDiff",_from,false] spawn OEC_fnc_MP;
	};
};