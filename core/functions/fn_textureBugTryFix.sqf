#include <zmacro.h>
if(scriptAvailable(10)) exitWith {hint "Script is in use, wait a moment.";};

//	Author: Poseidon
//	["textures"] spawn OEC_fnc_textureBugTryFix;
//	change it so that we only reset textures if the texture is not an arma texture, so check the first few characters of texture string for a3/
private["_mode","_vehicleClass","_targetObjects"];
_mode = param [0,"",[""]];

if(_mode == "") exitWith {};

_texturedTypes = ["SignAd_Sponsor_ION_F","SignAd_Sponsor_F","SignAd_SponsorS_F","Land_Billboard_F","Land_ConcreteKerb_03_BW_long_F","Flag_White_F","B_diver_F","Land_Graffiti_01_F","Land_City_4m_F","I_medic_F","Car","Air","Ship","Armored","Submarine"];

_targetObjects = [];

{
	_vehicleClass = getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "vehicleClass");

	if(_vehicleClass in ["Car","Air","Ship","Armored","Submarine","Signs"] || (typeof _x) in _texturedTypes || _x isKindOf "Man") then {
		_targetObjects pushBack _x;
	};
}foreach allMissionObjects "";

switch(_mode) do {
	case "textures":{//sets the textures on all vehicles to plain black, waits a few seconds, then reskins them again
		private["_textures"];

		{
			_textures = getObjectTextures _x;
			_x setVariable ["savedTextures",_textures];

			for "_i" from 0 to ((count _textures) - 1) do
			{
				_x setObjectTexture [_i, '#(argb,8,8,3)color(0,0,0,1)'];
			};

		}foreach _targetObjects;

		hint "Texture bug fix attempt nearly complete. We suggest restarting your game as soon as possible. 30 seconds until textures are restored.";
		sleep 16;

		if(diag_fps > 10) then {
			hint "Your FPS appears to have recovered. This fix may last for seconds, or for hours. It varies from person to person.";
		};

		sleep 14;

		{
			_textures = _x getVariable ["savedTextures",[]];
			_x setVariable ["savedTextures",nil];

			if(!(_textures isEqualTo [])) then {
				for "_i" from 0 to ((count _textures) - 1) do
				{
					_x setObjectTexture [_i, _textures select _i];
				};
			};

		}foreach _targetObjects;

		sleep 2;

		hint "Texture bug fix attempt complete. If this worked let us know on the forums, also we reccomend restarting your game. Sooner rather than later.";
	};

	case "visibility":{//turns the vehicles invisible, waits a few seconds, makes them visible again
		systemChat "Method - Toggle vehicle visiblity/rendering.";

		{
			_x hideObject true;
		}foreach _targetObjects;

		hint "Vehicles hidden. waiting...";

		sleep 5;

		{
			_x hideObject false;
		}foreach _targetObjects;

		hint "Vehicles revealed.";
	};

	case "both":{//does both
		private["_textures","_vehicleClass"];
		systemChat "Method - Toggle vehicle visiblity/rendering and re-texture everything.";

		{
			_textures = getObjectTextures _x;
			_x setVariable ["savedTextures",_textures];

			for "_i" from 0 to ((count _textures) - 1) do
			{
				_x setObjectTexture [_i, '#(argb,8,8,3)color(0,0,0,1)'];
			};

		}foreach _targetObjects;

		{
			_x hideObject true;
		}foreach _targetObjects;

		hint "Textures wiped and set invisible. waiting...";

		sleep 5;

		{
			_x hideObject false;
		}foreach _targetObjects;

		{
			_textures = _x getVariable ["savedTextures",[]];
			_x setVariable ["savedTextures",nil];

			if(!(_textures isEqualTo [])) then {
				for "_i" from 0 to ((count _textures) - 1) do
				{
					_x setObjectTexture [_i, _textures select _i];
				};
			};

		}foreach _targetObjects;

		hint "Textures reverted and made visible.";
	};
};