#include "..\..\macro.h"
//	File: fn_upgradeProperty.sqf
//  Modifications: Fusah
//	Description: Handles upgrading property.

private["_houseCfg","_action"];
params [
	["_property",objNull,[objNull]],
	["_mode","",[""]],
	["_isVirtual",true,[true]]
];

if(oev_houseTransaction) exitWith {hint "您当前有一个活动事务，请稍候。";};
if(isNull _property || _mode == "") exitWith {};
if(((_property getVariable ["house_owner",["0",""]]) select 0) != getPlayerUID player) exitWith {hint "你没有这个财产。";};

_houseCfg = [(typeOf _property)] call OEC_fnc_houseConfig;
if(count _houseCfg == 0) exitWith {};
closeDialog 0;

switch (_mode) do {
	case "storage": {
		//modify the storage capacity of the property up to it's maximum value of crates * 700
		if (((_houseCfg select 0)*0.15) > oev_atmcash && ((_houseCfg select 0)*0.15) > oev_cash) exitWith {hint "银行资金不足。";};

		if ((_property getVariable ["storageCapacity",10000]) >= ((_houseCfg select 1)*700)) exitWith {};

		_action = [
			format[localize "STR_Property_UpgradeStorageMSG",((_property getVariable ["storageCapacity",100]) + 700),[((_houseCfg select 0)*0.15)] call OEC_fnc_numberText],//message
			"升级属性",//header
			"升级",localize "STR_Global_Cancel"//yes & no buttons
		] call BIS_fnc_guiMessage;

		if (_action) then {
			oev_houseTransaction = true;
			oev_action_inUse = true;

			if(oev_cash >= ((_houseCfg select 0)*0.15)) then {
				oev_cash = oev_cash - ((_houseCfg select 0)*0.15);
				oev_cache_cash = oev_cache_cash - ((_houseCfg select 0)*0.15);
			} else {
				oev_atmcash = oev_atmcash - ((_houseCfg select 0)*0.15);
				oev_cache_atmcash = oev_cache_atmcash - ((_houseCfg select 0)*0.15);
			};

			[6] call OEC_fnc_ClupdatePartial;
			[[_property,player,"storage"],"OES_fnc_updateProperty",false,false] spawn OEC_fnc_MP;
			hint "装修正在进行中。。。";
		};
	};
	case "physicalstorage": {
		//modify the storage capacity of the property up to it's maximum value of crates * 700
		if (200000 > oev_atmcash && 200000 > oev_cash) exitWith {hint "Insufficient bank funds.";};

		if ((_property getVariable ["physicalStorageCapacity",10000]) >= (((_houseCfg select 1)*200) + 100)) exitWith {};

		_action = [
			format[localize "STR_Property_UpgradePhysicalStorageMSG",((_property getVariable ["physicalStorageCapacity",100]) + 200),[200000] call OEC_fnc_numberText],//message
			"升级属性",//header
			"升级",localize "STR_Global_Cancel"//yes & no buttons
		] call BIS_fnc_guiMessage;

		if (_action) then {
			oev_houseTransaction = true;
			oev_action_inUse = true;

			if(oev_cash >= 200000) then {
				oev_cash = oev_cash - 200000;
				oev_cache_cash = oev_cache_cash - 200000;
			} else {
				oev_atmcash = oev_atmcash - 200000;
				oev_cache_atmcash = oev_cache_atmcash - 200000;
			};

			[6] call OEC_fnc_ClupdatePartial;
			[[_property,player,"physicalstorage"],"OES_fnc_updateProperty",false,false] spawn OEC_fnc_MP;
			hint "装修正在进行中。。。";
		};
	};
	case "oil": {
		if (_property getVariable ["oilstorage",false]) exitWith {hint "该地产已具备储油能力。";};
		private _price = if (life_donation_house) then {
			50000 * .85
		} else {
			50000
		};
		if (_price > oev_atmcash && _price > oev_cash) exitWith {hint "银行资金不足。";};

		_action = [
			format["您确定要花费$%1整修该物业以储存石油吗？",_price],
			"升级属性",
			"升级",
			localize "STR_Global_Cancel"
		] call BIS_fnc_guiMessage;

		if(_action) then {
			oev_houseTransaction = true;
			oev_action_inUse = true;

			if(oev_cash >= _price) then {
				oev_cash = oev_cash - _price;
				oev_cache_cash = oev_cache_cash - _price;
			} else {
				oev_atmcash = oev_atmcash - _price;
				oev_cache_atmcash = oev_cache_atmcash - _price;
			};

			[6] call OEC_fnc_ClupdatePartial;
			[[_property,player,"oil"],"OES_fnc_updateProperty",false,false] spawn OEC_fnc_MP;
			hint "装修正在进行中。。。";
		};
	};
};
