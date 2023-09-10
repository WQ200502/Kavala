#include "..\..\macro.h"
//	File: fn_toggleSidechat.sqf
//	Description: Toggles player side chat.
params [
	["_mode",-1,[0]]
];
if (_mode == 1) then {life_sidechat = !life_sidechat;} else {life_gangChat = !life_gangChat;};
private _alvl = __GETC__(life_adminlevel);
[[player,life_sidechat,playerSide,_alvl,oev_streamerMode,life_gangChat],"OES_fnc_managesc",false,false] spawn OEC_fnc_MP;