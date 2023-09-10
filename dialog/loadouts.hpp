class loadoutSave_dialog
{
	idd = 634780;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[1] spawn OEC_fnc_loadoutMenu;";

	class ControlsBackground
	{
		class Mainbackground : Life_RscText
		{
			type = 0;
			idc = -1;
			x = 0.2;
			y = 0.3;
			w = 0.65000003;
			h = 0.22500002;
			colorBackground[] = {0,0,0,0.7};

		};
		class Life_RscTitleBackground : Life_RscText
		{
			type = 0;
			idc = -1;
			x = 0.2;
			y = 0.3;
			w = 0.65;
			h = 0.05;
			colorBackground[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R',0.3843])", "(profileNamespace getVariable ['GUI_BCG_RGB_G',0.7019])", "(profileNamespace getVariable ['GUI_BCG_RGB_B',0.8862])", "(profileNamespace getVariable ['GUI_BCG_RGB_A',0.7])"};

		};

	};
	class Controls
	{
		class saveBtn : Life_RscButtonMenu
		{
			type = 1;
			idc = -1;
			x = 0.55000026;
			y = 0.45;
			w = 0.12500003;
			h = 0.05000004;
			text = "Save";
			colorBackground[] = {0,0,0,0.8};
			colorBackgroundActive[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			onButtonClick = "[lbCurSel 634781] spawn OEC_fnc_saveLoadout";

		};
		class closeBtn : Life_RscButtonMenu
		{
			type = 1;
			idc = -1;
			x = 0.70000015;
			y = 0.45;
			w = 0.12500003;
			h = 0.05000004;
			text = "关闭";
			colorBackground[] = {0,0,0,0.8};
			colorBackgroundActive[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			onButtonClick = "closeDialog 0;";

		};
		class titleText : Life_RscTitle
		{
			type = 0;
			idc = -1;
			x = 0.455;
			y = 0.3;
			w = 0.16;
			h = 0.05050506;
			text = "保存加载项";

		};
		class slText : Life_RscText
		{
			type = 0;
			idc = -1;
			x = 0.255;
			y = 0.37;
			w = 0.375;
			h = 0.05000004;
			text = "选择一个插槽以保存此加载。";

		};
		class lbLoadout : Life_RscListBox
		{
			type = 4;
			idc = 634781;
			x = 0.22878792;
			y = 0.45;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
			};
		};
	};
};
class loadoutLoad_dialog
{
	idd = 634790;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[2] spawn OEC_fnc_loadoutMenu;";

	class ControlsBackground
	{
		class Mainbackground : Life_RscText
		{
			type = 0;
			idc = -1;
			x = 0.2;
			y = 0.3;
			w = 0.65000003;
			h = 0.22500002;
			colorBackground[] = {0,0,0,0.7};

		};
		class Life_RscTitleBackground : Life_RscText
		{
			type = 0;
			idc = -1;
			x = 0.2;
			y = 0.3;
			w = 0.65;
			h = 0.05;
			colorBackground[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R',0.3843])", "(profileNamespace getVariable ['GUI_BCG_RGB_G',0.7019])", "(profileNamespace getVariable ['GUI_BCG_RGB_B',0.8862])", "(profileNamespace getVariable ['GUI_BCG_RGB_A',0.7])"};

		};

	};
	class Controls
	{
		class loadBtn : Life_RscButtonMenu
		{
			type = 1;
			idc = -1;
			x = 0.55000026;
			y = 0.45;
			w = 0.12500003;
			h = 0.05000004;
			text = "Load";
			colorBackground[] = {0,0,0,0.8};
			colorBackgroundActive[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			onButtonClick = "[lbCurSel 634791] spawn OEC_fnc_loadLoadout";

		};
		class closeBtn : Life_RscButtonMenu
		{
			type = 1;
			idc = -1;
			x = 0.70000015;
			y = 0.45;
			w = 0.12500003;
			h = 0.05000004;
			text = "Close";
			colorBackground[] = {0,0,0,0.8};
			colorBackgroundActive[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			onButtonClick = "closeDialog 0;";

		};
		class titleText : Life_RscTitle
		{
			type = 0;
			idc = -1;
			x = 0.455;
			y = 0.3;
			w = 0.16;
			h = 0.05050506;
			text = "加载";

		};
		class llText : Life_RscText
		{
			type = 0;
			idc = -1;
			x = 0.255;
			y = 0.37;
			w = 0.375;
			h = 0.05000004;
			text = "选择一个加载插槽。";

		};
		class lbLoadout : Life_RscListBox
		{
			type = 4;
			idc = 634791;
			x = 0.22878792;
			y = 0.45;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
			};
		};
	};
};
