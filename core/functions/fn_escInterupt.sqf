//  File: fn_escInterupt.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Monitors when the ESC menu is pulled up and blocks off certain controls when conditions meet.
private["_abortButton","_respawnButton","_fieldManual","_escSync","_canUseControls","_time"];
disableSerialization;
((findDisplay 49) displayCtrl 122) ctrlEnable false;

_escSync ={
	private["_abortButton","_thread","_syncManager","_respawnButton"];
	disableSerialization;

	_syncManager ={
		disableSerialization;
		private["_abortButton","_timeStamp","_respawnButton"];
		_abortButton = (findDisplay 49) displayCtrl 104;
		_respawnButton = (findDisplay 49) displayCtrl 1010;
		_timeStamp = time + 10;
		if !(isNull(findDisplay 4500)) exitWith {closeDialog 0;};
		if(!isNil "life_adminlevel") then {
			if((call life_adminlevel) > 0) then {
				_timeStamp = time + 1;
			};
		};

		waitUntil {
			_abortButton ctrlSetText format[localize "STR_NOTF_AbortESC",round(_timeStamp - time)];
			_abortButton ctrlCommit 0;
			_respawnButton ctrlSetText format[localize "STR_NOTF_RespawnESC",round(_timeStamp - time)];
			_respawnButton ctrlCommit 0;
			round(_timeStamp - time) <= 0 || isNull (findDisplay 49)
		};

		_abortButton ctrlSetText localize "STR_DISP_INT_ABORT";
		_abortButton ctrlCommit 0;
		_respawnButton ctrlSetText "重生";
		_respawnButton ctrlCommit 0;
	};

	_abortButton = (findDisplay 49) displayCtrl 104;
	_respawnButton = (findDisplay 49) displayCtrl 1010;
	if(oev_session_completed) then {
		[] call OEC_fnc_ClupdateRequest; //call our silent sync.
	};

	if(_this) then {
		_thread = [] spawn _syncManager;
		waitUntil{scriptDone _thread || isNull (findDisplay 49)};
		_abortButton ctrlEnable true;
		if((([position player select 0,position player select 1,0] distance getMarkerPos("debug_island_marker")) > 600) && !(player getVariable ["BIS_revive_incapacitated", false])) then {
			_respawnButton ctrlEnable true;
		};
	};
};

_canUseControls ={
	if((player getVariable["restrained",FALSE]) || (oev_inCombat) || (player getVariable["Escorting",FALSE]) || (player getVariable["transporting",FALSE]) || (player getVariable ["BIS_revive_incapacitated", false])) then {false} else {true};
};

3 enableChannel [true, false];

while {true} do {
	waitUntil{uiSleep 0.05;!isNull (findDisplay 49)};
	((findDisplay 49) displayCtrl 122) ctrlEnable false;
	_abortButton = (findDisplay 49) displayCtrl 104;
	_abortButton buttonSetAction "[[player],""OES_fnc_cleanupRequest"",false,false] spawn OEC_fnc_MP; 3 enableChannel [true, false];";
	_respawnButton = (findDisplay 49) displayCtrl 1010;
	_respawnButton buttonSetAction "[] spawn OEC_fnc_respawnConfirm; 3 enableChannel [true, false];";



	//Block off our buttons first.
	_abortButton ctrlEnable false;
	_respawnButton ctrlEnable false;

	//Spawn extra items; Title then buttons
	_ctrlID = 90000;
	{
		_ctrl = findDisplay 49 ctrlCreate [format ["OlyEx%1", _x], _ctrlID];
		_ctrlID = _ctrlID + 1;
	} forEach ["Title", "Website", "Teamspeak", "Discord", "Stats", "Wiki"];
	// Move buttons when options (101) gets clicked and moves the others
	((findDisplay 49)displayCtrl 101) ctrlAddEventHandler ["ButtonClick", {
		// Using a spawn sync's the movement up with the other controls.
		[] spawn{
			_form = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			_form2 = (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2));
			_ctrlIDs = [[90000,7.5,3.2],[90001,8.62,4.32],[90002,9.72,5.42],[90003,10.8,6.52],[90004,11.9,7.6],[90005,13,8.7]];
			if !(uiNamespace getvariable "BIS_DisplayInterrupt_isOptionsExpanded") then {
				{
					_ctrl = ((findDisplay 49)displayCtrl (_x select 0));
					_ctrl ctrlSetPosition [ctrlPosition _ctrl select 0, (_x select 2) * _form + _form2];
					_ctrl ctrlCommit 0.2;
				}forEach _ctrlIDs;
			} else {
				{
					_ctrl = ((findDisplay 49)displayCtrl (_x select 0));
					_ctrl ctrlSetPosition [ctrlPosition _ctrl select 0, (_x select 1) * _form + _form2];
					_ctrl ctrlCommit 0.2;
				}forEach _ctrlIDs;
			};
		};
	}];

	[] spawn{
		while {!(isNull findDisplay 49)} do {
			waitUntil{uiSleep 0.05; isNull findDisplay 49 || !isNull (findDisplay 151 displayCtrl 146)};
			if ((vehicle player) isKindOf "Helicopter" && ctrlEnabled (findDisplay 151 displayCtrl 146)) then {
					(findDisplay 151 displayCtrl 146) ctrlEnable false; // Toggle model
					(findDisplay 151 displayCtrl 147) ctrlEnable false; // Show Gauges
					(findDisplay 151 displayCtrl 148) ctrlEnable false; // Rough Landing
					(findDisplay 151 displayCtrl 149) ctrlEnable false; // Wind Dynamics
					(findDisplay 151 displayCtrl 150) ctrlEnable false; // Auto Trim
					(findDisplay 151 displayCtrl 151) ctrlEnable false; // Stress Damage
			};
			waitUntil{uiSleep 0.05; isNull findDisplay 49 || isNull (findDisplay 151 displayCtrl 146)};
		};
	};

	if !((call life_adminlevel) > 0) then {
		if (oev_inCombat) then {
			while {oev_inCombat && !isNull (findDisplay 49)} do {
				_time = round((oev_inCombatTime + 40) - diag_tickTime);
				_abortButton ctrlSetText format["Abort Available in %1 (Combat)",[_time,"MM:SS"] call BIS_fnc_secondsToString];
				_respawnButton ctrlSetText format["Respawn Available in %1 (Combat)",[_time,"MM:SS"] call BIS_fnc_secondsToString];
				_abortButton ctrlCommit 0;
				_respawnButton ctrlCommit 0;
			};
		};
		_usebleCtrl = call _canUseControls;
		_usebleCtrl spawn _escSync;
	} else {
		_abortButton ctrlEnable true;
		_respawnButton ctrlEnable true;
		true spawn _escSync;
	};


	waitUntil{uiSleep 0.05;isNull (findDisplay 49)};
};
