//	Author: Poseidon
//	Description: Applies post processing affects and adjusts them at certain times of the day to make things perty

private["_nightColors","_dayColors"];
_nightColors = [1, 1.1, -0.01, [0.4, 0.25, 0.2, -0.1], [0.8, 0.725, 0.625, 1.075], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];
_dayColors = [1.025, 1.015, -0.05, [0.4, 0.25, 0.2, -0.1], [0.8, 0.725, 0.625, 1.075], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];

OLifeColorAdjustments = ppEffectCreate ["colorCorrections", 1500];

if((date select 3) < 19 && (date select 3) >= 4) then {
	OLifeColorAdjustments ppEffectAdjust _dayColors;
	OLifeColorAdjustments ppEffectCommit 0;
	OLifeColorAdjustments ppEffectEnable true;

	while{true} do {
		waitUntil{(date select 3) == 19};
		OLifeColorAdjustments ppEffectAdjust _nightColors;
		OLifeColorAdjustments ppEffectCommit 180;
		OLifeColorAdjustments ppEffectEnable true;

		waitUntil{(date select 3) == 4};
		OLifeColorAdjustments ppEffectAdjust _dayColors;
		OLifeColorAdjustments ppEffectCommit 450;
		OLifeColorAdjustments ppEffectEnable true;
	};
}else{
	OLifeColorAdjustments ppEffectAdjust _nightColors;
	OLifeColorAdjustments ppEffectCommit 0;
	OLifeColorAdjustments ppEffectEnable true;

	while{true} do {
		waitUntil{(date select 3) == 4};
		OLifeColorAdjustments ppEffectAdjust _dayColors;
		OLifeColorAdjustments ppEffectCommit 450;
		OLifeColorAdjustments ppEffectEnable true;

		waitUntil{(date select 3) == 19};
		OLifeColorAdjustments ppEffectAdjust _nightColors;
		OLifeColorAdjustments ppEffectCommit 180;
		OLifeColorAdjustments ppEffectEnable true;
	};
};