//  File: fn_repairTruck.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Main functionality for toolkits, to be revised in later version.
private["_veh","_upp","_ui","_progress","_pgText","_cP","_displayName","_vehDamage"];

// list of classnames that should never require R&R repair after toolkit use
// (eg planes that can't take off if engine is yellow)
private _FULL_REPAIR_VEHICLES = ["C_Plane_Civil_01_racing_F", "C_Plane_Civil_01_F"];

_veh = cursorTarget;
private _dam_obj = _veh;
if (oev_action_inUse) exitWith {hint "你已经在执行另一个动作了！";};
oev_interrupted = false;
oev_interruptedTab = false;
if (isNull _veh) exitwith {};
if ((_veh isKindOf "Car") || (_veh isKindOf "Ship") || (_veh isKindOf "Air")) then {
	oev_action_inUse = true;
	_displayName = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName");
	_upp = format[localize "STR_NOTF_Repairing",_displayName];
	/* repair vehicles based off of damage /x00 */
	if ((getDammage _veh) > 0.03) then {
		_vehDamage = 0.01;
	} else {
		if((getDammage _veh) > 0.02) then {
			_vehDamage = 0.25;
		} else {
			if((getDammage _veh) > 0.01) then {
				_vehDamage = 0.50;
			} else {
				_vehDamage = 0.75;
			};
		};
	};
	_cP = _vehDamage;
	//Setup our progress bar.
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN DOWN"];
	_ui = uiNameSpace getVariable "life_progress";
	_progress = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	_progress progressSetPosition _vehDamage;

	private _sleepVal = 0.25;
	if !("ToolKit" in (items player)) then {
		_sleepVal = 0.75;
		if(playerSide isEqualTo independent) then {
			_sleepVal = 0.25
		}
	} else {
		if(_cp < .1) then {
			_sleepVal = 0.12;
		}
	};
	private _cpRateChange = 1;
	if (playerSide isEqualTo independent) then {
		private _perkTier = ["med_toolkits"] call OEC_fnc_fetchStats;
		_cpRateChange = switch (_perkTier) do {
			case 1: {1.05};
			case 2: {1.10};
			case 3: {1.15};
			case 4: {1.20};
			case 5: {1.25};
			default {1};
		};
	};
	["AinvPknlMstpSnonWnonDnon_medic_1",1.5] spawn OEC_fnc_handleAnim;
	while {true} do {
		uiSleep _sleepVal;
		_cP = _cP + (0.01 * _cpRateChange);
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
		if(_cP >= 1) exitWith {};
		if(!alive player) exitWith {};
		if(player != vehicle player) exitWith {};
		if(oev_interrupted) exitWith {};
		if(oev_interruptedTab) exitWith {};
	};

	oev_action_inUse = false;
	5 cutText ["","PLAIN DOWN"];
	[] spawn OEC_fnc_handleAnim;
	if(!alive player) exitWith {};
	if(oev_interrupted) exitWith {oev_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
	if(oev_interruptedTab) exitWith {oev_interruptedTab = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN DOWN"]; oev_action_inUse = false;};
	if(player != vehicle player) exitWith {titleText[localize "STR_NOTF_RepairingInVehicle","PLAIN DOWN"];};

	if (playerSide isEqualTo independent) then {
		if ("ToolKit" in (items player)) then {
			["med_toolkits",1] call OEC_fnc_statArrUp;
		} else {
			oev_atmcash = oev_atmcash - 5000;
			oev_cache_atmcash = oev_cache_atmcash - 5000;
			systemChat "你手头没有工具箱，还花了5000元修理这辆车。";
		};
		_dam_obj setDamage 0;
		titleText[localize "STR_NOTF_RepairedVehicle","PLAIN DOWN"];
	} else {
		if ("ToolKit" in (items player)) then {
			player removeItem "ToolKit";
			_dam_obj setDamage 0;
			titleText[localize "STR_NOTF_RepairedVehicle","PLAIN DOWN"];
		} else {
			if ((getDammage _veh) > 0.38 && !((typeOf _veh) in _FULL_REPAIR_VEHICLES)) then {
				_dam_obj setDamage 0.4;
				hint "你的车损坏太严重，无法完全修理。联系医生进行全面维修或牵引。";
			} else {
				if ((typeOf _veh) in _FULL_REPAIR_VEHICLES) then {
					_dam_obj setDamage 0;
					titleText[localize "STR_NOTF_RepairedVehicle","PLAIN DOWN"];
				} else {
					_dam_obj setDamage (getDammage _veh);
					hint "你的车已经修好了。由于没有工具箱，它可能需要额外的修理。";
				};
			};
		};
	};
};
