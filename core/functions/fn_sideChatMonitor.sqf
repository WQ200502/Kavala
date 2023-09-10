#include "..\..\macro.h"
//	Author: Poseidon
//	Description: Monitors side chat text for bad words, and trys to prevent players from using VON in side.

[] spawn{
	disableserialization;
	private["_display"];

	life_badChatCount = 0;
	life_chatCount = 0;

	while{true} do {
		waitUntil{sleep 0.5; !isNull (findDisplay 24)};
		_display = (findDisplay 24);

		if(life_badChatCount >= 4) then {
			_display closeDisplay 2;
			hint "You're banned from chat for a few minutes.";
		};

		if(life_chatCount >= 20) then {
			_display closeDisplay 2;
			hint "You can send a maximum of 20 messages a minute.";
		};

		if(!isNull (findDisplay 24)) then {
			(findDisplay 24) displayAddEventHandler ["KeyDown", {
				private["_badWords","_display","_badWords","_textField","_text","_censored","_replacementPhrases1"];
				_badWords = ["kys","k y s","bleach","kill yourself","rope yourself","off yourself","rope urself","off urself","kill urself","3ggaming","3g gaming","3 g gaming","fag","feg", "f4g", "nig nog", "nignog", "nigg", "niglet", "nigroid", "ni99", "n199", "n1gg", "negro", "blackie", "Jiggaboo", "beaner", "chink","arche","archtype","execVM", "comp me", "reported", "recorded", "grandma gary", "invictu", ";"];
				_replacementPhrases1 = [
					"I'm wrestling with some insecurity issues in my life but thank you all for playing with me.","C'mon, Mom! One more game before you tuck me in. Oops mistell.",
					"I could really use a hug right now.","It's past my bedtime. Please don't tell my mommy.","Ah shucks... you guys are the best!","I feel very, very small... please hold me...",
					"Mommy says people my age shouldn't suck their thumbs.","I'm trying to be a nicer person. It's hard, but I am trying.","Wishing you all the best."
				];


				_display = _this select 0;
				_textField = _display displayctrl 101;
				_text = ctrlText _textField;
				_censored = false;

				if(_this select 1 == 0x1C || _this select 1 == 0x9C) exitWith {
					if(_text != "") then {
						{
							if(toLower(_text) find _x != -1) exitWith {//a censored word was found inside their message, exit and find out what to do
								_censored = true;

								switch(_x) do {//determine action based on the word found
									case "comp me":{hint "If you are requesting comp, do it via text message."};
									case "reported":{hint "Thanks for the report."};
									case "recorded":{hint "If you have recorded someone breaking a rule, submit a player report."};
									case "grandma gary": {_text = "Grandma Gary eats duh poo poo."; _textField ctrlSetText _text; _censored = false;};
									case "kys": {_textField ctrlSetText (selectRandom(_replacementPhrases1));};
									case "k y s": {_textField ctrlSetText (selectRandom(_replacementPhrases1));};
									case "rope yourself": {_textField ctrlSetText (selectRandom(_replacementPhrases1));};
									case "off yourself": {_textField ctrlSetText (selectRandom(_replacementPhrases1));};
									case "kill yourself": {_textField ctrlSetText (selectRandom(_replacementPhrases1));};
									case "rope urself": {_textField ctrlSetText (selectRandom(_replacementPhrases1));};
									case "off urself": {_textField ctrlSetText (selectRandom(_replacementPhrases1));};
									case "kill urself": {_textField ctrlSetText (selectRandom(_replacementPhrases1));};
									case "bleach": {_textField ctrlSetText (selectRandom(_replacementPhrases1));};
									case "bleach": {_textField ctrlSetText (selectRandom(_replacementPhrases1));};
									case "nigg": {_textField ctrlSetText "黑人的命也是命！";};
									case ";": {_textField ctrlSetText "";_censored = false;[_text] spawn OEC_fnc_adminChat;};

									default {};
								};
							};
						}foreach _badWords;

						switch(true) do {
							case (_censored): {
								_textField ctrlSetText "";
								life_badChatCount = life_badChatCount + 1;
								[] spawn{sleep 120; life_badChatCount = life_badChatCount - 1;};
								life_chatCount = life_chatCount + 1;
								[] spawn{sleep 60; life_chatCount = life_chatCount - 1;};
							};

							default {};
						};

						life_chatCount = life_chatCount + 1;
						[] spawn{sleep 60; life_chatCount = life_chatCount - 1;};
					};
				};

				false;
			}];
		};

		waitUntil{isNull (findDisplay 24)};
	};
};

disableSerialization;
private["_selectedChannel"];
life_sideChatKickCount = 0;

while {true} do {
	waitUntil{sleep 0.1; (!isNull (findDisplay 55))};
	_selectedChannel = currentChannel;

	if(ctrlText ((findDisplay 55) displayCtrl 101) == "\A3\ui_f\data\igui\rscingameui\rscdisplayvoicechat\microphone_ca.paa") then {
		if(currentChannel == 1 || currentChannel == 0 || currentChannel == 7 || currentChannel == 9) then {
			life_sideChatKickCount = life_sideChatKickCount + 1;
			[] spawn{sleep 60; life_sideChatKickCount = life_sideChatKickCount - 1;};

			hint "Do not use voice in side chat. Your side chat will be re-enabled shortly.";

			[] spawn{
				private["_timer"];
				_timer = time + 5;
				while{_timer > time} do {
					setCurrentChannel 3;
					sleep 0.1;
				};
			};

			if(life_sideChatKickCount >= 3 && life_sidechat) then {
				life_sidechat = false;
				life_gangChat = false;
				private _alvl = __GETC__(life_adminlevel);
				[[player,life_sidechat,playerSide,_alvl,oev_streamerMode,life_gangChat],"OES_fnc_managesc",false,false] spawn OEC_fnc_MP;
				systemChat "Your side chat was removed for using VON.";
			};
		};
	};

	waitUntil{isNull (findDisplay 55) || currentChannel != _selectedChannel};
};