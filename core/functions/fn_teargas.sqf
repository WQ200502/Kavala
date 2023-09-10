//  File: fn_tearGas.sqf
//  Author: Ozadu
//  Description: blurs screen is player is near a tear gas grenage

params[
	["_smokeShell",objNull,[objNull]]
];
_radius = 20;
_smokeTypes = ["G_40mm_SmokeOrange"];
_halfFace = ["G_Bandanna_aviator","H_Shemag_khk","H_Shemag_tan","H_Shemag_olive","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Shemag_olive_hs","G_Balaclava_oli","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan","G_Lowprofile","G_Combat"];
_fullFace = ["H_CrewHelmetHeli_B","H_PilotHelmetFighter_O","G_Balaclava_combat","G_Balaclava_lowprofile"];

/*loop while the smoke shell is still active*/
while{!isNull _smokeShell} do {
	_distance = player distance _smokeShell;

    /*Initiate blur effects when near tear gas*/
    if(_distance < 20) exitWith {
		if(!(isNil "life_tearGas")) exitWith {life_tearGas pushBack _smokeShell};
		life_tearGas = [_smokeShell];

		private["_name","_priority","_handle"];
		_name = "DynamicBlur";
		_priority = 400;

		while {
			_handle = ppEffectCreate [_name, _priority];
			_handle < 0
		} do {
			_priority = _priority + 1;
		};
		_handle ppEffectEnable true;

		/*Adjust the amount of blur depending on the distance from the gas*/
		while{count life_tearGas > 0} do {
			private "_closest";
			_closest = life_tearGas select 0;
			{
				if((_x distance player) < (_closest distance player)) then {
					_closest = _x;
				};
			}forEach life_tearGas;

			_gasDistance = player distance _closest;
			_effect = 10*(1/(1.3^_gasDistance));
			_headGear = headgear player;
			_goggles = goggles player;
			if(_headGear in _halfFace || goggles player in _halfFace) then {_effect = _effect * .5};
			if(_headGear in _fullFace || _goggles in _fullFace) then {_effect = _effect * 0};
			_handle ppEffectAdjust [_effect];
			_handle ppEffectCommit 0;
			uiSleep .1;
		};
		life_tearGas = nil;
		_handle ppEffectEnable false;
		ppEffectDestroy _handle;
    };
	uiSleep .5;
};