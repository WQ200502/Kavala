#include "..\..\macro.h"
if(scriptAvailable(60)) exitWith {hint "Please wait before questioning the dealer again!";};

_dealer = _this select 0;

_index = switch(_dealer) do {
	case dealer1: {0};
	case dealer2: {1};
	case dealer3: {2};
	case dealer4: {3};
	case dealer5: {4};
};

[0, _index] remoteExec["OES_fnc_handleDrugSellers",2];