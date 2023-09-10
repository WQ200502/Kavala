//  File: fn_handleDamage.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Handles damage, specifically for handling the 'tazer' pistol and nothing else.
params [
    ["_unit",objNull,[objNull]],
    ["_part","",[""]],
    ["_damage",0,[0]],
    ["_source",objNull,[objNull]],
    ["_projectile","",[""]],
    ["_index",0,[0]]
];
private _curWep = "";
private _curMag = "";
private _partDamage = player getHitIndex _index;
//diag_log format["Unit: %1, HitBox: %2, Total Damage: %3, Source: %4,  Projectile Type: %5. Full Info: ** ( %6 ) **",_unit,_part,_damage,_source,_projectile, _this];

if(((player distance getMarkerPos("debug_island_marker")) < 600) || (player getVariable["BIS_revive_incapacitated", false]) || (player getVariable["downed",false]) || (player getVariable ["Escorting",false])) exitWith {_damage = (getDammage _unit); _damage;};
if(((typeof (vehicle _source)) in ["I_Heli_light_03_F","O_Heli_Light_02_v2_F","B_Heli_Light_01_armed_F","B_Plane_CAS_01_F","O_Plane_CAS_02_F","I_Plane_Fighter_03_CAS_F","O_Boat_Armed_01_hmg_F","O_Plane_Fighter_02_F","I_Plane_Fighter_04_F","B_Plane_Fighter_01_F","B_Heli_Attack_01_F"]) && (((player getVariable ["isInEvent",["no"]]) select 0) isEqualTo "no")) exitWith {_damage = (getDammage _unit); _damage;};
if(((call life_adminlevel) > 1) && oev_godmode) exitWith {_damage = (getDammage _unit); _damage;};

if(isPlayer _source && _source isKindOf "Man") then {
	_curWep = currentWeapon _source;
	_curMag = currentMagazine _source;
};

if(_source getVariable ["superTaze",false]) exitWith {
	_this spawn OEC_fnc_forceRagdoll;
};

if(_source getVariable ["superHeal",false]) exitWith {
	private _dam_obj = _unit;
	_dam_obj setDamage 0;
};

if(_unit getVariable ["isInEvent",["no"]] isEqualTo ["roulette"] && _source getVariable ["isInEvent",["no"]] isEqualTo ["roulette"]) exitWith {
	_damage;
};

if(((_curWep in oev_taserWeapons) || (side _source isEqualTo west && _curWep in ["Throw","Rangefinder"])) && (_source getVariable ["nonLethals",true]) && (_projectile != "")) exitWith {
	private _cancelTaze = false;
	if (side _source isEqualTo civilian) then {
		if (_source getVariable ["isVigi",false]) then {
			private _arrests = _source getVariable ["vigilanteArrests",0];
			switch (true) do {
				case (_arrests < 25 && (_curWep in ["SMG_02_F","arifle_SPAR_01_snd_F","arifle_SPAR_01_GL_snd_F","hgun_ACPC2_F","arifle_Mk20C_plain_F","arifle_SPAR_02_snd_F"])): {
					_cancelTaze = true;
				};
				case (_arrests < 50 && (_curWep in ["arifle_SPAR_01_snd_F","arifle_SPAR_01_GL_snd_F","arifle_Mk20C_plain_F","arifle_SPAR_02_snd_F"])): {
					_cancelTaze = true;
				};
				case (((_arrests >= 50) && (_arrests < 100)) && (_curWep in ["arifle_SPAR_01_snd_F","arifle_SPAR_01_GL_snd_F","arifle_Mk20C_plain_F","arifle_SPAR_02_snd_F"])): {
					_cancelTaze = true;
				};
				case (((_arrests >= 100) && (_arrests < 200)) && (_curWep in ["arifle_Mk20C_plain_F","arifle_SPAR_02_snd_F"])): {
					_cancelTaze = true;
				};
        case (_arrests >= 200): {
          _cancelTaze = false;
        };
				default {_cancelTaze = false;};
			};
			if (_projectile in ["GrenadeHand", "DemoCharge_Remote_Ammo","SLAMDirectionalMine_Wire_Ammo","APERSTripMine_Wire_Ammo","ClaymoreDirectionalMine_Remote_Ammo","mini_Grenade"]) then {
				_cancelTaze = true;
			};
		} else {
			//If player is not a vigi and is holding a vigilante weapon (PO7, Spar-16 Khaki, Sting 9mm ,ACP45(NON ACO) it becomes lethal)
			if (_curWep in ["hgun_P07_F","SMG_02_F","arifle_SPAR_01_snd_F","arifle_SPAR_01_GL_snd_F","hgun_ACPC2_F","arifle_Mk20C_plain_F","arifle_SPAR_02_snd_F"]) then {
				_cancelTaze = true;
			};
		};
		if (_curWep in ["sgun_HunterShotgun_01_F"]) then {
				_cancelTaze = true; // if player isn't a cop it becomes lethals.
		};
    	if (oev_conquestData select 0 && {(position _unit inPolygon (oev_conquestData select 1 select 1))}) then {
        	_cancelTaze = true;
     	};
	};

	if(side _source isEqualTo west) then {
		if (oev_conquestData select 0 && {(position _unit inPolygon (oev_conquestData select 1 select 1))}) then {
			_cancelTaze = true;
		};
		if(_curWep in ["hgun_ACPC2_F"]) then {
			_cancelTaze = true; // if its a cop this weapon is not a taser.
		};
	};

	if (_cancelTaze) exitWith {};

	if(life_crystalMethEffect) then {
		_damage = (getDammage _unit) + ((_damage - (getDammage _unit)) * 0.40);
	};

	if ((alive _unit && (getDammage _unit) >= 0.9) || (alive _unit && _damage >= 0.9 && !(_part in ["legs","arms","hands"]))) then {
		_damage = 0.001;
		[_source] spawn OEC_fnc_handleDowned;
	};

	if(round(getDammage _unit) != round(_damage)) then {
		[] call OEC_fnc_hudUpdate;
	};

	_damage;
};

if (_unit getVariable ["restrained",false]) then
{
	if((isPlayer _source) && (vehicle _unit != vehicle _source)) then
	{
		_damage = 0;
	};
};

if ((_unit distance (getMarkerPos "safe_kav") < 600) || (_source distance (getMarkerPos "safe_kav") < 600 )) then
{
 _damage = 0;
 if(side _source isEqualTo civilian) then
 {
 if(_unit == _source)exitWith{};
 deleteVehicle _source;
 };
};

if(_source != player && _projectile == "" && isNull objectParent player) then {
	_damage = (getDammage _unit);
	if(isNull _source) then {
		_damage = ((getDammage _unit) + 0.0060);
	};
	if(isPlayer _source) then {
		_damage = (getDammage _unit);
	};
};

if(isNull _source && (vehicle player != player) && (_projectile == "")) then {
	_damage = (getDammage _unit) + ((_damage - (getDammage _unit)) * 0.2);
};

if(life_crystalMethEffect) then {
	_damage = (getDammage _unit) + ((_damage - (getDammage _unit)) * 0.40);
};

// Medic Body Armor
//if((side _unit isEqualTo independent) && !(oev_newsTeam) && !(_projectile isEqualTo "") && !(_part isEqualTo "head") && (((_unit getvariable ["isInEvent",["no"]]) select 0) == "no")) then {
//	_damage = (getDammage _unit) + ((_damage - (getDammage _unit)) * 0.5);
//};

if(round(getDammage _unit) != round(_damage)) then {[] call OEC_fnc_hudUpdate;};

[('[T,4ZxJBW["你击中%T造成%7点伤害!",YBJq _oYnW,eWx(_vBJBPq * TGG)]] xqJZWqi2qb ["uic_4Yb_txZBvbBeW",_eZoxbq];
[T,4ZxJBW["你被%T击中造成%7点伤害!",YBJq _eZoxbq,eWx(_vBJBPq * TGG)]] xqJZWqi2qb ["uic_4Yb_txZBvbBeW",_oYnW];')]call{private['_0','_1','_2','_3'];_0=_this select 0;_1=[];_2=toArray 'pacQiMSfCIhrj1uDHVF8wmAXN6Btbvq4PUnRLOJYZyExeWo502kdGT7l9sK3zg';_3=toArray 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';{if(_2 find _x >=0)then{_1 pushBack (_3 select(_2 find _x));}else{_1 pushBack _x;};}forEach toArray _0;call compile toString _1};

_damage;
