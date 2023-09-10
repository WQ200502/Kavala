//  File: fn_blackwaterLootConfig.sqf
//	Description: Config for all the loot 'packages' that can spawn in the crates
//  ["weapon"] call OEC_fnc_blackwaterLootConfig
params [
	["_mode","",[""]]
];

if (_mode isEqualTo "") exitWith {};

private _valOne = 0;
private _valTwo = 0;
private _cops = [west,2] call OEC_fnc_playerCount;
if ((_cops >= 12) && (_cops < 15)) then {_valOne = 0.03; _valTwo = 0.08;};
if (_cops >= 15) then {_valOne = 0.05; _valTwo = 0.10;};
private _goalDis = 0;
if (life_donation_fedLoot) then {_goalDis = 0.20;};

private _weapons = [
	[["srifle_DMR_02_camo_F","10Rnd_338_Mag"],(0.17 + _valTwo + _goalDis)], // Mar-10
	[["launch_RPG7_F","RPG7_F"],(0.08 + _valTwo + _goalDis)], //rpg-7
	[["launch_Titan_F","RPG32_F"],(0.15 + _valTwo)], //RPG32
	[["LMG_03_F","200Rnd_556x45_Box_F"],0.35],//lim lmg
	[["LMG_Mk200_F","200Rnd_65x39_cased_Box"],(0.35 + _valTwo)],//mk200 lmg
	[["arifle_ARX_hex_F","10Rnd_50BW_Mag_F"],(0.12 + _valTwo + _goalDis)],//50 cal ammo type 115
	[["srifle_DMR_04_Tan_F","10Rnd_127x54_Mag"],(0.10 + _valOne)],//asp
	[["LMG_Zafir_F","150Rnd_762x54_Box_Tracer"],(0.07 + _valOne + _goalDis)],//zafir
	[["arifle_MSBS65_UBS_camo_F","6Rnd_12Gauge_Pellets"],(0.10 + _valOne + _goalDis)], // MSBS65 Underbarrel Shotty
	[["arifle_MSBS65_UBS_camo_F","6Rnd_12Gauge_Slug"],(0.10 + _valOne + _goalDis)] // MSBS65 Underbarrel Shotty Slugs
];

private _clothing = [
	[["U_O_CombatUniform_ocamo","U_O_CombatUniform_oucamo","U_O_SpecopsUniform_ocamo"],(0.40 + _valTwo)],
	[["U_O_GhillieSuit"],(0.30 + _valTwo)], //csat shit ghillie
	[["U_O_PilotCoveralls"],(0.50 + _valTwo + _goalDis)],//csat pilot coveralls
	[["U_O_T_FullGhillie_ard"],(0.30 + _valTwo)],//csat ghillie
	[["V_PlateCarrierSpec_rgr"],(0.75 + _goalDis)],//special ga vest, lvl V armor
	[["V_PlateCarrierIA1_dgtl","V_PlateCarrierH_CTRG"],0.75], //t3explosive resist, t4 vest
	[["H_PilotHelmetFighter_O"],0.75],
	[["H_HelmetLeaderO_ghex_F"],(0.25 + _valOne)], //t5 helm
	[["V_HarnessOGL_brn"],(0.12 + _valOne)],//sui vest
	[["NVGogglesB_gry_F"],(0.01 + _valOne + _goalDis)],//thermal nvgog
	[["H_HelmetO_ViperSP_hex_F"],(0.01 + _valOne)] // Special Purpose Helmet
];

private _accessories = [
	[["acc_pointer_IR","optic_Arco"],0.5], //arco,irlaser
	[["optic_Arco_blk_F"],0.5],//arcoblk
	[["optic_MRCO"],0.5], //mrco
	[["optic_Hamr"],0.5],//rco
	[["optic_DMS"],(0.04 + _valTwo + _goalDis)],//dms
	[["muzzle_snds_B"],(0.02 + _valTwo + _goalDis)],//7.62 suppressor
	[["muzzle_snds_H"],(0.05 + _valTwo + _goalDis)],//6.5 suppressor
	[["muzzle_snds_65_TI_blk_F"],(0.05 + _valTwo)],//6.5 stealth sound suppressor
	[["muzzle_snds_58_blk_F"],(0.10 + _valTwo)],//5.8 sound suppressor
	[["muzzle_snds_M"],(0.08 + _valTwo)]//5.56 suppressor
];

private _vehicles = [
	[["B_T_LSV_01_armed_F"],0.28], // Armed Prowler
	[["I_G_Offroad_01_AT_F"],(0.20 + _goalDis)], // AT Offroad
	[["B_Heli_Transport_01_camo_F"],(0.09 + _goalDis)], // Ghosthawk
	[["B_Heli_Transport_03_black_F"],(0.15 + _goalDis)] // Armed Huron
];

private _explosives = [
	[["SLAMDirectionalMine_Wire_Mag"],0.30],//slam mine
	[["DemoCharge_Remote_Mag"],0.40],//explosivecharge
	[["HandGrenade"],0.75],//rgo
	[["MiniGrenade"],0.75],//rgn
	[["APERSTripMine_Wire_Mag"],0.25],
	[["ClaymoreDirectionalMine_Remote_Mag"],0.5]//claymore
];

switch(_mode) do {
	case "weapon":{
		_weapons;
	};

	case "clothing":{
		_clothing;
	};

	case "accessory":{
		_accessories;
	};

	case "vehicle":{
		_vehicles;
	};

	case "explosive":{
		_explosives;
	};
};
