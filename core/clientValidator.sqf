//	Description: Loops through a list of variables and checks whether
//	or not they are defined, if they are defined then trigger
//	spyglass and kick the client to the lobby.

private["_vars"];
_vars = [
	"oev_revive_fee","oev_gangPrice","oev_enableFatigue","oev_paycheck_period","life_vShop_rentalOnly",
	"oev_weapon_shop_array","life_garage_prices","life_garage_sell","oev_houseLimit","oev_gangUpgradeMultipler","oev_impound_car","oev_impound_boat",
	"oev_impound_air"
];

{
	if(!isNil {(missionNamespace getVariable _x)}) exitWith {
		[[profileName,getPlayerUID player,format["VariableSetBeforeInitialized_%1",_x]],"OEC_fnc_cookieJar",false,false] call OEC_fnc_MP;
		[[profileName,format["客户端初始化前设置的变量: %1",_x]],"OEC_fnc_notifyAdmins",-2,false] call OEC_fnc_MP;
		uiSleep 0.5;
		["SpyGlass",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
	};
} foreach _vars;