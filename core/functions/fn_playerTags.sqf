//  File: fn_playerTags.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Adds the tags above other players heads when close and have visible range.
private["_units","_tagIcon","_tagTextLines","_visPosition","_distance","_maxDistance","_transparency","_spotted","_playerName","_nameColor","_sPos","_text", "_titleColor", "_medicIconTag", "_medicIconColor", "_kosPlayers"];

_tagIcon = "";
_playerName = "";
_nameColor = "#FFFFFF";
_tagTextLines = [];
_maxDistance = 17;
_hidden = false;
_isMasked = false;
_isCamo = false;
_maskedName = false;
_titleColor = [217, 217, 217];
_medicIconTag = "";
_medicIconColor = [0.38, 0.71, 0.27];

_kosPlayers = [];

if(visibleMap || {!alive player} || {dialog}) exitWith {};

if(isNil "KK_fnc_trueZoom") then {
	KK_fnc_trueZoom = {
		(([0.5,0.5] distance2D worldToScreen positionCameraToWorld [0,3,4]) * (getResolution select 5) / 2)
	};
};

if (((currentWeapon player in ["Binocular","Rangefinder","launch_Titan_F","launch_I_Titan_F","launch_RPG32_F"]) && cameraView == "Gunner") && {!life_acquireTargetCooldown}) then {
	life_lastScopeTime = time;
	life_targetCache = objNull;
	private _intersect = lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,5000],vehicle player,objNull,true,1,"FIRE","NONE"];
	if (count _intersect > 0) then {
		//Assigning the return variables
		private _intersectPosASL = ((_intersect select 0) select 0);
		private _intersectObject = ((_intersect select 0) select 2);
		//Distance from the unit
		private _distance = _intersectPosASL vectorDistance (eyepos player);

		//Is the target terrain?
		if (isNull _intersectObject) exitWith {
			if !(isNull(life_currTarget select 0)) then {
				life_currTarget = [objNull,0];
				hintSilent "";
			};
		};
		if (vehicle _intersectObject isKindOf "Air") then {
			//Distance check for air vehicles
			if ((_distance > 2000) || ((count fullCrew [_intersectObject,"driver",false]) isEqualTo 0)) exitWith {
				if !(isNull(life_currTarget select 0)) then {
					life_currTarget = [objNull,0];
					hintSilent "";
				};
			};
			if (isNull(life_currTarget select 0)) then {
				life_currTarget = [_intersectObject,time];
			} else {
				[_intersectObject,2] spawn OEC_fnc_targetLocking;
			};
		} else {
			//Is the target a ground vehicle?
			if (vehicle _intersectObject isKindOf "Car" || vehicle _intersectObject isKindOf "Truck" || vehicle _intersectObject isKindOf "Armored" || vehicle _intersectObject isKindOf "Ship") then {
				//Distance check for ground and water vehicles
				if ((_distance > 500) || ((count fullCrew [_intersectObject,"driver",false]) isEqualTo 0)) exitWith {
					if !(isNull(life_currTarget select 0)) then {
						life_currTarget = [objNull,0];
						hintSilent "";
					};
				};
				if (isNull(life_currTarget select 0)) then {
					life_currTarget = [_intersectObject,time];
				} else {
					[_intersectObject,0] spawn OEC_fnc_targetLocking;
				};
			} else {
				//Is the target a person?
				if (vehicle _intersectObject isKindOf "Man") then {
					//Distance check for people
					if ((_distance > 150) || (name _intersectObject IsEqualTo "Error: No unit")) exitWith {
						if !(isNull(life_currTarget select 0)) then {
							life_currTarget = [objNull,0];
							hintSilent "";
						};
					};
					if (isNull(life_currTarget select 0)) then {
						life_currTarget = [_intersectObject,time];
					} else {
						[_intersectObject,1] spawn OEC_fnc_targetLocking;
					};
				} else {
					if !(isNull(life_currTarget select 0)) then {
						life_currTarget = [objNull,0];
						hintSilent "";
					};
				};
			};
		};
	} else {
		if !(isNull(life_currTarget select 0)) then {
			life_currTarget = [objNull,0];
			hintSilent "";
		};
	};
} else {
	if ((time - life_lastScopeTime) < 2) then {
		if !(isNull(life_targetCache)) then {
			if(((life_targetCache getVariable ["gang_data",[0,"",0]]) select 0) in oev_gang_warIDs) then {
				hintSilent parseText format ["<t color='#00CC00'><t size='2'><t align='center'>Target Acquired</t></t></t><br/><br/><t color='#D61414'><t size='1'><t align='center'>%1</t></t></t>",name life_targetCache];
			} else {
				hintSilent parseText format ["<t color='#00CC00'><t size='2'><t align='center'>Target Acquired</t></t></t><br/><br/><t color='#FFFFFF'><t size='1'><t align='center'>%1</t></t></t>",name life_targetCache];
			};
		} else {
			life_targetCache = objNull;
			life_currTarget = [objNull,0];
			hintSilent "";
		};
	};
};

if(oev_eventESP) then { _maxDistance = 500; };

if(time > oev_nextHudClear) then {//Instead of calling (visiblePosition player) nearEntities every single frame, its only called twice a second.
	oev_nextHudClear = (time + 0.5);
	oev_playerTagUnits = [];

	oev_playerTagUnits = (visiblePosition player) nearEntities[["Man","Car","Truck","Air","Ship"],_maxDistance];
	{ oev_playerTagUnits pushBackUnique _x; }foreach oev_spottedPlayers;
	oev_playerTagUnits = oev_playerTagUnits - [vehicle player];

	oev_groupIconUnits = units group player - [player];
};

switch (playerSide) do {
	case west: {
		private _drawnVehicles = [];
		{
			if (vehicle _x != _x) then {
				if !(vehicle _x in _drawnVehicles) then {
					_drawnVehicles pushBack (vehicle _x);
					_highestRank = [_x, _x getVariable ["rank", 0], 1];
					{
						if (_x in oev_groupIconUnits) then {
							_highestRank set [2, (_highestRank select 2) + 1];
							if (_x getVariable ["rank", 0] > (_highestRank select 1)) then {
								_highestRank set [0, _x];
								_highestRank set [1, _x getVariable ["rank", 0]];
							};
						};
					} forEach crew vehicle _x - [_x];
					_tagIcon = switch (_highestRank select 1) do {
						case 2: {MISSION_ROOT + "images\PO_tag.paa"};
						case 3: {"\a3\ui_f\data\gui\cfg\Ranks\corporal_gs.paa"};
						case 4: {MISSION_ROOT + "images\staff_sgt.paa"};
						case 5: {MISSION_ROOT + "images\staff_sgt.paa"};
						case 6: {"\a3\ui_f\data\gui\cfg\Ranks\sergeant_gs.paa"};
						case 7: {"\a3\ui_f\data\gui\cfg\Ranks\lieutenant_gs.paa"};
						case 8: {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"};
						case 9: {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"};
						case 10: {"\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa"};
						default {"\a3\ui_f\data\gui\cfg\Ranks\private_gs.paa"};
					};
					if (_highestRank select 1 isEqualTo 10) then {
						_tagIcon = "\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa";
					};

					drawIcon3D [
						_tagIcon, life_colorRGBA, vehicle (_highestRank select 0) modelToWorldVisual [0,0,0], 0.5, 0.5, 0, "", 1
					];
					drawIcon3D [
						MISSION_ROOT + "images\icons\groupIcon.paa", life_colorRGBA, vehicle (_highestRank select 0) modelToWorldVisual [0,0,0], 1, 1, 0, str(_highestRank select 2), 1
					];
				};
			} else {
				_tagIcon = switch (_x getVariable ["rank", 0]) do {
					case 2: {MISSION_ROOT + "images\PO_tag.paa"};
					case 3: {"\a3\ui_f\data\gui\cfg\Ranks\corporal_gs.paa"};
					case 4: {MISSION_ROOT + "images\staff_sgt.paa"};
					case 5: {MISSION_ROOT + "images\staff_sgt.paa"};
					case 6: {"\a3\ui_f\data\gui\cfg\Ranks\sergeant_gs.paa"};
					case 7: {"\a3\ui_f\data\gui\cfg\Ranks\lieutenant_gs.paa"};
					case 8: {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"};
					case 9: {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"};
					case 10: {"\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa"};
					default {"\a3\ui_f\data\gui\cfg\Ranks\private_gs.paa"};
				};
				if !(_x getVariable["hexIconName",""] isEqualTo "") then {
					_tagIcon = switch (_x getVariable["hexIconName",""]) do {
						case "dep": {"\a3\ui_f\data\gui\cfg\Ranks\private_gs.paa"};
						case "po": {MISSION_ROOT + "images\PO_tag.paa"};
						case "corp": {"\a3\ui_f\data\gui\cfg\Ranks\corporal_gs.paa"};
						case "sgt": {"\a3\ui_f\data\gui\cfg\Ranks\sergeant_gs.paa"};
						case "lt": {"\a3\ui_f\data\gui\cfg\Ranks\lieutenant_gs.paa"};
						case "depc": {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"};
						case "chief": {"\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa"};
						default {""};
					};
				};
				drawIcon3D [
					_tagIcon, life_colorRGBA, _x modelToWorldVisual (_x selectionPosition "Spine3"), 0.5, 0.5, 0, "", 1
				];
				drawIcon3D [
					MISSION_ROOT + "images\icons\groupIcon.paa", life_colorRGBA, _x modelToWorldVisual (_x selectionPosition "Spine3"), 1, 1, 0, "", 1
				];
			};
		} forEach oev_groupIconUnits;
	};
	case independent: {
		private _drawnVehicles = [];
		{
			if (vehicle _x != _x) then {
				if !(vehicle _x in _drawnVehicles) then {
					_drawnVehicles pushBack (vehicle _x);
					_highestRank = [_x, _x getVariable ["rank", 0], 1];
					{
						if (_x in oev_groupIconUnits) then {
							_highestRank set [2, (_highestRank select 2) + 1];
							if (_x getVariable ["rank", 0] > (_highestRank select 1)) then {
								_highestRank set [0, _x];
								_highestRank set [1, _x getVariable ["rank", 0]];
							};
						};
					} forEach crew vehicle _x - [_x];
					_tagIcon = switch (_highestRank select 1) do {
						case 6: {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"}; // Supervisor [Captain Bars]
						case 7: {"\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa"}; // Coordinator [Eagle]
						default {MISSION_ROOT + "images\medicrank.paa"}; // Default Logo
					};
					if (getPlayerUID (_highestRank select 0) isEqualTo "76561198144351505" && {_highestRank select 1 isEqualTo 7}) then {
						_tagIcon = "\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa";
					};
					drawIcon3D [
						_tagIcon, life_colorRGBA, vehicle (_highestRank select 0) modelToWorldVisual [0,0,0], 0.5, 0.5, 0, "", 1
					];
					drawIcon3D [
						MISSION_ROOT + "images\icons\groupIcon.paa", life_colorRGBA, vehicle (_highestRank select 0) modelToWorldVisual [0,0,0], 1, 1, 0, str(_highestRank select 2), 1
					];
				};
			} else {
				_tagIcon = switch (_x getVariable ["rank", 0]) do {
					case 6: {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"}; // Supervisor [Captain Bars]
					case 7: {"\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa"}; // Coordinator [Eagle]
					default {MISSION_ROOT + "images\medicrank.paa"}; // Default Logo
				};
				if (getPlayerUID _x isEqualTo "76561198144351505" && {_x getVariable ["rank", 0] isEqualTo 7}) then {
					_tagIcon = "\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa";
				};
				drawIcon3D [
					_tagIcon, life_colorRGBA, _x modelToWorldVisual (_x selectionPosition "Spine3"), 0.5, 0.5, 0, "", 1
				];
				drawIcon3D [
					MISSION_ROOT + "images\icons\groupIcon.paa", life_colorRGBA, _x modelToWorldVisual (_x selectionPosition "Spine3"), 1, 1, 0, "", 1
				];
			};
		} forEach oev_groupIconUnits;
	};
	case civilian: {
		private _drawnVehicles = [];
		{
			if (vehicle _x != _x) then {
				if !(vehicle _x in _drawnVehicles) then {
					_drawnVehicles pushBack (vehicle _x);
					_highestRank = [_x, leader player == _x, {_x in oev_groupIconUnits} count (crew vehicle _x)];
					{
						if (_x in oev_groupIconUnits && leader player == _x) then {
							_highestRank set [0, _x];
							_highestRank set [1, true];
						};
					} forEach crew vehicle _x - [_x];
					if (_highestRank select 1 || !((_x getVariable["hexIconName",""]) isEqualTo "")) then {
						if(((_x getVariable["hexIconName",""]) isEqualTo "" || !(life_hexIcons)) && leader player == _x) then {
							drawIcon3D [
								MISSION_ROOT + "images\icons\groupLeader.paa", life_colorRGBA, vehicle (_highestRank select 0) modelToWorldVisual [0,0,0], 1, 1, 0, "", 1
							];
						} else {
							if (!((_x getVariable["hexIconName",""]) isEqualTo "") && life_hexIcons) then {
								drawIcon3D [
									format[MISSION_ROOT + "images\icons\hexIcons\%1.paa",(_x getVariable["hexIconName",""])], life_colorRGBA, (vehicle _x) modelToWorldVisual [0,0,0], 0.5, 0.5, 0, "", 1
								];
							};
						};
					};

					drawIcon3D [
						MISSION_ROOT + "images\icons\groupIcon.paa", life_colorRGBA, vehicle (_highestRank select 0) modelToWorldVisual [0,0,0], 1, 1, 0, str(_highestRank select 2), 1
					];
				};
			} else {
				if (leader player == _x || !((_x getVariable["hexIconName",""]) isEqualTo "")) then {
					if(((_x getVariable["hexIconName",""]) isEqualTo "" || !(life_hexIcons)) && leader player == _x) then {
						drawIcon3D [
							MISSION_ROOT + "images\icons\groupLeader.paa", life_colorRGBA, _x modelToWorldVisual (_x selectionPosition "Spine3"), 1, 1, 0, "", 1
						];
					} else {
						if (!((_x getVariable["hexIconName",""]) isEqualTo "") && life_hexIcons) then {
							drawIcon3D [
								format[MISSION_ROOT + "images\icons\hexIcons\%1.paa",(_x getVariable["hexIconName",""])], life_colorRGBA, _x modelToWorldVisual (_x selectionPosition "Spine3"), 0.5, 0.5, 0, "", 1
							];
						};
					};
				};

				drawIcon3D [
					MISSION_ROOT + "images\icons\groupIcon.paa", life_colorRGBA, _x modelToWorldVisual (_x selectionPosition "Spine3"), 1, 1, 0, "", 1
				];
			};
		} forEach oev_groupIconUnits;
	};
};

/*
{
	//private _UIColor = ["IGUI","TEXT_RGB"] call BIS_fnc_displayColorGet;
	//private _newPos = _x modelToWorldVisual (_x selectionPosition "Spine3");
	if (leader player == _x) then {
		drawIcon3D [
			MISSION_ROOT + "images\icons\groupLeader.paa",
			["IGUI","TEXT_RGB"] call BIS_fnc_displayColorGet,
			_x modelToWorldVisual (_x selectionPosition "Spine3"),
			1,
			1,
			0,
			"",
			1
		];
	};
	drawIcon3D [
		MISSION_ROOT + "images\icons\groupIcon.paa",
		["IGUI","TEXT_RGB"] call BIS_fnc_displayColorGet,
		_x modelToWorldVisual (_x selectionPosition "Spine3"),
		1,
		1,
		0,
		"",
		1
	];
} forEach oev_groupIconUnits;
*/

{
	if((lineIntersectsSurfaces [eyePos player, eyePos _x, vehicle player,_x]) isEqualTo [] || oev_eventESP) then {
		if(!isPlayer _x && _x getVariable["realname",""] == "") exitWith {};
		if(vehicle _x == vehicle player) exitWith {};

		_visPosition = visiblePosition _x;
		_distance = player distance _x;

		if(_distance > 900) exitWith {};

		_cameraDistance = _distance;
		if(cameraView == "EXTERNAL") then {
			_cameraDistance = _distance + 2.5;
		};

		_sPos = [_visPosition select 0,_visPosition select 1, ((_x modelToWorld (_x selectionPosition 'head')) select 2) + 0.45 + (_cameraDistance * 0.05) - (((call KK_fnc_trueZoom) * (_cameraDistance * 0.1)) * 0.22)];

		if(!(_sPos isEqualTo []) && ((_distance < _maxDistance) || {_x getVariable ["lastSpottedTime",0] > time})) then {
			if(!isPlayer _x && _x getVariable["realname",""] == "") exitWith {};
			if(!isNil {_x getVariable "olympusinvis"}) exitWith {};

			//_isMasked = ((goggles _x) in ["G_Balaclava_blk","G_Balaclava_combat","G_Balaclava_lowprofile","G_Balaclava_oli","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan"]);
			_isCamo = ((uniform _x) in ["U_I_FullGhillie_ard","U_O_FullGhillie_ard","U_B_FullGhillie_ard","U_I_FullGhillie_lsh","U_O_FullGhillie_lsh","U_B_FullGhillie_lsh","U_I_FullGhillie_sard","U_O_FullGhillie_sard","U_B_FullGhillie_sard","U_B_T_FullGhillie_tna_F","U_O_T_FullGhillie_tna_F"]);

			_spotted = false;
			_tagIcon = "";
			_tagTextLines = [];
			_text = "";
			_transparency = 1 - ((_distance / 50) min 0.34);
			_nameColor = [1,1,1, _transparency];
			_playerName = (_x getVariable ["realname",name _x]);
			_medicIconTag = "";
			_medicIconColor = [0.38, 0.71, 0.27, _transparency];

			if (player getVariable ["blindfolded",false]) then {
				_playerName = getPlayerUID _x;
				_playerName = _playerName select [6]; // playerID less 7656119
			};

			//if _isMasked and > 3 distance change name to masked player, nah jk no one likes to get close to people to roleplay.

			if(_isCamo && {_distance > 3 && (stance _x == "PRONE" || stance _x == "CROUCH")}) then {
				if(stance _x == "CROUCH") then {
					_transparency = _transparency * 0.5;
				}else{
					_transparency = _transparency * 0.2;
				};

				_nameColor = [1,1,1, _transparency];
			};

			if(!isNil {_x getVariable "name"}) then {
				_tagIcon = "a3\ui_f\data\map\MapControl\hospital_ca.paa";
				_nameColor = [1,0,0, _transparency];
			}else{
				switch (side _x) do {
					case west: {
						if (!isNil {(_x getVariable "rank")}) then {
							_tagIcon = switch (_x getVariable "rank") do {
								case 2: {MISSION_ROOT + "images\PO_tag.paa"};
								case 3: {"\a3\ui_f\data\gui\cfg\Ranks\corporal_gs.paa"};
								case 4: {MISSION_ROOT + "images\staff_sgt.paa"};
								case 5: {MISSION_ROOT + "images\staff_sgt.paa"};
								case 6: {"\a3\ui_f\data\gui\cfg\Ranks\sergeant_gs.paa"};
								case 7: {"\a3\ui_f\data\gui\cfg\Ranks\lieutenant_gs.paa"};
								case 8: {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"};
								case 9: {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"};
								case 10: {"\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa"};
								default {"\a3\ui_f\data\gui\cfg\Ranks\private_gs.paa"};
							};
							if ((_x getVariable "rank") isEqualTo 10) then {
								//Will only show if the Chief is rank 6 >.<
								_tagIcon = "\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa";
							};
						};

						_nameColor = [0.21, 0.38, 1, _transparency];
					};

					case independent: {
						_nameColor = [0.38, 0.71, 0.27, _transparency];
						if (!isNil {(_x getVariable "rank")}) then {
							_medicIconColor = switch (_x getVariable "rank") do {
								case 2: {[1, 0, 0, _transparency]}; // Basic Paramedic [Red]
								case 3: {[0.98, 0.98, 0.039, _transparency]}; // Adv. Paramedic [Yellow]
								case 4: {[0.886, 0.466, 0.07, _transparency]}; // Search & Rescue [Orange] ,
								case 5: {[0.886, 0.466, 0.07, _transparency]}; // Staff RnR [White]
								case 6: {[0.38, 0.71, 0.27, _transparency]}; // Supervisor [Lime Green]
								case 7: {[0.38, 0.71, 0.27, _transparency]}; // Coordinator [Lime Green]
								default {[0.38, 0.71, 0.27, _transparency]};
							};
							_medicIconTag = switch (_x getVariable "rank") do {
								case 6: {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"}; // Supervisor [Captain Bars]
								case 7: {"\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa"}; // Coordinator [Eagle]
								default {MISSION_ROOT + "images\medicrank.paa"}; // Default Logo
							};
						};
						if((format["%1",_x]) in ["indp_news_1","indp_news_2","indp_news_3","indp_news_4","indp_news_5","indp_news_6","indp_news_7","indp_news_8"]) then {
							_nameColor = [1,1,1, _transparency];
						};
						if (((getPlayerUID _x) isEqualTo "76561198144351505") && {(_x getVariable "rank") isEqualTo 7}) then {
							// RnR Director & Rank 7
							_medicIconTag = "\a3\ui_f\data\gui\cfg\Ranks\colonel_gs.paa";
							_medicIconColor = [0, 0, 0, _transparency];
						};
					};

					case civilian: {
						if (_x getVariable ["conqSafezone", false]) then {
							_tagIcon = format["%1images\icons\shield_white.paa",MISSION_ROOT];
						} else {
							if (_x getVariable ["restrictions", false]) then {
								_tagIcon = format["%1images\poo.paa",MISSION_ROOT];
							};
						};
						if(playerSide isEqualTo civilian) then {
							if (((_x getVariable ["gang_data",[0,"",0]]) select 0 == (oev_gang_data select 0)) || (group player) isEqualTo (group _x)) then {
								_nameColor = [0, 1, 0, _transparency];
							};

							if ((((_x getVariable ["gang_data",[0,"",0]]) select 0) in oev_gang_warIDs) && !(_x getVariable ["restrained",false]) && !((group player) isEqualTo (group _x)) && !(!isNil {_x getVariable "adminesp"})) then {
								_nameColor = [1, 0, 0, _transparency];
							};

							if !(_x isKindOf "Man") then {
								{
									if ((isPlayer _x) && (alive _x)) exitWith {
										_playerName = (_x getVariable ["realname",name _x]);
										if ((((_x getVariable ["gang_data",[0,"",0]]) select 0) in oev_gang_warIDs) && !((group player) isEqualTo (group _x)) && !(!isNil {_x getVariable "adminesp"}) && !(_x getVariable ["restrained",false])) then {
											_nameColor = [1, 0, 0, _transparency];
										};
									};
								} forEach crew _x;
							};
						};

						if(!isNil {(_x getVariable "gang_data") select 1}) then {
							_tagTextLines pushBack [((_x getVariable ["gang_data",[0,"",0]]) select 1), [0.71, 0.71, 0.71, _transparency],false];
						};

						if(playerside isEqualTo west && (_x getVariable "epiActive") && (_x getVariable ["restrained", false])) then {
							_playerName = (_x getVariable ["realname", name _x]);
							_nameColor = [1, 0, 0, _transparency];
							_tagTextLines pushBack ["Needs Dopamine!", [1, 0, 0, _transparency],false];
						};
					};
				};
				// Specific People KOS
				//if (((getPlayerUID _x) isEqualTo "76561198068537683" || (getPlayerUID _x) isEqualTo "76561198088179854" || (getPlayerUID _x) isEqualTo "76561198183874289") && !(_x getVariable ["restrained",false])) then {
				//	_nameColor = [1, 0, 0, _transparency]; //  KOS  -> Ryan and Hawk
				//};

				if (getPlayerUID _x in _kosPlayers && !(_x getVariable ["restrained",false])) then {
					_nameColor = [1,0,0,_transparency];
				};

			};

			drawIcon3D [//Draw main icon + playername
				_tagIcon,//icon
				_nameColor,//color
				_sPos,//position
				1,//width
				1,//height
				0,//angle
				_playerName,//test
				2,//shadow
				0.035,//text size
				"PuristaSemiBold"
			];
			if ((side _x) isEqualTo independent) then {
				drawIcon3D [//Draw medic icon w/ custom color
					_medicIconTag,//icon
					_medicIconColor,//color
					_sPos,//position
					1,//width
					1,//height
					0,//angle
					"",//test
					2,//shadow
					0.035,//text size
					"PuristaSemiBold"
				];
			};

			if !((_x getVariable ["currentTitle",""]) isEqualTo "") then {
				_titleColor = _x getVariable ["titlecolor", [217, 217, 217]];
				_tagTextLines pushBack [format["%1",_x getVariable ["currentTitle",""]],[parseNumber(((_titleColor select 0)/255) toFixed 2), parseNumber(((_titleColor select 1)/255) toFixed 2), parseNumber(((_titleColor select 2)/255) toFixed 2), _transparency],true];
			};

			if(((_x getVariable ["isInEvent",["no"]]) select 0) != "no") then {
				_tagTextLines pushBack [format[": Participating In Event - %1 :",((_x getVariable ["isInEvent",["no"]]) select 0)],[1, 0.8, 0, _transparency],false];
			};

			if((format["%1",_x]) in ["indp_news_1","indp_news_2","indp_news_3","indp_news_4","indp_news_5","indp_news_6","indp_news_7","indp_news_8"]) then {
				_tagTextLines pushBack ["~~  News Anchor  ~~", [0, 0.8, 0.8, _transparency],false];
			};

			if(!isNil {_x getVariable "adminesp"}) then {
				_tagTextLines pushBack ["! Staff ESP Enabled !", [1, 0, 0, _transparency],false];
			};


			for "_i" from 0 to ((count _tagTextLines) - 1) do {
				private _font = "PuristaSemiBold";
				private _size = 0.035;
				if ((_tagTextLines select _i) select 2) then {
					_font = "PuristaLight";
					_size = 0.03;
				};
				drawIcon3D [//Draw main icon + playername
					'',//icon
					(_tagTextLines select _i) select 1,//color
					[_sPos select 0,_sPos select 1,(_sPos select 2) - ((_i + 1)  * (_cameraDistance * 0.015)) + (((call KK_fnc_trueZoom) * (_cameraDistance * 0.1)) * 0.06)],//position
					1,//width
					1,//height
					0,//angle
					(_tagTextLines select _i) select 0,//text
					2,//shadow
					_size,//text size
					_font
				];
			};
		};
	};
}foreach oev_playerTagUnits;
