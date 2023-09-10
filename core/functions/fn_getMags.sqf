// File: fn_getMags

private["_magsFormatted","_allMags","_magArray","_val","_index"];
_container = _this;
_magsFormatted = [];

_allMags = [];
{
	if (((_x select 3) isEqualTo 0) || !(_x select 2)) then {
		_allMags pushBack [(_x select 0), (_x select 1)];
	};
}foreach (magazinesAmmoFull (_container));

_allMags sort true;

for "_i" from 0 to ((count _allMags) - 1) do {
	_magArray = (_allMags select _i);
	_val = {_x isEqualTo _magArray} count _allMags;
	_i = (_i + _val) - 1;
	_magArray pushBack _val;
	_index = _magsFormatted find _magArray;

	if(_index == -1) then {
		_magsFormatted pushBack _magArray;
	};
};

_magsFormatted;
