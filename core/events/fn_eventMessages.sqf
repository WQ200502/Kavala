// Created by: Fraali
// Stores and handles event messages
params [
["_confirm", "", []]
];
_text = "";
_messages = [];

// Derby - 0; Race - 1; Escort - 2; Lastman - 3; Dogfight - 4; Roulette - 5;
switch (lbCurSel 50003) do {
  case 0 : {
    _messages pushBack ["A Demolition Derby is starting! During this event your goal is to destroy other participants with your vehicle (VDM does not apply). Top 3 players win money. Store your gear as you will <t color='#FFFF00'>NOT</t> be compensated for any gear lost. If you are in restraints, in jail, or dead, you will not be added.<br/><t size='1.15'align='center'>Type <t color='#FFFF00'>;ejoin</t> in chat to join!", "Starting Demo Derby"];
  };
  case 1 : {
    _messages pushBack ["A Race Event is starting! During the event, you will operate a vehicle with your goal being to finish first. Top 3 players win money. Store your gear as you will <t color='#FFFF00'>NOT</t> be compensated for any gear lost. If you are in restraints, in jail, or dead, you will not be added.<br/><t size='1.15'align='center'>Type <t color='#FFFF00'>;ejoin</t> in chat to join!", "Starting Race"];
  };
  case 2 : {
    _messages pushBack ["A Escort Event is starting! The goal is to escort/attack the VIP on the way to the destination. Killing the VIP on the way to his location will reward you with money. You will <t color='#FFFF00'>NOT</t> be compensated for any gear lost. If you are in restraints, in jail, or dead, you will not be added.<br/><t size='1.15'align='center'>Type <t color='#FFFF00'>;ejoin</t> in chat to join!", "Starting Escort"];
  };
  case 3 : {
    _messages pushBack ["A Last Man Standing Event is starting! You will start naked, finding guns and gear in crates in the area to kill other participants. Last alive wins money. Store your gear as you will <t color='#FFFF00'>NOT</t> be compensated for any gear lost. If you are in restraints, in jail, or dead, you will not be added.<br/><t size='1.15'align='center'>Type <t color='#FFFF00'>;ejoin</t> in chat to join!", "Starting Lastman"];
  };
  case 4 : {
    _messages pushBack ["An Air-Battles Event is starting! During this event, you will operate an armed helicopter to destroy other participants. Top 3 players win money. Store your gear as you will <t color='#FFFF00'>NOT</t> be compensated for any gear lost. If you are in restraints, in jail, or dead, you will not be added.<br/><t size='1.15'align='center'>Type <t color='#FFFF00'>;ejoin</t> in chat to join!", "Starting DogFight (Heli)"];
    _messages pushBack ["An Air-Battles Event is starting! During this event, you will operate an armed plane to destroy other participants. Top 3 players win money. Store your gear as you will <t color='#FFFF00'>NOT</t> be compensated for any gear lost. If you are in restraints, in jail, or dead, you will not be added.<br/><t size='1.15'align='center'>Type <t color='#FFFF00'>;ejoin</t> in chat to join!", "Starting DogFight (Plane)"];
    _messages pushBack ["Get in the helicopters, but do NOT shoot! Stay within the <t color='#FFFF00'>salt flats</t> or you will receive a 14 day ban. You will be disqualified if you do not follow the instructions from the event coordinators!", "Dogfight Rules"];
    _messages pushBack ["You’re good to take off! Wait 5 seconds and then weapons are free to fire!", "Free to Fire!"];
  };
  case 5 : {
    _messages pushBack ["A Russian Roulette Event is starting! During this event you will receive a handgun and will get one bullet randomly. Top 3 players win money. Store your gear as you will <t color='#FFFF00'>NOT</t> be compensated for any gear lost. If you are in restraints, in jail, or dead, you will not be added.<br/><t size='1.15'align='center'>Type <t color='#FFFF00'>;ejoin</t> in chat to join!", "Starting Roulette"];
  };
  default {};
};

_messages pushBack ["We will be teleporting all participants in 1 minute! If you do not wish to lose gear, store it now as you will <t color='#FFFF00'>NOT</t> receive compensation! Please exit your vehicle or you will not be teleported! Once everyone is teleported, DO NOT RUN AWAY.", "Ready to Teleport"];
_messages pushBack ["It's getting close! Everyone needs to stay near the middle, if you go outside of it you will be killed!", "Stay in the Middle"];

waitUntil {!((findDisplay 50000) isEqualTo displayNull)};
lbClear 50044;
{
  lbAdd [50044, _x select 1];
} forEach _messages;

if !((lbCurSel 50044) isEqualTo -1) then {
  _text = (_messages select (if (lbSize 50044 > (lbCurSel 50044)) then {(lbCurSel 50044)} else {0})) select 0;
  findDisplay 50000 displayCtrl 50047 ctrlEnable true;
  findDisplay 50000 displayCtrl 50048 ctrlEnable true;
  ((findDisplay 50000) displayCtrl 50046) ctrlSetStructuredText parseText format ["<t size='0.8'>%1</t>", _text]; // Display text
} else {
  findDisplay 50000 displayCtrl 50047 ctrlEnable false;
  findDisplay 50000 displayCtrl 50048 ctrlEnable false;
};

switch (_confirm) do {
  case "all" : {
    [_text] spawn{
      _text = _this select 0;
      private _action = [
      	"Are you sure you want to send an event message to all players?",
      	"Confirmation",
      	"Yes",
      	"No"
      ] call BIS_fnc_guiMessage;
      if !(_action) exitWith {};
        [
          ["event","Event All Message"],
          ["player_id",getPlayerUID player],
          ["message",_text],
          ["position",getPosATL player]
        ] call OEC_fnc_logIt;
        [ObjNull,_text,player,7] remoteExec ["OES_fnc_handleMessages",2];
        hint parseText format["An event message has been sent to all players: %1",_text];
    };
  };
  case "part" : {
    [_text] spawn{
      _text = _this select 0;
      private _action = [
        "Are you sure you want to send an event message to only players in the event?",
        "Confirmation",
        "Yes",
        "No"
      ] call BIS_fnc_guiMessage;
      if !(_action) exitWith {};
        [
          ["event","Event Part Message"],
          ["player_id",getPlayerUID player],
          ["message",_text],
          ["position",getPosATL player]
        ] call OEC_fnc_logIt;
        [ObjNull,_text,player,8] remoteExec ["OES_fnc_handleMessages",2];
        hint parseText format["An event message has been sent to all event participants: %1",_text];
    };
  };
};
