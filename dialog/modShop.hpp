class life_mod_shop {
	idd = 40000;
	name = "life_mod_shop";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class RscTitleBackground: Life_RscText {
			idc = -1;
			x = 0.1;
			y = 0.128;
			w = 0.8;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};

		class RscBackground: Life_RscText {
			idc = -1;
			x = 0.1;
			y = 0.172;
			w = 0.8;
			h = 0.684;
			colorBackground[] = {0,0,0,0.7};
		};

		class RscTitleText: Life_RscTitle {
			idc = -1;
			text = "西海岸模组商店";
			x = 0.1;
			y = 0.128;
			w = 0.8;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
		};

		class vehAvailableMods: Life_RscText {
			idc = -1;
			text = "可用模组";
			x = 0.5525;
			y = 0.18;
			w = 0.34;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};
		class vehCurrentSpecs: Life_RscText {
			idc = -1;
			text = "车辆规格";
			x = 0.1075;
			y = 0.18;
			w = 0.4;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};
	};

	class Controls {
		class decreaseInsurance: Life_RscButtonMenu {
			onButtonClick = "if(modshop_insurance > 0) then {modshop_insurance = modshop_insurance - 1; [vehicle player] spawn OEC_fnc_modShopUpdate;}";
			idc = 40101;
			text = "-";
			x = 0.5525;
			y = 0.28;
			w = 0.03;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class increaseInsurance: Life_RscButtonMenu {
			onButtonClick = "if(modshop_insurance < 2) then {modshop_insurance = modshop_insurance + 1; [vehicle player] spawn OEC_fnc_modShopUpdate;}";
			idc = 40102;
			text = "+";
			x = 0.8625;
			y = 0.28;
			w = 0.03;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class modInsurance: Life_RscStructuredText {
			idc = -1;
			text = "保险范围:";
			x = 0.5475;
			y = 0.24;
			w = 0.26;
			h = 0.036;
			colorText[] = {0.95,0.95,0.95,1};
			tooltip = "没有保险，汽车因毁坏而丢失。基本覆盖，汽车和颜色被取代。全覆盖，汽车，铬，和修改更换。";
		};

		class insuranceLevel: Life_RscText {
			idc = 40900;
			text = "";
			x = 0.5825;
			y = 0.28;
			w = 0.28;
			h = 0.04;
			colorBackground[] = {0,0,0,0.4};
		};

		class decreaseTurbo: Life_RscButtonMenu {
			onButtonClick = "if(modshop_turbo > 0) then {modshop_turbo = modshop_turbo - 1; [vehicle player] spawn OEC_fnc_modShopUpdate;}";
			idc = 40201;
			text = "-";
			x = 0.5525;
			y = 0.39;
			w = 0.03;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class increaseTurbo: Life_RscButtonMenu {
			onButtonClick = "if(modshop_turbo < 4) then {modshop_turbo = modshop_turbo + 1; [vehicle player] spawn OEC_fnc_modShopUpdate;}";
			idc = 40202;
			text = "+";
			x = 0.8625;
			y = 0.39;
			w = 0.03;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class modTurbo: Life_RscStructuredText {
			idc = 40010;
			text = "涡轮增压:";
			x = 0.5475;
			y = 0.35;
			w = 0.26;
			h = 0.036;
			colorText[] = {0.95,0.95,0.95,1};
			tooltip = "提高车辆的速度或操纵性。";
		};

		class turboLevel: Life_RscText {
			idc = 40901;
			text = "";
			x = 0.5825;
			y = 0.39;
			w = 0.28;
			h = 0.04;
			colorBackground[] = {0,0,0,0.4};
		};

		class decreaseSecurity: Life_RscButtonMenu {
			onButtonClick = "if(modshop_security > 0) then {modshop_security = modshop_security - 1; [vehicle player] spawn OEC_fnc_modShopUpdate;}";
			idc = 40301;
			text = "-";
			x = 0.5525;
			y = 0.50;
			w = 0.03;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class increaseSecurity: Life_RscButtonMenu {
			onButtonClick = "if(modshop_security < 3) then {modshop_security = modshop_security + 1; [vehicle player] spawn OEC_fnc_modShopUpdate;}";
			idc = 40302;
			text = "+";
			x = 0.8625;
			y = 0.50;
			w = 0.03;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class modSecurity: Life_RscStructuredText {
			idc = -1;
			text = "安全系统:";
			x = 0.5475;
			y = 0.46;
			w = 0.26;
			h = 0.036;
			colorText[] = {0.95,0.95,0.95,1};
			tooltip = "添加警报器和更高质量的门锁。";
		};

		class securityLevel: Life_RscText {
			idc = 40902;
			text = "";
			x = 0.5825;
			y = 0.50;
			w = 0.28;
			h = 0.04;
			colorBackground[] = {0,0,0,0.4};
		};

		class decreaseTrunk: Life_RscButtonMenu {
			onButtonClick = "if(modshop_storage > 0) then {modshop_storage = modshop_storage - 1; [vehicle player] spawn OEC_fnc_modShopUpdate;}";
			idc = 40401;
			text = "-";
			x = 0.5525;
			y = 0.61;
			w = 0.03;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class increaseTrunk: Life_RscButtonMenu {
			onButtonClick = "if(modshop_storage < 4) then {modshop_storage = modshop_storage + 1; [vehicle player] spawn OEC_fnc_modShopUpdate;}";
			idc = 40402;
			text = "+";
			x = 0.8625;
			y = 0.61;
			w = 0.03;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class modTrunk: Life_RscStructuredText {
			idc = -1;
			text = "库存升级:";
			x = 0.5475;
			y = 0.57;
			w = 0.26;
			h = 0.036;
			colorText[] = {0.95,0.95,0.95,1};
			tooltip = "增加后备箱的容量。";
		};

		class trunkLevel: Life_RscText {
			idc = 40903;
			text = "";
			x = 0.5825;
			y = 0.61;
			w = 0.28;
			h = 0.04;
			colorBackground[] = {0,0,0,0.4};
		};

		class decreasePaintMod: Life_RscButtonMenu {
			onButtonClick = "if((modshop_paintFinish select 1) > 0) then {modshop_paintFinish = [modshop_paintFinish select 0, (modshop_paintFinish select 1) - 1]; [vehicle player] spawn OEC_fnc_modShopUpdate;}";
			idc = 40501;
			text = "-";
			x = 0.5525;
			y = 0.72;
			w = 0.03;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class increasePaintMod: Life_RscButtonMenu {
			onButtonClick = "if (call oev_donator >= 100) then {if((modshop_paintFinish select 1) < 3) then {modshop_paintFinish = [modshop_paintFinish select 0, (modshop_paintFinish select 1) + 1]; [vehicle player] spawn OEC_fnc_modShopUpdate;}; } else { if((modshop_paintFinish select 1) < 2) then { modshop_paintFinish = [modshop_paintFinish select 0, (modshop_paintFinish select 1) + 1]; [vehicle player] spawn OEC_fnc_modShopUpdate;};};";
			idc = 40502;
			text = "+";
			x = 0.8625;
			y = 0.72;
			w = 0.03;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class modPaint: Life_RscStructuredText {
			idc = -1;
			text = "油漆颜色和样式:";
			x = 0.5475;
			y = 0.68;
			w = 0.26;
			h = 0.036;
			colorText[] = {0.95,0.95,0.95,1};
			tooltip = "改变油漆的颜色或表面处理";
		};

		class paintLevel: Life_RscText {
			idc = 40904;
			text = "";
			x = 0.5825;
			y = 0.72;
			w = 0.28;
			h = 0.04;
			colorBackground[] = {0,0,0,0.4};
		};

		class ColorList: Life_RscCombo {
			idc = 40503;
			onLBSelChanged = "[vehicle player] spawn OEC_fnc_modShopUpdate;";
			x = 0.5575;
			y = 0.78;
			w = 0.275;
			h = 0.03;
		};

		class vehicleInfomationList: Life_RscStructuredText {
			idc = 40099;
			text = "";
			sizeEx = 0.035;
			x = 0.1075;
			y = 0.22;
			w = 0.46;
			h = 0.564;
		};

		class TotalPrice: Life_RscStructuredText {
			idc = 40001;
			text = "";
			sizeEx = 0.035;
			x = 0.1125;
			y = 0.8;
			w = 0.42;
			h = 0.05;
		};

		class ButtonClose: Life_RscButtonMenu {
			onButtonClick = "closeDialog 0;";
			idc = 40005;
			text = "关闭";
			x = 0.1;
			y = 0.86;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class buttonConfirm: Life_RscButtonMenu {
			onButtonClick = "[vehicle player] spawn OEC_fnc_modShopBuy; closeDialog 0;";
			idc = 40600;
			text = "购买";
			x = 0.7425;
			y = 0.86;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class buttonRepair: Life_RscButtonMenu {
			onButtonClick = "[vehicle player] spawn OEC_fnc_serviceHeli; closeDialog 0;";
			idc = -1;
			text = "仅维修";
			x = ((0.7425) - 0.18);
			y = 0.86;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
	};
};
