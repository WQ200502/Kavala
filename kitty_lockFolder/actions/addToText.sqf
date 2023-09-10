_num = (_this select 0);

_oldCode = ctrlText 1000;

_code = _oldCode + _num;

ctrlSetText [1000, _code];