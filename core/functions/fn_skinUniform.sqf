if(isServer && isDedicated) exitWith {};
//  File: fn_skinUniform.sqf
//	Description: Combined with JIP keeps players uniforms up to date with proper skin
//	Since the global variant of this command is not very good this is used as an alternative

private ["_data","_rankLevel","_uniformSkin","_backpackSkin","_skinableUniforms","_skinableBackpacks","_uniformSkin2"];
params [
	["_unit", objNull, [objNull]],
	["_localOnly", false, [false]]
];

if(isNull _unit) exitWith {};
_uniform = uniform _unit;
_backpack = backpack _unit;
_uniformSkin = "none";
_uniformSkin2 = "none";
_backpackSkin = "none";


if(_uniform != "") then {
	_skins = [_uniform, "", _unit] call OEC_fnc_clothingSkins;
	if(count _skins > 0) then {
		_uniformSkin = (_skins select 0) select 8;

		if(count (_skins select 0) > 9) then {
			_uniformSkin2 = (_skins select 0) select 9;
		};
	};
};

if(_backpack != "") then {
	_skins = [_backpack, "", _unit] call OEC_fnc_clothingSkins;
	if(count _skins > 0) then {
		_backpackSkin = (_skins select 0) select 8;
	};
};

if(_localOnly) then {
	if(_uniformSkin != "none") then {
		_unit setObjectTexture [0, _uniformSkin];

		if(_uniformSkin2 != "none") then {
			_unit setObjectTexture [0, _uniformSkin2];
		};
	};

	if(_backpackSkin != "none") then {
		if (_backpack isEqualTo "B_Kitbag_sgg") exitWith {
			if ((call oev_donator) >= 30) then {
				(unitbackpack _unit) setObjectTexture [0, _backpackSkin];
			};
		};

		if (_backpack isEqualTo "B_Kitbag_mcamo") exitWith {
			if ((call oev_donator) >= 50) then {
				(unitbackpack _unit) setObjectTexture [0, _backpackSkin];
			};
		};

		if (_backpack isEqualTo "B_Messenger_Black_F") exitWith {
			if ((call oev_donator) >= 100) then {
				(unitbackpack _unit) setObjectTexture [0, _backpackSkin];
			};
		};

		(unitbackpack _unit) setObjectTexture [0, _backpackSkin];
	};
} else {
	if(_uniformSkin != "none") then {
		[[_unit,0,_uniformSkin],"OEC_fnc_setTexture",-2,false] spawn OEC_fnc_MP;
		_unit setObjectTextureGlobal [0, _uniformSkin];

		if(_uniformSkin2 != "none") then {
			[[_unit,1,_uniformSkin2],"OEC_fnc_setTexture",-2,false] spawn OEC_fnc_MP;
			_unit setObjectTextureGlobal [1, _uniformSkin2];
		};
	};

	if(_backpackSkin != "none") then {
		if (_backpack isEqualTo "B_Kitbag_sgg") exitWith {
			if ((call oev_donator) >= 30) then {
				[[(unitbackpack _unit),0,_backpackSkin],"OEC_fnc_setTexture",-2,false] spawn OEC_fnc_MP;
				(unitbackpack _unit) setObjectTextureGlobal [0, _backpackSkin];
			};
		};

		if (_backpack isEqualTo "B_Kitbag_mcamo") exitWith {
			if ((call oev_donator) >= 30) then {
				[[(unitbackpack _unit),0,_backpackSkin],"OEC_fnc_setTexture",-2,false] spawn OEC_fnc_MP;
				(unitbackpack _unit) setObjectTextureGlobal [0, _backpackSkin];
			};
		};

		if (_backpack isEqualTo "B_Messenger_Black_F") exitWith {
			if ((call oev_donator) >= 100) then {
				[[(unitbackpack _unit),0,_backpackSkin],"OEC_fnc_setTexture",-2,false] spawn OEC_fnc_MP;
				(unitbackpack _unit) setObjectTextureGlobal [0, _backpackSkin];
			};
		};

		[[(unitbackpack _unit),0,_backpackSkin],"OEC_fnc_setTexture",-2,false] spawn OEC_fnc_MP;
		(unitbackpack _unit) setObjectTextureGlobal [0, _backpackSkin];
	};
};
