//  File: fn_adminChat.sqf
//	Author: Fusah
//	Description: Handles chat admin commands
#include "..\..\macro.h"

params [
	["_text",""]
];

private ["_log_event"];
_log_event = "";

private _alvl = call life_adminlevel;
private _dlvl = call oev_developerlevel;

//if !(_alvl > 0 || _dlvl > 0) exitWith {};

private _txt = _text splitString "";
private _msg = _text splitString " ";

if ((_txt select 0) != ";") exitWith {};
private _cmds = [";god", {
		if (_alvl > 1 || getPlayerUID player isEqualTo "76561198045288873") then {
			if !(oev_godmode) then {
				player allowDamage false;
				hint "God Mode On";
				oev_godmode = true;
				_log_event = "ADMIN God Mode On";
			} else {
				player allowDamage true;
				hint "God Mode Off";
				oev_godmode = false;
				_log_event = "ADMIN God Mode Off";
			};
		} else {
			hint "Insufficient Permissions";
		};
	}, ";getkeys", {
		if (_alvl > 0) then {
			[] spawn OEC_fnc_adminTakeKeys;
			closeDialog 0;
			hint "You now have keys for the target vehicle.";
		} else {
			hint "Insufficient Permissions";
		};
	}, ";invis", {
		if (_alvl > 2 || (getPlayerUID player) isEqualTo "76561198045288873") then {
			if !(player getVariable ["invis", false]) then {
				player setVariable ["invis", true];
				[0, player] remoteExec ["OES_fnc_adminInvis", 2];
				hint "You are now invisible.";
				_log_event = "ADMIN Invis On";
			} else {
				player setVariable ["invis", false];
				[1, player] remoteExec ["OES_fnc_adminInvis", 2];
				hint "You are now visible";
				_log_event = "ADMIN Invis Off";
			};
		} else {
			hint "Insufficient Permissions";
		};
	}, ";esp", {
		if (_alvl > 0) then {
			if !(oev_eventESP) then {
				hint "ESP Enabled";
				oev_eventESP = true;
				player setVariable ["adminesp",true,true];
				_log_event = "ADMIN ESP On";
			} else {
				hint "ESP Disabled";
				oev_eventESP = false;
				player setVariable ["adminesp",nil,true];
				_log_event = "ADMIN ESP Off";
			};
		} else {
			hint "Insufficient Permissions";
		};
	}, ";sesp", {
		if (_alvl > 1) then {
			if !(oev_eventESP) then {
				hint "Silent ESP Enabled";
				oev_eventESP = true;
				_log_event = "ADMIN SESP On";
			} else {
				hint "Silent ESP Disabled";
				oev_eventESP = false;
				player setVariable ["adminesp",nil,true];
				_log_event = "ADMIN SESP Off";
			};
		} else {
			hint "Insufficient Permissions";
		};
	}, ";espec", {
		if (_alvl > 1) then {
			[] spawn OEC_fnc_adminEnhancedSpec;
			closeDialog 0;
		} else {
			hint "Insufficient Permissions";
		};
	}, ";tpmap", {
		if (_alvl > 1) then {
			[] spawn{
				[] spawn OEC_fnc_adminTpMap;
				closeDialog 0;
				sleep 0.1;
				closeDialog 0;
			};
		} else {
			hint "Insufficient Permissions";
		};
	}, ";amenu", {
		if (_alvl > 0) then {
			["life_admin_menu"] spawn OEC_fnc_createDialog;
		} else {
			hint "Insufficient Permissions";
		};
	}, ";emenu", {
		if (_alvl > 0) then {
			["life_event_menu"] spawn OEC_fnc_createDialog;
			_log_event = "ADMIN Event Menu";
		} else {
			hint "Insufficient Permissions";
		};
	}, ";heal", {
		if (_alvl >= 4 || _dlvl >= 3) then {
			private _dam_obj = vehicle player;
			_dam_obj setDamage 0;
			_log_event = "ADMIN Heal";
			} else {
			hint "Insufficient Permissions";
		};
	}, ";sheal", {
		if (_alvl > 3) then {
			if !(player getVariable ["superHeal",false]) then {
				player setVariable ["superHeal", true, true];
				_log_event = "ADMIN Super Heal On";
			} else {
				player setVariable ["superHeal", false, true];
				_log_event = "ADMIN Super Heal Off";
			};
		} else {
			hint "Insufficient Permissions";
		};
	}, ";stase", {
		if (_alvl > 3 || _dlvl > 1) then {
			if ((getPlayerUID player) isEqualTo "76561198371289799") exitWith {};
			if !(player getVariable ["superTaze", false]) then {
				player setVariable ["superTaze", true, true];
				_log_event = "ADMIN Super Tase On";
			} else {
				player setVariable ["superTaze", false, true];
				_log_event = "ADMIN Super Tase Off";
			};
		} else {
			hint "Insufficient Permissions";
		};
	}, ";flip", {
		if (_alvl >= 4 || _dlvl >= 3) then {
			private _pos = getPos player;
			(vehicle player) setPos _pos;
			uiSleep 0.25;
			_pos = getPos player;
			(vehicle player) setPos _pos;
			_log_event = "ADMIN Flip";
		} else {
			hint "Insufficient Permissions";
		};
	}, ";spoil", {
		if (_alvl > 3 || _dlvl > 0) then {
			private _obj1 = "Target_Rail_F" createVehicle [10, 10, 10];
			private _obj2 = "Land_ConcreteKerb_03_BW_short_F" createVehicle [10, 10, 1];
			_vehicle = vehicle player;
			_obj1 attachTo [_vehicle, [-0.04, -2.6, 0.1]];
			_obj2 attachTo [_vehicle, [-0.0268555, -2.83, 0.506853]];
			_obj1 setVectorDirAndUp [[50, 1, 1], [-1, 1, 0.75]];
			_log_event = "ADMIN Spoil";
			waitUntil {UISleep 5;isNull _vehicle};
			deleteVehicle _obj1;
			deleteVehicle _obj2;
		} else {
			hint "Insufficient Permissions";
		};
	}, ";streamer", {
		if (_alvl > 0) then {
			if !(oev_streamerMode) then {
				hint "Streamer Mode On";
				oev_streamerMode = true;
				[player,false,playerSide,5,oev_streamerMode,false] remoteExec ["OES_fnc_managesc",2];
				_log_event = "ADMIN Streamer On";
			} else {
				hint "Streamer Mode Off";
				oev_streamerMode = false;
				[player,false,playerSide,5,oev_streamerMode,false] remoteExec ["OES_fnc_managesc",2];
				_log_event = "ADMIN Streamer Off";
			};
		} else {
			hint "Insufficient Permissions";
		};
	}, ";rainbow", {
		if (_alvl > 3 || _dlvl > 1) then {
			hint "Rainbow'd your stuff";
			private _vehicle = vehicle player;
			private _tex = "a3\data_f\rainbow_ca.paa";
			private _mat = "A3\characters_f_bootcamp\Data\VR_Soldier_F.rvmat";
			_vehicle setObjectTextureGlobal [0,_tex];
			_vehicle setObjectTextureGlobal [1,_tex];
			_vehicle setObjectTextureGlobal [2,_tex];
			_vehicle setObjectTextureGlobal [3,_tex];
			_vehicle setObjectTextureGlobal [4,_tex];
			_vehicle setObjectTextureGlobal [5,_tex];
			_vehicle setObjectTextureGlobal [6,_tex];
			_log_event = "ADMIN Rainbow";
		} else {
			hint "Insufficient Permissions";
		};
	}, ";aidsrainbow", {
		if (_alvl > 3 || _dlvl > 1) then {
			hint "Rainbow'd your stuff";
			private _vehicle = vehicle player;
			private _tex = "a3\data_f\rainbow_ca.paa";
			private _mat = "A3\characters_f_bootcamp\Data\VR_Soldier_F.rvmat";
			_vehicle setObjectTextureGlobal [0,_tex];
			_vehicle setObjectTextureGlobal [1,_tex];
			_vehicle setObjectTextureGlobal [2,_tex];
			_vehicle setObjectTextureGlobal [3,_tex];
			_vehicle setObjectTextureGlobal [4,_tex];
			_vehicle setObjectTextureGlobal [5,_tex];
			_vehicle setObjectTextureGlobal [6,_tex];
			_vehicle setObjectMaterialGlobal [0,_mat];
			_vehicle setObjectMaterialGlobal [1,_mat];
			_vehicle setObjectMaterialGlobal [2,_mat];
			_vehicle setObjectMaterialGlobal [3,_mat];
			_vehicle setObjectMaterialGlobal [4,_mat];
			_vehicle setObjectMaterialGlobal [5,_mat];
			_vehicle setObjectMaterialGlobal [6,_mat];
			_log_event = "ADMIN Aids Rainbow";
		} else {
			hint "Insufficient Permissions";
		};
	}, ";vrmat", {
		if (_alvl > 3 || _dlvl > 1) then {
			private _vehicle = vehicle player;
			private _mat = "A3\characters_f_bootcamp\Data\VR_Soldier_F.rvmat";
			_vehicle setObjectMaterialGlobal [0,_mat];
			_vehicle setObjectMaterialGlobal [1,_mat];
			_vehicle setObjectMaterialGlobal [2,_mat];
			_vehicle setObjectMaterialGlobal [3,_mat];
			_vehicle setObjectMaterialGlobal [4,_mat];
			_vehicle setObjectMaterialGlobal [5,_mat];
			_vehicle setObjectMaterialGlobal [6,_mat];
			_log_event = "ADMIN VRmat";
		};
	}, ";mat", {
		if (_alvl > 3 || _dlvl > 1) then {
			_index = [-1,-1];
			if(count _cmdArgs > 2) then {
				if((_cmdArgs select 2) find ".rvmat" != -1) then {
					_index = [parseNumber (_cmdArgs select 1), 2];
				}
			} else {
				if((_cmdArgs select 1) find ".rvmat" != -1) then {
					_index = [0, 1];
				};
			};
			if(_index isEqualTo [-1,-1]) exitWith {hint ".rvmat not found.";};
			(vehicle player) setObjectMaterialGlobal [parseNumber (_cmdArgs select (_index select 0)), format ["%1", _cmdArgs select (_index select 1)]];
			_log_event = "ADMIN Mat";
		} else {
			hint "Insufficient Permissions";
		};
	}, ";cmat", {
		if (getPlayerUID player in ["76561198071078342","76561198064919358","76561198129408945","76561198068537683"]) then { //Jay, Zahzi, Hylos, Ryan
			_index = [-1,-1];
			if(count _cmdArgs > 2) then {
				if((_cmdArgs select 2) find ".rvmat" != -1) then {
					_index = [parseNumber (_cmdArgs select 1), 2];
				}
			} else {
				if((_cmdArgs select 1) find ".rvmat" != -1) then {
					_index = [0, 1];
				};
			};
			if(_index isEqualTo [-1,-1]) exitWith {hint ".rvmat not found.";};
			cursorObject setObjectMaterialGlobal [parseNumber (_cmdArgs select (_index select 0)), format ["%1", _cmdArgs select (_index select 1)]];
			_log_event = "ADMIN Cursor Mat";
		} else {
			hint "Not a valid command. Type ;cmds for a list of valid commands.";
		};
	}, ";tex", {
		if (_alvl > 3 || _dlvl > 1) then {
			if (count _cmdArgs > 2) then {
				(vehicle player) setObjectTextureGlobal [parseNumber (_cmdArgs select 1), format ["%1", _cmdArgs select 2]];
			} else {
				(vehicle player) setObjectTextureGlobal [0, format ["%1", _cmdArgs select 1]];
			};
			_log_event = "ADMIN Texture";
		} else {
			hint "Insufficient Permissions";
		};
	}, ";ctex", {
		if (getPlayerUID player in ["76561198071078342","76561198064919358","76561198129408945","76561198068537683"]) then { //Jay, Zahzi, Hylos, Ryan
			if (count _cmdArgs > 2) then {
				(cursorObject) setObjectTextureGlobal [parseNumber (_cmdArgs select 1), format ["%1", _cmdArgs select 2]];
			} else {
				(cursorObject) setObjectTextureGlobal [0, format ["%1", _cmdArgs select 1]];
			};
			_log_event = "ADMIN Cursor Texture";
		} else {
			hint "Not a valid command. Type ;cmds for a list of valid commands.";
		};
	}, ";cmds", {
		if (_alvl > 0 || _dlvl > 0) then {
		hint ";god - Toggle godmode\n;getkeys - Get keys to target vehicle\n;invis - Toggle visibility\n;esp - Toggle staff esp\n;sesp - Toggle silent esp\n;spec - Go into spectate mode\n;espec - Go into adv spectate\n;tpmap - Tp to a point on the map\n;amenu - Open Admin Menu\n;emenu - Open Event Menu\n;heal - Heals you\n;flip - Flips your vehicle\n;streamer - Toggle streamer mode\n;help - Display all non-staff commands\n;ejoin - Join the active event\n;eleave - Leave the active event\n;r - Reply to your last message";
		};
	}, ";exec", {
		if (_dlvl >= 3) then {
			["inject",""] remoteExec ["OES_fnc_payload",2];
			_log_event = "ADMIN Exec";
		} else {
			hint "Not a valid command. Type ;cmds for a list of valid commands.";
		};
	}, ";help", {
		hint ";help - Display all commands you have access to\n;r - Reply to your last message\n;ejoin - Join the current active event\n;eleave - Leave the current active event you are in";
	}, ";r", {
		if !(player getVariable ["restrained",false]) then {
			_msg deleteAt 0;
			_msg = _msg joinString " ";
			private _lmid = player getVariable ["lastMessageID",objNull];
			if(!(isNull _lmid))then {
				[10 ,-1,_msg] call OEC_fnc_newMsg;
			} else {
				hint "You can't reply to your previous message.";
			} ;
		} else{
			hint "You can't use your phone while restrained.";
		};
	}, ";ejoin", {
				["join"] spawn OEC_fnc_changePlayerStatus;
	}, ";eleave", {
				["leave"] spawn OEC_fnc_changePlayerStatus;
	}, ";debug", {
		if (_alvl >= 4 || _dlvl >= 2) then {
			diag_log "----SQF Scripts----";
			{diag_log format ["%1:%2, %3",_x select 1, _x select 2, _x select 3]}forEach diag_activeSQFScripts;
			diag_log "----SQS Scripts----";
			{diag_log format ["%1:%2, %3",_x select 1, _x select 2, _x select 3]}forEach diag_activeSQSScripts;
			diag_log "----FSM Scripts----";
			{diag_log format ["%1:%2, %3",_x select 1, _x select 2, _x select 3]}forEach diag_activeMissionFSMs;
			diag_log "----Variables----";
			{
				diag_log format ["%1: %2",_x, player getVariable [format ["%1",_x], nil]];
			 	systemChat format ["%1: %2",_x, player getVariable [format ["%1",_x], nil]];
			} forEach allVariables player;
			systemChat "Wrote debug to RPT!";
			hint "Wrote debug to RPT!";
		} else {
			hint "Not a valid command. Type ;cmds for a list of valid commands."
		};
	}, ";cursor", {
		if (_alvl >= 4 || _dlvl >= 2) then {
			// Seperated messages for reading easily
			systemChat format ["Object: %1", cursorObject];
			systemChat format ["Object Actions: %1", actionIDs cursorObject];
			systemChat format ["Object Position: %1", getPos cursorObject];
			systemChat format ["Object Damage: %1", getDammage cursorObject];
			systemChat format ["Simulation: %1", simulationEnabled cursorObject];
			systemChat format ["Name: %1, Realname: %2", name cursorObject, cursorObject getVariable ["realName", name cursorObject]];
			systemChat "Object Variables:";
			if (count(allVariables cursorObject) > 0) then {
				{
					systemChat format ["%1: %2",_x, cursorObject getVariable [format ["%1",_x], nil]];
				} forEach allVariables cursorObject;
			} else {
				systemChat "nil";
			};
		};
	}, ";mass", {
		if (getPlayerUID player in ["76561198071078342","76561198064919358","76561198129408945","76561198068537683"]) then {
			_veh = (vehicle player);
			if (_veh != player) then {
				_log_event = "ADMIN Mass";
				systemChat format["Default Mass: %1", _veh getVariable["defaultModMass",2000]];
				_veh setMass parseNumber(_cmdArgs select 1);
			};
		};
	}, ";fly", {
		if(getPlayerUID player in ["76561198045288873","76561198064919358","76561198068537683","76561197988603739","76561198129408945","76561198069862784","76561198068833340","76561198071078342"]) then {
			if(player getVariable["fly",false]) then {
				player setVariable["fly",false];
				_log_event = "ADMIN Enable Fly";
			} else {
				player setVariable["fly",true];
				_log_event = "ADMIN Disable Fly";
			};
		};
	}, ";airdrop", {
		if(getPlayerUID player in ["76561198045288873","76561198064919358","76561198068537683"] || player getVariable["airdropEnabled",false]) then {
				[player] remoteExec ['OES_fnc_airdropServer', 2];
		};
	}, ";trimohasamassivecock", {
		if(_alvl > 0) then {
			player setVariable["airdropEnabled",true];
		};
	}, ";vote", {
		if(oev_conquestVote) then {
			if !(player getVariable["votedConquest",false]) then {
				if(playerSide == civilian) then {
					['conquestVote'] call OEC_fnc_createDialog;
				} else {
					hint "Only civilians can vote in Conquest!";
				};
			} else {
				hint "You have already voted in this Conquest!";
			};
		} else {
			hint "There is not a Conquest vote active right now!";
		};
	}
];

private _cmdArgs = toLower(_text) splitString " ";
if ((_cmdArgs select 0) in _cmds) then {
	private _cmdIdx = _cmds find (_cmdArgs select 0);
	call (_cmds select (_cmdIdx + 1));
	[
		["event", _log_event],
		["player", name player],
		["player_id", getPlayerUID player],
		["position", getPos player]
	] call OEC_fnc_logIt;
} else {
	hint "Not a valid command. Type ;cmds for a list of valid commands.";
};
