/*
	Takes a file path and returns parsed text ready to display.
*/
private ["_filePath","_return","_rawContents"];
_filePath = param [0,"",[""]];
_return = "";

_rawContents = loadFile _filePath;

if(_rawContents isEqualTo "") exitWith {_return};

_return = (toArray(_rawContents) apply {
	switch(_x) do {
		case 65533:{
			8226
		};

		default {
			_x
		};
	};
});

(toString(_return));