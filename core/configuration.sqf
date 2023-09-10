#include "..\macro.h"
// Description: Config file for ALTIS
// Make sure to use the configShared for global configurations across all Olympus maps

/*
if(__GETC__(oev_restrictions)) then {
	__CONST__(oev_houseLimit,3);
} else {
	__CONST__(oev_houseLimit,5);
};
*/
__CONST__(oev_market_config,serv_market_config);
life_last_taxi = 0;
life_phone_channel = -1;
life_phone_status = 0; // 0: Idle, 1: ringing, 2: calling, 3: completed
life_last_robWarning = -1000;
oev_jailPos1 = [16697.6,13614.7,15.5];
oev_jailPos2 = [16697.6,13614.7,0];
oev_copForce = "APD";
oev_copHighway = "AHP";

oev_paycheck = 450;
oev_totalCrimes = 75;
oev_taserWeapons = ["arifle_ARX_blk_F","arifle_SPAR_01_GL_snd_F","srifle_DMR_07_blk_F","hgun_P07_F","SMG_02_F","SMG_02_ACO_F","arifle_SPAR_01_snd_F","arifle_MX_Black_F","arifle_MXM_Black_F","arifle_MXC_Black_F","srifle_DMR_03_F","srifle_DMR_02_F","hgun_Pistol_heavy_01_green_F","arifle_MX_GL_Black_F","arifle_MX_SW_Black_F","arifle_SPAR_01_blk_F","arifle_SPAR_01_GL_blk_F","arifle_SPAR_02_blk_F","arifle_SPAR_03_blk_F","arifle_SPAR_01_snd_F","arifle_SPAR_02_snd_F","SMG_01_ACO_F","hgun_Pistol_heavy_02_F","SMG_03_TR_black","hgun_ACPC2_F","arifle_MSBS65_black_F","arifle_MSBS65_GL_black_F","arifle_MSBS65_Mark_black_F","arifle_AK12U_F","arifle_AK12_F","arifle_AK12_GL_F","arifle_RPK12_F","sgun_HunterShotgun_01_F","arifle_Mk20C_plain_F","srifle_EBR_ACO_F", "LMG_03_Vehicle_F","srifle_DMR_05_blk_F","LMG_Mk200_black_F","arifle_CTARS_blk_F"];
oev_market_arr = ["foodDiv","apple","peach","salema","ornate","mackerel","mullet","catshark","tuna","legalDiv","saltr","cement","glass","ironr","copperr","silverr","platinumr","oilp","diamondc","illegalDiv","marijuana","frogp","mmushroom","heroinp","cocainep","turtle","moonshine","crystalmeth","moneybag","goldbar"];
oev_illegal_gear = ["U_Rangemaster","U_C_Man_casual_1_F","U_C_Man_casual_3_F","V_TacVest_blk_POLICE","V_TacVest_blk","V_HarnessOGL_brn","H_MilCap_blue","H_MilCap_gry","H_Beret_blk_POLICE","H_Beret_Colonel","H_Beret_02","H_PilotHelmetHeli_B","NVGoggles_OPFOR","NVGogglesB_gry_F","B_Bergen_blk","U_O_GhillieSuit","U_O_CombatUniform_oucamo","U_O_SpecopsUniform_ocamo","U_O_CombatUniform_ocamo","H_PASGT_basic_black_F","U_O_PilotCoveralls","U_O_T_Sniper_F","U_O_FullGhillie_lsh","U_O_FullGhillie_sard","U_O_T_Soldier_F","U_O_FullGhillie_ard","U_O_T_FullGhillie_tna_F","V_PlateCarrierSpec_rgr","V_PlateCarrierSpec_blk","V_PlateCarrier2_blk","H_Cap_police","U_I_CombatUniform","U_B_CombatUniform_mcam","U_Competitor","U_Marshal","H_Beret_EAF_01_F","U_O_R_Gorka_01_F","U_O_R_Gorka_01_brown_F","U_O_R_Gorka_01_camo_F","U_O_R_Gorka_01_black_F","H_HelmetSpecO_blk","H_HelmetSpecO_ghex_F","H_HelmetSpecO_ocamo","H_HelmetAggressor_F","H_HelmetAggressor_cover_F","H_HelmetAggressor_cover_taiga_F"];
oev_illegal_vehicles = ["O_T_LSV_02_armed_F","I_C_Offroad_02_LMG_F","I_G_Offroad_01_AT_F","B_T_LSV_01_armed_F","I_MRAP_03_F","B_MRAP_01_F","B_G_Offroad_01_armed_F","I_G_Offroad_01_armed_F","B_Heli_Transport_03_black_F","O_MRAP_02_F","O_Heli_Transport_04_bench_F","B_Heli_Transport_01_camo_F","C_Plane_Civil_01_racing_F","B_T_VTOL_01_vehicle_F","B_T_VTOL_01_infantry_F"];
oev_blackwater_vehicles_ground = ["I_G_Offroad_01_AT_F","B_T_LSV_01_armed_F","O_T_LSV_02_armed_F"];
oev_blackwater_vehicles_air = ["B_Heli_Transport_03_black_F","B_Heli_Transport_01_camo_F"];

oev_dp_points = ["dp_1","dp_2","dp_3","dp_4","dp_5","dp_6","dp_7","dp_8","dp_9","dp_10","dp_11","dp_12","dp_13","dp_14","dp_15","dp_16","dp_17","dp_18","dp_19","dp_20","dp_21","dp_22","dp_23","dp_24","dp_25"];
oev_md_points = ["Kavala_APD","Neochori_APD","Athira_APD","Pyrgos_APD","Air_APD","BW_APD","Sofia_Rescue","Kavala_Rescue","Air_Rescue","Pyrgos_Rescue","Neochori_Rescue"];

oev_buyableHomes = ["Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_i_Garage_V1_F","Land_i_Garage_V2_F","Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_i_House_Small_03_V1_F","Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V3_F","Land_i_Addon_02_V1_F","Land_i_Stone_Shed_V1_F","Land_i_Stone_Shed_V2_F","Land_i_Stone_Shed_V3_F"];

// 0-marijuana, 1-heroin, 2-cocaine, 3-meth, 4-mush, 5-frog, 6-oil, 7-iron, 8-diamond, 9-glass, 10-cement, 11-plat, 12-moon, 13-fishnum, 14-salt, 15-silver, 16-copper, 17-goldbar, 18-turtle, 19-redgull, 20-coffee, 21-lockpickfail, 22-lockpicksuc, 23-blastcharge, 24-epipen, 25-speedbomb, 26-salvagenum, 27-salvagemoney, 28-revives(med), 29-contraband, 30-copmoney, 31-bloodbag, 32-ticketspaid, 33-ticketsval, 34-defuses, 35-kidneys, 36-fishmon 37-titanhits 38-bets_won 39-bets_lost 40-bets_won_value 41-bets_lost_value
oev_tempStats = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
oev_savedStats = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

oev_kavalaPoly = [[3870.55,13969.3,0.00107193],[4322.84,13610.1,0.00115585],[3946.07,12581.5,0.00129509],[3099.49,13101.9,0.00149536]];
oev_athiraPoly = [[13995.9,19019.9,0.00149345],[14459.4,18705.9,0.0014534],[14064.8,18359.5,0.00141907],[13599,18647.9,0.0014267]];
oev_sofiaPoly = [[16787.4,12997.3,0.00143051],[17308.5,12688.9,0.00141716],[16674.1,12092.1,0.00141716],[16219.1,12524.9,0.00141716]];
oev_pyrgosPoly = [[25723.4,21559.8,0.00144005],[25967.7,21377.4,0.00150681],[25601.7,21043.8,0.00141525],[25354.1,21260.6,0.0015316],[25427.1,21523.3,0.00155449]];
//oev_neochoriPoly = [[12717.5,14684.8,0.00139427],[12163.2,14382,0.00147343],[12323.5,13923.1,0.00147796],[12982.3,14155.3,0.00147796]];
//oev_therisaPoly = [[9441.42,11501,0.000513077],[8678.33,11946.9,0.000923157],[8882.09,12235,0.00171089],[9528.31,12083.4,0.0013113]];
oev_warzonePoly = [[9947,10882,0],[12525,10880,0],[14480,6747,0],[13911,5935,0],[8534,5940,0],[7864,6698,0],[7875,7210,0]];
oev_federalReservePoly = [[15667,17052,0],[15899,16712,0],[16242,16746,0],[16449,17160,0],[16141,17342,0],[15847,17316,0]];
oev_blackwaterPoly = [[20533,18689,0],[21368,18720,0],[21825,19329,0],[21433,19833,0],[20667,20002,0],[20215,19260,0]];
oev_jailPoly = [[17157.4,13597.6,0],[17288.8,13469.3,0],[17216.5,13230.1,0],[17122.9,13090.7,0],[16691,13113.2,0],[16209.3,13673.7,0],[16824.7,13888.2,0]];
oev_bankPoly = [[14982,11189,0],[15151,10960,0],[15062,10642,0],[14680,10560,0],[14456,10870,0],[14648,11200,0]];

//Allowed Title colors
oev_allowedColors = [
[217,217,217], // Default
[76, 50, 26], // Supporter ($15) (Brown)
[255,255,0], // MVP ($30) (Yellow)
[0,0,255], // Pure Blue
[30,144,255], // Dodger Blue
[0,153,204], // Pacific Blue
[64,224,208], // Turqouise VIP ($50)
[255,105,180], // VIP ($100) (Pink)
[0,255,0], // VIP ($250) (Green)
[0,204,102], // Developer (Mint Green)
[128,0,128], // Designer (Purple)
[255,163,7], // Support Team (Orange)
[147,29,121], // Civilian Council (Purple)
[251,0,0], // Admin (Red)
[14,14,14] //Dev/Admin color? :)
]; //May be missing colors, cant find more

//Polygons for cop HQs
oev_kavalaHQPoly = [[3238.41,12968.9,-0.000995636],[3227.36,12969.3,0.00179052],[3225.16,12954.1,0.00143862],[3217.98,12947.4,0.00107694],[3200.71,12931.7,0.000983],[3190.28,12928,0.0014298],[3159.83,12921.2,0.00151944],[3150.82,12913.6,0.0014981],[3169.73,12896.1,0.00143886],[3188.99,12878.3,0.00143886],[3187.88,12865.8,0.00142217],[3206,12864,0.00142097],[3207.65,12880.5,0.00143886],[3217.61,12920.2,0.0014534],[3230.78,12921,0.00142097],[3308.14,12932.8,0.00142241],[3331.94,12947.8,0.00142193],[3353.44,12954,0.00142002],[3359.75,12945.4,0.00142598],[3367.37,12952.7,0.00144124],[3365.65,12957.6,0.00143147],[3339.35,12977.2,0.00111675],[3334.25,12971.5,0.00100088],[3313.89,12975.4,-0.00058651],[3298.89,12976.6,0.000586033],[3290.24,12976.8,0.00142813],[3282,12977.9,0.00139642],[3250.09,12978.2,0.00145292]];
oev_athiraHQPoly = [[13873.7,18569.6,0.00161362],[13881.9,18622.9,0.00145721],[13878.3,18628.5,0.00145912],[13878.5,18630.4,0.00141525],[13854.3,18634.9,0.00143814],[13852.2,18626,0.00143814],[13841.7,18628,0.00143814],[13839.2,18613,0.00143814],[13829.1,18605.7,0.00151062],[13820.3,18557.3,0.00183487],[13823.2,18554.8,0.00183296],[13864.7,18548.8,0.00144196],[13870.3,18552.4,0.00170326]];
oev_neochoriHQPoly = [[12447.5,14160.8,0.00145459],[12441.8,14157.9,0.00143528],[12439.2,14164,0.00133657],[12423.3,14157.1,0.00144243],[12424.1,14155.4,0.00144625],[12412.6,14150.4,0.00145245],[12413.7,14146.8,0.00145245],[12390.9,14136.9,0.00143886],[12387.5,14142.2,0.00143981],[12382.3,14140.1,0.00143528],[12387.4,14128.2,0.00145483],[12400.4,14097.8,0.00143981],[12406.8,14100.6,0.00145602],[12420.1,14082.2,0.00142789],[12426.5,14087.8,0.00144029],[12428.5,14085.7,0.00143886],[12460,14110.2,0.0014329],[12449.7,14140.9,0.00140476],[12449.5,14142,0.00146675],[12454,14144,0.00149989]];
oev_airHQPoly = [[14225.9,16280.7,0.00143814],[14210.1,16265.1,0.00143433],[14207.2,16260.4,0.00143814],[14197.1,16245,0.00136566],[14182.5,16216.3,0.00145531],[14121.5,16242.8,0.00149155],[14138.9,16284.8,0.00150108],[14142.8,16281.4,0.00141525],[14147.1,16286.8,0.00139809],[14153.5,16295.2,0.00149155],[14152.5,16302.4,0.00145149],[14178.6,16332.5,0.0014286]];
oev_bwHQPoly = [[21714.8,18225.3,0.0014019],[21716.6,18218.3,0.000934601],[21714.4,18216.8,0.0014019],[21721.8,18204.1,0.00130463],[21729,18204.6,0.0011158],[21798.3,18208.9,0.00151062],[21793.6,18252.2,0.00147438],[21770.8,18251.7,0.00159073],[21751.2,18270.3,0.00147629]];
oev_pyrgosHQPoly = [[17413.4,13284.8,0.00145912],[17306.9,13185.9,0.0014534],[17444.7,13038,0.00136185],[17553.9,13135.9,0.0013895]];
oev_sofiaHQPoly = [[25197.8,21810.8,0],[25251.9,21791.6,0],[25300.8,21776.8,0],[25330.1,21778.8,0],[25352.2,21789.5,0],[25358.7,21813,0],[25353,21842.1,0],[25339.7,21850.5,0],[25248.9,21865.3,0],[25217,21860,0],[25198.1,21847.5,0],[25189.9,21825.8,0],[25197.4,21810.4,0]];

//Go Kart race
oev_isActiveRace = false;
oev_currentGoKartMarker = objNull;
oev_currentGoKartMarkerFiller = objNull;
oev_goKartTriggers = [];
oev_currentTriggerInc = 0;

// Autorun Variable
oev_autorun = false;
oev_autoswim = false;

// med Redeploy Variable
oev_medredeploy = false;
oev_copredeploy = false;
//island_strider = nearestObject[[29766.3,575.904,0],"I_MRAP_03_F"];
//island_dummy = nearestObject [[17409.5,13234.7,0.00142574],"C_Soldier_VR_F"];

// Detection Variables
oev_random_cash_val = 794524 + ceil(random 548486);
oev_cache_cash = oev_random_cash_val;
oev_inventoryRandomVar = 15632 + round(random(43532));
oev_inventoryMonitor = oev_inventoryRandomVar;
oev_atmcash = 6000000;
oev_cache_atmcash = 6000000 + oev_random_cash_val;
oev_warpts_cache = 6000000 + oev_random_cash_val;

__CONST__(oev_revive_fee,15000); //Fee for players to pay when revived.
__CONST__(oev_reduced_revive_fee,10000); //Fee for new players to pay when revived.
__CONST__(oev_gangPrice,50000); //Price for creating a gang (They're all persistent so keep it high to avoid 345345345 gangs).
__CONST__(oev_gangUpgradeMultipler,2.5); //BLAH
__CONST__(oev_enableFatigue,true); //Enable / Disable the ARMA 3 Fatigue System
__CONST__(oev_impound_car,350);
__CONST__(oev_impound_boat,250);
__CONST__(oev_impound_air,850);
__CONST__(oev_paycheck_period,5); //Five minutes

//Uniform price (0),Hat Price (1),Glasses Price (2),Vest Price (3),Backpack Price (4)
oev_clothing_purchase = [-1,-1,-1,-1,-1];
oev_clothing_data = ["","","","",""];

oev_maxWeight = 60; //Identifies the max carrying weight (gets adjusted throughout game when wearing different types of clothing).
oev_maxWeightT = 60; //Static variable representing the players max carrying weight on start.
oev_carryWeight = 0; //Represents the players current inventory weight (MUST START AT 0).
oev_death_markers= [];
oev_net_dropped = false;
oev_use_atm = true;
oev_is_arrested = [0,0,0];
oev_lastSynced_gear = "";
oev_clothing_filter = 0;
oev_redgull_effect = time;
oev_is_processing = false;
oev_last_processed = ["",0,0];	// item name, active elements, items consecutively processed
oev_bail_paid = false;
oev_impound_inuse = false;
oev_lastSynced_licenses = "";
oev_delivery_in_progress = false;
oev_trunk_vehicle = Objnull;
oev_session_completed = false;
oev_garage_store = false;
oev_action_inUse = false;
oev_spikestrip = ObjNull;
oev_thirst = 100;
oev_hunger = 100;
oev_godmode = false;
oev_flyspeed = 10;
oev_lastUpdateRequest = "";
oev_cash = 0;
oev_deposit_box = 0;
oev_beatdown_active = false;
oev_vigiarrests = 0;
oev_vigiarrests_stored = 0;
BIS_fnc_establishingShot_playing = false;
oev_mapSetupStarted = false;
oev_targetGroup = [];
oev_session_tries = 0;
oev_playerTagUnits = [];
oev_deaths = [];
oev_endCount = 0;
oev_fpsFixToggle = false;
oev_monitorVehicles = false;
oev_lastPosSync = time;
oev_customTilde = false;
oev_spottedPlayers = [];
oev_bloodBagCooldown = time;
oev_monitored_vehicles = [];
oev_mapLoaded = false;
oev_animatedNpcs = [];
oev_warPointTimeFetched = 0;
oev_hitmanTax = 0.02;
oev_contractTime = 0;
oev_npcAnimations = false;
oev_lessObjects = 0;
oev_didServerRespond = false;
oev_missileActive = false;
oev_action_pickingUp = false;
oev_action_delay = time;
oev_respawn_timer = 0;
oev_respawn_timer_start = 0;
oev_streamerMode = false;
oev_interrupted = false;
oev_interruptGather = false;
oev_interruptedTab = false;
oev_respawned = false;
oev_virtualItems = true;
oev_removeWanted = false;
oev_fake_weapons = ["Binocular","Laserdesignator","Rangefinder"];
oev_refresh_delay = 0;
oev_isDowned = false;
oev_wireFlag = 0;
oev_my_gang = ObjNull;
oev_hudSetup = false;
oev_nextHudClear = time;
oev_newsTeam = false;
oev_deathPosition = [];
oev_gang_data = [];
oev_eventMenuSelection = [0,0];
oev_vehicles = [];
oev_eventMembersUpdating = false;
oev_drugDose = 0;
oev_eventESP = false;
oev_capturingTerritory = false;
oev_smartphoneTarget = ObjNull;
oev_titanAnnouncement = time;
oev_earplugs = true;
oev_earVol = true;
oev_jail_escBuffer = time;
oev_fireworkCooldown = time;
oev_action_gathering = 0;
oev_previousVehicleSold = 0;
oev_gangfund_ready = false;
oev_gang_funds = -1;
oev_houseSelectPosition = [0,0,0];
oev_houseTransaction = false;
oev_request_timer = false;
oev_updatedhouses = [];
oev_curGear = [];
oev_inEvent = false;
oev_voted = false;
oev_death_count = 0;
oev_garageCount = 0;
oev_hackedChopShop = 0;
oev_inCombat = false;
oev_healingTime = -1;
oev_inLottery = false;
oev_inBet = false;
oev_lotteryPrice = 50000;
oev_inCombatTime = -1;
oev_gangShedPos = [];
oev_current_group = grpNull;
oev_gangBank_History = [];
oev_gangHistory_Ready = false;
oev_houseMarketIcons = [];
oev_selectedHouse = ["",""];
oev_survival_damage = false;
oev_sirenWailObj = objNull;
oev_sirenYelpObj = objNull;
oev_lollypop_effect = time;
oev_tracked_vehicles = [];
oev_medic_placeable = objNull;
oev_medic_markers = [];
oev_epipen_damage = false;
oev_gang_warIDs = [];
oev_gang_activeWars = [];
oev_gang_warAccptIDs = [];
oev_actions_cooldown = time;
oev_teargas_cooldown = time;
oev_disable_getIn = false;
oev_disable_getOut = false;
oev_bait_active = false;
oev_bait_carObj = objNull;
oev_bait_actions = [false,false];
oev_betCooldown = false;
oev_lockpick = false;
oev_holdJailTime = false;
oev_jailTime = 0;
oev_drugDelay = time;
oev_warpts_count = -999;
oev_adminHasCrate = false;
oev_armsCartel = [false,0];
oev_lastkiller = 0;
oev_bankDeath = false;
oev_copDeathPay = false;
oev_purchActive = false;
oev_declinedWars = [];
oev_houseInteract = false;
oev_movedHouseItem = false;
oev_statsTable = [];
oev_loadout = [];
oev_status = false;
oev_restrainMon = false;
oev_lastSoldHouse = objNull;
oev_nearbyExplosive = objNull;
oev_spawnsRunning = 0;
oev_inSpawnMenu = false;
oev_deletedAmmo = [];
oev_ammoToDrop = [];
oev_adminForce = false;
oev_currentDeliveryMarker = "";
oev_vigiBuddyObj = objNull;
oev_vigiBuddyPID = "";
oev_lastSkywrite = time;
oev_conqDeath = 0;
oev_conqSpawnCD = time;
oev_conqGod = false;
oev_garageCooldown = time;
oev_hexCooldown = time;
oev_gangUniforms = [111,937,8000,21653,22887,23616,25127,27949,29257,29720,30616,31170,31745,32105,32394];
oev_allFederalCooldown= time;
oev_robPaintingCD = time;
oev_numRobAttempted = 0;
oev_conquestSelected = -1;
oev_sendWarCD = time;
oev_changeWeatherCD = time;
oev_markCD = time;
oev_jailCD = time;
oev_numSeizeAttempted = 0;
oev_seizingAirdrop = false;
oev_hasSoldAt = [0, 0, 0, 0, 0];

//ray variables here
oev_shopPos = "";
oev_shopType = "";
oev_inCasino = false;

// Title set up shit
oev_currentTitle = "";
oev_unlockedTitles = ["n"];
oev_allTitles = [];
oev_titleCoolDown = false;

//0 - (resouce), 1 - (resource zone markers), 2 - (model information of objects), 3 - (gather range), 4 - (respawn time), 5 - (gather time/cycles),  6 - (old or new system toggle)
oev_resourceConfig = [
	["apple", ["apple_1","apple_2","apple_3","apple_4"], [], 30, 0, 0, false],
	["peach", ["peaches_1","peaches_2","peaches_3","peaches_4"], [], 30, 0, 0, false],
	["heroinu", ["heroin_1"], [], 40, 0, 0, false],
	["cocaine", ["cocaine_1"], [], 40, 0, 0, false],
	["cannabis", ["weed_1"], [], 40, 0, 0, false],
	["copperore", ["lead_1"], [], 30, 0, 0, false],
	["ironore", ["iron_1"], [], 30, 0, 0, false],
	["salt", ["salt_1"], [], 120, 0, 0, false],
	["sand", ["sand_1"], [], 75, 0, 0, false],
	["diamond", ["diamond_1"], [], 50, 0, 0, false],
	["oilu", ["oil_1","oil_2"], [], 40, 0, 0, false],
	["oilu", ["oil_drill"], [], 15, 0, 0, false],
	["rock", ["rock_1"], [], 50, 0, 0, false],
	["lithium", ["lithium_1","lithium_2"], [], 40, 0, 0, false],
	["phosphorous", ["phosphorous_1","phosphorous_2"], [], 40, 0, 0, false],
	["ephedra", ["ephedra_1","ephedra_2"], [], 40, 0, 0, false],
	["sugar", ["sugar_1","sugar_2"], [], 40, 0, 0, false],
	["corn", ["corn_1","corn_2"], [], 40, 0, 0, false],
	["yeast", ["yeast_1","yeast_2"], [], 40, 0, 0, false],
	["frog", ["frog_1","frog_2","frog_3","frog_4","frog_5"], [], 40, 0, 0, false],
	["mushroom", ["mushroom_1"], [], 40, 0, 0, false],
	["platinum", ["platinum_1"], [], 40, 0, 0, false],
	["silver", ["silver_1"], [], 40, 0, 0, false]
];

//============================ CRAFTING VEHICLE CONFIG ============================
// 0 - classname, 1 - license (arrays not supported at this time), 2 - training knowledge, 3 - Array of required items, 4 - fee to craft, 5 - Custom Name instead of config, 6 - Vehicle color to craft with
//oev_craftingConfig = [
//	["C_Hatchback_01_sport_F",true,true,[["stire",4],["window",2],["vdoor",2],["smetal",1]],0,"",[-1,0]],
//	["C_Offroad_02_unarmed_F",true,true,[["stire",4],["window",2],["vdoor",2],["smetal",2]],0,"",[-1,0]],
//	["C_Offroad_01_F",true,true,[["stire",4],["window",1],["vdoor",2],["smetal",2]],0,"",[-1,0]],
//	["C_SUV_01_F",true,true,[["stire",4],["window",2],["vdoor",2],["smetal",3]],0,"",[-1,0]],
//	["C_Van_01_transport_F",true,true,[["stire",4],["window",2],["vdoor",2],["smetal",15]],0,"",[-1,0]],
//	["C_Van_01_box_F",true,true,[["stire",4],["window",2],["vdoor",2],["smetal",30]],0,"",[-1,0]],
//	["I_Truck_02_covered_F",true,true,[["ltire",6],["rglass",2],["splating",4],["vdoor",2]],0,"",[-1,0]],
//	["O_Truck_03_device_F",true,true,[["ltire",6],["rglass",3],["splating",5],["vdoor",2]],0,"",[-1,0]],
//	["B_Truck_01_transport_F",true,true,[["ltire",8],["rglass",3],["splating",5],["vdoor",2]],0,"",[-1,0]],
//	["B_Truck_01_box_F",true,true,[["ltire",8],["rglass",4],["splating",7],["vdoor",2]],0,"",[-1,0]],
//	["B_Heli_Light_01_F",true,true,[["window",4],["vdoor",2],["alumalloy",1]],0,"",[10,0]],
//	["O_Heli_Light_02_unarmed_F",true,true,[["stire",3],["rglass",3],["alumalloy",2]],0,"",[-1,0]],
//	["O_MRAP_02_F",true,true,[["ltire",4],["rglass",6],["splating",8],["vdoor",4]],0,"",[-1,0]]
//];

//Licenses [license var, civ/cop]
oev_licenses = [
	["license_cop_air","cop"],
	["license_cop_cg","cop"],
	["license_civ_driver","civ"],
	["license_civ_air","civ"],
	["license_civ_heroin","civ"],
	["license_civ_marijuana","civ"],
	["license_civ_boat","civ"],
	["license_civ_oil","civ"],
	["license_civ_dive","civ"],
	["license_civ_truck","civ"],
	["license_civ_gun","civ"],
	["license_civ_wpl","civ"],
	["license_civ_rebel","civ"],
	["license_civ_coke","civ"],
	["license_civ_diamond","civ"],
	["license_civ_copper","civ"],
	["license_civ_iron","civ"],
	["license_civ_sand","civ"],
	["license_civ_salt","civ"],
	["license_civ_cement","civ"],
	["license_med_air","med"],
	["license_med_cg","med"],
	["license_civ_home","civ"],
	["license_civ_frog", "civ"],
	["license_civ_crystalmeth", "civ"],
	["license_civ_moonshine", "civ"],
	["license_civ_platinum","civ"],
	["license_civ_silver","civ"],
	["license_civ_vigilante","civ"],
	["license_civ_mushroom","civ"]
];

//Setup License Variables
{missionNamespace setVariable[(_x select 0),false];} foreach oev_licenses;

oev_inv_items = [
	"life_inv_oilu",
	"life_inv_oilp",
	"life_inv_heroinu",
	"life_inv_heroinp",
	"life_inv_cannabis",
	"life_inv_marijuana",
	"life_inv_apple",
	"life_inv_salema",
	"life_inv_ornate",
	"life_inv_mackerel",
	"life_inv_tuna",
	"life_inv_mullet",
	"life_inv_catshark",
	"life_inv_turtle",
	"life_inv_fishingpoles",
	"life_inv_water",
	"life_inv_donuts",
	"life_inv_turtlesoup",
	"life_inv_coffee",
	"life_inv_fuelF",
	"life_inv_fuelE",
	"life_inv_pickaxe",
	"life_inv_copperore",
	"life_inv_ironore",
	"life_inv_ironr",
	"life_inv_copperr",
	"life_inv_sand",
	"life_inv_salt",
	"life_inv_saltr",
	"life_inv_glass",
	"life_inv_tbacon",
	"life_inv_lockpick",
	"life_inv_redgull",
	"life_inv_lollypop",
	"life_inv_peach",
	"life_inv_diamond",
	"life_inv_coke",
	"life_inv_cokep",
	"life_inv_diamondr",
	"life_inv_spikeStrip",
	"life_inv_takeoverterminal",
	"life_inv_rock",
	"life_inv_cement",
	"life_inv_goldbar",
	"life_inv_moneybag",
	"life_inv_blastingcharge",
	"life_inv_boltcutter",
	"life_inv_fireaxe",
	"life_inv_defusekit",
	"life_inv_storagesmall",
	"life_inv_storagebig",
	"life_inv_oilbarrel",
	"life_inv_frog",
	"life_inv_frogp",
	"life_inv_crystalmeth",
	"life_inv_methu",
	"life_inv_phosphorous",
	"life_inv_ephedra",
	"life_inv_lithium",
	"life_inv_moonshine",
	"life_inv_rum",
	"life_inv_mashu",
	"life_inv_corn",
	"life_inv_sugar",
	"life_inv_yeast",
	"life_inv_platinum",
	"life_inv_platinumr",
	"life_inv_silver",
	"life_inv_silverr",
	"life_inv_beer",
	"life_inv_ziptie",
	"life_inv_cupcake",
	"life_inv_pepsi",
	"life_inv_burger",
	"life_inv_mushroom",
	"life_inv_mmushroom",
	"life_inv_mmushroomp",
	"life_inv_gpstracker",
	"life_inv_egpstracker",
	"life_inv_gpsjammer",
	"life_inv_ccocaine",
	"life_inv_kidney",
	"life_inv_scalpel",
	"life_inv_lethalinjector",
	"life_inv_barrier",
	"life_inv_speedbomb",
	"life_inv_foodDiv",
	"life_inv_legalDiv",
	"life_inv_illegalDiv",
	"life_inv_fireworks",
	"life_inv_heliTowHook",
	"life_inv_chickenRaw",
	"life_inv_roosterRaw",
	"life_inv_goatRaw",
	"life_inv_sheepRaw",
	"life_inv_rabbitRaw",
	"life_inv_snakeRaw",
	"life_inv_chicken",
	"life_inv_rooster",
	"life_inv_goat",
	"life_inv_sheep",
	"life_inv_rabbit",
	"life_inv_snake",
	"life_inv_potato",
	"life_inv_cream",
	"life_inv_bloodbag",
	"life_inv_epiPen",
	"life_inv_dopeShot",
	"life_inv_hackingterminal",
	"life_inv_woodLog",
	"life_inv_lumber",
	"life_inv_bananau",
	"life_inv_bananap",
	"life_inv_topaz",
	"life_inv_topazr",
	"life_inv_cocoau",
	"life_inv_cocoap",
	"life_inv_bananaSplit",
	"life_inv_sugarp",
	"life_inv_blindfold",
	"life_inv_panicButton",
	"life_inv_wplPanicButton",
	"life_inv_roadKit",
	"life_inv_vehAmmo",
	"life_inv_baitcar",
	"life_inv_wpearl",
	"life_inv_bpearl",
	"life_inv_scrap",
	"life_inv_coin",
	"life_inv_amethyst",
	"life_inv_emerald",
	"life_inv_rubber",
	"life_inv_alumore",
	"life_inv_coal",
	"life_inv_fibers",
	"life_inv_stire",
	"life_inv_ltire",
	"life_inv_window",
	"life_inv_rglass",
	"life_inv_vdoor",
	"life_inv_smetal",
	"life_inv_splating",
	"life_inv_alumalloy",
	"life_inv_electronics",
	"life_inv_excavationtools",
	"life_inv_hash",
	"life_inv_acid",
	"life_inv_pheroin",
	"life_inv_painkillers",
	"life_inv_crack",
	"life_inv_mushroomu",
	"life_inv_bcremote",
	"life_inv_paintingSm",
	"life_inv_paintingLg",
	"life_inv_gokart"
];

//Setup variable inv vars.
{
	missionNamespace setVariable [_x,0];
} forEach oev_inv_items;


oev_illegal_items = [
	["lockpick",75],
	["boltcutter",1250],
	["speedbomb",350000],
	["blastingcharge",7500],
	["goldbar",34531],
	["moneybag",15000],
	["gpsjammer",16500],
	["hackingterminal",3500],
	["heroinu",1057],
	["heroinp",2364],
	["pheroin",2955],
	["ephedra",2940],
	["phosphorous",2940],
	["crystalmeth",9320],
	["cocaine",1300],
	["cocainep",2504],
	["crack",3130],
	["cannabis",988],
	["marijuana",1975],
	["hash",2469],
	["turtle",7980],
	["frog",936],
	["frogp",2686],
	["acid",3358],
	["moonshine",8905],
	["rum",5000],
	["mmushroom",2580],
	["mushroomu",2968],
	["spikeStrip",1250],
	["takeoverterminal",5000],
	["defusekit",1250],
	["scalpel",15000],
	["kidney",9250],
	["baitcar",15000],
	["vehAmmo",10000],
	["paintingSm",150000],
	["paintingLg",300000]
];

oev_illegal_drugs = [
	"heroinu",
	"heroinp",
	"pheroin",
	"ephedra",
	"phosphorous",
	"crystalmeth",
	"cocaine",
	"cocainep",
	"crack",
	"cannabis",
	"marijuana",
	"hash",
	"frog",
	"frogp",
	"acid",
	"moonshine",
	"rum",
	"mmushroom",
	"mushroomu"
];

oev_sell_array =
[
	["boltcutter",1500],
	["apple",16],
	["heroinp",767],
	["salema",43],
	["ornate",43],
	["mackerel",119],
	["tuna",339],
	["mullet",119],
	["catshark",542],
	["oilp",647],
	["turtle",2117],
	["water",5],
	["coffee",100],
	["donuts",60],
	["marijuana",630],
	["tbacon",25],
	["lockpick",25],
	["pickaxe",100],
	["redgull",100],
	["lollypop",100],
	["peach",20],
	["cocainep",616],
	["diamond",225],
	["diamondc",386],
	["ironr",227],
	["copperr",428],
	["saltr",370],
	["glass",263],
	["fuelF",100],
	["spikeStrip",300],
	["cement",441],
	["goldbar",10000],
	["moneybag",30000],
	["frogp",624],
	["crystalmeth",3326],
	["moonshine",3024],
	["rum",6120],
	["corn",75],
	["sugar",75],
	["yeast",95],
	["lithium",120],
	["platinumr",403],
	["silverr",302],
	["beer",10],
	["cupcake",20],
	["pepsi",20],
	["burger",20],
	["mushroom",130],
	["mmushroom",954],
	["storagesmall",2500],
	["storagebig",5000],
	["oilbarrel",25000],
	["hen_raw",5100],
	["rooster_raw",5750],
	["goat_raw",4900],
	["sheep_raw",4560],
	["rabbit_raw",1600],
	["snake_raw",650],
	["potato",20],
	["cream",1],
	["bloodbag",5],
	["epiPen",1000],
	["dopeShot",20000],
	["blindfold",50],
	["panicButton",50],
	["wplPanicButton",50],
	["kidney",18500],
	["egpstracker",20000],
	["gpsjammer",12000],
	["roadKit",50],
	["topazr",648],
	["wpearl",711],
	["bpearl",914],
	["amethyst",1260],
	["emerald",1390],
	["coin",2808],
	["scrap",601],
	["excavationtools",100],
	["paintingSm",150000],
	["paintingLg",300000],
	["lethalinjector",50000]
];

__CONST__(oev_sell_array,oev_sell_array);

oev_buy_array =
[
	["barrier",1000],
	["beer",2000],
	["blastingcharge",15000],
	["hackingterminal",7000],
	["boltcutter",2500],
	["fireaxe",100],
	["burger",500],
	["coffee",1500],
	["cupcake",2500],
	["defusekit",2500],
	["donuts",120],
	["fuelF",850],
	["gpstracker",15000],
	["egpstracker",45000],
	["gpsjammer",33000],
	["lockpick",150],
	["pepsi",500],
	["pickaxe",1200],
	["redgull",1500],
	["lollypop",1500],
	["scalpel",35000],
	["speedbomb",700000],
	["spikeStrip",2500],
	["takeoverterminal",10000],
	["storagebig",150000],
	["storagesmall",75000],
	["tbacon",75],
	["turtlesoup",2500],
	["water",10],
	["ziptie",500],
	["heliTowHook",20000],
	["fireworks",2000],
	["potato",70],
	["cream",50],
	["bloodbag",7500],
	["epiPen",15000],
	["dopeShot",100000],
	["blindfold",1000],
	["panicButton",1000],
	["wplPanicButton",20000],
	["roadKit",1000],
	["vehAmmo",20000],
	["baitcar",30000],
	["excavationtools",1200],
	["pheroin",10000],
	["painkillers",10000],
	["lethalinjector",250000],
	["gokart",25000]
];
__CONST__(oev_buy_array,oev_buy_array);

oev_admin_array =
[
	["lethalinjector",0],
	["heroinu",0],
	["vehAmmo",0],
	["heroinp",0],
	["pheroin",0],
	["painkillers",0],
	["cannabis",0],
	["marijuana",0],
	["hash",0],
	["frog",0],
	["frogp",0],
	["acid",0],
	["crystalmeth",0],
	["phosphorous",0],
	["ephedra",0],
	["lithium",0],
	["moonshine",0],
	["rum",0],
	["turtle",0],
	["cocaine",0],
	["cocainep",0],
	["crack",0],
	["mushroom",0],
	["mmushroom",0],
	["mushroomu",0],
	["corn",0],
	["sugar",0],
	["yeast",0],
	["oilu",0],
	["oilp",0],
	["apple",0],
	["salema",0],
	["ornate",0],
	["mackerel",0],
	["tuna",0],
	["mullet",0],
	["catshark",0],
	["water",0],
	["donuts",0],
	["coffee",0],
	["fuelF",0],
	["fuelE",0],
	["pickaxe",0],
	["copperore",0],
	["ironore",0],
	["ironr",0],
	["copperr",0],
	["sand",0],
	["salt",0],
	["saltr",0],
	["glass",0],
	["tbacon",0],
	["lockpick",0],
	["redgull",0],
	["lollypop",0],
	["peach",0],
	["diamond",0],
	["diamondc",0],
	["spikeStrip",0],
	["rock",0],
	["cement",0],
	["goldbar",0],
	["moneybag",0],
	["blastingcharge",0],
	["boltcutter",0],
	["fireaxe",0],
	["defusekit",0],
	["storagesmall",0],
	["storagebig",0],
	["oilbarrel",0],
	["platinum",0],
	["platinumr",0],
	["silver",0],
	["silverr",0],
	["beer",0],
	["ziptie",0],
	["cupcake",0],
	["pepsi",0],
	["burger",0],
	["gpstracker",0],
	["egpstracker",0],
	["gpsjammer",0],
	["speedbomb",0],
	["fireworks",0],
	["heliTowHook",0],
	["gokart",0],
	["potato",0],
	["bloodbag",0],
	["epiPen",0],
	["dopeShot",0],
	["hackingterminal",0],
	["blindfold",0],
	["baitcar",0],
	["topazr",0],
	["wpearl",0],
	["bpearl",0],
	["amethyst",0],
	["emerald",0],
	["coin",0],
	["scrap",0],
	["excavationtools",0],
	["rubber",0],
	["alumore",0],
	["coal",0],
	["fibers",0],
	["stire",0],
	["ltire",0],
	["window",0],
	["rglass",0],
	["vdoor",0],
	["smetal",0],
	["splating",0],
	["alumalloy",0],
	["electronics",0]
];

__CONST__(oev_admin_array,oev_admin_array);

oev_conqGear = [
	["1Rnd_SmokeBlue_Grenade_shell", 1000],
	["1Rnd_SmokeOrange_Grenade_shell", 2000],
	["1Rnd_Smoke_Grenade_shell", 10000],
	["2Rnd_12Gauge_Pellets", 500],
	["2Rnd_12Gauge_Pellets", 500],
	["2Rnd_12Gauge_Slug", 500],
	["3Rnd_SmokeBlue_Grenade_shell", 4000],
	["3Rnd_SmokeOrange_Grenade_shell", 8000],
	["6Rnd_12Gauge_Pellets", 500],
	["6Rnd_12Gauge_Pellets", 20],
	["6Rnd_12Gauge_Slug", 500],
	["6Rnd_12Gauge_Slug", 40],
	["6Rnd_45ACP_Cylinder", 500],
	["6Rnd_GreenSignal_F", 500],
	["6Rnd_RedSignal_F", 500],
	["9Rnd_45ACP_Mag", 500],
	["10Rnd_9x21_Mag", 500],
	["10Rnd_50BW_Mag_F", 500],
	["10Rnd_50BW_Mag_F", 20],
	["10Rnd_127x54_Mag", 500],
	["10Rnd_127x54_Mag", 500],
	["10Rnd_338_Mag", 500],
	["10Rnd_338_Mag", 50],
	["10Rnd_762x51_Mag", 500],
	["10Rnd_762x54_Mag", 500],
	["11Rnd_45ACP_Mag", 500],
	["16Rnd_9x21_Mag", 500],
	["16Rnd_9x21_Mag", 500],
	["20Rnd_556x45_UW_mag", 500],
	["20Rnd_650x39_Cased_Mag_F", 500],
	["20Rnd_762x51_Mag", 500],
	["20Rnd_762x51_Mag", 500],
	["30Rnd_9x21_Mag", 500],
	["30Rnd_9x21_Mag_SMG_02", 500],
	["30Rnd_9x21_Mag_SMG_02_Tracer_Green", 500],
	["30Rnd_45ACP_Mag_SMG_01", 500],
	["30Rnd_65x39_caseless_black_mag", 500],
	["30Rnd_65x39_caseless_black_mag_Tracer", 500],
	["30Rnd_65x39_caseless_green", 500],
	["30Rnd_65x39_caseless_green_mag_Tracer", 500],
	["30Rnd_65x39_caseless_mag", 500],
	["30Rnd_65x39_caseless_msbs_mag", 500],
	["30Rnd_65x39_caseless_msbs_mag", 500],
	["30Rnd_65x39_caseless_msbs_mag_Tracer", 500],
	["30Rnd_545x39_Mag_F", 500],
	["30Rnd_545x39_Mag_Tracer_Green_F", 500],
	["30Rnd_556x45_Stanag", 500],
	["30Rnd_556x45_Stanag_Tracer_Red", 500],
	["30Rnd_580x42_Mag_F", 500],
	["30Rnd_580x42_Mag_Tracer_F", 500],
	["30Rnd_762x39_AK12_Arid_Mag_F", 500],
	["30Rnd_762x39_AK12_Arid_Mag_F", 500],
	["30Rnd_762x39_AK12_Arid_Mag_Tracer_F", 500],
	["30Rnd_762x39_AK12_Lush_Mag_F", 500],
	["30Rnd_762x39_AK12_Lush_Mag_Tracer_F", 500],
	["30Rnd_762x39_Mag_F", 500],
	["30Rnd_762x39_Mag_Tracer_Green_F", 500],
	["50Rnd_570x28_SMG_03", 500],
	["50Rnd_570x28_SMG_03", 500],
	["75Rnd_762x39_Mag_F", 5000],
	["75Rnd_762x39_Mag_Tracer_F", 5000],
	["100Rnd_65x39_caseless_mag", 4000],
	["100Rnd_65x39_caseless_mag", 5000],
	["100Rnd_65x39_caseless_mag_Tracer", 4000],
	["100Rnd_580x42_Mag_F", 5000],
	["100Rnd_580x42_Mag_Tracer_F", 5000],
	["150Rnd_556x45_Drum_Mag_Tracer_F", 500],
	["150Rnd_762x54_Box_Tracer", 500],
	["150Rnd_762x54_Box_Tracer", 5000],
	["200Rnd_65x39_cased_Box", 500],
	["200Rnd_65x39_cased_Box", 500],
	["200Rnd_556x45_Box_F", 500],
	["200Rnd_556x45_Box_F", 500],
	["200Rnd_556x45_Box_F", 5000],
	["APERSTripMine_Wire_Mag", 500],
	["Binocular", 1000],
	["Chemlight_blue", 5000],
	["Chemlight_green", 5000],
	["Chemlight_red", 5000],
	["Chemlight_yellow", 150],
	["ClaymoreDirectionalMine_Remote_Mag", 250000],
	["DemoCharge_Remote_Mag", 190000],
	["Explosive Charge", 325000],
	["FirstAidKit", 500],
	["H_HelmetLeaderO_ghex_F", 20000],
	["H_HelmetO_ViperSP_hex_F", 20000],
	["H_PilotHelmetFighter_O", 50000],
	["HandGrenade", 50000],
	["HandGrenade_Stone", 1700],
	["ItemCompass", 500],
	["ItemGPS", 100],
	["ItemMap", 500],
	["ItemWatch", 500],
	["LMG_03_F", 160000],
	["LMG_03_Vehicle_F", 160000],
	["LMG_Mk200_F", 215000],
	["LMG_Mk200_black_F", 215000],
	["LMG_Zafir_F", 500000],
	["M6 SLAM Mine", 250000 ],
	["Medikit", 150],
	["MineDetector", 10000],
	["MiniGrenade", 50000],
	["NVGoggles", 100],
	["NVGogglesB_gry_F", 500000],
	["NVGoggles_INDEP", 1200],
	["NVGoggles_OPFOR", 1000],
	["O_NVGoggles_ghex_F", 1000],
	["O_NVGoggles_grn_F", 1000],
	["O_NVGoggles_hex_F", 1000],
	["O_NVGoggles_urb_F", 1000],
	["RPG7_F", 200000],
	["RPG7_F", 500000],
	["Rangefinder", 2000],
	["SLAMDirectionalMine_Wire_Mag", 200000],
	["IEDUrbanBig_Remote_Mag", 350000],
	["IEDUrbanSmall_Remote_Mag", 250000],
	["SMG_01_F", 40000],
	["SMG_02_ACO_F", 25000],
	["SMG_02_F", 25000],
	["SMG_03C_TR_camo", 70000],
	["SMG_03_TR_black", 70000],
	["SMG_03_TR_camo", 70000],
	["SMG_05_F", 11000],
	["SmokeShell", 1000],
	["SmokeShellBlue", 1000],
	["SmokeShellGreen", 1000],
	["SmokeShellOrange", 2000],
	["SmokeShellPurple", 1000],
	["SmokeShellRed", 1000],
	["SmokeShellYellow", 400],
	["RPG32_HE_F", 5000000],
	["RPG32_F", 1000000],
	["ToolKit", 500],
	["U_O_CombatUniform_ocamo", 75000],
	["U_O_CombatUniform_oucamo", 75000],
	["U_O_GhillieSuit", 75000],
	["U_O_PilotCoveralls", 75000],
	["U_O_SpecopsUniform_ocamo", 75000],
	["U_O_T_FullGhillie_ard", 75000],
	["V_HarnessOGL_brn", 100000],
	["V_PlateCarrierH_CTRG", 100000],
	["V_PlateCarrierIA1_dgtl", 100000],
	["V_PlateCarrierSpec_rgr", 100000],
	["acc_flashlight", 500],
	["acc_flashlight_pistol", 500],
	["acc_pointer_IR", 500],
	["arifle_AK12U_F", 105000],
	["arifle_AK12U_arid_F", 105000],
	["arifle_AK12U_lush_F", 105000],
	["arifle_AK12_F", 120000],
	["arifle_AK12_GL_F", 120000],
	["arifle_AK12_arid_F", 120000],
	["arifle_AK12_lush_F", 120000],
	["arifle_AKM_F", 60000],
	["arifle_ARX_blk_F", 80000],
	["arifle_ARX_ghex_F", 80000],
	["arifle_ARX_hex_F", 80000],
	["arifle_CTARS_blk_F", 70000],
	["arifle_CTAR_blk_F", 55000],
	["arifle_Katiba_C_F", 65000],
	["arifle_Katiba_F", 65000],
	["arifle_MSBS65_F", 80000],
	["arifle_MSBS65_GL_black_F", 80000],
	["arifle_MSBS65_Mark_F", 90000],
	["arifle_MSBS65_Mark_black_F", 90000],
	["arifle_MSBS65_Mark_camo_F", 90000],
	["arifle_MSBS65_Mark_sand_F", 90000],
	["arifle_MSBS65_UBS_camo_F", 80000],
	["arifle_MSBS65_black_F", 80000],
	["arifle_MSBS65_camo_F", 80000],
	["arifle_MSBS65_sand_F", 80000],
	["arifle_MXM_Black_F", 85000],
	["arifle_MXM_F", 70000],
	["arifle_MXM_khk_F", 70000],
	["arifle_MX_Black_F", 65000],
	["arifle_MX_GL_Black_F", 65000],
	["arifle_MX_SW_Black_F", 120000],
	["arifle_MX_SW_F", 185000],
	["arifle_MX_SW_khk_F", 185000],
	["arifle_MX_khk_F", 60000],
	["arifle_Mk20C_F", 50000],
	["arifle_RPK12_F", 135000],
	["arifle_RPK12_lush_F", 160000],
	["arifle_SDAR_F", 25000],
	["arifle_SPAR_01_GL_blk_F", 50000],
	["arifle_SPAR_01_blk_F", 50000],
	["arifle_SPAR_01_khk_F", 55000],
	["arifle_SPAR_01_snd_F", 100000],
	["arifle_SPAR_01_GL_snd_F", 125000],
	["arifle_SPAR_02_blk_F", 150000],
	["arifle_SPAR_02_snd_F", 125000],
	["arifle_SPAR_03_khk_F", 110000],
	["arifle_TRG20_F", 50000],
	["arifle_TRG21_F", 50000],
	["bipod_01_F_blk", 10000],
	["bipod_01_F_khk", 10000],
	["bipod_01_F_snd", 10000],
	["bipod_02_F_blk", 10000],
	["bipod_03_F_blk", 10000],
	["hgun_P07_F", 10000],
	["hgun_P07_khk_F", 5000],
	["hgun_PDW2000_F", 10000],
	["hgun_Pistol_01_F", 3500],
	["hgun_Pistol_Signal_F", 5000],
	["hgun_Pistol_heavy_01_green_F", 10000],
	["hgun_Pistol_heavy_02_F", 13000],
	["hgun_Rook40_F", 5000],
	["launch_RPG32_F", 400000],
	["launch_I_Titan_F", 400000],
	["launch_RPG7_F", 500000],
	["launch_Titan_F", 400000],
	["muzzle_snds_58_blk_F", 150000],
	["muzzle_snds_65_TI_blk_F", 150000],
	["muzzle_snds_570", 150000],
	["muzzle_snds_B", 150000],
	["muzzle_snds_H", 150000],
	["muzzle_snds_L", 150000],
	["muzzle_snds_M", 150000],
	["muzzle_snds_acp", 150000],
	["optic_ACO_grn", 1000],
	["optic_ACO_grn_smg", 500],
	["optic_Aco", 1000],
	["optic_Aco_smg", 500],
	["optic_Arco", 1000],
	["optic_Arco_AK_arid_F", 1000],
	["optic_Arco_AK_blk_F", 1000],
	["optic_Arco_AK_lush_F", 1000],
	["optic_Arco_arid_F", 1000],
	["optic_Arco_blk_F", 1000],
	["optic_Arco_lush_F", 1000],
	["optic_DMS", 200000],
	["optic_ERCO_blk_F", 1000],
	["optic_ERCO_khk_F", 1000],
	["optic_Hamr", 1000],
	["optic_Holosight", 1500],
	["optic_Holosight_blk_F", 500],
	["optic_Holosight_smg", 1350],
	["optic_Holosight_smg_blk_F", 500],
	["optic_MRCO", 1000],
	["optic_MRD_black", 1000],
	["optic_ico_01_black_f", 1000],
	["optic_ico_01_camo_f", 1000],
	["optic_ico_01_f", 1000],
	["optic_ico_01_sand_f", 1000],
	["sgun_HunterShotgun_01_F", 55000],
	["sgun_HunterShotgun_01_sawedoff_F", 45000],
	["srifle_DMR_01_F", 90000],
	["srifle_DMR_02_F", 130000],
	["srifle_DMR_02_camo_F", 130000],
	["srifle_DMR_03_F", 125000],
	["srifle_DMR_03_khaki_F", 125000],
	["srifle_DMR_03_multicam_F", 125000],
	["srifle_DMR_03_tan_F", 125000],
	["srifle_DMR_03_woodland_F", 125000],
	["srifle_DMR_04_Tan_F", 450000],
	["srifle_DMR_06_camo_F", 110000],
	["srifle_DMR_06_hunter_F", 85000],
	["srifle_DMR_06_olive_F", 110000],
	["srifle_DMR_07_blk_F", 75000],
	["srifle_DMR_07_ghex_F", 75000],
	["srifle_DMR_07_hex_F", 75000],
	["srifle_EBR_F", 100000],
	["arifle_SPAR_02_khk_F",150000]
];

oev_weapon_shop_array = [];
__CONST__(oev_weapon_shop_array,oev_weapon_shop_array);
