/*
*/
disableSerialization;
_dialog = findDisplay 31000;
_inv = _dialog displayCtrl 31010;
_near = _dialog displayCtrl 31011;
_weightText = _dialog displayCtrl 31001;
lbClear _inv;
lbClear _near;

_weightText ctrlSetText format["重量: %1 / %2", oev_carryWeight, oev_maxWeight];

{
	_str = [_x] call OEC_fnc_varToStr;
	_shrt = [_x,1] call OEC_fnc_varHandle;
	_icon = [_x] call OEC_fnc_iconConfig;
	_val = missionNameSpace getVariable _x;
	if(_val > 0) then
	{
		_inv lbAdd format["%1x - %2",_val,_str];
		_inv lbSetData [(lbSize _inv)-1,_shrt];
		_inv lbSetPicture [(lbSize _inv)-1,_icon];
	};
} foreach oev_inv_items;


//Near players
_near_units = [];
{if(player distance _x < 20 && { (group player) isEqualTo (group _x) }) then {_near_units pushBack _x};} foreach playableUnits;
private _firstExtraIndex = count _near_units;
private _extraUnits = player getVariable ["life_extraInventoryTargets", []];
_near_units append (player getVariable ["life_extraInventoryTargets", []]);
player setVariable ["life_extraInventoryTargets", []];

{
	if(!isNull _x && alive _x && player distance _x < 20 && _x != player && isNil {_x getVariable "olympusinvis"}) then{
		_near lbAdd format["%1 - %2",_x getVariable["realname",name _x], side _x];
		_near lbSetData [(lbSize _near)-1,str(_x)];
	};
} foreach _near_units;

if (count _extraUnits > 0) then {
	_near lbSetCurSel _firstExtraIndex;
};
