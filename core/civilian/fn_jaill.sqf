//  File: fn_jaill.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Starts the initial process of jailing.
params [
	["_unit",objNull,[objNull]],
	["_bad",false,[false]]
];
if (isNull _unit) exitWith {}; //Dafuq?
if (_unit != player) exitWith {}; //Dafuq?

player setVariable ["restrained",false,true];
player setVariable ["zipTied",false,true];
player setVariable ["blindfolded",false,true];
player setVariable ["Escorting",false,true];
player setVariable ["transporting",false,true];

titleText [localize "STR_Jail_Warn","PLAIN DOWN"];
hint localize "STR_Jail_LicenseNOTF";

player setPosASL oev_jailPos1;

if(_bad) then {
	waitUntil {alive player};
	uiSleep 1;
};

//Check to make sure they goto check
if((player distance oev_jailPos2) > 25.8) then {
	player setPosAsl oev_jailPos1;
};

if((oev_is_arrested select 0) isEqualTo 1) exitWith {}; //Dafuq i'm already arrested

oev_is_arrested set[0,1];
[5] call OEC_fnc_ClupdatePartial; // Force a sync for the players arrested state. We only need the first value set
								   // jailSys and jailMe takes care of the rest.

[0] call OEC_fnc_removeLicenses;
if(life_inv_heroinu > 0) then {[false,"heroinu",life_inv_heroinu] call OEC_fnc_handleInv;};
if(life_inv_heroinp > 0) then {[false,"heroinp",life_inv_heroinp] call OEC_fnc_handleInv;};
if(life_inv_coke > 0) then {[false,"cocaine",life_inv_coke] call OEC_fnc_handleInv;};
if(life_inv_cokep > 0) then {[false,"cocainep",life_inv_cokep] call OEC_fnc_handleInv;};
if(life_inv_turtle > 0) then {[false,"turtle",life_inv_turtle] call OEC_fnc_handleInv;};
if(life_inv_cannabis > 0) then {[false,"cannabis",life_inv_cannabis] call OEC_fnc_handleInv;};
if(life_inv_marijuana > 0) then {[false,"marijuana",life_inv_marijuana] call OEC_fnc_handleInv;};
if(life_inv_ephedra > 0) then {[false,"ephedra",life_inv_ephedra] call OEC_fnc_handleInv;};
if(life_inv_phosphorous > 0) then {[false,"phosphorous",life_inv_phosphorous] call OEC_fnc_handleInv;};
if(life_inv_frog > 0) then {[false,"frog",life_inv_frog] call OEC_fnc_handleInv;};
if(life_inv_frogp > 0) then {[false,"frogp",life_inv_frogp] call OEC_fnc_handleInv;};
if(life_inv_methu > 0) then {[false,"methu",life_inv_methu] call OEC_fnc_handleInv;};
if(life_inv_crystalmeth > 0) then {[false,"crystalmeth",life_inv_crystalmeth] call OEC_fnc_handleInv;};
if(life_inv_mashu > 0) then {[false,"mashu",life_inv_mashu] call OEC_fnc_handleInv;};
if(life_inv_moonshine > 0) then {[false,"moonshine",life_inv_moonshine] call OEC_fnc_handleInv;};
if(life_inv_rum > 0) then {[false,"rum",life_inv_rum] call OEC_fnc_handleInv;};
if(life_inv_mmushroom > 0) then {[false,"mmushroom",life_inv_mmushroom] call OEC_fnc_handleInv;};
if(life_inv_mmushroomp > 0) then {[false,"mmushroomp",life_inv_mmushroomp] call OEC_fnc_handleInv;};
if(life_inv_ccocaine > 0) then {[false,"ccocaine",life_inv_ccocaine] call OEC_fnc_handleInv;};

/* remove illegal items */
if(life_inv_lockpick > 0) then {[false,"lockpick",life_inv_lockpick] call OEC_fnc_handleInv;};
if(life_inv_boltcutter > 0) then {[false,"boltcutter",life_inv_boltcutter] call OEC_fnc_handleInv;};
if(life_inv_speedbomb > 0) then {[false,"speedbomb",life_inv_speedbomb] call OEC_fnc_handleInv;};
if(life_inv_blastingcharge > 0) then {[false,"blastingcharge",life_inv_blastingcharge] call OEC_fnc_handleInv;};
if(life_inv_goldbar > 0) then {[false,"goldbar",life_inv_goldbar] call OEC_fnc_handleInv;};
if(life_inv_hackingterminal > 0) then {[false,"hackingterminal",life_inv_hackingterminal] call OEC_fnc_handleInv;};
if(life_inv_takeoverterminal > 0) then {[false,"takeoverterminal",life_inv_takeoverterminal] call OEC_fnc_handleInv;};

if(life_inv_hash > 0) then {[false,"hash",life_inv_hash] call OEC_fnc_handleInv;};
if(life_inv_acid > 0) then {[false,"acid",life_inv_acid] call OEC_fnc_handleInv;};
if(life_inv_mushroomu > 0) then {[false,"mushroomu",life_inv_mushroomu] call OEC_fnc_handleInv;};
if(life_inv_pheroin > 0) then {[false,"pheroin",life_inv_pheroin] call OEC_fnc_handleInv;};
if(life_inv_crack > 0) then {[false,"crack",life_inv_crack] call OEC_fnc_handleInv;};

/* Remove police items */
if(life_inv_spikeStrip > 0) then {[false,"spikeStrip",life_inv_spikeStrip] call OEC_fnc_handleInv;};
if(life_inv_defusekit > 0) then {[false,"defusekit",life_inv_defusekit] call OEC_fnc_handleInv;};

removeAllWeapons player;
{player removeMagazine _x} foreach (magazines player);
player setVariable ["isVigi",false,true];
player setVariable ["vigilanteArrests",0,true];

[[player,_bad],"OES_fnc_jailSys",false,false] spawn OEC_fnc_MP;
[] call OEC_fnc_ClupdateRequest;