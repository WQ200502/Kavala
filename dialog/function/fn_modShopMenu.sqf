#include "..\..\macro.h"
//  File: fn_modShopMenu
//	Description: mod shop step 1, open this get info then call update mod shop
private["_vehicle","_pid","_copLevel","_medicLevel","_adminLevel","_donatorLevel","_vehData","_className","_vehOwnerStr","_playerUIDStr","_turboModText","_ctrl","_colorArray","_shopType","_temp","_mods","_vehicleInfoBox","_insurance","_color","_trunkSpace","_insuranceLevel","_securitySystems","_upgrade1","_tier","_vehicleColor","_paintFinish","_storageLevel","_turboLevel","_i","_currentSkin","_gangID"];
_vehicle = param [0,ObjNull,[ObjNull]];
if(isNull _vehicle) exitWith {};
if(dialog) exitWith {};
if(player getVariable["buyAndMod",false]) then {
	player setVariable["buyAndMod",false];
};
_mods = _vehicle getVariable["modifications",[0,0,0,0,0,0,0,0]];
_insurance = _vehicle getVariable["insured",0];
_color = _vehicle getVariable["oev_veh_color",[0,0]];
_withMods = _this select 1;
if (_withMods) then {
	player moveInDriver _vehicle;
	player setVariable["buyAndMod",true];
	uiSleep 0.5;
};
if (typeOf vehicle player in ["O_Truck_03_repair_F","O_Truck_03_ammo_F","B_Truck_01_ammo_F","O_LSV_02_armed_F"]) exitWith {hint "You cannot modify this vehicle!";};
if ((typeOf vehicle player in ["B_Heli_Light_01_F","O_Heli_Light_02_unarmed_F","I_Heli_Transport_02_F","B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F","C_Heli_Light_01_civil_F","O_Heli_Transport_04_F","O_Heli_Transport_04_repair_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_medevac_F","B_Heli_Transport_03_unarmed_F","B_Heli_Transport_03_F","B_Heli_Transport_03_unarmed_green_F","O_Heli_Transport_04_fuel_F","I_Heli_light_03_unarmed_F","I_Heli_light_03_dynamicLoadout_F"]) && !(isAutoHoverOn vehicle player) && !(_withMods)) exitWith {hint "To service your helicopter please re-approach with auto-hover on.";};
if (_vehicle isKindOf "Plane" && isTouchingGround _vehicle isEqualTo false) exitWith {hint "Please land the plane before attempting to service it!"};


modshop_old_storage = _mods select 1;
modshop_old_security = _mods select 2;
modshop_old_turbo = _mods select 0;
modshop_old_insurance = _insurance;
modshop_old_paintFinish = _color;

modshop_vehicle = _vehicle;

modshop_storage = _mods select 1;
modshop_security = _mods select 2;
modshop_turbo = _mods select 0;
modshop_insurance = _insurance;
modshop_paintFinish = _color;
modshop_price = 0;
modshop_noupdateskin = 0;

_pid = getPlayerUID player;
_copLevel = __GETC__(life_coplevel);
_medicLevel = __GETC__(life_medicLevel);
_adminLevel = __GETC__(life_adminlevel);
_donatorLevel = __GETC__(oev_donator);



disableSerialization;
_vehData = _vehicle getVariable["vehicle_info_owners",[]];
_gangID = _vehicle getVariable["gangID",0];
if(count _vehData  > 0) then {
	_vehOwnerStr = str((_vehData select 0) select 0);
	_playerUIDStr = str(getplayerUID player);

	if((_playerUIDStr == _vehOwnerStr) || ((_gangID isEqualTo (player getVariable ["gang_data",[0,"",0]] select 0)) && !(_gangID isEqualTo 0))) then {
		if(vehicle player != player) then {
			if(driver (vehicle player) == player) then {
				_vehicle setVelocity [0,0,0];
				_className = typeof _vehicle;
				if(_className in ["B_Heli_Light_01_F","O_Heli_Light_02_unarmed_F","I_Heli_Transport_02_F","B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F","C_Heli_Light_01_civil_F","O_Heli_Transport_04_F","O_Heli_Transport_04_repair_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_medevac_F","B_Heli_Transport_03_unarmed_F","B_Heli_Transport_03_F","B_Heli_Transport_03_unarmed_green_F","O_Heli_Transport_04_fuel_F","I_Heli_light_03_unarmed_F","I_Heli_light_03_dynamicLoadout_F"]) then {
					_vehicle setVectorUp [0,0,1];
				};

				if (_vehicle isKindOf "Plane") then {_vehicle engineOn false};
				_vehicleColor = "";
				_vehicleColors = ["access",_className] call OEC_fnc_vehicleSkins;

				_showUpgradeBtn = false;
				if(_className isEqualTo "C_Plane_Civil_01_racing_F") then {
					if(((_vehicle getVariable ["modifications", [0,0,0,0,0,0,0,0]]) select 3) isEqualTo 1) then {
						_vehicleColors = ["bttArmed",_className] call OEC_fnc_vehicleSkins;
					} else {
						_vehicleColors = ["bttUnarmed",_className] call OEC_fnc_vehicleSkins;
						_showUpgradeBtn = true;
					};
				};
				if(count _vehicleColors > 0) then {
					if !(((modshop_old_paintFinish select 0)) isEqualType "") then {
						{
							if ((_x select 0) isEqualTo (modshop_old_paintFinish select 0)) exitWith {
								_vehicleColor = _x select 1;
							};
						}forEach _vehicleColors;
						if (_vehicleColor isEqualTo "") then {
							_vehicleColor = "Default";
						};
					} else {
						_vehicleColor = "Default";
					};
				} else {
					_vehicleColor = "Default";
				};


				_vehicleInfo = ["allVehicles", _className] call OEC_fnc_vehicleConfig;
				_trunkSpace = (_vehicleInfo select 9);

				_insuranceLevel = "No insurance";
				switch (modshop_old_insurance) do {
					case 0: {_insuranceLevel = "没有保险";};
					case 1: {_insuranceLevel = "基本覆盖";};
					case 2: {_insuranceLevel = "完全覆盖";};
				};
				_securitySystems = "Factory Settings";
				switch (modshop_old_security) do {
					case 0: {_securitySystems = "出厂设置";};
					case 1: {_securitySystems = "汽车防盗器";};
					case 2: {_securitySystems = "总部安全系统";};
					case 3: {_securitySystems = "跟踪安全系统";};
				};
				_paintFinish = "";
				switch (modshop_old_paintFinish select 1) do {
					//case 0: {_paintFinish = "";};
					case 1: {_paintFinish = "光泽";};
					case 2: {_paintFinish = "铬";};
					case 3: {_paintFinish = "黄金";};
					default {_paintFinish = "";};
				};

				_storageLevel = format["%1",round(modshop_old_storage * (_trunkSpace * 0.05))];
				_turboLevel = format["Tier %1",modshop_old_turbo];

				_upgrade1 = "涡轮增压器:";

				if(_className in ["O_SDV_01_F","C_Rubberboat","C_Boat_Civil_01_F","B_Lifeboat","C_Boat_Civil_01_rescue_F","B_Boat_Transport_01_F","C_Boat_Civil_01_police_F","B_SDV_01_F"]) then {
					_upgrade1 = "涡轮增压器:";
				};

				switch(playerSide) do {
					case west: {_shopType = ["cop"];};
					case civilian: {_shopType = ["civ","reb"];};
					case independent: {_shopType = ["med"];};
					default {_shopType = ["civ"];};
				};

				/* disable vehicles from updating their skins /x00 */
				_currentSkin = format["%1 %2", _className, _color select 0];

				if(_currentskin in ["C_Hatchback_01_F 9","C_Hatchback_01_sport_F 7","C_Heli_Light_01_civil_F 14","C_SUV_01_F 4"]) then {
					_shopType = "med"; /* don't need to modify information below with setting civ = med /x00 */
					modshop_noupdateskin = 1;
				} else {
					modshop_noupdateskin = 0;
				};

				["life_mod_shop"] call OEC_fnc_createDialog;
				waitUntil {!isNull (findDisplay 40000)};

				if(_showUpgradeBtn) then {
					_upgradePlane = (findDisplay 40000) ctrlCreate ["Life_RscButtonMenu", 30001];
					_upgradePlane ctrlSetPosition [0.175,0.7,0.3,0.1];
					_upgradePlane ctrlSetText "升级为武装";
					_upgradePlane ctrlSetEventHandler ["ButtonClick","[objectParent player] spawn OEC_fnc_upgradePlane;"];
					_upgradePlane ctrlCommit 0;
				};

				if(_className in ["B_Heli_Light_01_F","O_Heli_Light_02_unarmed_F","I_Heli_Transport_02_F","B_Heli_Transport_01_F","C_Heli_Light_01_civil_F","O_Heli_Transport_04_F","O_Heli_Transport_04_repair_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_medevac_F","B_Heli_Transport_03_unarmed_F","C_Plane_Civil_01_F","C_Plane_Civil_01_racing_F","B_T_VTOL_01_vehicle_F","B_T_VTOL_01_infantry_F","B_Heli_Transport_03_F","B_Heli_Transport_03_unarmed_green_F","B_Heli_Transport_01_camo_F","O_Heli_Transport_04_fuel_F","I_Heli_light_03_unarmed_F","I_Heli_light_03_dynamicLoadout_F"]) then {
					_upgrade1 = "Maneuverability Upgrade";
					_turboModText = (findDisplay 40000) displayCtrl 40010;
					_turboModText ctrlSetText "机动性升级:";
				};

				_ctrl = (findDisplay 40000) displayCtrl 40503;
				_veh_color = ((_vehicle getVariable "oev_veh_color") select 0);
				if !(_veh_color isEqualType "") then {
					_veh_color = "Default";
				};
				lbClear _ctrl;
				_ctrl lbAdd "No Change";
				_ctrl lbSetData [(lbSize _ctrl)-1,_veh_color];
				_colorArray = _vehicleColors;
				_skinNamesArray = []; //This array is used to prevent duplicate skin names from appearing in the shop
				for "_i" from 0 to count(_colorArray)-1 do {
					_temp = (_colorArray select _i) select 1;
					_ind = (_colorArray select _i) select 0;
					_skinNamesArray pushBack _temp;
					_ctrl lbAdd format["%1",_temp];
					_ctrl lbSetData [(lbSize _ctrl)-1,_ind]; //ISSUE HERE
				};

				lbSetCurSel[40503,0];
				if((lbSize _ctrl)-1 != -1) then {
					lbSetCurSel [40503,-1];
					ctrlShow[40503,true];
				} else {
					lbSetCurSel[40503,-1];
					ctrlShow[40503,false];
				};
				_vehicleInfoBox = (findDisplay 40000) displayCtrl 40099;

				_vehicleInfoBox ctrlSetStructuredText parseText format[
				(localize "STR_Shop_Veh_UI_Color")+ " %1" + " %2<br/>
				" +(localize "STR_Shop_Veh_UI_Trunk")+ " %3 + %4<br/>
				" +"保险计划:"+ " %5<br/>
				" +"%8"+ " %6<br/>
				" +"安全系统:"+ " %7<br/>
				",
				_vehicleColor,
				_paintFinish,
				_trunkSpace,
				_storageLevel,
				_insuranceLevel,
				_turboLevel,
				_securitySystems,
				_upgrade1
				];
				[_vehicle] spawn OEC_fnc_modShopUpdate;
			};
		};
	} else {
			private _hasKeys = false;
			private _price = 5000;
			{
				if(_playerUIDStr == str (_x select 0)) then {
					_hasKeys = true;
				};
			} forEach _vehData;
			if(_hasKeys && (driver (vehicle player)) isEqualTo player) then {
				if (oev_cash < _price && oev_atmcash < _price) exitWith {hint format["你没有足够的钱修理这辆车！价格: %1",[_price] call OEC_fnc_numberText]};
				_vehicle setVelocity [0,0,-0.1];
				private _action = [
					format ["用%1元修理这辆车？",[_price] call OEC_fnc_numberText],
					"确认",
					"是",
					"否"
				] call BIS_fnc_guiMessage;
				if !(_action) exitWith {};
				if (oev_action_inUse) exitWith {titleText ["你已经在执行另一个操作了！", "PLAIN DOWN"]};
				oev_action_inUse = true;
				private _title = "修理中....";
				_hasKeys = false;
				private _origPosition = getPos player;
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
					_cP = _cP + 0.05;
					_progressBar progressSetPosition _cP;
					_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
					if (_cP >= 1 || !alive player) exitWith {};
					if ((player getVariable["restrained",false])) exitWith {};
					if (oev_interruptedTab) exitWith {};
					if (player distance _origPosition > 10) exitWith {};
				};
				5 cutText ["","PLAIN DOWN"];
				if (player distance _origPosition > 10) exitWith {titleText["你需要待在10米以内才能修车。","PLAIN DOWN"]; oev_action_inUse = false;};
				if (!alive player) exitWith {oev_action_inUse = false;};
				if ((player getVariable["restrained",false])) exitWith {oev_action_inUse = false;};
				if (oev_interruptedTab) exitWith {oev_interruptedTab = false; titleText["操作已取消","PLAIN DOWN"]; oev_action_inUse = false;};

				oev_action_inUse = false;
				[vehicle player] spawn OEC_fnc_serviceHeli;
				titleText ["你已成功地修理了车辆。","PLAIN DOWN"];
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
	};
};
