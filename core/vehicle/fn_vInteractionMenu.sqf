//  File: fn_vInteractionMenu.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Replaces the mass for various vehicle actions

#include <interaction.h>
private["_display","_curTarget","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7"];
if (oev_lockpick) exitWith {};
if(!dialog) then {
	["vInteraction_Menu"] call OEC_fnc_createDialog;
};
disableSerialization;
_curTarget = param [0,ObjNull,[ObjNull]];
if(isNull _curTarget) exitWith {closeDialog 0;}; //Bad target
private _trainVehicle = nearestObject[[29766.3,575.904,0],"I_MRAP_03_F"];
_isVehicle = if(((_curTarget isKindOf "landVehicle") || (_curTarget isKindOf "Ship") || (_curTarget isKindOf "Air") || (_curTarget isEqualTo _trainVehicle)) && !(typeOf _curTarget isEqualTo "B_Parachute_02_F")) then {true} else {false};
if(!_isVehicle) exitWith {closeDialog 0;};
_display = findDisplay 37400;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;
_Btn3 = _display displayCtrl Btn3;
_Btn4 = _display displayCtrl Btn4;
_Btn5 = _display displayCtrl Btn5;
_Btn6 = _display displayCtrl Btn6;
_Btn7 = _display displayCtrl Btn7;
_Btn8 = _display displayCtrl Btn8;
life_vInact_curTarget = _curTarget;
private _dlcID = getObjectDLC _curTarget;

//Mark button
if !(life_vInact_curTarget getVariable["markedForAntiDespawn",false]) then {
	(_display displayCtrl 444444) ctrlEnable true;
} else {
	(_display displayCtrl 444444) ctrlEnable false;
};

//Set Repair Action
_Btn1 ctrlSetText localize "STR_vInAct_Repair";
_Btn1 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_repairTruck; closeDialog 0;";

if(damage _curTarget < 1) then {_Btn1 ctrlEnable true;} else {_Btn1 ctrlEnable false;};
if(playerSide isEqualTo independent) then {_Btn1 ctrlEnable true;};

if(playerSide isEqualTo west) then {
	if (typeOf _curTarget in ["O_Truck_03_repair_F","O_Truck_03_ammo_F","B_Truck_01_ammo_F","O_LSV_02_armed_F"]) then {_Btn2 ctrlEnable false; _Btn3 ctrlEnable false; _Btn5 ctrlEnable false;};
	_Btn2 ctrlSetText localize "STR_vInAct_Registration";
	_Btn2 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_searchVehAction;";

	_Btn3 ctrlSetText localize "STR_vInAct_SearchVehicle";
	_Btn3 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_vehInvSearch;";

	_Btn4 ctrlSetText localize "STR_vInAct_PullOut";
	_Btn4 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_pulloutAction; closeDialog 0;";
	if ((count crew _curTarget != 0) && ({alive _x} count crew _curTarget) isEqualTo 0) then {
	_Btn4 ctrlSetText "退出昏迷";
	_Btn4 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_pulloutDeadAction;";
	_Btn4 ctrlEnable true;
	};
	if(count crew _curTarget isEqualTo 0) then {_Btn4 ctrlEnable false;};

	_Btn5 ctrlSetText localize "STR_vInAct_Impound";
	_Btn5 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_impoundAction; closeDialog 0;";

	_Btn6 ctrlSetText "收缴车辆";
    _Btn6 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_seizeAction; closeDialog 0;";

    if((life_vInact_curTarget getVariable["side",""]) isEqualTo "cop") then {_Btn6 ctrlEnable false;};
		if(life_vInact_curTarget getVariable["apdEscort",false] isEqualTo true) then {_Btn6 ctrlEnable false; _Btn5 ctrlEnable false;};

	if(_curTarget isKindOf "Ship") then {
		_Btn7 ctrlSetText localize "STR_vInAct_PushBoat";
		_Btn7 buttonSetAction "[] spawn OEC_fnc_pushObject; closeDialog 0;";
		if(_curTarget isKindOf "Ship" && {local _curTarget} && {count crew _curTarget == 0}) then { _Btn7 ctrlEnable true;} else {_Btn7 ctrlEnable false};
	} else {
		if(typeOf (_curTarget) in ["C_Kart_01_Blu_F","C_Kart_01_Red_F","C_Kart_01_F","C_Kart_01_Vrana_F"]) then {
			_Btn7 ctrlSetText localize "STR_vInAct_GetInKart";
			_Btn7 buttonSetAction "player moveInDriver life_vInact_curTarget; closeDialog 0;";
			if(count crew _curTarget == 0 && {canMove _curTarget} && {locked _curTarget == 0}) then {_Btn7 ctrlEnable true;} else {_Btn7 ctrlEnable false};
		} else {
			if(typeOf (_curTarget) in ["C_Plane_Civil_01_F","C_Plane_Civil_01_racing_F","O_Plane_CAS_02_F","B_Plane_CAS_01_F","I_Plane_Fighter_03_CAS_F","I_Plane_Fighter_04_F","B_Plane_Fighter_01_F","O_Plane_Fighter_02_F"]) then {
    			_Btn7 ctrlSetText localize "STR_vInAct_PushPlane";
				_Btn7 buttonSetAction "[] spawn OEC_fnc_pushObject; closeDialog 0;";
				if(_curTarget isKindOf "Air" && {local _curTarget} && {count crew _curTarget == 0}) then {_Btn7 ctrlEnable true;} else {_Btn7 ctrlEnable false;};
			} else {
				_Btn7 ctrlSetText localize "STR_vInAct_Unflip";
				_Btn7 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_flipAction; closeDialog 0;";
				if(count crew _curTarget == 0 && {canMove _curTarget}) then { _Btn7 ctrlEnable false;} else {_Btn7 ctrlEnable true;};
			};
		};
	};

	if (locked _curTarget isEqualTo 2) then {
		_Btn8 ctrlSetText "修身的吉姆·基斯";
    	_Btn8 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_slimJim; closeDialog 0;";
    } else {
    	if (!isNil "_dlcID") then {
    		if !(_dlcID in getDLCs 1) then {
    			_Btn8 ctrlSetText "上车";
					_Btn8 buttonSetAction "player moveInDriver life_vInact_curTarget; closeDialog 0;";
					if ((isNull (driver _curTarget)) && {canMove _curTarget} && {locked _curTarget isEqualTo 0}) then {_Btn8 ctrlEnable true;} else {_Btn8 ctrlEnable false;};
    		} else {
    			_Btn8 ctrlSetText "修身的吉姆·基斯";
    			_Btn8 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_slimJim; closeDialog 0;";
    		};
    	} else {
    		_Btn8 ctrlSetText "修身的吉姆·基斯";
    		_Btn8 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_slimJim; closeDialog 0;";
    	};
    };
} else {
	if (playerSide isEqualTo independent && !oev_newsTeam) then {
		_Btn2 ctrlSetText "拉出无意识玩家";
		_Btn2 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_pulloutDeadAction;";
		_Btn2 ctrlEnable false;
		if ((count crew _curTarget != 0) && ({alive _x} count crew _curTarget) isEqualTo 0) then {
			_Btn2 ctrlEnable true
		};
	} else {
		_Btn2 ctrlSetText localize "STR_vInAct_PullOut";
		_Btn2 buttonSetAction "[life_vInact_curTarget,false] spawn OEC_fnc_pulloutAction;";
		if((count crew _curTarget == 0) || (currentWeapon player == "") || (currentWeapon player in oev_fake_weapons)) then {_Btn2 ctrlEnable false;};
	};

	if(_curTarget isKindOf "Ship") then {
		_Btn3 ctrlSetText localize "STR_vInAct_PushBoat";
		_Btn3 buttonSetAction "[] spawn OEC_fnc_pushObject; closeDialog 0;";
		if(_curTarget isKindOf "Ship" && {local _curTarget} && {count crew _curTarget == 0}) then { _Btn3 ctrlEnable true;} else {_Btn3 ctrlEnable false};
	} else {
		if(typeOf (_curTarget) in ["C_Kart_01_Blu_F","C_Kart_01_Red_F","C_Kart_01_F","C_Kart_01_Vrana_F"]) then {
			_Btn3 ctrlSetText localize "STR_vInAct_GetInKart";
			_Btn3 buttonSetAction "player moveInDriver life_vInact_curTarget; closeDialog 0;";
			if(count crew _curTarget == 0 && {canMove _curTarget} && {locked _curTarget == 0}) then {_Btn3 ctrlEnable true;} else {_Btn3 ctrlEnable false};
		} else {
			if(typeOf (_curTarget) in ["C_Plane_Civil_01_F","C_Plane_Civil_01_racing_F","O_Plane_CAS_02_F","B_Plane_CAS_01_F","I_Plane_Fighter_03_CAS_F","I_Plane_Fighter_04_F","B_Plane_Fighter_01_F","O_Plane_Fighter_02_F"]) then {
    			_Btn3 ctrlSetText localize "STR_vInAct_PushPlane";
				_Btn3 buttonSetAction "[] spawn OEC_fnc_pushObject; closeDialog 0;";
				if(_curTarget isKindOf "Air" && {local _curTarget} && {count crew _curTarget == 0}) then {_Btn7 ctrlEnable true;} else {_Btn7 ctrlEnable false;};
			} else {
				_Btn3 ctrlSetText localize "STR_vInAct_Unflip";
				_Btn3 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_flipAction; closeDialog 0;";
				if(count crew _curTarget == 0 && {canMove _curTarget}) then { _Btn3 ctrlEnable false;} else {_Btn3 ctrlEnable true;};
			};
		};
	};

	if(typeOf _curTarget == "O_Truck_03_device_F" && {_curTarget in oev_vehicles}) then {
		_Btn5 ctrlSetText localize "STR_vInAct_DeviceMine";
		_Btn5 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_deviceMine";
		if(!isNil {(_curTarget getVariable "mining")} || !local _curTarget && {_curTarget in oev_vehicles}) then {
			_Btn5 ctrlEnable false;
		} else {
			_Btn5 ctrlEnable true;
		};
	} else {
		_Btn5 ctrlSetText "开锁车";
		_Btn5 buttonSetAction "[] spawn OEC_fnc_lockpick; closeDialog 0;";
		if (_curTarget in oev_vehicles || life_inv_lockpick <= 0) then {
			_Btn5 ctrlEnable false;
		} else {
			_Btn5 ctrlEnable true;
		};
	};

	if((playerSide isEqualTo independent) && !(oev_newsTeam)) then {
		_Btn4 ctrlSetText localize "STR_vInAct_Registration";
		_Btn4 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_searchVehAction;";
		_Btn4 ctrlShow true;
		_Btn4 ctrlEnable true;

		if ((call life_medicLevel) >= 3) then {
			_Btn5 ctrlSetText localize "STR_vInAct_Impound";
			_Btn5 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_impoundAction; closeDialog 0;";
			_Btn5 ctrlShow true;
			_Btn5 ctrlEnable true;
			if(life_vInact_curTarget getVariable["apdEscort",false] isEqualTo true) then {_Btn5 ctrlEnable false;};
		};
	} else {
		if ((count crew _curTarget != 0) && ({alive _x} count crew _curTarget) isEqualTo 0) then {
			_Btn4 ctrlSetText "拉出无意识玩家";
			_Btn4 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_pulloutDeadAction;";
			_Btn4 ctrlEnable true;
		} else {
			if (playerSide isEqualTo civilian) then {
				_Btn4 ctrlSetText localize "STR_vInAct_Registration";
				_Btn4 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_searchVehAction;";
				_Btn4 ctrlEnable true;
			};
		};
	};

	_Btn8 ctrlShow false;
	if (life_vInact_curTarget getVariable ["lights",false]) then {
		_Btn8 ctrlShow true;
		_Btn8 ctrlSetText "关灯";
	 	_Btn8 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_sirenLights; closeDialog 0;";
	};

	if (playerSide isEqualTo civilian) then {
		_Btn6 ctrlShow true;
		_Btn6 ctrlSetText "拿钥匙";
		_Btn6 buttonSetAction "[life_vInact_curTarget, player, profileName ,true] spawn OEC_fnc_clientGetKey; closeDialog 0;";
		if ((life_vInact_curTarget getVariable ["gangID",0] isEqualTo 0) || !((life_vInact_curTarget getVariable ["gangID",0]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0))) then {_Btn6 ctrlShow false;_Btn6 ctrlEnable false;} else {_Btn6 ctrlShow true;_Btn6 ctrlEnable true;};

		if(!isNil {(_curTarget getVariable "unblockVeh")}) then {
			_Btn6 ctrlSetText "取消阻止刷车";
			_Btn6 buttonSetAction "[life_vInact_curTarget] spawn OEC_fnc_impoundAction; closeDialog 0;";
			_Btn6 ctrlShow true;
			_Btn6 ctrlEnable true;
		};
	} else {
		_Btn6 ctrlShow false;
	};

	if (!isNil "_dlcID") then {
		if !(_dlcID in getDLCs 1) then {
			_Btn7 ctrlSetText "上车";
			_Btn7 buttonSetAction "player moveInDriver life_vInact_curTarget; closeDialog 0; if(typeOf(life_vInact_curTarget) in [""C_Plane_Civil_01_F"",""C_Plane_Civil_01_racing_F""] && !((life_vInact_curTarget getVariable [""cargoDestination"",0]) isEqualTo 0)) then {[life_vInact_curTarget] spawn OEC_fnc_planeDeliveryMarker;};";
			if ((isNull (driver _curTarget)) && {canMove _curTarget} && {locked _curTarget isEqualTo 0}) then {_Btn7 ctrlEnable true;} else {_Btn7 ctrlEnable false;};
		} else {
			_Btn7 ctrlShow false;
		};
	} else {
		_Btn7 ctrlShow false;
	};
};
