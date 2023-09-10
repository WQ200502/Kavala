// File: fn_vehicleOwners

private["_data","_return","_format","_thieves"];
_data = _this select 0;
_thieves = _this select 1;
_return = "";

{
	if !((_x select 0) in _thieves) then {
		_format = format["%1<br/>",_x select 1];
		_return = _return + _format;
	};
} foreach _data;

_return;