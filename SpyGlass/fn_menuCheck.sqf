#include "..\macro.h"
//	Author: Bryan "Tonic" Boardwine
//	Description: Checks for known cheat menus and closes them then reports them to the server. DESCRIPTIONEND

private["_displays","_detection","_display","_timeStamp"];
disableSerialization;

_displays = [
	[3030,"BIS_configviewer_display"],["RscDisplayMultiplayer","RscDisplayMultiplayer"],[162,"RscDisplayFieldManual"],["RscDisplayRemoteMissions","RscDisplayRemoteMissions"],[316000,"RscDisplayDebugPublic"],[125,"RscDisplayEditDiaryRecord"],
	[69,"UnknownDisplay"],[19,"UnknownDisplay"],[71,"UnknownDisplay"],[45,"UnknownDisplay"],[132,"UnknownDisplay"],[32,"UnknownDisplay"],[165,"RscDisplayPublishMission"],[2727,"RscDisplayLocWeaponInfo"],
	["RscDisplayMovieInterrupt","RscDisplayMovieInterrupt"],[157,"UnknownDisplay"],[30,"UnknownDisplay"],["RscDisplayArsenal","RscDisplayArsenal"],[166,"RscDisplayPublishMissionSelectTags"],[167,"RscDisplayFileSelect"]
];

_detection = false;
_timeStamp = time;

while {true} do {
	{
		_targetDisplay = _x select 0;
		_targetName = _x select 1;

		switch(typeName _targetDisplay) do {
			case (typeName ""): {if(!isNull (GVAR_UINS [_targetDisplay,displayNull])) exitWith {_detection = true;};};
			default {
				if(!(_targetDisplay == 316000)) then {
					if(!isNull (findDisplay _targetDisplay)) exitWith {_detection = true;};
				}else{
					if(!isNil "life_adminlevel") then {
						if(__GETC__(life_adminlevel) < 1) then {
							if(!isNull (findDisplay _targetDisplay)) exitWith {_detection = true;};
						};
					}else{
						if(!isNull (findDisplay _targetDisplay)) exitWith {_detection = true;};
					};
				};
			};
		};

		if(_detection) exitWith {
			[[profileName,steamid,format["MenuBasedHack_%1",_targetName]],"OEC_fnc_cookieJar",false,false] call OEC_fnc_MP;
			[[3,player,[format["Menu Hack_%1",_targetName]]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
			[[profileName,format["Menu Hack: %1",_targetName]],"OEC_fnc_notifyAdmins",-2,false] call OEC_fnc_MP;
			sleep 0.5;
			SPYGLASS_END
		};
	}foreach _displays;

	if(_detection) exitWith {};

	SpyGlass_lastCheckTime = time;

	/* A very old menu that can cause false-positives so we close it */
	if(!isNull (findDisplay 129)) then {
		closeDialog 0;
	};

	/*
	_display = findDisplay 602;
	if(!isNull _display && {count (allControls _display) > 85}) then {
		_count = count allControls _display;
		[[profileName,steamid,format["MenuBasedHack_RscDisplayInventory_Controls_%1",_count]],"OEC_fnc_cookieJar",false,false] call OEC_fnc_MP;
		[[profileName,format["Menu Hack: RscDisplayInventory number of controls do not match (Count %1)",_count]],"OEC_fnc_notifyAdmins",-2,false] call OEC_fnc_MP;
		closeDialog 0;
		SPYGLASS_END
	};
	*/

	if(!isNull (findDisplay 148)) then {
		sleep 0.5;
		if((lbSize 104)-1 > 3) exitWith {
			[[profileName,steamid,"MenuBasedHack_RscDisplayConfigureControllers"],"OEC_fnc_cookieJar",false,false] call OEC_fnc_MP;
			[[3,player,["Menu Hack: RscDisplayConfigureControllers (JME 313)"]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
			[[profileName,"Menu Hack: RscDisplayConfigureControllers (JME 313)"],"OEC_fnc_notifyAdmins",-2,false] call OEC_fnc_MP;
			closeDialog 0;
			SPYGLASS_END
		};
	};

	_display = findDisplay 54;
	if(!isNull _display) then {
		{
			if (_x && !isNull _display) exitWith {
				[[profileName,steamid,"MenuBasedHack_RscDisplayInsertMarker"],"OEC_fnc_cookieJar",false,false] call OEC_fnc_MP;
				[[3,player,["Menu Hack: RscDisplayInsertMarker"]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
				[[profileName,"Menu Hack: RscDisplayInsertMarker"],"OEC_fnc_notifyAdmins",-2,false] call OEC_fnc_MP;
				closeDialog 0;
				SPYGLASS_END
			};
		} forEach [
			(toLower ctrlText (_display displayCtrl 1001) != toLower localize "STR_A3_RscDisplayInsertMarker_Title"),
			{if (buttonAction (_display displayCtrl _x) != "") exitWith {true}; false} forEach [1,2]
		];
	};

	_display = findDisplay 131;
	if(!isNull _display) then {
		//These shouldn't be here...
		(_display displayCtrl 102) ctrlRemoveAllEventHandlers "LBDblClick";
		(_display displayCtrl 102) ctrlRemoveAllEventHandlers "LBSelChanged";

		{
			if (_x && !isNull _display) exitWith {
				[[profileName,steamid,"MenuBasedHack_RscDisplayConfigureAction"],"OEC_fnc_cookieJar",false,false] call OEC_fnc_MP;
				[[3,player,["Menu Hack: RscDisplayConfigureAction"]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
				[[profileName,"Menu Hack: RscDisplayConfigureAction"],"OEC_fnc_notifyAdmins",-2,false] call OEC_fnc_MP;
				closeDialog 0;
				SPYGLASS_END
			};
		} forEach [
			(toLower ctrlText (_display displayCtrl 1000) != toLower localize "STR_A3_RscDisplayConfigureAction_Title"),
			{if (buttonAction (_display displayCtrl _x) != "") exitWith {true}; false} forEach [1,104,105,106,107,108,109]
		];
	};

	_display = findDisplay 163;
	if(!isNull _display) then {
		(_display displayCtrl 101) ctrlRemoveAllEventHandlers "LBDblClick";
		(_display displayCtrl 101) ctrlRemoveAllEventHandlers "LBSelChanged";

		{
			if (_x && !isNull _display) exitWith {
				[[profileName,steamid,"MenuBasedHack_RscDisplayControlSchemes"],"OEC_fnc_cookieJar",false,false] call OEC_fnc_MP;
				[[3,player,["Menu Hack: RscDisplayControlSchemes"]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
				[[profileName,"Menu Hack: RscDisplayControlSchemes"],"OEC_fnc_notifyAdmins",-2,false] call OEC_fnc_MP;
				closeDialog 0;
				SPYGLASS_END
			};
		} forEach [
			(toLower ctrlText (_display displayCtrl 1000) != toLower localize "STR_DISP_OPTIONS_SCHEME"),
			{if (buttonAction (_display displayCtrl _x) != "") exitWith {true}; false} forEach [1,2]
		];
	};

	/* We'll just move the no-recoil check into this thread. */
	if((getAnimAimPrecision player) < 0.05) then {
		[[profileName,steamid,"No_recoil_hack"],"OEC_fnc_cookieJar",false,false] spawn OEC_fnc_MP;
		[[3,player,["No recoil hack, this detection is possibly a false positive"]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
		[[profileName,format["No recoil hack, this detection is possibly a false positive, maybe not. Aim coefficient = %1",getAnimAimPrecision player]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
		sleep 1;
		//failMission "SpyGlass"; Due to false positives, only log it for now
	};
	if (((unitRecoilCoefficient player) < 1) && ((unitRecoilCoefficient player) != -1)) then {
		[[profileName,steamid,"No_recoil_hack"],"OEC_fnc_cookieJar",false,false] spawn OEC_fnc_MP;
		[[3,player,["No recoil hack, this detection is possibly a false positive"]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
		[[profileName,format["No recoil hack, this detection is possibly a false positive, maybe not. Aim coefficient = %1",unitRecoilCoefficient player]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
		sleep 1;
		player setUnitRecoilCoefficient 1;
		//failMission "SpyGlass"; Due to false positives, only log it for now
	};
	if((getAnimSpeedCoef player) > 1.1) then {
		[[profileName,steamid,"Speed_hack"],"OEC_fnc_cookieJar",false,false] spawn OEC_fnc_MP;
		[[3,player,[format["Speed Hack | Anim coefficient = %1",getAnimSpeedCoef player]]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
		[[profileName,format["Speed hack, this detection is possibly a false positive, maybe not. Anim coefficient = %1",getAnimSpeedCoef player]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
		player setAnimSpeedCoef 1;
		sleep 1;
		//failMission "SpyGlass"; Not really sure if this is ever changed?? We will see
	};
  if (getCustomAimCoef player <= 0.05) then {
    //[10, player, [getCustomAimCoef player]] remoteExec ["OES_fnc_handleDisc",2];
   [profileName,format ["<br/><t color='#FFFF00'>Bad Aim Coef:<t color='#FFFFFF'> %1<t color='#FFFF00'>",getCustomAimCoef player]] call OEC_fnc_notifyAdmins;
  };

	/*
		Display Validator
		Loops through and makes sure none of the displays were modified..

		Checks every 5 minutes.
	*/
	uiSleep 10;
};
