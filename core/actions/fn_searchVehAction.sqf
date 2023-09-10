//  File: fn_searchVehAction.sqf
private["_vehicle","_data","_gangID","_gangName"];
_vehicle = cursorTarget;
_gangID = _vehicle getVariable ["gangID",0];
_gangName = _vehicle getVariable ["gangName",""];

if (playerSide isEqualTo civilian && !(license_civ_driver)) exitWith {hint "你需要驾照才能找到登记证！";};
if(_vehicle getVariable "isBlackwater") exitWith {hint "黑水公司的这辆车还没有被认领！";};
if(_vehicle getVariable ["apdEscort",false]) exitWith {hint "这是APD护送车";};
if((_vehicle isKindOf "Car") || !(_vehicle isKindOf "Air") || !(_vehicle isKindOf "Ship")) then {
	private _owners = _vehicle getVariable "vehicle_info_owners";
	private _thieves = _vehicle getVariable ["vehicle_info_lockpicked",[]];
	if(isNil {_owners} && (_gangID isEqualTo 0)) exitWith {hint "找不到此车辆的信息。这可能是个小故障。";};
	oev_action_inUse = true;
	hint localize "STR_NOTF_Searching";
	uiSleep 3;
	oev_action_inUse = false;
	if(player distance _vehicle > 10 || !alive player || !alive _vehicle) exitWith {hint localize "STR_NOTF_SearchVehFail";};
	private _isStolen = false;
	private _stolenVehicles = missionNamespace getVariable ["oev_cop_stolenVehicles", []];
	if (_stolenVehicles findIf { _x param [0, objNull, [objNull]] == _vehicle } >= 0) then {
		_isStolen = true;
	};

	if !(_gangID isEqualTo 0) then {
		if (_isStolen) then {
			_gangName = _gangName + "<br/><t color='#FF0000'><t size='1.5'>偷!</t></t>";
		};
		hint parseText format[localize "STR_NOTF_SearchVehGang",_gangName];
	} else {
		if ((_vehicle getVariable ["baited",false]) && (playerSide isEqualTo civilian)) then {
			private _randomCivs = [];
			{
				if (side _x isEqualTo civilian) then {
					_randomCivs pushBack _x;
				};
			} forEach playableUnits;
			_owners = format["%1<br/>",name (selectRandom _randomCivs)];
		} else {
			_owners = [_owners,_thieves] call OEC_fnc_vehicleOwners;
		};

		if(_owners == "任何<br/>") then {
			_owners = "没有主人，扣押它<br/>";
		};

		if (_isStolen) then {
			_owners = _owners + "<br/><t color='#FF0000'><t size='1.5'>偷!</t></t>";
		};

		hint parseText format[localize "STR_NOTF_SearchVeh",_owners];
	};
};
