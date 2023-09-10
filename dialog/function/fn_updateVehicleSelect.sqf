disableSerialization;
params ["_display"];
private ["_vList"];

_vList = _display displayCtrl 39502;
lbClear _vList;

{
	if (!isNull _x && alive _x) then {
		private _vehConfig = configFile >> "CfgVehicles" >> (typeOf _x);
		private _name = getText (_vehConfig >> "displayName");
		private _pic = getText (_vehConfig >> "picture");
		_vList lbAdd format ["%1", _name];
		if (_pic != "pictureStaticObject") then {
			_vList lbSetPicture [(lbSize _vList) - 1, _pic];
		};
		_vList lbSetData [(lbSize _vList) - 1, str _forEachIndex];
	};
} forEach oev_vehicles;

if (lbSize _vList <= 0) then {
	_vList lbAdd "您没有任何钥匙。";
	_vList lbSetData [(lbSize _vList) - 1, str objNull];
};

true
