//  File: fn_insertPlayerInfo.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Read the file name... Explains it.
if(oev_session_completed) exitWith {}; //Why did this get executed when the client already initialized? Fucking arma...
life_loadingStatus = "<t color='#0000FF'>The server didn't find any player information matching your UID, attempting to add player to system.</t>";

[[getPlayerUID player,profileName,oev_cash,oev_atmcash,player],"OES_fnc_insertRequest",false,false] spawn OEC_fnc_MP;