class yMenuAdmin : yMenuBase
{
	idd = 41000;

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "Admin Menu";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
		class Tab8PictureBackground: BaseTab8PictureBackground{};
		class Tab9PictureBackground: BaseTab9PictureBackground{};
		class Tab10PictureBackground: BaseTab10PictureBackground{};
		class Tab11PictureBackground: BaseTab11PictureBackground{};
		class Tab12PictureBackground: BaseTab12PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
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
	};


	class controls : controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{
			onButtonClick = "";
		};
		//Content can be added below this line ---------




		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = 41001;
			text = "关闭";
			onButtonClick = "[41000, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};