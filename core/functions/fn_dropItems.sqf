//  File: fn_dropItems.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Called on death, player drops any 'virtual' items they may be carrying.
private["_obj","_unit","_item","_value","_totalItemsActual","_hackedItemArray","_pos"];
_unit = _this select 0;
private _inventory = [];
private _cash = oev_cash;
oev_cash = 0;
oev_cache_cash = oev_random_cash_val;

//Assemble an array to be passed to the script that creates the item on the ground
private _tmpBrief = [];
//Get the position of the player
if (isNull objectParent player) then {
	_pos = _unit modelToWorld[3,0,0];
} else {
	_pos = _unit modelToWorld[3,-2.5,0];
};
_pos = [_pos select 0, _pos select 1, ((getPosATL _unit) select 2)];

if (playerSide isEqualTo civilian) then {
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

		[["event","Hacked Items"], ["player",name player], ["player_id",getPlayerUID player], ["hackeditems",_hackedItemArray], ["position",getPosATL player]] call OEC_fnc_logIt;
		[profileName,format["Kicked for hacked items. (Items expected to have = %1) (Actual item count = %2)",(oev_inventoryMonitor - oev_inventoryRandomVar),_totalItemsActual]] remoteExec ["OEC_fnc_notifyAdmins",-2];
		["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
	};
	//------------------------------------------------------------------------

	//Populate an array of items the player has by looping through all possible items
	{
		_item = _x;
		_value = missionNamespace getVariable _item;
		if (_value > 0) then {
			_inventory pushBackUnique [_x,_value];
			missionNamespace setVariable [_x,0];
		};
	} forEach oev_inv_items;
	oev_inventoryMonitor = oev_inventoryRandomVar;
	{
		_item = _x select 0;
		_value = _x select 1;
		_var = [_item,1] call OEC_fnc_varHandle;
		_tmpBrief pushBack [_var,_value];
	} forEach _inventory;
};
//Adds cash to the briefcase
if (_cash > 0) then {
	if !((call oev_restrictions) && playerSide isEqualTo civilian) then {
		_tmpBrief pushBack ["money",_cash];
	};
};

//Checks if the player has items and if not then don't spawn a brief
if(count _tmpBrief > 0) then {
	[_tmpBrief,_pos,"Land_Suitcase_F"] remoteExec ["OES_fnc_createItem",2];
};
