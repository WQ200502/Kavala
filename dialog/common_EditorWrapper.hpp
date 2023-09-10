//	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: ///
/// Base Classes Wrapped to Altis Life
//	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: //	Description: ///
class RscText : Life_RscText{
	fade = 0;
};

class RscStructuredText : Life_RscStructuredText{
	fade = 0;
};

class RscPicture : Life_RscPicture{
	fade = 0;
};

class RscEdit : Life_RscEdit{
	fade = 0;
};

class RscCombo : Life_RscCombo{
	fade = 0;
};

class RscListBox : Life_RscListBox{
	fade = 0;
};

class RscButton : Life_RscButton{
	fade = 0;
};

class RscShortcutButton : Life_RscShortcutButton{
	fade = 0;
};

class RscShortcutButtonMain : Life_RscShortcutButtonMain{
	fade = 0;
};

class RscFrame : Life_RscFrame{
	fade = 0;
};

class RscSlider : Life_RscSlider{
	fade = 0;
};

class IGUIBack : Life_RscText{
	colorBackground[] = {0, 0, 0, 0.7};
	fade = 0;
};

class RscCheckBox : Life_RscCheckBox{
	fade = 0;
};

class RscButtonMenu : Life_RscButtonMenu{
	fade = 0;
};

class RscButtonMenuOK : Life_RscButtonMenu{
	idc = 1;
	shortcuts[] =
	{
		"0x00050000 + 0",
		28,
		57,
		156
	};
	default = 1;
	text = "OK";
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenuOK\soundPush",
		0.09,
		1
	};
	fade = 0;
};

class RscButtonMenuCancel : Life_RscButtonMenu{
	idc = 2;
	shortcuts[] =
	{
		"0x00050000 + 1"
	};
	text = "Cancel";
	fade = 0;
};

class RscControlsGroup : Life_RscControlsGroup{
	fade = 0;
};

class RscHTML : Life_RscHTML {
	fade = 0;
};