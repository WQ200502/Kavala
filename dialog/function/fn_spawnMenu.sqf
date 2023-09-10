//  File: fn_spawnMenu.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Initializes the spawn point selection menu.

private["_spCfg","_sp","_ctrl","_nlr","_arrIndex","_markerSp","_markerX","_lbCurSel","_seconds","_time","_minutes","_spawnBtn"];
disableSerialization;
_nlr = false;
_lbCurSel = lbCurSel 38510;
oev_inSpawnMenu = true;

if((oev_is_arrested select 0) == 1) exitWith {
	[] call OEC_fnc_respawned;
};

if(oev_respawned) then {
	[] call OEC_fnc_respawned;
};

life_loadingStatus = "<t color='#00F7FF'>选择一个复活点</t>";

/*Fail DP mission*/
if(oev_delivery_in_progress) then {
	life_cur_task setTaskState "Failed";
	player removeSimpleTask life_cur_task;
	["MedDeliveryFailed",[localize "STR_NOTF_DPFailed"]] call BIS_fnc_showNotification;
	oev_delivery_in_progress = false;
	oev_md_point = nil;
};

cutText["","BLACK FADED"];
0 cutFadeOut 9999999;
["life_spawn_selection", true, false] call OEC_fnc_createDialog;
(findDisplay 38500) displaySetEventHandler ["keyDown","_this call OEC_fnc_displayHandler"];

_spCfg = [playerSide] call OEC_fnc_spawnPointCfg;

_ctrl = ((findDisplay 38500) displayCtrl 38510);
_spawnBtn = (findDisplay 38500) displayCtrl 38511;

{
	_ctrl lnbAddRow[_x select 1,_x select 0,""];
	_ctrl lnbSetPicture[[_forEachIndex,0],_x select 2];
	_ctrl lnbSetData[[_forEachIndex,0],_x select 0];
	_ctrl lnbSetValue[[_forEachIndex,0],0];
} foreach _spCfg;

_sp = _spCfg select 0; //First option is set by default
// bug with getMarkerPos. Returns [0,0,0] SOMETIMES, not sure why.
[((findDisplay 38500) displayCtrl 38502),1,0.1,getMarkerPos (_sp select 0)] call OEC_fnc_setMapPosition;
life_spawn_point = _sp;

ctrlSetText[38501,format["%2: %1",_sp select 1,localize "STR_Spawn_CSP"]];
switch (playerSide) do {
	case (civilian): {
		_markerSp = getMarkerPos (_sp select 0);
		_building = if ("House" in (_sp select 1) || "Gang Shed" in (_sp select 1)) then {(nearestObjects[_markerSp,["House_F","ruins"],10]) select 0} else {""};

		if(_markerSp inPolygon (oev_conquestData select 1 select 1)) then {
			if (!isNil "oev_conquestData" && oev_conquestData select 0) then {
					if ((_sp select 0) find "conq_spawn_" > -1) then {
						_spawnBtn ctrlEnable false;
						_spawnBtn ctrlSetText "时间锁定";
						waitUntil {_spawnBtn ctrlSetText ([oev_conqSpawnCD - time, "MM:SS"] call BIS_fnc_secondsToString);
						if(time > oev_conqSpawnCD)exitWith{
							_spawnBtn ctrlEnable true;
							_spawnBtn ctrlSetText "生成";true;
							};
						uiSleep 0.5; (lnbCurSelRow _ctrl) != _lbCurSel || !oev_inSpawnMenu || time > oev_conqSpawnCD;};
					} else {
						_spawnBtn ctrlEnable false;
						_spawnBtn ctrlSetText "封锁";
						waitUntil {uiSleep 0.5; (lnbCurSelRow _ctrl) != _lbCurSel || !(oev_conquestData select 0) || !oev_inSpawnMenu;};
					};
				};
			} else {
				if ("ruins" in str _building)then{
					_spawnBtn ctrlEnable false;
					_spawnBtn ctrlSetText "摧毁";
						waitUntil {uiSleep 1; (lnbCurSelRow _ctrl) != _lbCurSel || !("ruins" in str _building) || !oev_inSpawnMenu};
				}else{
					_spawnBtn ctrlEnable true;
					_spawnBtn ctrlSetText "生成";
				};
			};

		{
			if ((_markerSp distance (_x select 0)) < 1000) exitWith {
				_nlr = true;
				_arrIndex = _forEachIndex;
			};
		} forEach oev_deaths;

		/*
		if(_nlr) then {
			_spawnBtn ctrlEnable false;
			while{(lbCurSel 38510) == _lbCurSel && ((oev_deaths select _arrIndex) select 1) > time} do {
				_text = [round(((oev_deaths select _arrIndex) select 1) - time),"MM:SS"] call BIS_fnc_secondsToString;
				_spawnBtn ctrlSetText _text;
				sleep 0.1;
			};

			_spawnBtn ctrlEnable true;
			_spawnBtn ctrlSetText "Spawn";
		};
		*/
	};
	case (west): {
		[_ctrl,_spCfg] spawn{
			params [
				"_ctrl",
				"_spCfg"
			];
			_isDelayed = false;
			_sp = _spCfg select 0;
			_markerSp = getMarkerPos (_sp select 0);
			{
				if (_x select 0) exitWith {_isDelayed = true;};
			}forEach oev_hqTakeover;
			_setTime = round serverTime;
			if(_markerSp inPolygon (oev_conquestData select 1 select 1)) then {
				if (!isNil "oev_conquestData" && oev_conquestData select 0) then {
					_spawnBtn ctrlEnable false;
					_spawnBtn ctrlSetText "征服活动";
					waitUntil {uiSleep 0.5; (lnbCurSelRow _ctrl) != _lbCurSel || !(oev_conquestData select 0) || !oev_inSpawnMenu;};
				};
			};
			while {_isDelayed && oev_inSpawnMenu} do {
				//Clear the listbox of spawn points
				lnbClear _ctrl;
				private _exit = true;
				_markerSp = getMarkerPos (_sp select 0);
				private _isDelayed = true;
				{
					_delay = 0;
					if (((oev_hqTakeover select _forEachIndex) select 0) isEqualTo true) then {
						_activeTime = (((oev_hqTakeover select _forEachIndex select 1) - _setTime) - 900) / -1;
						_delayInc = floor(_activeTime / 60);
						_isDelayed = true;
						if (_delayInc >= 6) then {
							_delayInc = 6;
						};
						_delay = 30 * _delayInc;
					};
					_delay = _setTime + _delay;
					if (round serverTime < _delay) then {
						_ctrl lnbAddRow[format["%1 (%2)",((_spCfg select _ForEachIndex) select 1),[_delay - round serverTime,"MM:SS"] call BIS_fnc_secondsToString],(_spCfg select _ForEachIndex) select 0,""];
						_ctrl lnbSetColor [[_forEachIndex,0], [0.3,0.3,0.3,1]];
						_ctrl lnbSetValue [[_forEachIndex, 0], 1];
						_exit = false;
					} else {
						_ctrl lnbAddRow[(_spCfg select _ForEachIndex) select 1,(_spCfg select _ForEachIndex) select 0,""];
						_ctrl lnbSetValue [[_forEachIndex, 0], 0];
					};
					_ctrl lnbSetPicture[[_ForEachIndex,0],(_spCfg select _ForEachIndex) select 2];
					_ctrl lnbSetData[[_ForEachIndex,0],(_spCfg select _ForEachIndex) select 0];
				} forEach _spCfg;
				if (_exit) then {_isDelayed = false;};
				uiSleep 0.5;
			};
		};
	};
	case (independent): {
		private _idx = -1;
		private _spawn = "";
		private _obj = objNull;
		private _fedActive = false;
		_markerSp = getMarkerPos (_sp select 0);

		if(_markerSp inPolygon (oev_conquestData select 1 select 1) && (!isNil "oev_conquestData" && oev_conquestData select 0)) then {
			_spawnBtn ctrlEnable false;
			_spawnBtn ctrlSetText "征服活动";
			waitUntil {uiSleep 0.5; (lnbCurSelRow _ctrl) != _lbCurSel || !(oev_conquestData select 0) || !oev_inSpawnMenu;};
		} else {
			_spawnBtn ctrlSetText "复活";
			_spawnBtn ctrlEnable true;
		};
		// DOES NOT CURRENTLY HAVE FUNCTIONALITY FOR MORE THAN 1 EVENT AT A TIME. Loop through some way in the future if this is needed
		switch (true) do {
			case (fed_bank getVariable ["chargeplaced",false]): {_fedActive = true; _idx = 1; _spawn = "Air"; _obj = fed_bank;}; // Spawn Point Index of nearest HQ
			case (jailwall getVariable ["chargeplaced",false]): {_fedActive = true; _idx = 2; _spawn = "Pyrgos"; _obj = jailwall;}; // Spawn Point Index of nearest HQ
			case (life_bwObj getVariable ["chargeplaced",false]): {_fedActive = true; _idx = 3; _spawn = "Sofia"; _obj = life_bwObj;}; // Spawn Point Index of nearest HQ
		};
		if (_fedActive) then {
			_ctrl lbSetTooltip [_idx, "!! 活跃的联邦活动 !!"];
			_ctrl lbSetColor [_idx, [0.3, 0.3, 0.3, 1]];
			waitUntil{uiSleep 0.1; !(oev_inSpawnMenu) || !(_obj getVariable ["chargeplaced",false])};
			_ctrl lbSetTooltip [_idx, ""];
			_ctrl lbSetColor [_idx, [1, 1, 1, 1]];
		};
	};
	default {};
};
