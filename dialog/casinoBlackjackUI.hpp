//	File: casinoBlackjackUI.hpp
//	Author: Tech
//	Description: Dialog where you play Blackjack
class Casino_Blackjack
{
  idd = 20003;
  movingEnable = 0;
  enableSimulation = 1;
  onLoad = "['init'] spawn OEC_fnc_casinoBlackjack";

  class controlsBackground
  {
    class MainBackground: Life_RscText
    {
    	idc = -1;
      x = -0.1;
    	y = -0.1;
    	w = 1.22;
    	h = 1.22;
    	colorBackground[] = {0,0,0,0.7};
    };
    class TitleBackground: MainBackground
    {
    	y = -0.138;
    	h = 0.04;
    	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
    };
    class CasinoTitleBox: TitleBackground
    {
    	idc = -1;
      text = "赌场-21点"; //--- ToDo: Localize;
    	x = -0.1;
    	y = -0.138;
    };

    //blackjack stuff
    class BetButton: Life_RscButton
    {
    	idc = 3000;
    	text = "发牌"; //--- ToDo: Localize;
      onButtonClick = "['deal'] spawn OEC_fnc_casinoBlackjack;";
    	x = 0.9;
    	y = 0.85;
    	w = 0.2;
    	h = 0.15;
      //sizeEx = 2 * GUI_GRID_H;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
      colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
    };

    class StandButton: Life_RscButton
    {
    	idc = 8000;
    	text = "比牌"; //--- ToDo: Localize;
      onButtonClick = "['stand'] spawn OEC_fnc_casinoBlackjack";
      x = -0.05;
      y = 0.65;
      w = 0.15;
      h = 0.1;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
      colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
    };

    class HitButton: StandButton
    {
      idc = 8001;
      text = "加牌"; //--- ToDo: Localize;
      onButtonClick = "['hit'] spawn OEC_fnc_casinoBlackjack";
      y = 0.54;
    };

    class DoubleDownButton: StandButton
    {
      idc = 8002;
      text = "双倍下注"; //--- ToDo: Localize;
      onButtonClick = "['doubledown'] spawn OEC_fnc_casinoBlackjack";
      y = 0.43;
    };

    //class SplitButton: Life_RscButton
    //{
    //  idc = 8003;
    //  text = "Split"; //--- ToDo: Localize;
    //  onButtonClick = "['split', controlNull] spawn OEC_fnc_casinoBlackjack";
    //  x = -0.05;
    //  y = 0.32;
    //  w = 0.15;
    //  h = 0.1;
    //  //sizeEx = 2 * GUI_GRID_H;
    //  colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
    //  colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
    //};

    class DealerValue: Life_RscText
    {
      idc = 9000;
      x = -0.08;
      y = 0.25;
      w = 1;
      h = 0.04;
      colorBackground[] = {0,0,0,0};
    };
    class PlayerValue: DealerValue
    {
      idc = 9001;
      y = 0.35;
    };

//other shit
    class YourMoneyBackground: Life_RscText
    {
    	idc = -1;
    	x = -0.0375;
    	y = 1;
    	w = 0.3625;
    	h = 0.08;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
    };
    class YourMoneyText: YourMoneyBackground
    {
    	idc = 2000;
    	text = "你的钱: "; //--- ToDo: Localize;
    	y = 1.01;
    	w = 0.3375;
    	h = 0.06;
      colorBackground[] = {0,0,0,0};
    };
    class CloseButton: Life_RscButton
    {
    	idc = 1900;
    	text = "关闭"; //--- ToDo: Localize;
      onButtonClick = "['Casino_Blackjack'] call OEC_fnc_createDialog;oev_inCasino = false;";
    	x = 0.5;
    	y = 1;
    	w = 0.375;
    	h = 0.08;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
      colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
    };

    class BetInput: Life_RscEdit
    {
      idc = 1400;
      text = "";
      x = 0.0125;
      y = 0.94;
      w = 0.2625;
      h = 0.04;
    };
    class BetText: Life_RscText
    {
      idc = 1001;
      text = "赌注:"; //--- ToDo: Localize;
      x = -0.05;
      y = 0.94;
      w = 0.075;
      h = 0.04;
    };
    class QuickBet1: Life_RscButton
    {
      idc = 1601;
      text = "200k"; //--- ToDo: Localize;
      onButtonClick = "['updateBet', (_this select 0)] spawn OEC_fnc_casinoBlackjack";
      x = -0.05;
      y = 0.8;
      w = 0.1;
      h = 0.12;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
      colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
    };
    class QuickBet2: QuickBet1
    {
      idc = 1602;
      text = "400k"; //--- ToDo: Localize;
      x = 0.0625;
    };
    class QuickBet3: QuickBet1
    {
      idc = 1603;
      text = "500k"; //--- ToDo: Localize;
      x = 0.175;
      };
    class QuickBet4: QuickBet1
    {
      idc = 1604;
      text = "600k"; //--- ToDo: Localize;
      x = 0.2875;
    };
    class QuickBet5: QuickBet1
    {
      idc = 1605;
      text = "700k"; //--- ToDo: Localize;
      x = 0.4;
    };
    class QuickBet6: QuickBet1
    {
      idc = 1606;
      text = "800k"; //--- ToDo: Localize;
      x = 0.5125;
    };
    class QuickBet7: QuickBet1
    {
      idc = 1607;
      text = "1M"; //--- ToDo: Localize;
      x = 0.625;
    };
    class QuickBetRange1: Life_RscButton
    {
      idc = 1701;
      text = "200k-1M"; //--- ToDo: Localize;
      onButtonClick = "['updateQuickBetButtons', (_this select 0)] spawn OEC_fnc_casinoBlackjack";
      x = 0.7375;
      y = 0.8;
      w = 0.138;
      h = 0.04;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
      colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.68])"};
    };
    class QuickBetRange2: QuickBetRange1
    {
      idc = 1702;
      text = "1M-5M"; //--- ToDo: Localize;
      y = 0.84;
    };
    class QuickBetRange3: QuickBetRange1
    {
      idc = 1703;
      text = "5M-10M"; //--- ToDo: Localize;
      y = 0.88;
    };
  };
};
