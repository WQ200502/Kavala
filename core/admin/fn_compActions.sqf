#include "..\..\macro.h"
// File: fn_compActions
// Author: Jesse "tkcjesse" Schultz
// Description: Gives addActions to the admin who created the crate.

params [
	["_crate",objNull,[objNull]]
];
if (isNull _crate) exitWith {};
if (__GETC__(life_adminlevel) < 3) exitWith {};

hint "There is roughly 20 minutes until the crate despawns.";
oev_action_inUse = false;

_obj_main = player;
_obj_main addAction ["皮卡木箱",{private _obj = cursorObject;if ((typeOf(_obj)) isEqualTo 'IG_supplyCrate_F') then {if (((_obj getVariable ["owner",""]) select 0) isEqualTo (getPlayerUID player)) then {_obj attachTo [player,[0,1.2,1.1]];};};},"",2,false,false,"",'(typeOf cursorObject isEqualTo "IG_supplyCrate_F")'];
_obj_main addAction ["下降箱",{{detach _x;} forEach attachedObjects player;},"",2,false,false,"",''];
_obj_main addAction ["删除动作",{{detach _x;} forEach attachedObjects player;removeAllActions player;oev_adminHasCrate = false;},"",1.5,false,false,"",''];