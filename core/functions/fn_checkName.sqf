//	Description: Checks if a name contains valid characters only, returns true or false /x00

private["_playerName","_playerChars","_allowChars","_badWords","_return"];
_playerName = param [0,"",[""]];

_return = false;
if(_playerName == "") exitWith {_return = true; _return;};
_playerChars = toArray _playerName;
_allowChars = toArray("AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz !#$%()*+,./0123456789:=?@[\]^_-{|}~");
_badWords = ["headlessclient","3ggaming","3g gaming","3 g gaming", "call ","spawn ","execVM", "invictu", "arche", "archtype", "nigg", "chink", "fag", "server", "admin", "Error: No vehicle", "Error: No unit"]; //bad words, in this case we use it to prevent keyword which call functions/scripts. Server side all data is checked to

//prevent these keywords from being input into the database, so if a player has this in their name their data wont sync.

{
	if (!(_x in _allowChars)) exitWith {
       _return = true;
    };
} forEach _playerChars;

{
	if ((_playerName find _x) != -1) exitWith {
       _return = true;
    };
} forEach _badWords;

_return;
