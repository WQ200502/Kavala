/*
	//hide objects that need to be hidden, then spawn in map objects (decoration ones n junk)
*/
if(oev_mapSetupStarted) exitWith {};
oev_mapSetupStarted = true;

private["_itemCount","_lastUpdatedValue","_progress","_shitObjects"];
life_totalMapObjects = 0;
_itemCount = count (allLocalMapEntities);
_lastUpdatedValue = 0;
_progress = 0;

_shitObjects = ["Headgear_H_Bandanna_sand","Headgear_H_Beret_blk","Headgear_H_Booniehat_mcamo","Headgear_H_Booniehat_oli","Headgear_H_Cap_blk","Headgear_H_Cap_blu","Headgear_H_Cap_grn","Headgear_H_Cap_marshal","Headgear_H_Cap_police","Headgear_H_Cap_red","Headgear_H_Hat_blue","Headgear_H_Hat_brown","Headgear_H_Hat_checker","Headgear_H_Hat_grey","Headgear_H_Hat_tan","Headgear_H_HelmetB_light_desert","Headgear_H_HelmetCrew_I","Headgear_H_HelmetLeaderO_oucamo","Headgear_H_HelmetSpecB","Headgear_H_HelmetSpecO_blk","Headgear_H_MilCap_blue","Headgear_H_MilCap_ocamo","Headgear_H_RacingHelmet_1_blue_F","Headgear_H_RacingHelmet_1_green_F","Headgear_H_RacingHelmet_1_orange_F","Headgear_H_RacingHelmet_1_red_F","Headgear_H_RacingHelmet_1_white_F","Headgear_H_RacingHelmet_3_F","Headgear_H_RacingHelmet_4_F","Headgear_H_ShemagOpen_khk","Headgear_H_ShemagOpen_tan","Headgear_H_Shemag_olive","Headgear_H_StrawHat","Headgear_H_Watchcap_cbr","Vest_V_BandollierB_blk","Vest_V_BandollierB_cbr","Vest_V_PlateCarrier1_blk","Vest_V_PlateCarrierIA2_dgtl","Vest_V_PlateCarrierIAGL_oli","Vest_V_RebreatherB","Vest_V_TacVest_blk_POLICE","Vest_V_TacVest_brn","Vest_V_TacVest_camo","Vest_V_TacVest_khk","Vest_V_TacVest_oli","Weapon_arifle_Katiba_F","Weapon_arifle_MXM_F","Weapon_arifle_MX_F","Weapon_arifle_TRG20_F","Weapon_arifle_TRG21_F","Weapon_hgun_ACPC2_F","Weapon_hgun_P07_F","Weapon_hgun_PDW2000_F","Weapon_hgun_Pistol_heavy_01_F","Weapon_hgun_Pistol_heavy_02_F","Weapon_hgun_Rook40_F","Weapon_launch_Titan_short_F","Weapon_LMG_Mk200_F","Weapon_SMG_01_F","Weapon_SMG_02_F","Weapon_srifle_DMR_01_F","Weapon_srifle_DMR_02_F","Weapon_srifle_DMR_03_F","Weapon_srifle_EBR_F","Weapon_srifle_GM6_F"];

{
	if(!(_x select 4)) then {
		if(_x select 0 in life_decorObjects) then {
			if(!(_x select 0 in _shitObjects)) then {
				if(life_decorationDetailSetting < 100) then {
					if(round(random(99)) <= life_decorationDetailSetting) then {
						_x spawn OEC_fnc_createVehicleLocal;
						life_totalMapObjects = life_totalMapObjects + 1;
					}else{
						oev_lessObjects = oev_lessObjects + 1;
					};
				}else{
					if(life_decorationDetailSetting != 0) then {
						_x spawn OEC_fnc_createVehicleLocal;
						life_totalMapObjects = life_totalMapObjects + 1;
					}else{
						oev_lessObjects = oev_lessObjects + 1;
					};
				};
			};
		}else{
			_x spawn OEC_fnc_createVehicleLocal;
			life_totalMapObjects = life_totalMapObjects + 1;
		};
	};

	_progress = round((_foreachindex/_itemCount) * 100);
	if(_progress != _lastUpdatedValue) then {
		_lastUpdatedValue = _progress;

		if(!BIS_fnc_establishingShot_playing) then {
			0 cutText [format["- - -  Loading Olympus Altis Life map data, please wait  - - -\n%1%2",_lastUpdatedValue,"% Complete"],"BLACK FADED"];
		};
	};
}foreach (allLocalMapEntities);

oev_mapLoaded = true;