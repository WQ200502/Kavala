//  File: fn_requestMedic.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: N/A
params ["_type"];

switch (_type) do {
	case "request": {
		private["_medicsOnline"];
		_button = ((findDisplay 7300) displayCtrl 7303);
		if(!((ctrlText _button) isEqualTo "Request Denial")) then {
			_medicsOnline ={_x != player && {side _x isEqualTo independent} && {alive _x}} count playableUnits > 0; //Check if medics (indep) are in the room.

			if(_medicsOnline) then {
				//There is medics let's send them the request.
				[[life_corpse,profileName],"OEC_fnc_medicRequest",independent,FALSE] spawn OEC_fnc_MP;
			};
			if (life_corpse getVariable["hasRequested",0] isEqualTo 0) then {
				life_corpse setVariable["hasRequested",servertime,TRUE];
			};
			life_corpse setVariable["revive",FALSE,TRUE];
			life_corpse setVariable["denialRequest",FALSE,TRUE];

			//Create a thread to monitor duration since last request (prevent spammage).
			[] spawn{
				private["_timer"];
				disableSerialization;
				oev_request_timer = true;
				_timer = ((findDisplay 7300) displayCtrl 7301);

				((findDisplay 7300) displayCtrl 7303) ctrlSetText "要求拒绝";
				((findDisplay 7300) displayCtrl 7302) ctrlEnable false;
				oev_respawn_timer_start = time;
				oev_respawn_timer = oev_respawn_timer_start + 450; // 450 is the time for lockout on respawn in seconds
				waitUntil {
					_timer ctrlSetStructuredText parseText format["<t align='center'>新生活倒计时: %1</t>",[round((oev_respawn_timer - Time)- 1),"MM:SS"] call BIS_fnc_secondsToString];
					uiSleep 0.5;
					round(oev_respawn_timer - time) <= 0 || isNull life_deathCamera || isNull life_corpse;
				};
				oev_request_timer = false;
				oev_respawn_timer_start = 0;
				oev_respawn_timer = 0;
				((findDisplay 7300) displayCtrl 7303) ctrlEnable true;
				((findDisplay 7300) displayCtrl 7303) ctrlSetText "我还能抢救";
				((findDisplay 7300) displayCtrl 7302) ctrlEnable true;
				_timer ctrlSetStructuredText parseText "<t align='center'>你可以重生！</t>";
			};
		} else {
			[] spawn{
				_action = [
				"您确定要请求拒绝吗？",
				"确认",
				"是",
				"否"
			] call BIS_fnc_guiMessage;

			if (_action) then {
				life_corpse setVariable["denialRequest", TRUE, TRUE];
				[[life_corpse,profileName],"OEC_fnc_requestDenial",independent,FALSE] spawn OEC_fnc_MP;
				[] spawn{
					((findDisplay 7300) displayCtrl 7303) ctrlEnable false;
					if(oev_respawn_timer > 150) then {
						_requestDelay = 150 + time;
						waitUntil{time >= _requestDelay};
						if(oev_respawn_timer > 0 && oev_request_timer) then {
							((findDisplay 7300) displayCtrl 7303) ctrlEnable true;
						} else {
							((findDisplay 7300) displayCtrl 7303) ctrlEnable true;
							((findDisplay 7300) displayCtrl 7303) ctrlSetText "请求抢救";
							((findDisplay 7300) displayCtrl 7302) ctrlEnable true;
						};
					};
				};
			};
		};
		};
	};
	case "respawn": {
		private '_action';
		[] spawn{
			_action = ["你确定开始新的生活吗？","确定","是","否"] call BIS_fnc_guiMessage;
			 if (_action) then {
				 closeDialog 0;
				 oev_respawned = true;
				 [] spawn OEC_fnc_spawnMenu;
			 } else {
				 ((findDisplay 7300) displayCtrl 7302) ctrlEnable true;
			 };
		 };
	 };
};
