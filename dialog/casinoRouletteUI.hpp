//	File: casinoRouletteUI.hpp
//	Author: Tech
//	Description: Dialog where you play roulette
class Casino_Roulette
{
  idd = 20001;
  movingEnable = 0;
  enableSimulation = 1;
  onLoad = "['init'] spawn OEC_fnc_casinoRoulette";

  class controlsBackground
  {
    class MainBackground: Life_RscText
    {
    	idc = -1;
    	x = 0;
    	y = 0;
    	w = 1;
    	h = 1;
    	colorBackground[] = {0,0,0,0.68};
    };
    class TitleBackground: MainBackground
    {
    	h = 0.04;
    	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
    };
    class CasinoTitleBox: MainBackground
    {
    	text = "赌场-轮盘赌"; //--- ToDo: Localize;
    	y = -0.006;
    	w = 0.2;
    	h = 0.05;
      colorBackground[] = {0,0,0,0};
    };
    class YourMoneyBackground: Life_RscText
    {
    	idc = -1;
    	x = 0.0375;
    	y = 0.88;
    	w = 0.3625;
    	h = 0.08;
    	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
      colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
    };
    class YourMoneyText: Life_RscText
    {
    	idc = 2000;
    	text = "你的钱: "; //--- ToDo: Localize;
    	x = 0.0375;
    	y = 0.89;
    	w = 0.3375;
    	h = 0.06;
    };
    class CloseButton: Life_RscButton
    {
    	idc = 1900;
    	text = "关闭"; //--- ToDo: Localize;
      onButtonClick = "['Casino_Roulette'] call OEC_fnc_createDialog;oev_inCasino = false;";
    	x = 0.575;
    	y = 0.88;
    	w = 0.375;
    	h = 0.08;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
      colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
    };
    //Roulette stuff
    class BetInput: Life_RscEdit
    {
    	idc = 1400;
      text = "";
    	x = 0.0875;
    	y = 0.82;
    	w = 0.2625;
    	h = 0.04;
    };
    class BetText: Life_RscText
    {
    	idc = 1001;
    	text = "赌注:"; //--- ToDo: Localize;
    	x = 0.025;
    	y = 0.82;
    	w = 0.075;
    	h = 0.04;
    };
    class QuickBet1: Life_RscButton
    {
    	idc = 1601;
    	text = "200k"; //--- ToDo: Localize;
      onButtonClick = "['updateBet', (_this select 0)] spawn OEC_fnc_casinoRoulette";
    	x = 0.025;
    	y = 0.68;
    	w = 0.1;
    	h = 0.12;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
      colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
    };
    class QuickBet2: QuickBet1
    {
    	idc = 1602;
    	text = "400k"; //--- ToDo: Localize;
    	x = 0.1375;
    };
    class QuickBet3: QuickBet1
    {
    	idc = 1603;
    	text = "500k"; //--- ToDo: Localize;
    	x = 0.25;
    };
    class QuickBet4: QuickBet1
    {
    	idc = 1604;
    	text = "600k"; //--- ToDo: Localize;
    	x = 0.3625;
    };
    class QuickBet5: QuickBet1
    {
    	idc = 1605;
    	text = "700k"; //--- ToDo: Localize;
    	x = 0.475;
    };
    class QuickBet6: QuickBet1
    {
    	idc = 1606;
    	text = "800k"; //--- ToDo: Localize;
    	x = 0.5875;
    };
    class QuickBet7: QuickBet1
    {
    	idc = 1607;
    	text = "1M"; //--- ToDo: Localize;
    	x = 0.7;
    };
    class QuickBetRange1: Life_RscButton
    {
    	idc = 1701;
    	text = "200k-1M"; //--- ToDo: Localize;
      onButtonClick = "['updateQuickBetButtons', (_this select 0)] spawn OEC_fnc_casinoRoulette";
    	x = 0.8125;
    	y = 0.68;
    	w = 0.138;
    	h = 0.04;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
      colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
    };
    class QuickBetRange2: QuickBetRange1
    {
    	idc = 1702;
    	text = "1M-5M"; //--- ToDo: Localize;
    	y = 0.72;
    };
    class QuickBetRange3: QuickBetRange1
    {
    	idc = 1703;
    	text = "5M-10M"; //--- ToDo: Localize;
    	y = 0.76;
    };

    //ST_PICTURE + ST_KEEP_ASPECT_RATIO;
    class Roulette_Table: Life_RscPicture
    {
    	idc = 4000;
      style = 48 + 2048;
      text = "images\icons\casino\rouletteTable.paa";
    	x = -0.01; //x = 0.0375;
      y = 0.045; //y = 0.06;
      w = 0.49; //w = 0.35;
      h = 0.62; //h = 0.48;
    };
    class Roulette_Ball: Life_RscPicture
    {
      idc = 4001;
      style = 48 + 2048;
      text = "images\icons\casino\rouletteBall.paa";
      x = 0.2275; //x = 0.1625;
      y = 0.18; //y = 0.04;
      w = 0.015; //w = 0.025;
      h = 0.03; //h = 0.04;
    };

    class BetBackground: Life_RscText
    {
    	idc = 5001;
    	x = 0.47;
    	y = 0.45;
    	w = 0.5;
    	h = 0.18;
    	colorBackground[] = {0,0,0,1};
    };
    class BetText2: Life_RscText
    {
      idc = 5000;
      text = "下注";
      x = 0.637;
      y = 0.432;
      w = 0.16;
    	h = 0.08;
    };

    class BetRed: Life_RscButton
    {
    	idc = 1801;
    	text = "";
      onButtonClick = "['bet', (_this select 0)] spawn OEC_fnc_casinoRoulette";
    	x = 0.50;
    	y = 0.5;
    	w = 0.138;
    	h = 0.1;
      colorBackground[] = {0.89, 0.114, 0.137, 1};
      colorFocused[] = {0.89, 0.114, 0.137, 1};
      colorBackgroundActive[] = {1, 0.114, 0.137, 1};
      colorBackgroundDisabled[] = {0.89, 0.114, 0.137, 0.6};
    };
    class BetBlack: BetRed
    {
    	idc = 1802;
    	x = 0.65;
      colorBackground[] = {0.267, 0.263, 0.263, 1};
      colorFocused[] = {0.267, 0.263, 0.263, 1};
      colorBackgroundActive[] = {0.314, 0.314, 0.314, 1};
      colorBackgroundDisabled[] = {0.267, 0.263, 0.263, 0.6};
    };
    class BetGreen: BetRed
    {
    	idc = 1803;
    	x = 0.80;
      colorBackground[] = {0.173, 0.647, 0.047, 1};
      colorFocused[] = {0.173, 0.647, 0.047, 1};
      colorBackgroundActive[] = {0.173, 1, 0.047, 1};
      colorBackgroundDisabled[] = {0.173, 0.647, 0.047, 0.6};
    };
  };
};
