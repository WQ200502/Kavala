//  File: fn_deathScreen.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Handles stuff being displayed on the death screen while
//	it is currently active.
private["_medicsOnline","_medicsNear","_maxDeathTime","_disableMedButton","_reviveCost","_medicHRank","_medicUnits","_medicRank","_highestRank","_medicHRPlayer"];
disableSerialization;

_medicsOnline = ((findDisplay 7300) displayCtrl 7304);
_medicsNear = ((findDisplay 7300) displayCtrl 7305);
_medicHRank = ((findDisplay 7300) displayCtrl 7310);
_medicButton = ((findDisplay 7300) displayCtrl 7303);
_bleedOutTimer = ((findDisplay 7300) displayCtrl 7308);
_maxDeathTime = player getVariable "maxrevtime";
_medicHRPlayer = objNull;



if(O_stats_playtime_civ > 6000) then {
	_medicButton ctrlSetText "请求医生(15k元)";
} else {
	_medicButton ctrlSetText "请求医生(10k元)";
};

_disableMedButton = false;
if(O_stats_playtime_civ > 6000) then {
	_reviveCost = (call oev_revive_fee)
} else {
	_reviveCost = (call oev_reduced_revive_fee)
};
if (oev_atmcash < _reviveCost) then {
		_medicButton ctrlEnable false;
		_disableMedButton = true;
		systemChat "您负担不起医疗服务。";
	};

if (((oev_is_arrested select 0) == 1)) then {
	_medicButton ctrlEnable false;
	_disableMedButton = true;
	systemChat "囚犯不能请求医生。";
};

waitUntil {
  _highestRank = -1;
	_nearby = if([independent,oev_deathPosition,20000] call OEC_fnc_nearUnits) then {"所有医生都在20公里外"} else {"No medics within 20km"};
	_unsorted = [];
	_sorted = [];
  _medicUnits = [];
	if(_nearby != "20公里内没有医生") then {
		{
			if(side _x isEqualTo independent && {(_x getVariable ["isInEvent",["no"]]) isEqualTo ["no"]}) then {
				_unsorted pushBack _x;
			};
		} forEach playableUnits;

		if (count _unsorted isEqualTo 0) exitWith {_nearby = "20公里内没有医生"};

		{
			 _closest = _unsorted select 0;
			 {if ((getPos _x distance oev_deathPosition) < (getPos _closest distance oev_deathPosition)) then {_closest = _x}} forEach _unsorted;
			 _sorted pushBack _closest;
			 _unsorted = _unsorted - [_closest]
		} forEach _unsorted;
		_closest = (_sorted select 0);

		_nearby = format["%1 (%2 km)",name _closest, (round(getPos _closest distance oev_deathPosition)/1000)];
	};

	{
		if(side _x isEqualTo independent) then	{
			_medicUnits pushBack _x;
		};
	} forEach playableUnits;

	_medicCount = count _medicUnits;
  if(_medicCount == 0) then {
		_medicButton ctrlEnable false;
	} else {
    {
      _medicRank = (_x getVariable["rank",0]);
      if(_medicRank > _highestRank) then {
        _highestRank = _medicRank;
        _medicHRPlayer = _x;
      };
    } forEach _medicUnits;
		if (!oev_request_timer || !(life_corpse getVariable["denialRequest",false])) then {
			_medicButton ctrlEnable true;
		};
	};


	if (_disableMedButton) then {_medicButton ctrlEnable false;};
	_medicsOnline ctrlSetText format[localize "STR_Medic_Online",_medicCount];
	_medicsNear ctrlSetText format["最近的医生: %1",_nearby];
	if(isNull _medicHRPlayer) then {
		_medicHRank ctrlSetText format["最高等级：无", ([_medicHRPlayer, _highestRank] call OEC_fnc_medicParseRank)];
	} else {
  	_medicHRank ctrlSetText format["最高等级: %1", ([_medicHRPlayer, _highestRank] call OEC_fnc_medicParseRank)];
	};
	if (serverTime > _maxDeathTime) then {
		closeDialog 0; oev_respawned = true; [] spawn OEC_fnc_spawnMenu;
	} else {
		_bleedOutTimer ctrlSetStructuredText parseText format["<t align='center'>你会失血过多的: %1</t>",[round(_maxDeathTime - serverTime),"MM:SS"] call BIS_fnc_secondsToString];
	};
	uiSleep 0.5;
	(isNull (findDisplay 7300))
};
