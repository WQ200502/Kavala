#include "..\..\macro.h"
//  File: fn_loadLoadout.sqf
//	Author: Fusah
//	Modifications: TheCmdrRex, Raykazi
//	Description: loads the loadout of the person who wants it loaded?

private _slot = param [0, -1, [0]];
private _mode = param [1, 0, [0]];
private _loadout = param [2, [], [[]]];
private _newVendorPos = param [3, [], [[]]];
private _invPrice = param [4, 0, [0]];
private _newInv = param [5, [], [[]]];

private _exit = false;
private _weight = 0;
private _cfg = 0;
private _load = 0;

if (_mode isEqualTo 0) then {
	if (scriptAvailable(15)) exitWith {hint "请等待至少15秒，然后再尝试执行此操作！";};
	if (oev_shopPos isEqualTo "") exitWith {hint "这里没有小贩";};
	if (oev_shopType isEqualTo "") exitWith {hint "无效的商店类型";};
	if (__GETC__(oev_restrictions)) exitWith {hint "您受到限制，无法装载货物！";};
	private _vendorPos = call compile format ["%1",oev_shopPos];
	hint "请稍候...";
	closeDialog 0;
	[[[],3,player,oev_shopType,_vendorPos,[],_invPrice, _slot],"OES_fnc_handleLoadouts",false,false] spawn OEC_fnc_MP;
} else {
	if (_loadout isEqualTo []) exitWith {hint "请在卸货前先保存货物！";};
	if (oev_shopType isEqualTo "") exitWith {hint "无效的商店类型";};
	if !(count _loadout == 0) then {
		if !(count (_loadout select 5) == 0) then {
			_cfg = getNumber(configFile >> "CfgVehicles" >> (((_loadout select 5) select 0)) >> "maximumload");
			_load = round(_cfg / 8);
		};
	};

	{
		_invPrice = _invPrice + ([_x select 0,_x select 1,2] call OEC_fnc_invPrice);
	} forEach _newInv;
	private _price = _invPrice + ([_loadout, oev_shopType] call OEC_fnc_obtainPrice);

	{
		_weight = _weight + (([_x select 0] call OEC_fnc_itemWeight) * (_x select 1));
		if ((_weight + oev_carryWeight) > (oev_maxWeightT + _load)) exitWith {hint "您当前缺少此装船的y-inv空间！"; _exit = true;};
	} forEach _newInv;
	if (_exit) exitWith {};

	if (_price <= 0) exitWith {hint "您不能免费加载加载";};
	if (oev_cash < _price && oev_atmcash < _price) exitWith {hint format["你没有足够的钱来穿你现在省下的衣服！价格 : %1",[_price] call OEC_fnc_numberText]};
	private _action = [
		format ["你确定要穿上你的槽#%2装机吗？这将取代你目前所有的齿轮和成本你$%1！",[_price] call OEC_fnc_numberText, (_slot+1)],
		"确认",
		"是",
		"否"
	] call BIS_fnc_guiMessage;
	if !(_action) exitWith {};

	if (oev_action_inUse) exitWith {titleText ["你已经在执行另一个操作了！", "PLAIN DOWN"]};
	oev_action_inUse = true;
	private _title = "装备负荷...";

	disableSerialization;
	5 cutRsc ["life_progress","PLAIN DOWN"];
	private _ui = uiNamespace getVariable "life_progress";
	private _progressBar = _ui displayCtrl 38201;
	private _titleText = _ui displayCtrl 38202;
	_titleText ctrlSetText format["%2 (1%1)...","%",_title];
	_progressBar progressSetPosition 0.01;
	private _cP = 0.01;

	while {true} do {
		uiSleep 0.1;
		_cP = _cP + 0.01;
		_progressBar progressSetPosition _cP;
		_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
		if (_cP >= 1 || !alive player) exitWith {};
		if ((player getVariable["restrained",false])) exitWith {};
		if (oev_interruptedTab) exitWith {};
		if (player distance2D _newVendorPos > 8) exitWith {};
	};

	5 cutText ["","PLAIN DOWN"];
	if (player distance2D _newVendorPos > 8) exitWith {titleText["您需要留在8m以内以进行装载。","PLAIN DOWN"]; oev_action_inUse = false;};
	if (!alive player) exitWith {oev_action_inUse = false;};
	if ((player getVariable["restrained",false])) exitWith {oev_action_inUse = false;};
	if (oev_interruptedTab) exitWith {oev_interruptedTab = false; titleText["Action cancelled","PLAIN DOWN"]; oev_action_inUse = false;};

	oev_action_inUse = false;
	closeDialog 0; // Another dialog close to kick players outta other shops before equipping loadout
	[[[],2,player,oev_shopType,[],[],0,_slot],"OES_fnc_handleLoadouts",false,false] spawn OEC_fnc_MP;
	titleText ["您已成功配备了已保存的加载项！","PLAIN DOWN"];

	if !(oev_cash < _price) then {
		oev_cash = oev_cash - _price;
		oev_cache_cash = oev_cache_cash - _price;
		[0] call OEC_fnc_ClupdatePartial;
	} else {
		oev_atmcash = oev_atmcash - _price;
		oev_cache_atmcash = oev_cache_atmcash - _price;
		[1] call OEC_fnc_ClupdatePartial;
	};
};
