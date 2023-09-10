// File: fn_autoRun.sqf
// Authors: "Austin" ikiled and TheCmdrRex
// Description: Starts script to run if Custom action 18 is pressed.
#include "..\..\macro.h"

if(scriptAvailable(5)) exitWith {hint "Please do not spam autorun!";};

params[];

oev_autorun = not oev_autorun;
oev_autoswim = false;
oev_interrupted = false;

if (oev_autorun) then
{
	titleText ["Starting Auto Run... Move or press tab to stop","PLAIN DOWN"];

	if(currentWeapon player != "") then {
		life_curWep_h = currentWeapon player; // Player automatically holsters weapon prior to running
		player action ["SwitchWeapon", player, player, 100];
		player switchCamera cameraView;
	};

		12 cutRsc ["life_autorun","PLAIN DOWN"];
		_uiDisp = uiNamespace getVariable "life_autorun";
		_timer = _uiDisp displayCtrl 38310;
		_timer ctrlSetText "自动跑步生效";

	while {oev_autorun} do {
			// Checks before running
		if(oev_interruptedTab) exitWith {
			oev_interruptedTab = false;
			oev_autorun = false;
			titleText["自动跑步已被取消","PLAIN DOWN"];
			player playMoveNow "stop";
			12 cutText["","PLAIN DOWN"];
		};

		if(oev_interrupted) exitWith {
			oev_interrupted = false;
			oev_autorun = false;
			titleText["自动跑步已被取消","PLAIN DOWN"];
			player playMoveNow "stop";
			12 cutText["","PLAIN DOWN"];
		};

		if (oev_action_inUse) exitWith {
			oev_autorun = false;
			oev_interrupted = false;
			oev_action_inUse = false;
			titleText["自动跑步已被取消","PLAIN DOWN"];
			player playMoveNow "stop";
			12 cutText["","PLAIN DOWN"];
		};

		if (oev_lockpick) exitWith {
			oev_autorun = false;
			oev_interrupted = false;
			oev_action_inUse = false;
			titleText["自动跑步已被取消","PLAIN DOWN"];
			player playMoveNow "stop";
			12 cutText["","PLAIN DOWN"];
		};

		if (oev_is_processing) exitWith {
			oev_autorun = false;
			oev_interrupted = false;
			titleText["自动跑步已被取消","PLAIN DOWN"];
			player playMoveNow "stop";
			12 cutText["","PLAIN DOWN"];
		};

		if !(alive player) exitWith {
			oev_autorun = false;
			oev_interrupted = false;
			12 cutText["","PLAIN DOWN"];
		};

		if ((diag_tickTime - oev_healingTime) <= 8) exitWith {
			oev_autorun = false;
			oev_interrupted = false;
			titleText["您无法在康复时奔跑！","PLAIN DOWN"];
			player playMoveNow "stop";
			12 cutText["","PLAIN DOWN"];
		};

		if !(isTouchingGround player || surfaceIsWater position player) exitWith {
			oev_autorun = false;
			oev_interrupted = false;
			titleText["您需要在陆地上或在水中自动跑步！","PLAIN DOWN"];
			player playMoveNow "stop";
			12 cutText["","PLAIN DOWN"];
		};

		if (oev_isDowned) exitWith {
			oev_autorun = false;
			oev_interrupted = false;
			titleText["自动跑步已被取消","PLAIN DOWN"];
			player playMoveNow "stop";
			12 cutText["","PLAIN DOWN"];
		};

		if (player getVariable["jailed",false]) exitWith {
			oev_autorun = false;
			oev_interrupted = false;
			titleText["您无法在监狱中自动跑步!","PLAIN DOWN"];
			player playMoveNow "stop";
			12 cutText["","PLAIN DOWN"];
		};

		if(vehicle player != player) exitWith {
			oev_autorun = false;
			oev_interrupted = false;
			oev_action_inUse = false;
			titleText["自动跑步已被取消","PLAIN DOWN"];
			player playMoveNow "stop";
			12 cutText["","PLAIN DOWN"];
		};

		if (player getHit "legs" >= 0.5) exitWith {
			oev_autorun = false;
			titleText["你不能一瘸一拐地跑！","PLAIN DOWN"];
			player playMoveNow "stop";
			12 cutText["","PLAIN DOWN"];
		};

		if (getFatigue player isEqualTo 1) then {
			if(surfaceIsWater position player && !(isTouchingGround player)) then {
				if(uniform player in ["U_O_Wetsuit","U_I_Wetsuit","U_B_Wetsuit"]) then {
					player playMoveNow "advepercmrunsnonwnondf";
					oev_autoswim = true;
				} else {
					player playMoveNow "aswmpercmrunsnonwnondf";
					oev_autoswim = true;
				};
			} else {
				player playMoveNow "AmovPercMrunSnonWnonDf"; // Player runs slow when fatigued
			};

			// Player drinks their redgull/coffee/lollypop auto-matically when fatigued
			if((time - oev_redgull_effect) < 10) exitWith {_handled = true;}; // Prevents spamming the key and drink all yo redgulls
			if (player getVariable ["restrained",false]) exitWith {_handled = true;};
			if ((life_inv_redgull > 0) || (life_inv_coffee > 0) || (life_inv_lollypop > 0)) then {
				if ([false,"redgull",1] call OEC_fnc_handleInv) exitWith {
					["redgull"] spawn OEC_fnc_eatOrDrink;
					uisleep .2;
				};
				if ([false,"coffee",1] call OEC_fnc_handleInv) exitWith {
					["coffee"] spawn OEC_fnc_eatOrDrink;
					uisleep .2;
				};
				if ([false,"lollypop",1] call OEC_fnc_handleInv) exitWith {
					["lollypop"] spawn OEC_fnc_eatOrDrink;
					uisleep .2;
				};
			};
		};
		if (getFatigue player < 1) then {
			if(surfaceIsWater position player && !(isTouchingGround player)) then {
				if(uniform player in ["U_O_Wetsuit","U_I_Wetsuit","U_B_Wetsuit"]) then {
					player playMoveNow "advepercmrunsnonwnondf";
					oev_autoswim = true;
				} else {
					player playMoveNow "aswmpercmrunsnonwnondf";
					oev_autoswim = true;
				};
			} else {
				player playMoveNow "AmovPercMevaSnonWnonDf"; // Player runs fast when not fatigued
			};
		};
		if((surfaceIsWater position player && !oev_autoswim) || (!surfaceIsWater position player && oev_autoswim)) then {
			oev_autorun = false;
			oev_interrupted = false;
			oev_action_inUse = false;
			titleText["自动跑步已被取消","PLAIN DOWN"];
			player playMoveNow "stop";
			12 cutText["","PLAIN DOWN"];
		};
	};
}
else
{
		titleText["自动跑步已被取消","PLAIN DOWN"];
		player switchMove "";
		12 cutText["","PLAIN DOWN"];
};
