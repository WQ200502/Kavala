/*
	Updates the main menu tab when Y menu is first opened
*/
disableSerialization;
_dialog = findDisplay 30000;
_cashValue = _dialog displayCtrl 30001;
_bankValue = _dialog displayCtrl 30002;
_lic = _dialog displayCtrl 30003;
_restartTime = _dialog displayCtrl 30004;

lbClear _lic;

_side = switch(playerSide) do {
	case west:{"cop"};
	case civilian:{"civ"};
	case independent:{"med"};
};


_restartTime ctrlSetText format["%1 分钟，直到重新启动", [] call OEC_fnc_timeUntilRestart];

_cashValue ctrlSetStructuredText parseText format["<t align='center'>%1元</t>",[oev_cash] call OEC_fnc_numberText];
_bankValue ctrlSetStructuredText parseText format["<t align='center'>%1元</t>",[oev_atmcash] call OEC_fnc_numberText];

{
	if((_x select 1) == _side) then{
		_str = [_x select 0] call OEC_fnc_varToStr;
		_val = missionNamespace getVariable (_x select 0);
		if(_val) then{
			_lic lbAdd format["%1",_str];
		};
	};
} foreach oev_licenses;

//setup the give money listbox
private ["_near_units","_near"];
_near_units = [];
_near = (findDisplay 30000) displayCtrl 30007;
{ if(player distance _x < 10 && isNil {_x getVariable "olympusinvis"} && { (group player) isEqualTo (group _x) }) then {_near_units pushBack _x};} foreach playableUnits;

private _firstExtraIndex = count _near_units;
private _extraUnits = player getVariable ["life_extraInventoryTargets", []];
_near_units append _extraUnits;
player setVariable ["life_extraInventoryTargets", []];

{
	if(!isNull _x && alive _x && player distance _x < 10 && _x != player) then
	{
		_near lbAdd format["%1 - %2",_x getVariable["realname",name _x], side _x];
		_near lbSetData [(lbSize _near)-1,str(_x)];
	};
} foreach _near_units;

if (count _extraUnits > 0) then {
	_near lbSetCurSel _firstExtraIndex;
};

//website link
private "_websiteText";
_websiteText = (findDisplay 30000) displayCtrl 30009;
_websiteText ctrlSetStructuredText parseText format["<t colorLink='#0B92D1'><a href='%1'>AMX企鹅群</a></t>", "这个地方自己修改"];

//twitter link
private "_websiteText";
_websiteText = (findDisplay 30000) displayCtrl 30010;
_websiteText ctrlSetStructuredText parseText format["<t colorLink='#0B92D1'><a href='%1'>点击加入！</a></t>", "自己修改"];
