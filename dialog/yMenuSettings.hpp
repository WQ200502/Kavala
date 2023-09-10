class yMenuSettings : yMenuBase
{
	idd = 35000;
	onLoad = "[] spawn OEC_fnc_updateSettingsTab;";
	onMouseButtonClick = "params [""_ctrl""]; systemChat format [""%1"", _ctrl];if !(ctrlEnabled((findDisplay 35000)displayCtrl 35060) && _ctrl isEqualTo ((findDisplay 35000)displayCtrl 35600)) then {{_x ctrlEnable true}forEach[((findDisplay 35000)displayCtrl 35060), ((findDisplay 35000)displayCtrl 35061)];}";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "设置菜单";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
		class Tab8PictureBackground: BaseTab8PictureBackground{};
		class Tab9PictureBackground: BaseTab9PictureBackground{};
		class Tab10PictureBackground: BaseTab10PictureBackground{};
		class Tab11PictureBackground: BaseTab11PictureBackground{};
		class Tab12PictureBackground: BaseTab12PictureBackground{};
		class Tab1Picture: BaseTab1Picture{};
		class Tab2Picture: BaseTab2Picture{};
		class Tab3Picture: BaseTab3Picture{};
		class Tab4Picture: BaseTab4Picture{};
		class Tab5Picture: BaseTab5Picture{};
		class Tab6Picture: BaseTab6Picture{};
		class Tab7Picture: BaseTab7Picture{};
		class Tab8Picture: BaseTab8Picture{};
		class Tab9Picture: BaseTab9Picture{};
		class Tab10Picture: BaseTab10Picture{};
		class Tab11Picture: BaseTab11Picture{};
		class Tab12Picture: BaseTab12Picture{};

		class ViewDistanceTitle : RscControlsGroup{
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.68;

			class Controls
			{
				class ViewDistanceTitle : Life_RscText{
				idc = -1;
				colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
					text = "View Distance";

					sizeEx = 0.04;
					x = 0;
					y = (-0.2) + 0.20;
					w = 0.46;
					h = 0.04;
				};

				class PlayerTagsHeader : Life_RscText{
					idc = -1;
					colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
					text = "玩家标签";

					sizeEx = 0.04;
					x = 0;
					y = (-0.2) + 0.4;
					w = 0.30;
					h = 0.04;
				};

				class NPCTagsHeader: PlayerTagsHeader {
					idc = 35040;
					text = "NPC标签";
					y = (-0.2) + 0.45;
				};

				class NPCNamesHeader: PlayerTagsHeader {
					idc = 35041;
					text = "NPC姓名";
					y = (-0.2) + 0.50;
				};

				class SideChatHeader : PlayerTagsHeader{
					idc = -1;
					text = "侧边聊天设置";

					y = (-0.2) + 0.55;
				};

				class RevealNearestHeader : PlayerTagsHeader{
					idc = -1;
					text = "显示最近的对象";

					y = (-0.2) + 0.60;
				};

				class AmbientLifeHeader : PlayerTagsHeader{
					idc = -1;
					text = "环境生活与声音";

					y = (-0.2) + 0.65;
				};

				class HexColorTitle : Life_RscText{
				idc = -1;
				colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
					text = "六边形颜色";

					sizeEx = 0.04;
					x = 0;
					y = (-0.2) + 0.70;
					w = 0.46;
					h = 0.04;
				};

				class HexIconTitle : Life_RscText{
					idc = -1;
					colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
					text = "六边形图标";

					sizeEx = 0.04;
					x = 0;
					y = (-0.2) + 0.95;
					w = 0.46;
					h = 0.04;
				};

				class TerrainDetailTitle : Life_RscText{
					idc = -1;
					colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
					text = "地形/草地详图";

					sizeEx = 0.04;
					x = 0;
					y = (-0.2) + 1.13;
					w = 0.46;
					h = 0.04;
				};

				class DecorDetailTitle : Life_RscText{
					idc = -1;
					colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
					text = "地图装饰设置";

					sizeEx = 0.04;
					x = 0;
					y = (-0.2) + 1.23;
					w = 0.46;
					h = 0.04;
				};

				class ExperimentalHeader : PlayerTagsHeader{
					idc = -1;
					text = "实验优化";

					y = (-0.2) + 1.33;
				};

				class MapAutoLockHeader: PlayerTagsHeader {
					idc = -1;
					text = "地图自动缩放/锁定";
					y = (-0.2) + 1.38;
				};

				class NewPlayerHeader: PlayerTagsHeader {
					idc = -1;
					text = "新玩家提示";
					y = (-0.2) + 1.43;
				};

				class VehicleAnimations: PlayerTagsHeader {
					idc = -1;
					text = "车辆动画";
					y = (-0.2) + 1.48;
				};

				class LotteryNotificationsHeader: PlayerTagsHeader {
					idc = 35022;
					text = "彩票通知";
					y = (-0.2) + 1.53;
				};

				class DisableBettingHeader: PlayerTagsHeader {
					idc = 35028;
					text = "禁用投注";
					y = (-0.2) + 1.58;
				};

				class DisableDeathMsgsHeader: PlayerTagsHeader {
					idc = 35037;
					text = "启用死亡消息";
					y = (-0.2) + 1.63;
				};

				class GangChatSettinsHeader: PlayerTagsHeader {
					idc = 35046;
					text = "帮派通话设置";
					y = (-0.2) + 1.68;
				};

				class SkywriteColorHeader: PlayerTagsHeader { // grar
					idc = 35099;
					text = "天空写色彩";
					y = (-0.2) + 1.73;
				};

				class CopSpawnNewVerHeader: PlayerTagsHeader {
					idc = 35019;
					text = "警察重生 V2";
					y = (-0.2) + 1.58;
				};

				class CopSpawnBldgs: PlayerTagsHeader {
					idc = 35020;
					text = "V2 - 建筑重生";
					y = (-0.2) + 1.63;
				};

				class CopDisableBettingHeader: PlayerTagsHeader {
					idc = 35031;
					text = "禁用下注";
					y = (-0.2) + 1.68;
				};

				class copTogLethal: PlayerTagsHeader {
					idc = 35034;
					text = "禁用滚动选项";
					y = (-0.2) + 1.78;
				};

				class spacer: PlayerTagsHeader {	// creates space at the bottom of the menu so it is not ugly
					idc = 35038;
					y = (-0.2) + 1.83;
				};

				class HexIconsHeader: PlayerTagsHeader {
					idc = 35032;
					text = "自定义十六进制图标";
					y = (-0.2) + 1.07;
					w = 0.21;
					h = 0.04;
				};

				class HexIconMenuButton: Life_RscButton {
					idc = 35033;
					text = "设置十六进制图标";
					onButtonClick = "['yMenuIcons'] spawn OEC_fnc_createDialog;";
					colorText[] = {1, 1, 1, 1.0};
					period = 0;
					y = (-0.2) + 1.01;
					w = 0.21;
					h = 0.04;
				};

				class IconPreviewHex: Life_RscPicture {
					idc = 89675;
					text = "images\icons\hexIcons\groupIcon.paa";
					x = 0.28;
					y = (-0.2) + 0.99;
					w = 0.1045;
					h = 0.1040 * 4/3;
				};

				class IconPreviewIcon: Life_RscPicture {
					idc = 784308;
					text = "";
					x = 0.305;
					y = (-0.2) + 1.025;
					w = 0.0510;
					h = 0.0500 * 4/3;
				};

				//other shit -========================--------------------------------===================================-----------------------------------=--==--=-=

						//View distance settings-------------
				class OnFootText: life_RscText {
					idc = -1;
					text = "步行";

					x = 0;
					y = (-0.2) + 0.25;
					w = 0.1;
					h = 0.04;
				};

				class InLandText: OnFootText {
					idc = -1;
					text = "地面载具";

					y = (-0.2) + 0.30;
				};

				class InAirText: InLandText {
					idc = -1;
					text = "空中载具";

					y = (-0.2) + 0.35;
				};

				class OnFootValue : OnFootText{
					idc = 35001;
					text = "123";

					x = 0.37;
					w = 0.09;
				};

				class InLandValue : OnFootValue{
					idc = 35002;
					text = "123";
					y = (-0.2) + 0.30;
				};

				class InAirValue : InLandValue{
					idc = 35003;
					text = "123";
					y = (-0.2) + 0.35;
				};

				class OnFootSlider : life_RscXSliderH {
					idc = 35004;
					text = "";
					onSliderPosChanged = "[0, _this select 1] call OEC_fnc_settingsOnSliderChange;";
					tooltip = "步行时查看距离";

					x = 0.11;
					y = (-0.2) + 0.25;
					w = 0.25;
					h = 0.04;
				};

				class InLandSlider : OnFootSlider {
					idc = 35005;
					onSliderPosChanged = "[1, _this select 1] call OEC_fnc_settingsOnSliderChange;";
					tooltip = "在地面载具中查看距离";

					y = (-0.2) + 0.30;
				};

				class InAirSlider : InLandSlider {
					idc = 35006;
					onSliderPosChanged = "[2, _this select 1] call OEC_fnc_settingsOnSliderChange;";
					tooltip = "在空中载具中查看距离";

					y = (-0.2) + 0.35;
				};

				//group hex color
				class ColorRText : life_RscText {
					idc = -1;
					text = "红色";

					x = 0;
					y = (-0.2) + 0.75;
					w = 0.1;
					h = 0.04;
				};

				class ColorGText : ColorRText {
					idc = -1;
					text = "绿色";

					y = (-0.2) + 0.80;
				};

				class ColorBText : ColorGText {
					idc = -1;
					text = "蓝色";

					y = (-0.2) + 0.85;
				};

				class ColorAText : ColorBText {
					idc = -1;
					text = "透明";

					y = (-0.2) + 0.90;
				};

				class ColorRValue : ColorRText{
					idc = 9000;
					text = "10";
					y = (-0.2) + 0.75;
					x = 0.37;
					w = 0.09;
				};

				class ColorGValue : ColorRValue{
					idc = 9001;
					text = "10";
					y = (-0.2) + 0.80;
				};

				class ColorBValue : ColorGValue{
					idc = 9002;
					text = "10";
					y = (-0.2) + 0.85;
				};

				class ColorAValue : ColorBValue{
					idc = 9003;
					text = "10";
					y = (-0.2) + 0.90;
				};

				class ColorRSlider : life_RscXSliderH {
					idc = 9004;
					text = "";
					onSliderPosChanged = "[5, _this select 1] call OEC_fnc_settingsOnSliderChange;";
					tooltip = "六边形组的红色值";

					x = 0.11;
					y = (-0.2) + 0.75;
					w = 0.25;
					h = 0.04;
				};

				class ColorGSlider : ColorRSlider {
					idc = 9005;
					onSliderPosChanged = "[6, _this select 1] call OEC_fnc_settingsOnSliderChange;";
					tooltip = "六边形的绿色值";

					y = (-0.2) + 0.80;
				};

				class ColorBSlider : ColorGSlider {
					idc = 9006;
					onSliderPosChanged = "[7, _this select 1] call OEC_fnc_settingsOnSliderChange;";
					tooltip = "六边形的蓝色值";

					y = (-0.2) + 0.85;
				};

				class ColorASlider : ColorBSlider {
					idc = 9007;
					onSliderPosChanged = "[8, _this select 1] call OEC_fnc_settingsOnSliderChange;";
					tooltip = "六边形的不透明度";

					y = (-0.2) + 0.90;
				};

				//End of view distance settings------------------

				class PlayerTagsONOFF : Life_RscActiveText{
					idc = 35007;
					text = "";
					tooltip = "控制玩家头上是否有姓名标签";
					sizeEx = 0.04;

					x = 0.31;
					y = (-0.2) + 0.40;
					w = 0.15;
					h = 0.04;
				};

				class NPCTagsONOFF: PlayerTagsONOFF {
					idc = 35042;
					tooltip = "切换NPC标记";
					onButtonClick = "oev_npcTags = !oev_npcTags; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 0.45;
				};

				class NPCNamesONOFF: PlayerTagsONOFF {
					idc = 35043;
					tooltip = "切换NPC名称";
					onButtonClick = "oev_npcNames = !oev_npcNames; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 0.50;
				};

				class SideChatONOFF : PlayerTagsONOFF{
					idc = 35008;
					tooltip = "切换侧边聊天可见性";
					onButtonClick = "[1] spawn OEC_fnc_toggleSidechat; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 0.55;
				};

				class RevealONOFF : PlayerTagsONOFF{
					tooltip = "自动显示最近的对象，如果禁用，可能会提高性能";
					idc = 35009;
					y = (-0.2) + 0.60;
				};

				class AmbientLifeONOFF : PlayerTagsONOFF{
					idc = 35014;
					tooltip = "切换海龟，蛇，兔子，周围的声音。关闭可以提供一个小的性能提高";
					onButtonClick = "life_ambientLife = !life_ambientLife; enableEnvironment life_ambientLife; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 0.65;
				};

				class TerrainDetailSlider : life_RscXSliderH {
					idc = 35010;
					text = "";
					onSliderPosChanged = "[3, _this select 1] call OEC_fnc_settingsOnSliderChange;";
					tooltip = "草详细信息/密度。没有草能大幅度提高性能";

					x = 0;
					y = (-0.2) + 1.18;
					w = 0.36;
					h = 0.04;
				};

				class TerrainDetailValue : life_RscText{
					idc = 35011;
					text = "25";

					x = 0.37;
					y = (-0.2) + 1.18;
					w = 0.09;
					h = 0.04;
				};

				class DecorDetailSlider : life_RscXSliderH {
					idc = 35012;
					text = "";
					onSliderPosChanged = "[4, _this select 1] call OEC_fnc_settingsOnSliderChange;";
					tooltip = "% 在地图加载时创建的装饰对象。需要重新加入才能显示更改";

					x = 0;
					y = (-0.2) + 1.28;
					w = 0.36;
					h = 0.04;
				};

				class DecorDetailValue : life_RscText{
					idc = 35013;
					text = "15";

					x = 0.37;
					y = (-0.2) + 1.28;
					w = 0.09;
					h = 0.04;
				};

				class HexIconsONOFF : PlayerTagsONOFF{
					idc = 35024;
					tooltip = "在其他玩家上切换自定义组十六进制图标";
					onButtonClick = "life_hexIcons = !life_hexIcons; [] spawn OEC_fnc_updateSettingsTab;";
					x = 0.215;
					y = (-0.2) + 1.07;
				};

				class ExperimentalONOFF : PlayerTagsONOFF{
					idc = 35015;
					tooltip = "切换实验优化，在长时间运行时间后可增加FPS";
					onButtonClick = "oev_monitorVehicles = !oev_monitorVehicles; [] spawn OEC_fnc_updateSettingsTab; [] spawn OEC_fnc_vehicleMonitor;";
					y = (-0.2) + 1.33;
				};

				class MapAutoLockONOFF: PlayerTagsONOFF {
					idc = 35016;
					tooltip = "打开地图时切换自动缩放和跳转到玩家图标";
					onButtonClick = "life_mapZoom = !life_mapZoom; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 1.38;
				};

				class NewPlayerHintsONOFF: PlayerTagsONOFF {
					idc = 35021;
					tooltip = "切换新玩家提示显示";
					onButtonClick = "life_newPlayerHints = !life_newPlayerHints; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 1.43;
				};

				class DeathMessagesONOFF: PlayerTagsONOFF {
					idc = 35036;
					tooltip = "在500次死亡后切换死亡消息";
					onButtonClick = "life_deathMessages = !life_deathMessages; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 1.63;
				};

				class VehicleAnimationsONOFF: PlayerTagsONOFF {
					idc = 35069;
					tooltip = "锁定/解锁时切换车辆动画";
					onButtonClick = "life_vehAnim = !life_vehAnim; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 1.48;
				};

				class LotteryNotificationsONOFF: PlayerTagsONOFF {
					idc = 35023;
					tooltip = "将显示有关彩票的通知";
					onButtonClick = "life_lottery = !life_lottery; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 1.53;
				};

				class CopSpawnNewVerONOFF: PlayerTagsONOFF {
					idc = 35017;
					tooltip = "允许使用新的cop生成系统";
					onButtonClick = "life_copSpawnVer = !life_copSpawnVer; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 1.58;
				};

				class BettingVerONOFF: PlayerTagsONOFF {
					idc = 35029;
					tooltip = "切换是否为您弹出下注";
					onButtonClick = "life_bettingVer = !life_bettingVer; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 1.58;
				};

				class GangChatONOFF : PlayerTagsONOFF{
					idc = 35045;
					tooltip = "切换帮派聊天可见性";
					onButtonClick = "[2] spawn OEC_fnc_toggleSidechat; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 1.68;
				};

				class SkywriteDropMenu: Life_RscCombo{
					idc = 35600;

					x = 0.31;
					y = (-0.2) + 1.73;
          w = 0.125;
        	h = 0.039;
					onMouseButtonUp = "if (ctrlEnabled((findDisplay 35000)displayCtrl 35060)) then {{_x ctrlEnable false}forEach[((findDisplay 35000)displayCtrl 35060), ((findDisplay 35000)displayCtrl 35061)];} else {{_x ctrlEnable true}forEach[((findDisplay 35000)displayCtrl 35060), ((findDisplay 35000)displayCtrl 35061)];}";
				};

				class CopSpawnBldgsONOFF: PlayerTagsONOFF {
					idc = 35018;
					tooltip = "将建筑物生成物添加到动态生成系统中";
					onButtonClick = "life_copSpawnBldgs = !life_copSpawnBldgs; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 1.63;
				};

				class CopBettingVerONOFF: PlayerTagsONOFF {
					idc = 35030;
					tooltip = "切换是否为您弹出下注";
					onButtonClick = "life_bettingVer = !life_bettingVer; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 1.68;
				};
				class copTogLethalONOFF: PlayerTagsONOFF {
					idc = 35035;
					tooltip = "切换致命负载滚轮选项";
					onButtonClick = "life_copTogLethal = !life_copTogLethal; [] spawn OEC_fnc_updateSettingsTab;";
					y = (-0.2) + 1.78;
				};
				class EarplugsSettingsTile: Life_RscText {
					idc = -1;
					text = "耳塞设置";
					colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
					colorText[] = {1, 1, 1, 1.0};
					period = 0;
					y = (-0.2) + 1.78;
					w = 0.46;
					h = 0.04;
				};
				class EarplugsYellowText : life_RscText {
					idc = -1;
					text = "部分";

					x = 0;
					y = (-0.2) + 1.83;
					w = 0.1;
					h = 0.04;
				};
				class EarplugsYellow: life_RscXSliderH {
					idc = 35100;
					text = "";

					onSliderPosChanged = "[9, _this select 1] call OEC_fnc_settingsOnSliderChange;";
					tooltip = "Volume slider for full earplugs.";
					x = 0.11;
					y = (-0.2) + 1.83;
					w = 0.25;
					h = 0.04;
				};
				class EarplugsYellowValue : life_RscText {
					idc = 35104;
					text = "40%";

					x = 0.37;
					y = (-0.2) + 1.83;
					w = 0.1;
					h = 0.04;
				};
				class EarplugsRedText : life_RscText {
					idc = -1;
					text = "完全";

					x = 0;
					y = (-0.2) + 1.88;
					w = 0.1;
					h = 0.04;
				};
				class EarplugsRed: life_RscXSliderH {
					idc = 35101;
					text = "";

					onSliderPosChanged = "[10, _this select 1] call OEC_fnc_settingsOnSliderChange;";
					tooltip = "部分耳塞的音量滑块。";
					x = 0.11;
					y = (-0.2) + 1.88;
					w = 0.25;
					h = 0.04;
				};
				class EarplugsRedValue : life_RscText {
					idc = 35105;
					text = "10%";

					x = 0.37;
					y = (-0.2) + 1.88;
					w = 0.1;
					h = 0.04;
				};
			};
		};
	};


	class controls : controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{
			onButtonClick = "";
		};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};



		class SaveSettings : Life_RscButton {
			idc = 35061;
			text = "保存";
			onButtonClick = "_dialog = findDisplay 35000; _list = _dialog displayCtrl 35600; _sel = lbCurSel _list; _arr = _list lbData _sel; life_skywriteColor = _arr; [] spawn OEC_fnc_saveSettings;";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.88;
			w = 0.46;
			h = 0.05;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = 35060;
			text = "关闭";
			onButtonClick = "[35000, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};
