#include "..\..\macro.h"
//  File: fn_saveLoadout.sqf
//	Author: Fusah
//	Modifications: TheCmdrRex, Raykazi
//	Description: saves the loadout of the person who wants it saved?

params [
	["_slot",-1,[0]]
];

if(scriptAvailable(15)) exitWith {hint "请等待至少15秒，然后再尝试执行此操作！";};
if (oev_shopType isEqualTo "") exitWith {hint "无效的商店类型";};
if (oev_action_inUse) exitWith {titleText ["你已经在执行另一个操作了！", "PLAIN DOWN"]};
if (__GETC__(oev_restrictions)) exitWith {hint "您受到限制，无法保存装船！";};
private _loadout = getUnitLoadout [player,true];
private _validLoadout = [_loadout, oev_shopType] call OEC_fnc_validateGear;
private _invPrice = 0;
private _playerInv = [];
private _copItems = [1] call OEC_fnc_factionItems;
private _medicItems = [2] call OEC_fnc_factionItems;
private _vigiItems = [3] call OEC_fnc_factionItems;
private _rebItems =  [4] call OEC_fnc_factionItems;

private _shopName = switch (oev_shopType) do {
	case "rebel": {"rebel"};
	case "vigilante": {"vigilante"};
	case "cop_basic": {"police"};
	case "med_basic": {"medic"};
	default {"null"};
};

switch (oev_shopType) do {
	case "rebel": {
		{
			_playerInv pushBack [[_x,1] call OEC_fnc_varHandle,missionNameSpace getVariable _x]; // ["Item name", amount]
		} forEach _rebItems;

		{
			_invPrice = _invPrice + ([_x select 0,_x select 1,2] call OEC_fnc_invPrice);
		} forEach _playerInv;
	};
	case "vigilante": {
		{
			_playerInv pushBack [[_x,1] call OEC_fnc_varHandle,missionNameSpace getVariable _x]; // ["Item name", amount]
		} forEach _vigiItems;

		{
			_invPrice = _invPrice + ([_x select 0,_x select 1,2] call OEC_fnc_invPrice);
		} forEach _playerInv;
	};
	case "cop_basic": {
		{
			_playerInv pushBack [[_x,1] call OEC_fnc_varHandle,missionNameSpace getVariable _x]; // ["Item name", amount]
		} forEach _copItems;

		{
			_invPrice = _invPrice + ([_x select 0,_x select 1,2] call OEC_fnc_invPrice);
		} forEach _playerInv;
	};
	case "med_basic": {
		{
			_playerInv pushBack [[_x,1] call OEC_fnc_varHandle,missionNameSpace getVariable _x]; // ["Item name", amount]
		} forEach _medicItems;

		{
			_invPrice = _invPrice + ([_x select 0,_x select 1,2] call OEC_fnc_invPrice);
		} forEach _playerInv;
	};
};

if !(_validLoadout) exitWith {closeDialog 0; hint format ["请确保您的装船只有来自%1商店的物品！",_shopName]};

closeDialog 0;
private _action = [
		format ["是否确实要将当前的%1加载保存到插槽#%2？这将覆盖当前保存的%1加载。（如果你有）",_shopName, (_slot+1)],
		"确定",
		"是",
		"否"
] call BIS_fnc_guiMessage;
if !(_action) exitWith {};
hint "正在向服务器发送保存请求。。。";
[[_loadout,1,player,oev_shopType,[],_playerInv,_invPrice, _slot],"OES_fnc_handleLoadouts",false,false] spawn OEC_fnc_MP;
