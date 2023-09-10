//	Author: Kurt
//	Description: Set an array index to be of a certain value

params [
	["_val",-1,[0]]
];
if (_val isEqualTo -1) exitWith {};
oev_statsTable set [18,(oev_statsTable select 18) + _val];