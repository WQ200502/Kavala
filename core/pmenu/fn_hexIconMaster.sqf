//author: trimorphious (i know im retarded sorry)
//mode 0: equips the player's hex icon, which will get saved to the databse via hexMasterServ.sqf
//mode 1: updates the UI (preview and name of the icon) when the user clicks on an icon in the list
//mode 2: populates the icon list and enables the icons the user has unlocked so they can equip them and such
//mode 3: does an epic loot box roll for a random hex icon, given the user has a roll available

if(_this select 0 == 4) exitWith {
	player setVariable["hexIconArray",_this select 1];
};
if(_this select 0 == 5) exitWith {
	player setVariable["hexRedemptions",_this select 1];
};

//to give someone a custom icon, add their PID here and give them a case in the switch statement below
_customIDs = ["76561198846869680","76561198846869680","76561198846869680","76561198846869680","76561198846869680","76561198846869680","76561198846869680"];
_name = "";
_desc = "";
_title = "";
if(getPlayerUID player in _customIDs) then {
	if !(player getVariable["customIcons",false]) then {
		_hexArray = player getVariable["hexIconArray",[]];
		_hexArray pushBack 1;
		player setVariable["hexIconArray",_hexArray];
		player setVariable["customIcons",true];
	};
	switch(getPlayerUID player) do {
		case "76561198846869680": {
			_name = "fist";
			_desc = "Power fist. By whitelist only.";
			_title = "Fist";
		};
		case "76561198846869680": {
			_name = "afroman";
			_desc = "M-QFQ088. By whitelist only.";
			_title = "M-QFQ088";
		};
		case "76561198846869680": {
			_name = "mafiaguy";
			_desc = "Mafia guy. By whitelist only.";
			_title = "Mafia Guy";
		};
		case "76561198846869680": {
			_name = "crown";
			_desc = "Crown. By whitelist only.";
			_title = "Crown";
		};
		case "76561198846869680": {
			_name = "yin";
			_desc = "Yin. By whitelist only.";
			_title = "Yin";
		};
		case "76561198846869680": {
			_name = "yang";
			_desc = "Yang. By whitelist only.";
			_title = "Yang";
		};
		case "76561198846869680": {
			_name = "dash_cross";
			_desc = "Dash Cross. By whitelist only.";
			_title = "Dash Cross";
		};
	};
};

//founders circle gets all the hex icons automatically
if(call (oev_donator) >= 1000 && !(player getVariable["allIconsUnlocked",false])) then {
	_arr = [];
	_arr resize count(player getVariable["hexIconArray",[]]);
	_arr2 = _arr apply {1};
	_arr2 set[0,getPlayerUID player];
	player setVariable["hexIconArray",_arr2];
	player setVariable["allIconsUnlocked",true];
};

switch(_this select 0) do {
	case 0: {
		if(playerSide isEqualTo west) then {
			if(oev_hexCooldown > time) exitWith {
				hint "Please wait before changing your icon!";
			};
			oev_hexCooldown = time+1;
			_name = switch (lbCurSel 95674) do {
				case 0: {"dep"};
				case 1: {"po"};
				case 2: {"corp"};
				case 3: {"sgt"};
				case 4: {"lt"};
				case 5: {"depc"};
				case 6: {"chief"};
				default {""}
			};
			if((player getVariable["hexIconName",""]) != _name) then {
				if((player getVariable["hexIconName",""]) != "") then {
					for "_i" from 0 to (lbSize 95674) do {
						if(lbColor[95674, _i] isEqualTo [0,1,0,1]) then {
							lbSetColor[95674,_i,[1,1,1,1]];
						};
					};
				};
				player setVariable["hexIconName",_name,true];
				lbSetColor[95674,(lbCurSel 95674),[0,1,0,1]];
				ctrlSetText[45357,"Unequip"];
			} else {
				player setVariable["hexIconName","",true];
				lbSetColor[95674,(lbCurSel 95674),[1,1,1,1]];
				ctrlSetText[45357,"Equip"];
			};
		} else {
			if(_name isEqualTo "" || lbCurSel 95674 < 233) then {
				_name = getText(((missionConfigFile >> "CfgIcons") select (lbCurSel 95674)) >> "name");
			};
			if(oev_hexCooldown > time) exitWith {
				hint "Please wait before changing your icon!";
			};
			oev_hexCooldown = time+1;
			if((player getVariable["hexIconName",""]) != _name) then {
				if((player getVariable["hexIconName",""]) != "") then {
					for "_i" from 0 to (lbSize 95674) do {
						if(lbColor[95674, _i] isEqualTo [0,1,0,1]) then {
							lbSetColor[95674,_i,[1,1,1,1]];
						};
					};
				};
				player setVariable["hexIconName",_name,true];
				lbSetColor[95674,(lbCurSel 95674),[0,1,0,1]];
				ctrlSetText[45357,"Unequip"];
				[player,2,_name] remoteExec["OES_fnc_hexMasterServ",2];
			} else {
				lbSetColor[95674,(lbCurSel 95674),[1,1,1,1]];
				player setVariable["hexIconName","",true];
				ctrlSetText[45357,"Equip"];
				[player,3] remoteExec["OES_fnc_hexMasterServ",2];
			};
		};
	};

	case 1: {
		if(playerSide isEqualTo west) then {
			if(player getVariable ["rank",-1] < 5) exitWith {};
			_tagIcon = switch (lbCurSel 95674) do {
				case 1: {MISSION_ROOT + "images\PO_tag.paa"};
				case 2: {"\a3\ui_f\data\gui\cfg\Ranks\corporal_gs.paa"};
				case 3: {"\a3\ui_f\data\gui\cfg\Ranks\sergeant_gs.paa"};
				case 4: {"\a3\ui_f\data\gui\cfg\Ranks\lieutenant_gs.paa"};
				case 5: {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"};
				case 6: {"\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa"};
				default {"\a3\ui_f\data\gui\cfg\Ranks\private_gs.paa"};
			};
			_rank = player getVariable ["rank",-1];
			_compare = 0;
			if(lbCurSel 95674 > 2) then {
				_compare = 3;
			} else {
				_compare = 1;
			};
			if(player getVariable ["rank",-1] >= lbCurSel 95674+_compare) then {
				_name = switch (lbText[95674,(lbCurSel 95674)]) do {
					case "Deputy": {"dep"};
					case "Patrol Officer": {"po"};
					case "Corporal": {"corp"};
					case "Sergeant": {"sgt"};
					case "Lieutenant": {"lt"};
					case "Deputy Chief": {"depc"};
					case "Chief": {"chief"};
					default {"1"}
				};
				if((player getVariable["hexIconName",""]) isEqualTo _name) then {
					ctrlSetText[45357,"Unequip"];
					ctrlEnable [45357, true];
				} else {
					ctrlSetText[45357,"Equip"];
					ctrlEnable [45357, true];
				};
			} else {
				ctrlSetText[45357,"Locked"];
				ctrlEnable [45357, false];
			};
			ctrlSetText [874539,_tagIcon];
			ctrlSetText [86976,"APD Undercover Hex"];
		} else {
			if((_name isEqualTo "" && _desc isEqualTo "") || lbCurSel 95674 < 233) then {
				_name = getText(((missionConfigFile >> "CfgIcons") select (lbCurSel 95674)) >> "name");
				_desc = getText(((missionConfigFile >> "CfgIcons") select (lbCurSel 95674)) >> "desc");
			};
			ctrlSetText[45357,"Equip"];
			ctrlEnable [45357, false];
			ctrlSetText [874539,format["images\icons\hexIcons\%1.paa",_name]];
			ctrlSetText [86976,_desc];
			if((player getVariable["hexIconArray",[]]) select ((lbCurSel 95674)+1) == 1) then {
				ctrlEnable [45357, true];
				if((player getVariable["hexIconName",""]) isEqualTo _name) then {
					ctrlSetText[45357,"Unequip"];
				};
			};
		};
	};

	case 2: {
		_ctrl = (findDisplay 87432) displayCtrl 874539;
		_ctrl ctrlSetTextColor life_colorRGBA;
		ctrlSetText[45357,"Equip"];
		ctrlEnable [45357, false];
		ctrlShow [78609, false];
		_rank = player getVariable ["rank",-1];
		if(playerSide isEqualTo west && _rank >= 5) then {
			_ucIcons = [
				[1,"Deputy"],
				[2,"Patrol Officer"],
				[3,"Corporal"],
				[6,"Sergeant"],
				[7,"Lieutenant"],
				[8,"Deputy Chief"],
				[9,"Chief"]
			];
			{
				lbAdd[95674,_x select 1];
				if(_rank >= _x select 0) then {
					lbSetPicture [95674,_forEachIndex,"images\icons\unlockedicon.paa"];
				} else {
					lbSetPicture [95674,_forEachIndex,"images\icons\lockedicon.paa"];
				};
			} forEach _ucIcons;
		} else {
			for "_i" from 0 to ((count (missionConfigFile >> "CfgIcons")) - 1) do {
				lbAdd[95674,getText(((missionConfigFile >> "CfgIcons") select _i) >> "title")];
				if(getText(((missionConfigFile >> "CfgIcons") select _i) >> "name") isEqualTo (player getVariable["hexIconName",""])) then {
					lbSetPicture [95674,_i,"images\icons\unlockedicon.paa"];
					lbSetColor[95674,_i,[0,1,0,1]];
				} else {
					if((player getVariable["hexIconArray",[]]) select (_i + 1) == 0) then {
						lbSetPicture [95674,_i,"images\icons\lockedicon.paa"];
						lbSetColor[95674,_i,[0.659,0.659,0.655,1]];
					} else {
						lbSetPicture [95674,_i,"images\icons\unlockedicon.paa"];
					};
				};
			};
			if(getPlayerUID player in _customIDs) then {
				_index = lbAdd[95674,_title];
				if((player getVariable["hexIconName",""]) isEqualTo _name) then {
					lbSetColor[95674,_index,[0,1,0,1]];
				};
				lbSetPicture [95674,_index,"images\icons\unlockedicon.paa"];
			};
		};
	};

	case 3: {
		if((_this select 1) != -1) exitWith {
			ctrlSetText[9745322,format["images\icons\hexIcons\%1.paa",getText(((missionConfigFile >> "CfgIcons") select ((_this select 1)-1)) >> "name")]];
			player setVariable["hexIconArray", _this select 2];
		};
		_hexArray = player getVariable["hexIconArray",[]];
		if(_hexArray find 0 == -1) exitWith {
			hint "Congratulations, you have unlocked all the hex icons! Please wait until we add more.";
		};
		ctrlEnable[675843,false];
		playSound "openChest";
		uiSleep 0.2;
		_ppEffect = ppEffectCreate ["ColorCorrections",2500];
		_ppEffect ppEffectAdjust [1, 1, -0.01, [1,0.733,0.184,0.98], [1, 1, 1, 1], [1, 1, 1, 1]];
		_ppEffect ppEffectCommit 0.1;
		_ppEffect ppEffectEnable true;
		_ppEffect ppEffectForceInNVG true;
		closeDialog 0;
		uiSleep 1;
		_ppEffect ppEffectEnable false;
		player setVariable["hexRedemptions",(player getVariable["hexRedemptions",0])-1];
		['unlockIconsMenu'] call OEC_fnc_createDialog;
		ctrlShow[9755321,false];
		ctrlShow[9745322,true];
		[player,1,_hexArray] remoteExec["OES_fnc_hexMasterServ",2];
	};
};
