/*


*/
uisleep 300;

life_fpsFixCounter = 0;

while{true} do {
	if(oev_fpsFixToggle) exitWith {};
	uisleep 1;

	if(diag_fps < 7) then {
		life_fpsFixCounter = life_fpsFixCounter + 1;

		[] spawn{
			uisleep 7;

			if(life_fpsFixCounter > 0) then {
				life_fpsFixCounter = life_fpsFixCounter - 1;
			};
		}
	};

	if(life_fpsFixCounter > 5) then {
		life_fpsFixCounter = 0;
		hint "Possible texture bug detected causing low fps. Attempting to fix it. To disable low fps monitoring press F6.";
		["textures"] spawn OEC_fnc_textureBugTryFix;
		uisleep 50;
	};
};
