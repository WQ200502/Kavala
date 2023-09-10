//    File: fn_loadGear.sqf
//    Author: Bryan "Tonic" Boardwine

//    Description:
//    Loads saved civilian gear, this is limited for a reason and that's balance.

private["_itemArray","_uniform","_vest","_backpack","_launch","_goggles","_headgear","_items","_prim","_seco","_uItems","_cr","_id","_string","_start","_end","_bItems","_vItems","_pItems","_hItems","_yItems","_allMags","_handle","_load","_cfg"];

// if snapshot_life_gear exists then use it instead of life_gear since player has died and is an officer. /x00

waitUntil {!(isNull (findDisplay 46))};
_itemArray = life_gear;
_handle = [] spawn OEC_fnc_stripDownPlayer;
waitUntil {scriptDone _handle};

if(oev_newsTeam) exitWith {
	[] call OEC_fnc_newsLoadout;
};

if(count _itemArray == 0) exitWith {
    switch(playerSide) do {
        case west: {
            [] call OEC_fnc_copLoadout;
        };

        case civilian: {
            [] call OEC_fnc_civLoadout;
        };

        case independent: {
            [] call OEC_fnc_medicLoadout;
        };
    };
};

_itemArray params [
	["_uniform",""],
	["_vest",""],
	["_backpack",""],
	["_goggles",""],
	["_headgear",""],
	["_items",[]],
	["_prim",""],
	["_seco",""],
	["_launch",""],
	["_uItems",[]],
	["_bItems",[]],
	["_vItems",[]],
	["_allMags",[]],
	["_pItems",[]],
	["_hItems",[]],
	["_yItems",[]]
];

//Leave 3 lines below here permenantly to repair database issues from save gear fuckwad who set these to arrays...
if (_prim isEqualTo []) then {_prim = "";};
if (_seco isEqualTo []) then {_seco = "";};
if (_launch isEqualTo []) then {_launch = "";};

if(_goggles != "") then {_handle = [_goggles,true,false,false,false] spawn OEC_fnc_handleItem; waitUntil {scriptDone _handle};};
if(_headgear != "") then {_handle = [_headgear,true,false,false,false] spawn OEC_fnc_handleItem; waitUntil {scriptDone _handle};};
if(_uniform != "") then {_handle = [_uniform,true,false,false,false] spawn OEC_fnc_handleItem; waitUntil {scriptDone _handle};};
if(_vest != "") then {_handle = [_vest,true,false,false,false] spawn OEC_fnc_handleItem; waitUntil {scriptDone _handle};};
if(_backpack != "") then {_handle = [_backpack,true,false,false,false] spawn OEC_fnc_handleItem; waitUntil {scriptDone _handle};};
{_handle = [_x,true,false,false,false] spawn OEC_fnc_handleItem; waitUntil {scriptDone _handle};} foreach _items;

{player addItemToUniform _x;} foreach (_uItems);
{player addItemToVest _x;} foreach (_vItems);
{player addItemToBackpack _x;} foreach (_bItems);


//Save magazines that weren't added
{
	for "_i" from 0 to ((_x select 2) - 1) do {
		if (player canAdd (_x select 0)) then {
			player addMagazine [(_x select 0),(_x select 1)];
		} else {
			oev_deletedAmmo pushBack [(_x select 0),(_x select 1)];
		};
	};
}foreach (_allMags);

if(backpack player != "") then {
	_cfg = getNumber(configFile >> "CfgVehicles" >> (backpack player) >> "maximumload");
	_load = round(_cfg / 8);
	oev_maxWeight = oev_maxWeightT + _load;
}else{
	oev_maxWeight = oev_maxWeightT;
};

if(count _yItems > 1) then {
	if((_yItems select 0) isEqualType [] && count (_yItems select 0) > 0) then {
		{
			[true,(_x select 0),(_x select 1)] call OEC_fnc_handleInv;
		} foreach (_yItems select 0);
	};
};

//Primary & Secondary (Handgun) should be added last as magazines do not automatically load into the gun.
if(_prim != "") then {
	if((playerSide isEqualTo west) && ((count life_gear_snapshot) > 0)) then {
		_handle = [(life_gear_snapshot select 6),true,false,false,false] spawn OEC_fnc_handleItem; waitUntil {scriptDone _handle};
		{if(_x != "") then {player addPrimaryWeaponItem _x;};}foreach (life_gear_snapshot select 13);
	} else {
		_handle = [_prim,true,false,false,false] spawn OEC_fnc_handleItem; waitUntil {scriptDone _handle};
		{
		    if (_x != "") then {
		        player addPrimaryWeaponItem _x;
		    };
		} foreach (_pItems);
	};
};
if(_seco != "") then {_handle = [_seco,true,false,false,false] spawn OEC_fnc_handleItem; waitUntil {scriptDone _handle};};
if(_launch != "") then {
	player addWeapon _launch;
};


{
    if (_x != "") then {
        player addHandgunItem _x;
    };
} foreach (_hItems);

uiSleep 1;

if ((playerSide isEqualTo independent) && (life_inv_panicButton isEqualTo 0)) then {
	[true,"panicButton",1] call OEC_fnc_handleInv;
};
if ((playerSide isEqualTo independent) && (life_inv_roadKit isEqualTo 0)) then {
	[true,"roadKit",1] call OEC_fnc_handleInv;
};
if ((playerSide isEqualTo west) && (missionNamespace getVariable ["oev_bait_active", false])) then {
	[true, "bcremote", 1] call OEC_fnc_handleInv
};
if ((playerSide isEqualTo west) && (life_inv_defusekit isEqualTo 0)) then {
	[true, "defusekit", 1] call OEC_fnc_handleInv
};
if (sunOrMoon isEqualTo 0) then {
	if (hmd player isEqualTo "") then {
		if ((headgear player isEqualTo "") || {!(headgear player in ["H_PilotHelmetFighter_O","H_PilotHelmetFighter_B","H_PilotHelmetFighter_I", "H_HelmetO_ViperSP_hex_F", "H_HelmetO_ViperSP_ghex_F"])}) then {
			player linkItem "NVGoggles";
			hint "我们注意到现在是晚上，你没有夜视仪。我们给了你一个免费的！";
		};
	};
};

//After the gun has been added see if we can then add it back to the player (since a magazine is loaded into the gun usually once it is spawned).  If it cannot be added then we spawn it on the ground near the player
if ((side player) isEqualTo west) then {
	{
		if (player canAdd (_x select 0)) then {
			player addMagazine [(_x select 0),(_x select 1)];
		};
	} forEach oev_deletedAmmo;
} else {
	{
		if (player canAdd (_x select 0)) then {
			player addMagazine [(_x select 0),(_x select 1)];
		} else {
			oev_ammoToDrop pushBack (_x select 0);
		};
	} forEach oev_deletedAmmo;
};

