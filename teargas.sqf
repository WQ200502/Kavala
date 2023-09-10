//  File: fn_teargas.sqf
//	Author: [VS] Odin
//	Description: Main handling system for teargas.

private["_masks","_goggles","_fullFace","_vision","_breath"];

_masks = ["G_Bandanna_aviator","H_Shemag_khk","H_Shemag_tan","H_Shemag_olive","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Shemag_olive_hs","G_Balaclava_oli","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan"];
_goggles = ["G_Lowprofile","G_Combat"];
_fullFace = ["H_CrewHelmetHeli_B","H_PilotHelmetFighter_O","G_Balaclava_combat","G_Balaclava_lowprofile"];

While{true} do {
	"dynamicBlur" ppEffectEnable true; // enables ppeffect
	"dynamicBlur" ppEffectAdjust [0]; // enables normal vision
	"dynamicBlur" ppEffectCommit 15; // time it takes to normal
	resetCamShake; // resets the shake
	20 fadeSound 1;     //fades the sound back to normal
	//_resetBlur = 15;

	waituntil{
		((nearestObject [getpos player, "G_40mm_SmokeOrange"]) distance player < 10)
		and
		(getpos (nearestObject [getpos player, "G_40mm_SmokeOrange"]) select 2 < 0.5)
	};

	_vision = true;
	_breath = true;

	if (((goggles player) in _goggles) || ((headgear player) in _goggles)) then {_vision = false;};
	if (((goggles player) in _masks) || ((headgear player) in _masks)) then {_breath = false;};
	if (((goggles player) in _fullFace) || ((headgear player) in _fullFace)) then {_vision = false; _breath = false;};

	if (_vision) then {
		"dynamicBlur" ppEffectEnable true;	// enables ppeffect
		"dynamicBlur" ppEffectAdjust [20];	// intensity of blur
		"dynamicBlur" ppEffectCommit 3;		// time till vision is fully blurred
	};

	if (_breath) then {
		enableCamShake true;		// enables camera shake
		addCamShake [10, 45, 10];	// sets shakevalues
		player setFatigue 1;		// Set fatigue to 100%
		5 fadeSound 0.1;			// fades the sound to 10% in 5 seconds
	};

		sleep 5;

};