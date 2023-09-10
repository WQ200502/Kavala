
//	Description: Master file for various item effects like drugs and what not.
private["_item","_alreadyUsed","_commitTime"];
_item = param [0,"",[""]];
_alreadyUsed = false;
if(_item == "") exitWith {};

private _dam_obj = player;
oev_drugDose = oev_drugDose + (round(random(3)));
if(oev_drugDose >= 20) exitWith {systemChat "你死于吸毒过量。"; _dam_obj setDamage 1;};
enableCamShake true;

switch(true) do {
	case (_item in ["marijuana","hash"]): {

		{if(typeOf _x == "SmokeShell") exitWith {_alreadyUsed = true;};}foreach (attachedObjects (vehicle player));
		if(_alreadyUsed) exitWith {};

		_smoke = "SmokeShell" createVehicle position player;
		if (vehicle player != player) then {
			_smoke attachTo [vehicle player, [0,-1,0]];
		} else {
			_smoke attachTo [player, [0,0,1.2]];
		};

		if(oev_hunger >= 30) then {
			oev_hunger = (oev_hunger / 2);
		} else {
			oev_hunger = 0;
		};
		[] call OEC_fnc_hudUpdate;
		hint "你突然觉得很饿。。。";

		_degradeEffect = 3.2;

		while {_degradeEffect > 0.2} do {
			"colorCorrections" ppEffectEnable true;
			"colorCorrections" ppEffectAdjust [1, 1, 0, [0,0,0,0.0], [random(_degradeEffect),random(_degradeEffect),random(_degradeEffect),random(1)], [random(_degradeEffect),random(_degradeEffect),random(_degradeEffect), random(1)]];
			"colorCorrections" ppEffectCommit 2.5;
			_degradeEffect = _degradeEffect - 0.024;
			uiSleep 2.5;
			if(!alive player) exitWith {};
		};
		"colorCorrections" ppEffectEnable false;
	};

	case (_item in ["heroinp","pheroin","painkillers"]): {
		if(_item isEqualTo "pheroin" || _item isEqualTo "painkillers") then {
			player setHit ["legs", 0];
			titleText["你已经治好了你受伤的腿！","PLAIN DOWN"];
		};
		_ehIndex = player addEventHandler["HandleHeal",{player setVariable["fakked",true]}];
		for "_i" from 0 to 300 do
		{
			"chromAberration" ppEffectEnable true;
			"chromAberration" ppEffectAdjust [random(15) / 24, random(15) / 24, false];
			"chromAberration" ppEffectCommit (0.3 + random 0.1);
			waituntil {ppEffectCommitted "chromAberration"};
			uiSleep 0.02;
			if(player getVariable["fakked",false]) exitWith {player removeEventHandler["HandleHeal",_ehIndex]; player setVariable["fakked",false];};
		};
		"chromAberration" ppEffectEnable false;
	};

	case (_item in ["cocainep","crack"]): {
		player enableFatigue false;
		for "_i" from 0 to 80 do
		{
			"chromAberration" ppEffectEnable true;
			"radialBlur" ppEffectEnable true;
			"chromAberration" ppEffectAdjust [random 0.25,random 0.25,true];
			"chromAberration" ppEffectCommit 2;
			"radialBlur" ppEffectAdjust [(0.025 + (random 0.075)),(0.025 + (random 0.075)),0.15,0.15];
			"radialBlur" ppEffectCommit 2;
			addcamShake[3.5, 5, 3.5];
			uiSleep 2;
			if(!alive player) exitWith {};
		};
		player enableFatigue true;
		resetCamShake;
		"chromAberration" ppEffectEnable false;
		"radialBlur" ppEffectEnable false;
	};

	case (_item == "crystalmeth"): {
		oev_drugDose = oev_drugDose + 3 + (round(random(5)));
		if(oev_drugDose >= 20) exitWith {systemChat "你死于吸毒过量。"; _dam_obj setDamage 1;};
		if(life_crystalMethEffect) exitWith {};
		life_crystalMethEffect = true;
		for "_i" from 0 to 250 do
		{
			_commitTime = (0.4 + random 0.2);
			"chromAberration" ppEffectEnable true;
			"radialBlur" ppEffectEnable true;
			"chromAberration" ppEffectAdjust [random 0.25,random 0.25,true];
			"chromAberration" ppEffectCommit _commitTime;
			"radialBlur" ppEffectAdjust [(0.025 + (random 0.075)),(0.025 + (random 0.075)),0.15,0.15];
			"radialBlur" ppEffectCommit _commitTime;
			"chromAberration" ppEffectAdjust [random(15) / 24, random(15) / 24, false];
			"chromAberration" ppEffectCommit _commitTime;
			addcamShake[2.5, 5, 2.5];
			waituntil {ppEffectCommitted "chromAberration"};
			uiSleep 0.02;
			if(!alive player) exitWith {};
		};
		life_crystalMethEffect = false;
		if(alive player) then {
			_dam_obj setDamage ((getDammage player) * 1.25);
			if(!alive player) then {systemChat "死于吸毒。"};
		};
		resetCamShake;
		"radialBlur" ppEffectEnable false;
		"chromAberration" ppEffectEnable false;
	};


	case (_item in ["mmushroom","mushroomu"]): {
		for "_i" from 0 to 60 do
		{
			"colorCorrections" ppEffectEnable true;
			"filmGrain" ppEffectEnable true;
			4 setFog [(0.2 + random 0.4), 0.022, (20 + random(80))];

			"colorCorrections" ppEffectAdjust [1, 1, random(0.2), [0.0, 0.0, 0.0, 0.0], [(0.5 + random(1.5)), (0.5 + random(1.5)), (0.5 + random(1.5)), (0.8 + random(0.2))], [(1.5 + random(1.5)), (1.5 + random(1.5)), (1.5 + random(1.5)), (0.8 + random(0.2))]];
			"colorCorrections" ppEffectCommit 2;
			uiSleep 2;
			"colorCorrections" ppEffectAdjust [1, 1, random(0.2), [0.0, 0.0, 0.0, 0.0], [(0.5 + random(1.5)), (0.5 + random(1.5)), (0.5 + random(1.5)), (0.8 + random(0.2))], [(1.5 + random(1.5)), (1.5 + random(1.5)), (1.5 + random(1.5)), (0.8 + random(0.2))]];
			"colorCorrections" ppEffectCommit 2;
			"filmGrain" ppEffectAdjust [(0.01 + random 0.075), 1, 2, 0.1, 1, false];
			"filmGrain" ppEffectCommit 4;
			uiSleep 2;
			if(!alive player) exitWith {};
		};
		0.1 setFog [0.0, 0.00, 0];
		"colorCorrections" ppEffectEnable false;
		"filmGrain" ppEffectEnable false;
	};

	case (_item in ["moonshine","rum"]): {
		for "_i" from 0 to 40 do
		{
			"radialBlur" ppEffectEnable true;
			"radialBlur" ppEffectAdjust [(0.025 + (random 0.075)),(0.025 + (random 0.075)),0.15,0.15];
			"radialBlur" ppEffectCommit 4;
			addcamShake[2.5, 8, 2.5];
			uiSleep 4;
			if(!alive player) exitWith {};
		};
		resetCamShake;
		"radialBlur" ppEffectEnable false;
	};

	case (_item == "beer"): {
		for "_i" from 0 to 40 do
		{
			"radialBlur" ppEffectEnable true;
			"radialBlur" ppEffectAdjust [(0.025 + (random 0.075)),(0.025 + (random 0.075)),0.15,0.15];
			"radialBlur" ppEffectCommit 4;
			addcamShake[1.25, 8, 1.25];
			uiSleep 4;
			if(!alive player) exitWith {};
		};
		resetCamShake;
		"radialBlur" ppEffectEnable false;
	};

	case (_item in ["frogp","acid"]): {
		for "_i" from 0 to 60 do
		{
			"colorCorrections" ppEffectEnable true;
			"filmGrain" ppEffectEnable true;
			4 setFog [(0.2 + random 0.4), 0.022, (20 + random(80))];

			"colorCorrections" ppEffectAdjust [1, 1, random(0.2), [0.0, 0.0, 0.0, 0.0], [(0.5 + random(1.5)), (0.5 + random(1.5)), (0.5 + random(1.5)), (0.8 + random(0.2))], [(1.5 + random(1.5)), (1.5 + random(1.5)), (1.5 + random(1.5)), (0.8 + random(0.2))]];
			"colorCorrections" ppEffectCommit 2;
			uiSleep 2;
			"colorCorrections" ppEffectAdjust [1, 1, random(0.2), [0.0, 0.0, 0.0, 0.0], [(0.5 + random(1.5)), (0.5 + random(1.5)), (0.5 + random(1.5)), (0.8 + random(0.2))], [(1.5 + random(1.5)), (1.5 + random(1.5)), (1.5 + random(1.5)), (0.8 + random(0.2))]];
			"colorCorrections" ppEffectCommit 2;
			"filmGrain" ppEffectAdjust [(0.01 + random 0.075), 1, 2, 0.1, 1, false];
			"filmGrain" ppEffectCommit 4;
			uiSleep 2;
			if(!alive player) exitWith {};
		};
		0.1 setFog [0.0, 0.00, 0];
		"colorCorrections" ppEffectEnable false;
		"filmGrain" ppEffectEnable false;
	};

	default {hint "此项无效。";};
};

oev_drugDose = round(oev_drugDose * 0.95);
