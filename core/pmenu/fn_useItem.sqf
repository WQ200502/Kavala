#include <zmacro.h>
//  File: fn_useItem.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Main function for item effects and functionality through the player menu.
private["_item","_cops","_unit","_marker","_object","_ship_obj","_ship","_nearShips"];
disableSerialization;
if((lbCurSel 31010) isEqualTo -1) exitWith {hint localize "STR_ISTR_SelectItemFirst";};
if (player getVariable ["restrained",false]) exitWith {hint "您不能在受到约束时使用物品。";};
_item = lbData[31010,(lbCurSel 31010)];

switch (true) do {
	case (_item isEqualTo "lethalinjector"): {
		[] spawn OEC_fnc_lethalInjector;
		closeDialog 0;
	};

	//all food and water items
	case (_item in ["water","cupcake","coffee","pepsi","redgull","apple","salema","ornate","mackerel","tuna","mullet","catshark","turtle","turtlesoup","donuts","tbacon","potato","cream","peach","burger","mushroom","lollypop"]): {
		if([false,_item,1] call OEC_fnc_handleInv) then {
			[_item] spawn OEC_fnc_eatOrDrink;
			if (_item isEqualTo "donuts") then {
				["donuts",1] spawn OEC_fnc_statArrUp;
			};
		};
	};

	//all drugs
	case (_item in ["pheroin","painkillers","heroinp","cocainep","crack","mmushroom","mushroomu","moonshine","rum","beer","frogp","acid","marijuana","hash","crystalmeth"]): {
		if (player getVariable["restrained",false]) exitWith { hint "克制，你不能吸毒！"; closeDialog 0; };
		if (oev_drugDelay > time) exitWith {hint "吃这么快的药肯定会害死你。慢下来。"; closeDialog 0;};
		if ([false,_item,1] call OEC_fnc_handleInv) then {
			[_item] spawn OEC_fnc_itemEffects;
			oev_drugDelay = (time + 15);
		};
	};


	case (_item isEqualTo "fuelE"): {
		if(player distance cursorObject > 10) exitWith {};
		if(player getVariable ["restrained",false]) exitWith {};
		if ((life_inv_fuelE > 0) && (typeof cursorObject in ["Land_fs_feed_F","B_Slingload_01_Fuel_F"])) then {
			[] spawn oec_fnc_refillFuelCan;
			closeDialog 0;
		};
	};

	case (_item isEqualTo "boltcutter"): {
		[cursorObject] spawn OEC_fnc_boltcutter;
		closeDialog 0;
	};

	case (_item isEqualTo "fireaxe"): {
		[cursorObject] spawn OEC_fnc_fireaxe;
		closeDialog 0;
	};

	case (_item isEqualTo "epiPen"): {
		if(alive cursorObject) exitWith {};
		if(isNull cursorObject) exitWith {};
		if((cursorObject getVariable["epiSide",sideUnknown]) != side player) exitWith {hint "你不能在其他阵营使用肾上腺素。"};
		if(!(cursorObject isKindOf "man")) exitWith {};
		if(player distance cursorObject > 5) exitWith {hint "你离的太远了。"};
		if(cursorObject getVariable ["Reviving",ObjNull] isEqualTo player) exitWith {hint localize "STR_Medic_AlreadyReviving";};
		if(cursorObject getVariable["epiFailed",false]) exitWith {hint "这名玩家因使用肾上腺素不当而死亡。他们需要适当的医疗照顾。";};

		if(life_inv_epiPen > 0) then {
			[cursorObject] spawn OEC_fnc_epiPen;
			closeDialog 0;
		};
	};

	case (_item isEqualTo "dopeShot"): {
		if (oev_conquestData select 0 && getPos player inPolygon (oev_conquestData select 1 select 1)) exitWith {hint "You cannot use dopamine shots in conquest!";};
		if (isNull cursorObject || !(cursorObject isKindOf "Man")) then {
			if (life_inv_dopeShot > 0) then {
				closeDialog 0;
				if !(player getVariable ["epiActive", false]) exitWith {hint "你的多巴胺水平已经正常了。";};
				if (serverTime < player getVariable ["lastShot", 0]) exitWith {hint format ["你还不能注射多巴胺。请再等待%1秒。", round((player getVariable ["lastShot", 0]) - serverTime)];};
				if (playerSide isEqualTo civilian) then {
					profileNamespace setVariable ["epiActive", false];
				};
				titleText [localize "STR_NOTF_HS_Dopamine", "PLAIN DOWN"];
				player setVariable ["epiActive", false, true];
				//player setVariable ["lastShot", (serverTime + 1800), true]; ignore cooldown
				player setVariable ["epiTime", nil];

				[false,"dopeShot",1] call OEC_fnc_handleInv;
			};
		} else {
			if (isNull cursorObject) exitWith {};
			if (alive cursorObject) exitWith {};
			if !(cursorObject isKindOf "Man") exitWith {};
			if (player distance cursorObject > 5) exitWith {hint "你离得太远了。"};
			if (cursorObject getVariable ["Reviving", objNull] isEqualTo player) exitWith {hint localize "STR_Medic_AlreadyReviving";};
			if !(cursorObject getVariable ["epiFailed", false]) exitWith {hint "这个玩家不需要多巴胺。"};
			if (serverTime < cursorObject getVariable ["lastShot", 0]) exitWith {hint format ["你还不能用多巴胺来打这个玩家。请再等待%1秒。", (cursorObject getVariable ["lastShot", 0]) - serverTime];};

			if (life_inv_dopeShot > 0) then {
				[cursorObject] spawn OEC_fnc_dopeShot;
				closeDialog 0;
			};
		};
	};

	case (_item isEqualTo "blastingcharge"): {
		_object = objNull;
		_nearShips = nearestObjects [player, ["Land_Wreck_Traw2_F","Land_Wreck_Traw_F"], 50];
		if(count _nearShips > 0) then {
			_object = _nearShips select 0;
		};

		if((!isNull _object) && (player distance _object < 50)) then {
            if (!([false,_item,1] call OEC_fnc_handleInv)) exitWith {hint "错误：找不到对象";};
			_ship = _object getVariable "opened";
			_ship_obj = _object;
			if (_ship) then {hint "船已经被另一个玩家打开了！"};
			if (!_ship) then {
				hint "电荷已经被植入！离沉船远点！";
				"GrenadeHand_stone" createVehicle [getPos _ship_obj select 0, getPos _ship_obj select 1, 0];
				"GrenadeHand_stone" createVehicle [getPos _ship_obj select 0, getPos _ship_obj select 1, 0];
				"GrenadeHand_stone" createVehicle [getPos _ship_obj select 0, getPos _ship_obj select 1, 0];
				schiffwoffen = true;
				publicVariableServer "schiffwoffen";
			};
		} else {
			player reveal fed_bank;
			[cursorObject] spawn OEC_fnc_blastingCharge;
		};
	};

	case (_item isEqualTo "takeoverterminal"): {
		_hqSelect = switch (true) do {
			case (getpos player inPolygon oev_kavalaHQPoly): {oev_hqtakeover select 0};
			case (getpos player inPolygon oev_pyrgosHQPoly): {oev_hqtakeover select 1};
			case (getpos player inPolygon oev_athiraHQPoly): {oev_hqtakeover select 2};
			case (getpos player inPolygon oev_airHQPoly): {oev_hqtakeover select 3};
			case (getpos player inPolygon oev_sofiaHQPoly): {oev_hqtakeover select 4};
			case (getpos player inPolygon oev_neochoriHQPoly): {oev_hqtakeover select 5};
			case (getpos player inPolygon oev_bwHQPoly): {oev_hqtakeover select 6};
			default {[false,0]};
		};
		if (jailwall getVariable ["chargeplaced",false] || fed_bank getVariable ["chargeplaced",false] || (nearestObject [[20898.6,19221.7,0.00143909],"Land_Dome_Big_F"]) getVariable ["chargeplaced",false]) exitWith {hint "你不能用一个活跃的联邦事件来启动总部接管！"};
		if (altis_bank getVariable ["chargeplaced",false] || altis_bank_1 getVariable ["chargeplaced",false] || altis_bank_2 getVariable ["chargeplaced",false] && _inHQ isEqualTo "Pyrgos") exitWith {hint "当一家银行活跃时，你不能在皮尔戈斯发起收购！"};
		//if (scriptAvailable(3)) exitWith {hint "Please wait before trying to use again.";};
		if (_hqSelect select 0) exitWith {hint "这里已经有总部接管了！";};
		if ((_hqSelect select 1) != 0 && ((_hqSelect select 1) + 900) >= serverTime) exitWith {hint "最近总部被接管了！";};
		if !(isNull objectParent player) exitWith {hint "你不能把它放在车里！";};
		private _civCount = {side _x isEqualTo civilian && primaryWeapon _x != "" && ((getPos player) distance _x) < 100} count playableUnits;
		if !(_civCount >= 3) exitWith {hint "你需要3个武装平民在你的区域开始接管总部！"};
		if (getpos player inPolygon oev_kavalaHQPoly || getpos player inPolygon oev_athiraHQPoly || getpos player inPolygon oev_neochoriHQPoly || getpos player inPolygon oev_airHQPoly || getpos player inPolygon oev_bwHQPoly || getpos player inPolygon oev_pyrgosHQPoly || getpos player inPolygon oev_sofiaHQPoly) then {
			closeDialog 0;
			[] spawn OEC_fnc_takeoverTerminal;
		} else {
			hint "你需要进入总部才能开始接管！";
		};
	};

	case (_item isEqualTo "gpsjammer"): {
		closeDialog 0;
		[cursorObject] spawn OEC_fnc_gpsJamDevice;
	};

	case (_item isEqualTo "baitcar"): {
		closeDialog 0;
		[cursorObject] spawn OEC_fnc_baitCar;
	};

	case (_item isEqualTo "gpstracker"): {
		closeDialog 0;
		[cursorObject] spawn OEC_fnc_gpsTracker;
	};

	case (_item isEqualTo "egpstracker"): {
		closeDialog 0;
		[cursorObject] spawn OEC_fnc_gpsEnhanced;
	};

	case (_item isEqualTo "defusekit"): {
		closeDialog 0;
		[cursorObject] spawn OEC_fnc_defuseKit;
	};

	case (_item isEqualTo "spikeStrip"): {
		if !(isNull objectParent player) exitWith {hint "你不能从车内展开钉带！";};
		if(!isNull oev_spikestrip) exitWith {hint localize "STR_ISTR_SpikesDeployment"};
		if([false,_item,1] call OEC_fnc_handleInv) then {
			[] spawn OEC_fnc_ClspikeStrip;
		};
	};

	case (_item isEqualTo "fuelF"): {
		if(vehicle player != player) exitWith {hint localize "STR_ISTR_RefuelInVehicle"};
		[] spawn OEC_fnc_jerryRefuel;
		closeDialog 0;
	};

	case (_item isEqualTo "lockpick"): {
		[] spawn OEC_fnc_lockpick;
		closeDialog 0;
	};

	case (_item isEqualTo "heliTowHook"): {
		if(isNull cursorObject) exitWith {hint "必须看着要使用的车辆。"};
		if(player distance cursorObject > 5) exitWith {hint "你离的太远了。"};
		if(!((cursorObject isKindOf "LandVehicle") || (cursorObject isKindOf "Ship"))) exitWith {hint "无效的车辆。";};
		if(locked cursorObject != 0 && (side player isEqualTo civilian)) exitWith {hint "必须解锁车辆以连接挂钩和吊索。"};
		if(([false,_item,1] call OEC_fnc_handleInv)) then {
			[cursorObject] spawn OEC_fnc_heliTowHook;
		};
	};

	case (_item isEqualTo "speedbomb"): {
		[] spawn OEC_fnc_speedBomb;
	};

	case (_item isEqualTo "pickaxe"): {
		[] spawn OEC_fnc_newGather;
	};

	case (_item isEqualTo "excavationtools"): {
		[] spawn OEC_fnc_searchShipWreck;
		closeDialog 0;
	};

	case (_item isEqualTo "fireworks"): {
		if(oev_fireworkCooldown < time) then {
			if(([false,_item,1] call OEC_fnc_handleInv)) then {
				[] spawn OEC_fnc_firework;
			};
		} else {
				if(__GETC__(oev_donator) >= 250) then {
					hint "您每20秒只能使用一次烟花。"
				}else{
					hint "每三分钟只能使用一次烟火。"
				};
		};
	};

	case (_item isEqualTo "bloodbag"):	{
		if(getDammage player isEqualTo 0) exitWith {hint "您已经完全健康了。";};
		if(!alive player) exitwith {hint "这有点晚了...";};
		if(!(isNull objectParent player) && ((driver vehicle player) isEqualTo player)) exitWith {titleText["你开车时不能打血袋。","PLAIN DOWN"];};
		if(oev_bloodBagCooldown > time) exitWith {hint format["在%1秒内不能再开始输血。",round(oev_bloodBagCooldown - time)];};
		if(([false,_item,1] call OEC_fnc_handleInv)) then {
			[] spawn OEC_fnc_bloodBag;
		};
	};

	case (_item isEqualTo "panicButton"): {
		if (playerSide != independent ) exitWith {hint "只能由医务人员使用。";};
		_lastPanic = player getVariable ["lastPanic",(serverTime - 300)];
		if ((serverTime - _lastPanic) < 300) then {
			hint "你的紧急按钮正在充电。";
		} else {
			[[ObjNull,format["%我已经启动了紧急按钮。医务人员需要紧急援助。",profileName],player,9],"OES_fnc_handleMessages",false] spawn OEC_fnc_MP;
			hint "紧急按钮启动";
			player setVariable["lastPanic",serverTime,true];
			closeDialog 0;
		};
	};

	case (_item isEqualTo "wplPanicButton"): {
		if (!license_civ_wpl) exitWith {hint "这只能由工人保护许可证持有人使用。";};
		_lastPanic = player getVariable ["lastPanic",(serverTime - 300)];
		if ((serverTime - _lastPanic) < 300) then {
			hint "你的紧急按钮正在充电。";
		} else {
			[[ObjNull,format["%1已经启动了紧急按钮。",profileName],player,9],"OES_fnc_handleMessages",false] spawn OEC_fnc_MP;
			hint "紧急按钮启动";
			player setVariable["lastPanic",serverTime,true];
			closeDialog 0;
		};
	};

	case (_item isEqualTo "roadKit"): {
	if (playerSide != independent) exitWith {hint "只能由医务人员使用。";};
		closeDialog 0;
		//dostuff
		["life_medic_roadKit"] call OEC_fnc_createDialog;
	};

	case (_item isEqualTo "vehAmmo"): {
		[] spawn OEC_fnc_vehicleAmmo;
		closeDialog 0;
	};

	case (_item isEqualTo "bcremote"): {
		[] spawn OEC_fnc_baitCarRemote;
		closeDialog 0;
	};

	case (_item isEqualTo "gokart"): {
		[0] spawn OEC_fnc_pocketGoKart;
		closeDialog 0;
	};

	default{hint localize "STR_ISTR_NotUsable";};
};

[] call OEC_fnc_hudUpdate;
[] call OEC_fnc_updateInventoryTab;
