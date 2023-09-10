//	Author: Poseidon
//	Description: Accepts multiple strings, number of columns, column width, and returns a string formated as a row DESCRIPTIONEND
//	Example data: _this = [[["TestWord",10], ["ThisIsTooLongYeeee",15], ["ThirdColumn",20]]]
private["_rowData","_dataArray","_dataLength","_trimmedData","_columnWidth","_return"];
_rowData = param[0,[],[[]]];
_return = "";

if(_rowData isEqualTo []) exitWith {_return};

_smallChars = [49,105,108,58,39,34,124,46,33,59,44];//1il:'"|.!;,
_wideChars = [87,119,77,109];//WwMm

{
	_dataArray = toArray(_x select 0);
	_columnWidth = (_x select 1);
	_dataLength = count _dataArray;
	_dataCalculatedWidth = 0;
	_columnCalculatedWidth = (_columnWidth * 2);

	if(_dataLength >= _columnWidth) then {
		_dataArray deleteRange [(_columnWidth - 3),_dataLength];

		for "_i" from 1 to 3 do {
			_dataArray pushBack 46;
		};
	};

	{
		if(_smallChars find _x != -1) then {
			_dataCalculatedWidth = _dataCalculatedWidth + 1.2;
		}else{
			if(_wideChars find _x != -1) then {
				_dataCalculatedWidth = _dataCalculatedWidth + 3.75;
			}else{
				_dataCalculatedWidth = _dataCalculatedWidth + 2;
			};
		};
	}foreach _dataArray;

	for "_i" from 1 to round(((_columnCalculatedWidth - _dataCalculatedWidth) / 2) * 1.1) do {
		_dataArray pushBack 32;
	};

	_trimmedData = format["%1",toString(_dataArray)];

	_return = _return + _trimmedData;
}foreach _rowData;

_return;


