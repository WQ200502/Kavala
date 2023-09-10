//[this,['reb_v_1'],'REPAIR_VEH_KNEEL'] call NPC_fnc_civRebelVehicles;
params ["_obj_main","_spawns","_stance"];
if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance,"REBEL"] call OEC_fnc_ambientAnim;
};

_obj_main addAction ["汽车商店",OEC_fnc_vehicleShopMenu,['reb_v',civilian,_spawns,'reb',"Olympus Rebel Vehicles"],1.5,false,false,"",'license_civ_rebel && isNull objectParent player',6];
_obj_main addAction ["战争点车辆商店",OEC_fnc_vehicleShopMenu,['war_v',civilian,_spawns,'reb',"Olympus Warpoint Vehicles"],1.5,false,false,"",'license_civ_rebel && isNull objectParent player',6];
_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
_obj_main addAction ["空中车库",{["Air",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
_obj_main addAction ["帮派车库",{["Car",_this select 3] call OEC_fnc_handleGangVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && ((count oev_gang_data) > 0)',6];
_obj_main addAction ["把载具存入车库",OEC_fnc_storeVehicle,30,1.5,false,false,"",'!oev_garage_store && isNull objectParent player',6];