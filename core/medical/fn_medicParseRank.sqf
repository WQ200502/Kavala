//Author Raykazi
//Description Translate medic rank to its proper medic rank name unless your the Director
private["_rankStr","_rank","_medic"];
_medic = _this select 0;
_rank = _this select 1;
_rankStr = "None";
if(isNull _medic || (!(_rank isEqualType 0))) exitWith {_rankStr = "None";};
if(_rank isEqualType 0 && _rank > 0) then {
  switch(_rank) do {
    case 1: {
      _rankStr = "EMT";
    };
    case 2: {
      _rankStr = "Basic Paramedic";
    };
    case 3: {
      _rankStr = "Advanced Paramedic";
    };
    case 4: {
      _rankStr = "Search & Rescue";
    };
    case 5: {
      _rankStr = "Search & Rescue";
    };
    case 6: {
      _rankStr = "Supervisor";
    };
    case 7: {
      if((getPlayerUID _medic) isEqualTo "76561198846869680") then {
        _rankStr = "Fattest Defib";
      } else {
        _rankStr = "Coordinator";
      };
    };
  };
};
_rankStr;
