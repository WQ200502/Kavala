//  File: fn_refillMags.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Refills magazines

private _mAmmo = magazinesAmmo player;
private _mTypes = [];
private _a = 0;

private _specialTypes = ["10Rnd_50BW_Mag_F", "6Rnd_12Gauge_Pellets", "3Rnd_SmokeOrange_Grenade_shell", "3Rnd_SmokeBlue_Grenade_shell"];

for "_i" from 0 to ((count _mAmmo) - 1) do {
	private _mType = ((_mAmmo select _i) select 0);
	if (getNumber(configFile >> "CfgMagazines" >> _mType >> "count") > 1) then {
		_mTypes set [_a, _mType];
		_a = _a + 1;
	};
};

if (primaryWeapon player != "") then {
	private _primaryMagazine = primaryWeaponMagazine player;
	if (count _primaryMagazine > 0) then {
		private _primaryMagazineClassname = (_primaryMagazine select 0);
		private _primaryMagazineCapacity = getNumber(configFile >> "CfgMagazines" >> _primaryMagazineClassname >> "count");
		player setAmmo [primaryWeapon player, _primaryMagazineCapacity];
		//Fill special ammo such as 3GL smokes.
		{
			if (_x in (primaryWeaponMagazine player)) then {
				player removePrimaryWeaponItem _x;
				player addPrimaryWeaponItem _x;
			};
		} forEach _specialTypes;
	};
};

if (handgunWeapon player != "") then {
	private _handgunMagazine = handgunMagazine player;
	if (count _handgunMagazine > 0) then {
		private _handgunMagazineClassname = (_handgunMagazine select 0);
		private _handgunMagazineCapacity = getNumber(configFile >> "CfgMagazines" >> _handgunMagazineClassname >> "count");
		player setAmmo [handgunWeapon player, _handgunMagazineCapacity];
	};
};

{
	player removeMagazine _x;
} forEach _mTypes;

{
	private _maxAmmo = getNumber(configFile >> "CfgMagazines" >> _x >> "count");
	player addMagazine [_x,_maxAmmo];
} forEach _mTypes;

hint "你所有的子弹都加满了！";
