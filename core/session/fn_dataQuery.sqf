//  File: fn_dataQuery.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Starts the 'authentication' process and sends a request out to
//	the server to check for player information.
private["_uid","_side","_sender","_isDeadCiv"];
if(oev_session_completed) exitWith {}; //Why did this get executed when the client already initialized? Fucking arma...
_sender = player;
_uid = getPlayerUID _sender;
_side = playerSide;
_isDeadCiv = (_side isEqualTo civilian && (profileNamespace getVariable["epiActive",false])); //(_side isEqualTo civilian && (profileNamespace getVariable["oisd",false]));

life_loadingStatus = format["<t color='#FF0000'>正在向服务器发送请求以获取玩家信息 UID [%1]</t>",_uid];

0 cutFadeOut 999999999;

[[_uid,_side,_sender,_isDeadCiv],"OES_fnc_queryRequest",false,false] call OEC_fnc_MP;