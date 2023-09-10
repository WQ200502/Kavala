//  File: fn_spawnPointSelected.sqf
//	Author: Bryan "Tonic" Boardwine
//  Description: Sorts out the spawn point selected and does a map zoom.

disableSerialization;
private["_control","_selection","_spCfg","_sp","_nlr","_lbCurSel","_arrIndex","_text","_markerSp","_markerX","_time","_seconds","_minutes","_spawn","_ctrl"];
_ctrl = param [0,controlNull,[controlNull]];
_control = findDisplay 38500;
_selection = param [1,0,[0]];
_lbCurSel = lnbCurSelRow _ctrl;
_nlr = false;
_spawnBtn = _control displayCtrl 38511;
_tSpawnBtn = (_control displayCtrl 38504);
_spCfg = [playerSide] call OEC_fnc_spawnPointCfg;
_sp = _spCfg select _selection;
[((findDisplay 38500) displayCtrl 38502),1,0.1,getMarkerPos (_sp select 0)] call OEC_fnc_setMapPosition;
life_spawn_point = _sp;

ctrlSetText[38501,format["%2: %1",_sp select 1,localize "STR_Spawn_CSP"]];
_markerSp = getMarkerPos (_sp select 0);
if (playerSide isEqualTo civilian) then {
	_building = if ("House" in (_sp select 1) || "Gang Shed" in (_sp select 1)) then {(nearestObjects[_markerSp,["House_F","ruins"],10]) select 0} else {""};

	if(_markerSp inPolygon (oev_conquestData select 1 select 1)) then {
		if (!isNil "oev_conquestData" && oev_conquestData select 0) then {
				if ((_sp select 0) find "conq_spawn_" > -1) then {
					_spawnBtn ctrlEnable false;
					_spawnBtn ctrlSetText "时间锁定";
					waitUntil {
						_spawnBtn ctrlSetText ([oev_conqSpawnCD - time, "MM:SS"] call BIS_fnc_secondsToString);
						if(time > oev_conqSpawnCD) exitWith{
							_spawnBtn ctrlEnable true;
							_spawnBtn ctrlSetText "重生";
							true;
						};
						uiSleep 0.5; (lnbCurSelRow _ctrl) != _lbCurSel || !oev_inSpawnMenu || time > oev_conqSpawnCD;
					};
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
				if (_markerSP isEqualTo [0,0,0]) then {
					_spawnBtn ctrlEnable false;
					_spawnBtn ctrlSetText "窃听！";
					[
						["event","Bugged Spawn"],
						["player",name player],
						["player_id",getPlayerUID player],
						["marker",_sp select 0],
						["markerpos",_markerSp],
						["building",_building],
						["notarray",false]
					] call OEC_fnc_logIt;
				}else{
					_spawnBtn ctrlEnable true;
					_spawnBtn ctrlSetText "重生";
				};
			};
		};

	{
		if ((_markerSp distance (_x select 0)) < 1500) exitWith {
			_nlr = true;
			_arrIndex = _forEachIndex;
		};
	} forEach oev_deaths;

	if (life_martialLaw_pv select 0) then {
		if ((life_spawn_point select 1) isEqualTo (life_martialLaw_pv select 1)) then {
			hint parseText format ["<t color='#FF0000' size='2' align='center' underline='true'>警告</t><br/><br/><t align='center'>%1 目前正在戒严！ 进入你需要自担风险！</t>",(life_spawn_point select 1)];
		};
	};
	/*
	if (_nlr) then {
		if !(ctrlEnabled 38511) then {
			waitUntil {ctrlEnabled 38511};
			_spawnBtn ctrlEnable false;
		} else {
			_spawnBtn ctrlEnable false;
		};

		while {(lnbCurSelRow _ctrl) == _lbCurSel && ((oev_deaths select _arrIndex) select 1) > time} do {
			_text = [round(((oev_deaths select _arrIndex) select 1) - time),"MM:SS"] call BIS_fnc_secondsToString;
			_spawnBtn ctrlSetText _text;
			sleep 0.1;
		};
		_spawnBtn ctrlEnable true;
		_spawnBtn ctrlSetText "Spawn";
	};
	*/
} else {
	if (playerSide isEqualTo west) then {
		_tSpawnBtn ctrlSetText format ["重生点选择 | 当前在线警察: %1", {side _x isEqualTo west} count playableUnits];
		while {oev_inSpawnMenu && ((lnbCurSelRow _ctrl) isEqualTo _lbCurSel)} do {
			if(_markerSp inPolygon (oev_conquestData select 1 select 1)) then {
				if (!isNil "oev_conquestData" && oev_conquestData select 0) then {
						_spawnBtn ctrlEnable false;
						_spawnBtn ctrlSetText "征服活动";
						waitUntil {uiSleep 0.5; (lnbCurSelRow _ctrl) != _lbCurSel || !(oev_conquestData select 0) || !oev_inSpawnMenu;};
					};
				};
			if ((_ctrl lnbValue [_lbCurSel,0]) isEqualTo 1) then {
				_spawnBtn ctrlEnable false;
			} else {
				_spawnBtn ctrlSetText "重生";
				_spawnBtn ctrlEnable true;
			};
			_tSpawnBtn ctrlSetText format ["重生点选择 | 当前在线警察: %1", {side _x isEqualTo west} count playableUnits];
			uiSleep 0.5;
		};
	};
	if (playerSide isEqualTo independent) then {
		private _fedActive = false;
		private _obj = objNull;
		private _marker = (_sp select 0);
		if(_markerSp inPolygon (oev_conquestData select 1 select 1) && (!isNil "oev_conquestData" && oev_conquestData select 0)) then {
			_spawnBtn ctrlEnable false;
			_spawnBtn ctrlSetText "征服活动";
			waitUntil {uiSleep 0.5; (lnbCurSelRow _ctrl) != _lbCurSel || !(oev_conquestData select 0) || !oev_inSpawnMenu;};
		} else {
			_spawnBtn ctrlSetText "重生";
			_spawnBtn ctrlEnable true;
		};
		// DOES NOT CURRENTLY HAVE FUNCTIONALITY FOR MORE THAN 1 EVENT AT A TIME. Loop through some way in the future if this is needed
		switch (true) do {
			case ((fed_bank getVariable ["chargeplaced",false]) && (_marker isEqualTo "medic_spawn_2")): {_fedActive = true; _obj = fed_bank;};
			case ((jailwall getVariable ["chargeplaced",false]) && (_marker isEqualTo "medic_spawn_3")): {_fedActive = true; _obj = jailwall;};
			case ((life_bwObj getVariable ["chargeplaced",false]) && (_marker isEqualTo "medic_spawn_4")): {_fedActive = true; _obj = life_bwObj;};
		};
		if (_fedActive) then {
			_spawnBtn ctrlEnable false;
			waitUntil{uiSleep 0.1; (!((lnbCurSelRow _ctrl) isEqualTo _lbCurSel) || !(_obj getVariable ["chargeplaced",false]))};
			_spawnBtn ctrlEnable true;
		};
	};
};
