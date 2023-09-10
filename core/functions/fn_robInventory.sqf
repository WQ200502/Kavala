//  File: fn_dropItems.sqf
//	Author: Bryan "Tonic" Boardwine
// 	Modified by: Kurt

//	Description: Called on robbery, player drops any 'virtual' items they may be carrying.
private["_var","_robber","_item","_value","_totalItemsActual","_hackedItemArray","_pos","_inventoryBlacklist"];
_robber = _this select 0;
private _inventory = [];

//------------------------------------------------------------------------
//Code for checking of hacked in inventory items....
_totalItemsActual = 0;
{
	_totalItemsActual = _totalItemsActual + (missionNameSpace getVariable _x);
}foreach oev_inv_items;

if(_totalItemsActual > (oev_inventoryMonitor - oev_inventoryRandomVar) || _totalItemsActual >= 150) exitWith {
	_hackedItemArray = [];

	{
		if((missionNameSpace getVariable _x) > 0) then {
			_hackedItemArray pushBack [_x, (missionNameSpace getVariable _x)];
		};
	}foreach oev_inv_items;

	[
		["event", "Hacked Items"],
		["player", name player],
		["player_id", getPlayerUID player],
		["hacked_items", _hackedItemArray],
		["position", getPos player]
	] call OEC_fnc_logIt;
	[[profileName,format["Kicked for hacked items. (Items expected to have = %1) (Actual item count = %2)",(oev_inventoryMonitor - oev_inventoryRandomVar),_totalItemsActual]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};
//------------------------------------------------------------------------

_inventoryBlacklist = ["life_inv_bcremote"];
{
	_item = _x;
	_value = missionNamespace getVariable _item;
	if (_value > 0) then {
		if !(_x in _inventoryBlacklist) then {
			_inventory pushBackUnique [_x,_value];
		};
		missionNamespace setVariable [_x,0];
	};
} forEach oev_inv_items;
oev_inventoryMonitor = oev_inventoryRandomVar;

_pos = [getPos player, 1, 2, 0, 1, 1, 0, [], [player modelToWorld[0,1,0], player modelToWorld[0,1,0]]] call BIS_fnc_findSafePos;
_pos = [_pos select 0, _pos select 1, ((getPosATL player) select 2)];

private _tmp = [];
{
	_var = [(_x select 0),1] call OEC_fnc_varHandle;
	_tmp pushBack [_var,(_x select 1)];
} forEach _inventory;

//Spawn the bag ONLY if they are carrying atleast one item
if ((count _tmp) > 0) then {
	[[_tmp,_pos,"Land_RotorCoversBag_01_F"],"OES_fnc_createItem",false,false] spawn OEC_fnc_MP;
	[
		["event", "Player Robbed"],
		["player", name _robber],
		["player_id", getPlayerUID _robber],
		["target", name player],
		["target_id", getPlayerUID player],
		["items", _inventory],
		["position", getPos player]
	] call OEC_fnc_logIt;
} else {
	[1,format ["The player you are robbing does not have any items on them!"]] remoteExec ["OEC_fnc_broadcast",_robber,false];
};

oev_carryWeight = 0;
[] call OEC_fnc_hudUpdate;
