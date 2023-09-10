// File: fn_titleNotification.sqf
// Author: Solomon
// Description: Fills arrays of currently unlocked titles when player joins, checks if new titles have been unlocked. Should be called ANY time a stat for titles is changed
// Currently called in: fn_onPlayerKilled, init, fn_statArrUp, fn_revivePlayer, and fn_handleGoKartRace

// Protection against multiple triggers happening for titles
if (oev_titleCoolDown) then {
  uiSleep 6;
};

// Filling array with all title names and descriptions
if ((count oev_allTitles) isEqualTo 0) then {
  for "_i" from 0 to ((count (missionConfigFile >> "CfgTitleCiv"))-1) do {
    oev_allTitles pushBack [getText(((missionConfigFile >> "CfgTitleCiv") select _i) >> "title"), getText(((missionConfigFile >> "CfgTitleCiv") select _i) >> "desc")];
  };
  for "_i" from 0 to ((count (missionConfigFile >> "CfgTitleCop"))-1) do {
    oev_allTitles pushBack [getText(((missionConfigFile >> "CfgTitleCop") select _i) >> "title"), getText(((missionConfigFile >> "CfgTitleCop") select _i) >> "desc")];
  };
  for "_i" from 0 to ((count (missionConfigFile >> "CfgTitleMedic"))-1) do {
    oev_allTitles pushBack [getText(((missionConfigFile >> "CfgTitleMedic") select _i) >> "title"), getText(((missionConfigFile >> "CfgTitleMedic") select _i) >> "desc")];
  };
  for "_i" from 0 to ((count (missionConfigFile >> "CfgTitleSpecial"))-1) do {
    oev_allTitles pushBack [getText(((missionConfigFile >> "CfgTitleSpecial") select _i) >> "title"), getText(((missionConfigFile >> "CfgTitleSpecial") select _i) >> "desc")];
  };
  for "_i" from 0 to ((count (missionConfigFile >> "CfgTitleServerBest"))-1) do {
    oev_allTitles pushBack [getText(((missionConfigFile >> "CfgTitleServerBest") select _i) >> "title"), getText(((missionConfigFile >> "CfgTitleServerBest") select _i) >> "desc")];
  };
};

// Filling up array of currently unlocked stats
private _notEmpty = false;
for "_i" from 0 to ((count  oev_allTitles) - 1) do {
  private _titleProgress = [(oev_allTitles select _i) select 0] call OEC_fnc_titleCheck;
  if (_titleProgress select 0) then {
    if ((oev_unlockedTitles select 0) isEqualTo "n" || (_notEmpty && !((oev_unlockedTitles select 0) isEqualTo "n") )) then {    // Fills array within initial unlocked titles when user joins
      if (!_notEmpty) then {
        _notEmpty = true;
        oev_unlockedTitles set [0, (oev_allTitles select _i) select 0];
      } else {
          oev_unlockedTitles pushBack ((oev_allTitles select _i) select 0);
      };
    } else {                                                                                                     // Notifies user of new titles
        if ((oev_unlockedTitles find ((oev_allTitles select _i) select 0)) isEqualTo -1) then {
          titleText[format["<t underline='1' size='3'>%1</t><br/><br/><t underline='0' size='1'>%2</t>", ((oev_allTitles select _i) select 0) splitString " " joinString toString [160],((oev_allTitles select _i) select 1)],"PLAIN", -1, true, true];
          titleFadeOut 5;
          oev_titleCoolDown = true;
          uiSleep 6;
          oev_titleCoolDown = false;
          oev_unlockedTitles pushBack (( oev_allTitles select _i) select 0);
        };
    };
  };
};
