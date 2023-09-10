#include "..\..\macro.h"
//  File: fn_weaponShopMenu.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Something

/*
private["_config","_itemInfo","_itemList"];
uiNamespace setVariable ["Weapon_Shop",_this select 3];

disableSerialization;
["life_weapon_shop"] call OEC_fnc_createDialog;

_config = [_this select 3] call OEC_fnc_weaponShopCfg;
if(_config isEqualType "") exitWith {hint _config; closeDialog 0;};

ctrlSetText[38401,_config select 0];

_filters = ((findDisplay 38400) displayCtrl 38402);
lbClear _filters;

_filters lbAdd localize "STR_Shop_Weapon_ShopInv";
_filters lbAdd localize "STR_Shop_Weapon_YourInv";

_filters lbSetCurSel 0;

waitUntil { !dialog };
[false] call OEC_fnc_saveGear;
if(oev_lastSynced_gear != format["%1",life_gear]) then {
	[1] call OEC_fnc_ClupdatePartial;
	[3] call OEC_fnc_ClupdatePartial;
};
*/

// If we lost our firing pin, let's get it back
[player, true] call OEC_fnc_neuterAction;

test_loadWeapons = {
	_configData = param[0,[],[]];

	if(_configData isEqualTo []) exitWith {closeDialog 0;};

	_shop = uiNamespace getVariable ["Weapon_Shop",""];
	// Timed Rebel weapons shop discount
	private _goalDis = 1;
	if (life_donation_active) then {_goalDis = 0.85;};

	if (_shop in ["rebel","war_market"]) then {
		private _territory = "Arms";
		private _flagObj = call compile format["%1_flag",_territory];
		if(isNil "_flagObj" || isNull _flagObj) exitWith {};
		private _flagData = _flagObj getVariable ["capture_data",[]];
		if(count _flagData == 0) exitWith {};
		oev_armsCartel = [false,0,(_flagData select 0)];

		if(count oev_gang_data > 0) then {
			if(((_flagData select 0) == (oev_gang_data select 0)) && ((_flagData select 2) > 0) && !(oev_conquestData select 0)) then {
				_goalDis = _goalDis - 0.15;
				oev_armsCartel = [true,0,(_flagData select 0)];
			};
		};
	};

	if (_shop isEqualTo "war_market") then {
		oev_warpts_count = -999;
		hint "Fetching war points...";
		[[0,0,player],"OES_fnc_warGetSetPts",false,false] spawn OEC_fnc_MP;
		waitUntil {!(oev_warpts_count isEqualTo -999)};
		uiSleep 0.5;
		hint format ["You have %1 war points to spend!",oev_warpts_count];
	};

	_currentRow = 0;
	_shortItems = 0;
	_heightAdjust = 1;

	_display = life_weaponDialogInfo param [0,displayNull,[displayNull]];
	_controlGroup = life_weaponDialogInfo param [1,controlNull,[controlNull]];

	if(isNull _display || isNull _controlGroup) exitWith {hint format["错误：重置ah列表失败/n%1-%2", _display, _controlGroup];};

	_auctionsControlGroup = _display displayCtrl 810005;

	if(!isNull _auctionsControlGroup) then {
		ctrlDelete _auctionsControlGroup;
	};

	_auctionsControlGroup = [_display, "RscControlsGroup", 810005, controlNull, [0.01, 0.08, 0.98, 0.91], [0, 0, 0, 0.4], false, ""] call OEC_fnc_ctrlCreate;
	[_display, "RscText", 810006, _auctionsControlGroup, [0, 0, 0.98, 0.91], [0.3, 0.3, 0.3, 0.4], false, ""] call OEC_fnc_ctrlCreate;
	_focusButton = [_display, "RscButtonMenu",810403, _auctionsControlGroup, [0, 0, 0, 0], [0, 0, 0, 0], true, ""] call OEC_fnc_ctrlCreate;//Need to make a stupid button so we can focus the window
	ctrlSetFocus _focusButton;

	_auctionsControlGroup = _display displayCtrl 810005;
	_auctionsControlBackground = _display displayCtrl 810006;

	{
		//[_entity,_displayName,_picture,_scope,_type,_itemInfo,_cfg,_magazines,_muzzles,_desc,_acc_p,_acc_o,_acc_m,_base,_slotclasses];
		_itemInfo = [_x select 0] call OEC_fnc_fetchCfgDetails;
		if(_foreachindex > 0 && _foreachindex % 2 == 0) then {
			if(_shortItems == 2) then {
				_currentRow = _currentRow + 0.37;
			}else{
				_currentRow = _currentRow + 1;
			};

			_heightAdjust = 1;
			_shortItems = 0;
		};

		private["_className", "_timeLeft"];

		if((count (_x select 3)) == 0) then {
			_shortItems = _shortItems + 1;
			_heightAdjust = 0.37;
		};

		[_display, "RscText", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.01), ((_currentRow * 0.32) + 0.02), 0.47, 0.3 * _heightAdjust], [0, 0, 0, 0.5], true, ""] call OEC_fnc_ctrlCreate;//Box background
		[_display, "RscText", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.02), ((_currentRow * 0.32) + 0.03), 0.20, 0.09], [0.6, 0.6, 0.6, 0.5], true, ""] call OEC_fnc_ctrlCreate;//Box background
		[_display, "RscPictureKeepAspect", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.02), ((_currentRow * 0.32) + 0.03), 0.20, 0.09], [1, 0, 1, 1], true, (_itemInfo select 2)] call OEC_fnc_ctrlCreate;
		[_display, "RscFrame", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.02), ((_currentRow * 0.32) + 0.03), 0.20, 0.09], [0, 0, 0, 0.25], true, ""] call OEC_fnc_ctrlCreate;//Box border
		_buttonControl = [_display, "RscButtonMenu", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.02), ((_currentRow * 0.32) + 0.03), 0.20, 0.09], [0, 0, 0, 0.01], true, ""] call OEC_fnc_ctrlCreate;//Box button
		_buttonControl buttonSetAction format["[] spawn{[true, '%1', (((%2) * (call (life_medDis))) * %3), %3] spawn OEC_fnc_weaponShopBuySell;}",_x select 0, _x select 2, _goalDis];

		_itemName = "";
		if(isNil {(_x select 1)}) then {
			_itemName = (_itemInfo select 1);
		}else{
			_itemName = (_x select 1);
		};


		[_display, "RscStructuredText", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.23), ((_currentRow * 0.32) + 0.03), 0.23, 0.04], [0, 0, 0, 0], true, format["%1",_itemName]] call OEC_fnc_ctrlCreate;
		if !(_shop isEqualTo "war_market") then {
			[_display, "RscStructuredText", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.23), ((_currentRow * 0.32) + 0.07), 0.23, 0.04], [0, 0, 0, 0], true, format["价格: %1元",[(((_x select 2) * __GETC__(life_medDis)) * _goalDis)] call OEC_fnc_numberText]] call OEC_fnc_ctrlCreate;
		} else {
			[_display, "RscStructuredText", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.23), ((_currentRow * 0.32) + 0.07), 0.23, 0.04], [0, 0, 0, 0], true, format["价格: %1战争点",[round((_x select 2) * _goalDis)] call OEC_fnc_numberText]] call OEC_fnc_ctrlCreate;
		};

		for "_magNumber" from 0 to (count (_x select 3)) - 1 do {
			_magInfo = [((_x select 3) select _magNumber) select 0] call OEC_fnc_fetchCfgDetails;

			[_display, "RscText", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.02), ((_currentRow * 0.32) + 0.1175) + ((_magNumber * 0.095) + 0.01), 0.06, 0.09], [0, 0, 0, 0.5], true, ""] call OEC_fnc_ctrlCreate;//Box background
			[_display, "RscText", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.02), ((_currentRow * 0.32) + 0.1175) + ((_magNumber * 0.095) + 0.01), 0.06, 0.09], [0.6, 0.6, 0.6, 0.5], true, ""] call OEC_fnc_ctrlCreate;//Box background
			[_display, "RscPictureKeepAspect", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.02), ((_currentRow * 0.32) + 0.1175) + ((_magNumber * 0.095) + 0.01), 0.06, 0.09], [1, 0, 1, 1], true, _magInfo select 2] call OEC_fnc_ctrlCreate;
			[_display, "RscFrame", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.02), ((_currentRow * 0.32) + 0.1175) + ((_magNumber * 0.095) + 0.01), 0.06, 0.09], [0, 0, 0, 0.25], true, ""] call OEC_fnc_ctrlCreate;//Box border
			_buttonControl = [_display, "RscButtonMenu", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.02), ((_currentRow * 0.32) + 0.1175) + ((_magNumber * 0.095) + 0.01), 0.06, 0.09], [0, 0, 0, 0.01], true, ""] call OEC_fnc_ctrlCreate;//Box button
			_buttonControl buttonSetAction format["[] spawn{[true, '%1', (((%2) * (call (life_medDis))) * %3), %3] spawn OEC_fnc_weaponShopBuySell;}",((_x select 3) select _magNumber) select 0, ((_x select 3) select _magNumber) select 2, _goalDis];

			[_display, "RscStructuredText", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.08), ((_currentRow * 0.32) + 0.1175) + ((_magNumber * 0.095) + 0.01), 0.3, 0.04], [0, 0, 0, 0], true, format["%1",_magInfo select 1]] call OEC_fnc_ctrlCreate;
			if !(_shop isEqualTo "war_market") then {
				[_display, "RscStructuredText", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.08), ((_currentRow * 0.32) + 0.1575) + ((_magNumber * 0.095) + 0.01), 0.3, 0.04], [0, 0, 0, 0], true, format["价格: %1元",[((((_x select 3) select _magNumber) select 2) * __GETC__(life_medDis) * _goalDis)] call OEC_fnc_numberText]] call OEC_fnc_ctrlCreate;
			} else {
				[_display, "RscStructuredText", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.08), ((_currentRow * 0.32) + 0.1575) + ((_magNumber * 0.095) + 0.01), 0.3, 0.04], [0, 0, 0, 0], true, format["价格: %1战争点",[round((((_x select 3) select _magNumber) select 2) * _goalDis)] call OEC_fnc_numberText]] call OEC_fnc_ctrlCreate;
			};
		};

		//[_display, "RscText", -1, _auctionsControlGroup, [0.01, ((_foreachindex * 0.09) + 0.02), 0.2, 0.04], [0, 0, 0, 0.5], true, format["%1",_className]] call OEC_fnc_ctrlCreate;//Item Name
		//[_display, "RscText", -1, _auctionsControlGroup, [0.20, ((_foreachindex * 0.09) + 0.02), 0.15, 0.04], [0, 0, 0, 0.5], true, format["%1 H",_x select 5]] call OEC_fnc_ctrlCreate;//Time Left
		//[_display, "RscText", -1, _auctionsControlGroup, [0.35, ((_foreachindex * 0.09) + 0.02), 0.2, 0.04], [0, 0, 0, 0.5], true, format["%1",_x select 8]] call OEC_fnc_ctrlCreate;//Seller Name
		//[_display, "RscText", -1, _auctionsControlGroup, [0.545, ((_foreachindex * 0.09) + 0.02), 0.15, 0.04], [0, 0, 0, 0.5], true, format["$%1",_x select 3]] call OEC_fnc_ctrlCreate;//Price

		[_display, "RscFrame", -1, _auctionsControlGroup, [(((_foreachindex % 2) * 0.48) + 0.01), ((_currentRow * 0.32) + 0.02), 0.47, 0.3 * _heightAdjust], [0, 0, 0, 0.25], true, ""] call OEC_fnc_ctrlCreate;//Box border



		if(_foreachindex > 0 && _foreachindex % 2 == 0 && _currentRow > 1) then {
			_backgroundSize = ctrlPosition _auctionsControlBackground;

			_backgroundSize set [3, (_backgroundSize select 3) + (0.3 * _heightAdjust)];
			_auctionsControlBackground ctrlSetPosition _backgroundSize;
			_auctionsControlBackground ctrlCommit 0;
		};
	} forEach _configData;
};

private["_config","_itemInfo","_itemList"];
uiNamespace setVariable ["Weapon_Shop",_this select 3];

_config = [_this select 3] call OEC_fnc_weaponShopCfgAltis;
if(_config isEqualType "") exitWith {hint _config; closeDialog 0;};

private["_display","_control","_controlGroup"];
disableSerialization;
["blankDialog"] call OEC_fnc_createDialog;
waitUntil{!isNull (findDisplay 800000)};
_display = findDisplay 800000;
_controlGroup = _display ctrlCreate ["RscControlsGroup", 810001];
//============================ Background And Title ============================
[_display, "RscText", -1, _controlGroup, [0, 0, 1, 1], [0, 0, 0, 0.7], true, ""] call OEC_fnc_ctrlCreate;
[_display, "RscText", -1, _controlGroup, [0.01, 0.02, 0.98, 0.05], [profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843], profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019], profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862], profilenamespace getvariable ['GUI_BCG_RGB_A',0.7]], true, (_config select 0)] call OEC_fnc_ctrlCreate;
_buttonControl = [_display, "RscButton", -1, _controlGroup, [0.8, 0.025, 0.17, 0.04], [0, 0, 0.6, 1], true, "补充弹药"] call OEC_fnc_ctrlCreate;//Box button
_buttonControl buttonSetAction "[] call OEC_fnc_refillMags;";
_shopType = (_this select 3);
if (_shopType == "rebel" || _shopType == "vigilante" || _shopType == "cop_basic" || _shopType == "med_basic") then { //fuckeventuallyaddothercheck
	oev_shopType = _shopType;
	oev_shopPos = format["%1",getPos (_this select 0)];
	_buttonControl1 = [_display, "RscButton", -1, _controlGroup, [0.625, 0.025, 0.17, 0.04], [0, 0, 0.6, 1], true, "加载"] call OEC_fnc_ctrlCreate;//Load button
	_buttonControl2 = [_display, "RscButton", -1, _controlGroup, [0.45, 0.025, 0.17, 0.04], [0, 0, 0.6, 1], true, "保存"] call OEC_fnc_ctrlCreate;//Save Button
	_buttonControl1 buttonSetAction ("['loadoutLoad_dialog'] spawn OEC_fnc_createDialog;");
	_buttonControl2 buttonSetAction ("['loadoutSave_dialog'] spawn OEC_fnc_createDialog;");

	if !(playerSide isEqualTo civilian) then {
		_buttonControl3 = [_display, "RscButton", -1, _controlGroup, [0.275, 0.025, 0.17, 0.04], [0, 0, 0.6, 1], true, "同步"] call OEC_fnc_ctrlCreate;//Sync Loadount
		_buttonControl3 buttonSetAction ("[] call OEC_fnc_syncLoadout;");
	};

};
//============================ END Background And Title ============================


//Set display and control group in a variable so it can be easily accessed by other dialog functions
life_weaponDialogInfo = [_display,_controlGroup];

//============================ Auction Section ============================
//Column Headers

//Box and background
[_display, "RscFrame", -1, _controlGroup, [0.01, 0.08, 0.98, 0.91], [0.3, 0.3, 0.3, 0.4], true, ""] call OEC_fnc_ctrlCreate;

//============================ END Auction Section ============================

//A loop that runs while dialog is open to ensure pop up boxes keep their focus
[_display] spawn{
	disableSerialization;
	_display = param [0,displayNull,[displayNull]];

	while{true} do {
		if(isNull _display) exitWith {};

		sleep 0.01;

		if(!isNull (_display displayCtrl 810005)) then {
			if(isNull (_display displayCtrl 810404)) then {
				ctrlSetFocus (_display displayCtrl 810403);
			}else{
				ctrlSetFocus (_display displayCtrl 810404);
			};
		};
	};
};

sleep 0.1;
[_config select 1] call test_loadWeapons;

waitUntil{isNull (findDisplay 800000)};

if !(alive player) exitWith {};
[false] call OEC_fnc_saveGear;

if(!(oev_conquestData select 0)) then {
	[[2,(oev_armsCartel select 2),player,(oev_armsCartel select 1),0,0,true],"OES_fnc_gangBank",false,false] spawn OEC_fnc_MP;
};

if(oev_lastSynced_gear != format["%1",life_gear]) then {
	[1] call OEC_fnc_ClupdatePartial;
	if !(oev_newsTeam) then {
		[3] call OEC_fnc_ClupdatePartial;
	};
};
