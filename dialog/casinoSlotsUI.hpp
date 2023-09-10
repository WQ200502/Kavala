//	File: casinoSlotsUI.hpp
//	Author: Tech
//	Description: Dialog where you play slots
class Casino_Slots
{
  idd = 20002;
  movingEnable = 0;
  enableSimulation = 1;
  onLoad = "[] spawn OEC_fnc_casinoSlotsCreate";

  class controlsBackground
  {
    class SpriteBackground: Life_RscText
    {
      idc = -1;
      x = 0.35;
      y = 0.45;
      w = 0.38;
      h = 0.2;
      colorBackground[] = {0,0,0,0.68};
    };
    class BetInput: Life_RscEdit
    {
      idc = 2000;
      text = "";
      x = 0.2;
    	y = 0.975;
    	w = 0.2;
    	h = 0.04;
    };
  };
};
