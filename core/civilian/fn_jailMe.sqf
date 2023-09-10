//  File: fn_jailMe.sqf
//	Author Bryan "Tonic" Boardwine

//	Description: Once word is received by the server the rest of the jail execution is completed.
private["_bail","_esc","_countDown","_bounty","_lastSync","_trashObjs","_perkTier","_jailTimeChange"];
params [
	["_ret",[],[[]]],
	["_bad",false,[false]]
];

_lastSync = time + 150;
_bounty = (oev_is_arrested select 2);
oev_jailTime = time + (oev_is_arrested select 1);
life_bail_amount = _bounty;
_jailTimeChange = 1;
if(count _ret > 0) then {
	_bounty = ((oev_is_arrested select 2) + (_ret select 3));
	life_bail_amount = _bounty;
	_perkTier = ["civ_jailTime"] call OEC_fnc_fetchStats;
	_jailTimeChange = switch (_perkTier) do {
		case 1: {0.95};
		case 2: {0.90};
		case 3: {0.85};
		default {1};
	};
	oev_jailTime = time + ((_bounty * 0.0024) * _jailTimeChange);
	if((oev_jailTime > (time + 4800)) || (_bounty > 2000000)) then {
		oev_jailTime = time + 4800;
		life_bail_amount = 2000000;
		_bounty = 2000000;
	};
};
if((oev_jailTime < (time + 290)) || _bounty < 62500) then {oev_jailTime = time + 300; _bounty = 62500; life_bail_amount = 62500;};
oev_is_arrested set [0,1];
oev_is_arrested set [1,round(oev_jailTime - time)];
oev_is_arrested set [2,_bounty];
[5] call OEC_fnc_ClupdatePartial;

if (count _ret > 0) then {
	if (((_ret select 3) > 2500) && (((_ret select 3) * 0.2) < (oev_atmcash - 100000))) then {
		_perkTier = ["civ_copKills"] call OEC_fnc_fetchStats;
		private _jailFeeChange = switch (_perkTier) do {
			case 1: {0.95};
			case 2: {0.90};
			case 3: {0.85};
			case 4: {0.80};
			case 5: {0.75};
			default {1};
		};
		oev_atmcash = oev_atmcash - (((_ret select 3) * 0.2) * _jailFeeChange);
		oev_cache_atmcash = oev_cache_atmcash - (((_ret select 3) * 0.2) * _jailFeeChange);
		systemChat format["You were sentenced to pay $%1 and serve %2 minutes in jail.",[((_bounty * 0.2) * _jailFeeChange)] call OEC_fnc_numberText,(round(oev_jailTime - time)/60)];
	};
};
["prison_time",(round(oev_jailTime - time)/60)] spawn OEC_fnc_statArrUp;
if(O_stats_crimes select 0 > 0) then {
	[[getPlayerUID player],"OES_fnc_wantedPardon",false,false] spawn OEC_fnc_MP;
};

//Give them a jail uniform
private _jailUniform = uniform player;
private _jailBackpack = backpack player;
player allowDamage false;
removeUniform player;
removeBackpack player;
player forceAddUniform "U_C_WorkerCoveralls";
player setVariable ["jailed",true,true];
private _dam_obj = player;
_dam_obj setDamage 0;
oev_thirst = 100;
oev_hunger = 100;
life_ses_last_pos = [];
[] call OEC_fnc_hudUpdate;
_esc = false;
_bail = false;

oev_jail_escBuffer = time + 600;
oev_canpay_bail = false;
systemChat "你可以在服刑10分钟后交保。";

if((round(oev_jailTime - time)) >= 900) then {
	private _trashLocations = [
		[16676.1,13610.3,1.80224],
		[16690.5,13595,0.965832],
		[16715.9,13627.1,1.65066],
		[16688.7,13636.2,2.44119]
	];

	_trashObjs = [];
	{
		_obj_main = "Land_GarbageBags_F" createVehicleLocal _x;
		_obj_main setPos _x;
		_obj_main addAction ["搜索垃圾",OEC_fnc_trashJail,'',1.5,false,false,'','!oev_action_inUse && !(_target getVariable "deactivated")',4];
		_obj_main setVariable ["deactivated",false];
		_trashObjs pushBack _obj_main;
	} forEach _trashLocations;
};

while {true} do {
	if((round(oev_jailTime - time)) > 0) then {
		_countDown = [(oev_jailTime - time),"MM:SS"] call BIS_fnc_secondsToString;
		hintSilent parseText format[(localize "STR_Jail_Time")+ "<br/> <t size='2'><t color='#FF0000'>%1</t></t><br/><br/>" +(localize "STR_Jail_Pay")+ " %3<br/>" +(localize "STR_Jail_Price")+ " $%2<br/><br/>你可以在垃圾堆里搜查监狱违禁品，然后转入监狱里的监狱看守。<br/><br/>发现违禁品: %4",_countDown,[life_bail_amount] call OEC_fnc_numberText,if(isNil "oev_canpay_bail") then {"Yes"} else {"No"},profileNamespace getVariable ["contraband",0]];
	};

	if !(oev_holdJailTime) then {
		oev_is_arrested set[1,round(oev_jailTime - time)];
	};
	oev_is_arrested set[2,(round(oev_jailTime - time)/0.0048)];

	if ((round(time) > round(_lastSync)) && !(oev_holdJailTime)) then {
		_lastSync = time + 150;
		[5] call OEC_fnc_ClupdatePartial;
		life_bail_amount = (round(oev_jailTime - time)/0.0048);
	};

	if(time > oev_jail_escBuffer) then {
		oev_canpay_bail = nil;
	} else {
		oev_canpay_bail = false;
	};

	if(secondaryWeapon player != "" || primaryWeapon player != "" || handgunWeapon player != "") then {
		removeAllWeapons player;
	};

	if(vehicle player != player) exitWith {
		_dam_obj setDamage 1;
	};

	if((jailwall getVariable["safe_open",false]) && (time > oev_jail_escBuffer) && (player distance oev_jailPos2) > 25.8) exitWith {
		_esc = true;
	};

	if !(isForcedWalk player) then {
		player forceWalk true;
	};

	if(((player distance oev_jailPos2) > 27)) then	{
		player setPosAsl oev_jailPos1;

		if(jailwall getVariable["safe_open",false]) then {
			systemChat "你必须在逃跑前至少服刑10分钟！";
		} else {
			systemChat "傻逼，就你这逼样还想跑?";
		};
	};

	if(oev_bail_paid) exitWith {
		_bail = true;
	};

	if((round(oev_jailTime - time)) < 1) exitWith {hint ""};
	if(!alive player && ((round(oev_jailTime - time)) > 0)) exitWith {};
	uiSleep 1;
};

player forceWalk false;
if (alive player) then {
	profileNamespace setVariable ["contraband",0];
};
switch (true) do {
	case (_bail) : {
		oev_is_arrested = [0,0,0];
		oev_bail_paid = false;
		hint localize "STR_Jail_Paid";
		serv_wanted_remove = [player];
		player setPos (getMarkerPos "jail_release");
		player allowDamage true;
		[[getPlayerUID player],"OES_fnc_wantedRemove",false,false] spawn OEC_fnc_MP;
		[5] call OEC_fnc_ClupdatePartial;
		if !(_jailUniform in oev_illegal_gear) then {
			removeUniform player;
			player forceAddUniform _jailUniform;
		};
		player addBackpack _jailBackpack;
		player setVariable ["jailed",false,true];
	};

	case (_esc) : {
		oev_is_arrested = [0,0,0];
		hint localize "STR_Jail_EscapeSelf";
		player allowDamage true;
		[[0,"STR_Jail_EscapeNOTF",true,[profileName]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;
		[[getPlayerUID player,profileName,"3",player],"OES_fnc_wantedAdd",false,false] spawn OEC_fnc_MP;
		[5] call OEC_fnc_ClupdatePartial;
		player setVariable ["jailed",false,true];
	};


	case (alive player && !_esc && !_bail) : {
		oev_is_arrested = [0,0,0];
		hint localize "STR_Jail_Released";
		[[getPlayerUID player],"OES_fnc_wantedRemove",false,false] spawn OEC_fnc_MP;
		player allowDamage true;
		player setPos (getMarkerPos "jail_release");
		[5] call OEC_fnc_ClupdatePartial;
		if !(_jailUniform in oev_illegal_gear) then {
			removeUniform player;
			player forceAddUniform _jailUniform;
		};
		player addBackpack _jailBackpack;
		player setVariable ["jailed",false,true];
	};
};

if((round(oev_jailTime - time)) >= 900) then {
	{
		deleteVehicle _x;
	} forEach _trashObjs;
};
