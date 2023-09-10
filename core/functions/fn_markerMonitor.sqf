//	Author: Poseidon
//	Description: Monitors markers created by player. Prevents spamming of markers, censors markers which may contain certain words, and places player name in front of marker

disableserialization;
private["_display","_text","_channel","_buttonOK","_buttonCancel"];

life_badMarkerCount = 0;
life_markerCount = 0;

while{true} do {
	waitUntil{sleep 0.25; visibleMap && {!isNull (findDisplay 54)}};//Wait until RscDisplayInsertMarker is showing
	_display = (findDisplay 54);

	if(life_badMarkerCount >= 3) then {
		_display closeDisplay 2;
	};

	if(life_markerCount >= 10) then {
		_display closeDisplay 2;
		hint "Error: You have placed too many markers too quickly. Please wait.";
	};

	if(!isNull (findDisplay 54)) then {
		_text = _display displayctrl 101;
		_channel = _display displayctrl 103;
		_buttonOK = _display displayctrl 1;
		_buttonCancel = _display displayctrl 2;

		(findDisplay 54) displayAddEventHandler ["KeyDown", {
			private["_display","_badWords","_textField","_text","_textArray","_censored"];
			_badWords = ["3ggaming","3g gaming","3 g gaming","fag","feg","nigger","cock","chink","arch","arche","asylum","server","teamspeak","gay","ban","retard","fucker","bitch","fucktard","sucks","spawn","execVM","crappy","shitty", "invictu"];
			_display = _this select 0;
			_textField = _display displayctrl 101;
			_text = ctrlText _textField;
			_textArray = toArray(_text);
			_censored = false;

			{
				if(toLower(_text) find _x != -1) exitWith {
					_censored = true;
				};
			}foreach _badWords;

			switch(true) do {
				case (count _textArray >= 64): {
					_text = "";
					_display closeDisplay 2;
					life_badMarkerCount = life_badMarkerCount + 1;
					[] spawn{sleep 300; life_badMarkerCount = life_badMarkerCount - 1;};
					life_markerCount = life_markerCount + 1;
					[] spawn{sleep 60; life_markerCount = life_markerCount - 1;};
					hint "Error: Markers may not exceed 64 characters";
				};

				case (_censored): {
					_text = "";
					_display closeDisplay 2;
					life_badMarkerCount = life_badMarkerCount + 1;
					[] spawn{sleep 300; life_badMarkerCount = life_badMarkerCount - 1;};
					life_markerCount = life_markerCount + 1;
					[] spawn{sleep 60; life_markerCount = life_markerCount - 1;};
					hint "Error: Marker name contains banned words";
				};

				default {};
			};
		}];

		(findDisplay 54) displayAddEventHandler ["Unload", {
			private["_display","_exitCode","_badWords","_textField","_text","_textArray","_censored"];
			_display = _this select 0;
			_exitCode = _this select 1;

			if(_exitCode != 1) exitWith {};

			_badWords = ["3ggaming","3g gaming","3 g gaming","fag","feg","nigger","cock","chink","arch","arche","asylum","server","teamspeak","gay","ban","retard","fucker","bitch","fucktard","sucks","spawn","execVM","crappy","shitty", "invictu"];
			_textField = _display displayctrl 101;
			_text = ctrlText _textField;
			_textArray = toArray(_text);
			_censored = false;

			{
				if(toLower(_text) find _x != -1) exitWith {
					_censored = true;
				};
			}foreach _badWords;

			switch(true) do {
				case (life_markerCount >= 10): {
					_text = "";
					hint "Error: You have placed too many markers too quickly. Please wait.";
				};

				case (count _textArray >= 64): {
					_text = "";
					life_badMarkerCount = life_badMarkerCount + 1;
					[] spawn{sleep 300; life_badMarkerCount = life_badMarkerCount - 1;};
					life_markerCount = life_markerCount + 1;
					[] spawn{sleep 60; life_markerCount = life_markerCount - 1;};
					hint "Error: Markers may not exceed 64 characters";

				};

				case (_censored): {
					_text = "";
					life_badMarkerCount = life_badMarkerCount + 1;
					[] spawn{sleep 300; life_badMarkerCount = life_badMarkerCount - 1;};
					life_markerCount = life_markerCount + 1;
					[] spawn{sleep 60; life_markerCount = life_markerCount - 1;};
					hint "Error: Marker name contains banned words";
				};

				default {
					_text = format["%1: %2", name player, _text];
					life_markerCount = life_markerCount + 1;
					[] spawn{sleep 60; life_markerCount = life_markerCount - 1;};
				};
			};

			_textField ctrlSetText _text;
		}];
	};

	waitUntil{isNull (findDisplay 54)};//Wait till insert marker box closes to restart loop
};