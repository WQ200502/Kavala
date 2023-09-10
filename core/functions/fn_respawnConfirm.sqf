private '_action';
[] spawn{

  _action = ["你确定你要重生?","Confirmation","是","否"] call BIS_fnc_guiMessage;

  if (_action) then {
    oev_respawned = true;
    _dam_obj = player;
    _dam_obj setDamage 1;
    [0, format ["%1 自杀了.", name player]] remoteExecCall ["OEC_fnc_broadcast", -2];
    [
      ["event","Respawned"],
      ["player",name player],
      ["player_id",getPlayerUID player],
      ["cash_dropped",oev_cash],
      ["position",getPosATL player]
    ] call OEC_fnc_logIt;
  };

};

((findDisplay 49) closeDisplay 2);
