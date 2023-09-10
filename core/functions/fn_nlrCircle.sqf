//  File: fn_nlrCircle.sqf
//	Author: Ray "Head Nigha" Kazi
//	Description: Zahzi didnt like my copy pasta

private ["_dist","_count"];
while {true} do {
  waitUntil {sleep 15; ((count oev_deaths) > 0)};
  {
    if (time < (_x select 1)) then {
      _dist = player distance (_x select 0);
      _pos = (_x select 0);
      _count = (_x select 2);

      if (_dist < 1000) then {
        _count = _count + 1;
        hint parseText "<t color='#FF0000'><t size='2'><t align='center'>!!! 警告 !!!<br/><br/><t color='#FF5733'><t align='left'><t size='1'>你正在打破新的生活规则！在死亡时间过去15分钟之前，不要在距离你被杀地点1000米范围内返回！请立即离开该区域！";

        if (_count in [1,3,5,8,13,17]) then {
          [
            ["event","Broke NLR"],
            ["player",name player],
            ["player_id",getPlayerUID player],
            ["nlr_position",_pos],
            ["distance",_dist],
            ["position",getPosATL player]
          ] call OEC_fnc_logIt;
        };

        (oev_deaths select _forEachIndex) set [2,_count];
      };

      if(isNil{_x select 3}) then {
        _marker = createMarkerLocal [format ["nlr_marker_%1", floor(_x select 1)], [_pos select 0, _pos select 1]];
        _marker setMarkerSizeLocal [1000, 1000];
        _marker setMarkerColorLocal "ColorOrange";
        _marker setMarkerShapeLocal "ELLIPSE";
        _marker setMarkerAlphaLocal 0.7;
        _marker setMarkerTextLocal "NLR Zone";

        _marker_text = createMarkerLocal [format ["nlr_marker_text_%1", floor(_x select 1)], [_pos select 0, _pos select 1]];
        _marker_text setMarkerColorLocal "ColorBrown";
        _marker_text setMarkerTypeLocal "mil_objective";
        _marker_text setMarkerTextLocal format["你最近死在这里-NLR活动-%1m", [] call OEC_fnc_timeUntilRestart];

        (oev_deaths select _forEachIndex) set [3, true];
      };
    } else {
      if((_x select 3)) then {
        deleteMarkerLocal format["nlr_marker_%1", floor(_x select 1)];
        deleteMarkerLocal format["nlr_marker_text_%1", floor(_x select 1)];
      };
    };
  } forEach oev_deaths;
};
