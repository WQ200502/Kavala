//  File: fn_cookieJar.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description:
//	Reports to the RPT of a confirmed cheater for external programs
//	to parse,log or ban automatically.

private["_pName","_pUID","_pReason"];
_pName = param [0,"",[""]];
_pUID = param [1,"",[""]];
_pReason = param [2,"",[""]];

if(_pName == "" || _pUID == "" || _pReason == "") exitWith {}; //Bad params passed..

[format["SPYGLASS-FLAG:%1:%2:%3",_pName,_pUID,_pReason]] call A3Log;