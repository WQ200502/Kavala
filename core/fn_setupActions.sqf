//  File: fn_setupActions.sqf
//	Description: Master file handler for all client-based actions.

private _obj_main = player;
life_actions = [];

switch (playerSide) do {
	case west: {
		life_actions pushBack (_obj_main addAction["司机身份进入",OEC_fnc_copEnter,"driver",20,false,false,"",'(cursorTarget getVariable["side", "cop"] isEqualTo "cop" || cursorTarget getVariable["side", "cop"] isEqualTo "med") && !isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 5']);
		life_actions pushBack (_obj_main addAction["乘客身份进入",OEC_fnc_copEnter,"passenger",19,false,false,"",'(cursorTarget getVariable["side", "cop"] isEqualTo "cop" || cursorTarget getVariable["side", "cop"] isEqualTo "med") && !isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 5']);
		life_actions pushBack (_obj_main addAction["指挥官进入",OEC_fnc_copEnter,"commander",20,false,false,"",'(cursorTarget getVariable["side", "cop"] isEqualTo "cop" || cursorTarget getVariable["side", "cop"] isEqualTo "med") && !isNull cursorTarget && (typeOf cursorTarget == "I_MRAP_03_F") && (locked cursorTarget) != 0 && cursorTarget distance player < 5']);
		life_actions pushBack (_obj_main addAction["退出",OEC_fnc_copEnter,"exit",20,false,false,"GetOut",'(vehicle player != player) && (locked(vehicle player)==2)']);
		life_actions pushBack (_obj_main addAction["<t color='#00FF00'>加载晕弹</t>",{[] call OEC_fnc_toggleLethals;},"",1.5,false,false,"",'!life_copTogLethal && (((currentWeapon player) in oev_taserWeapons) && !(player getVariable ["nonLethals",false]) && { ! ( oev_conquestData select 0 && { getPos player inPolygon (oev_conquestData select 1 select 1) } ) })']);
		life_actions pushBack (_obj_main addAction["<t color='#FF0000'>加载实弹</t>",{[] call OEC_fnc_toggleLethals;},"",1.5,false,false,"",'!life_copTogLethal && ((((player getVariable ["rank",0]) > 2) || (((player getVariable ["rank",0]) == 2) && (getPos player inPolygon oev_warzonePoly || player getVariable ["lethalsPO",true]))) && ((currentWeapon player) in oev_taserWeapons) && (player getVariable ["nonLethals",false]))']);
		life_actions pushBack (_obj_main addAction["<t color='#FF9933'>部署催泪瓦斯</t>",OEC_fnc_deployVehicleTeargas,"",0,false,false,"",'(typeOf vehicle player == "C_Plane_Civil_01_racing_F") && ((player getVariable ["rank",3]) > 4) && ((driver (vehicle player)) isEqualTo player)']);
		life_actions pushBack (_obj_main addAction["没收物品",OEC_fnc_seizeObjects,cursorTarget,1.5,false,false,"",'((count(nearestObjects [player,["weaponholder","GroundWeaponHolder","WeaponHolderSimulated"],3])>0))']);
		if (call oev_donator > 0) then {
			life_actions pushBack (_obj_main addAction["<t color='#FF8000'>排烟</t>",OEC_fnc_handleSkywriteColors, nil, 1.5, true, true, "", " oev_lastSkywrite < time && (driver (vehicle player)) isEqualTo player && typeOf vehicle player in ['C_Plane_Civil_01_F','C_Plane_Civil_01_racing_F','B_T_VTOL_01_vehicle_F','B_T_VTOL_01_infantry_F','O_Plane_CAS_02_F','B_Plane_CAS_01_F','I_Plane_Fighter_03_CAS_F','I_Plane_Fighter_04_F','B_Plane_Fighter_01_F','O_Plane_Fighter_02_F']"]);
		};
		//life_actions pushBack (_obj_main addAction["Show Badge",{[[],'OEC_fnc_showBadge',cursorTarget,false] spawn OEC_fnc_MP;},cursorTarget,1,false,false,"",'!isNull cursorTarget && (cursorTarget isKindOf "man") && cursorTarget distance < 5']);
	};

	case independent: {
		life_actions pushBack (_obj_main addAction["给予多巴胺",OEC_fnc_giveDopamine,cursorTarget,18,false,false,"",'(!isNull cursorTarget && {cursorTarget distance player < 5} && {cursorTarget getVariable["epiActive",false]})']);
		life_actions pushBack (_obj_main addAction["替换肾脏",OEC_fnc_replaceKidney,cursorTarget,18,false,false,"",'(!isNull cursorTarget && {cursorTarget distance player < 5} && {cursorTarget getVariable["kidneyRemoved",false]})']);
		life_actions pushBack (_obj_main addAction["司机身份进入",OEC_fnc_copEnter,"driver",20,false,false,"",'!isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 5']);
		life_actions pushBack (_obj_main addAction["乘客身份进入",OEC_fnc_copEnter,"passenger",19,false,false,"",'!isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 5']);
		life_actions pushBack (_obj_main addAction["退出",OEC_fnc_copEnter,"exit",20,false,false,"GetOut",'(vehicle player != player) && (locked(vehicle player)==2)']);
	};

	case civilian: {
		//Drop fishing net
		life_actions pushBack (_obj_main addAction["投放渔网",OEC_fnc_dropFishingNet,"",1.5,false,false,"",'(surfaceisWater (getPos vehicle player)) && (vehicle player isKindOf "Ship") && oev_carryWeight < oev_maxWeight && speed (vehicle player) < 2 && speed (vehicle player) > -1 && !oev_net_dropped ']);
		life_actions pushBack (_obj_main addAction["<t color='#FF0000'>启动自爆背心</t>",OEC_fnc_suicideBomb,"",1.5,false,false,"",' vest player == "V_HarnessOGL_brn" && alive player && playerSide isEqualTo civilian && !(player getVariable ["restrained",false]) && !(player getVariable ["Escorting",false]) && !(player getVariable ["transporting",false])']);
		life_actions pushBack (_obj_main addAction["退出",OEC_fnc_copEnter,"exit",20,false,false,"GetOut",'(vehicle player != player) && {(locked(vehicle player)==0)} && {((vehicle player) isKindOf "Air")} && {(driver (vehicle player) isEqualTo player)}']);
		if (call oev_donator > 0) then {
			life_actions pushBack (_obj_main addAction["<t color='#FF8000'>排烟</t>",OEC_fnc_handleSkywriteColors, nil, 1.5, true, true, "", " oev_lastSkywrite < time && (driver (vehicle player)) isEqualTo player && typeOf vehicle player in ['C_Plane_Civil_01_F','C_Plane_Civil_01_racing_F','B_T_VTOL_01_vehicle_F','B_T_VTOL_01_infantry_F','O_Plane_CAS_02_F','B_Plane_CAS_01_F','I_Plane_Fighter_03_CAS_F','I_Plane_Fighter_04_F','B_Plane_Fighter_01_F','O_Plane_Fighter_02_F']"]);
		};
		// We shouldn't need this anymore with previous fixes.  Civs auto taze with tazerWeapons without lethal option.  Tested on drop + pickup / purchase new / reload / drop ammo + pickup. /x00
		// life_actions pushBack (_obj_main addAction["Load Taser Rounds",{player setVariable ['nonLethals',true,true];},"",20,false,false,"",'license_civ_vigilante && ((currentWeapon player) in oev_taserWeapons) && !(player getVariable ["nonLethals",false])']);
		// life_actions pushBack (_obj_main addAction["Load Lethal Rounds",{player setVariable ['nonLethals',false,true];},"",20,false,false,"",'license_civ_vigilante && ((currentWeapon player) in oev_taserWeapons) && (player getVariable ["nonLethals",false])']);
	};
};

if ((getPlayerUID player isEqualTo "") || (call oev_developerlevel) >= 3) then {
	life_actions pushBack (_obj_main addAction["<t color='#00FF00'>关闭爆闪</t>",{player setVariable ["superTaze",false,true];},"",1.5,false,false,"",'player getVariable ["superTaze",false]']);
	life_actions pushBack (_obj_main addAction["<t color='#FF0000'>开启爆闪</t>",{player setVariable ["superTaze",true,true];},"",1.5,false,false,"",'player getVariable ["superTaze",false]']);
};
