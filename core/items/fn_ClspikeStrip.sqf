//  File: fn_ClspikeStrip.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Creates a spike strip and preps it.
private["_position","_spikeStrip","_obj_main"];
_spikeStrip = "Land_Razorwire_F" createVehicle [0,0,0];
_spikeStrip attachTo[player,[0,5.5,0]];
_spikeStrip setDir 90;
_spikeStrip setVariable["O_droppedItem","spikeDeployed",true];

_obj_main = player;
life_action_spikeStripDeploy = _obj_main addAction["Place Spike Strip",{if(!isNull oev_spikestrip) then {detach oev_spikestrip; oev_spikestrip = ObjNull;}; player removeAction life_action_spikeStripDeploy; life_action_spikeStripDeploy = nil;},"",999,false,false,"",'!isNull oev_spikestrip && isNull objectParent player'];
oev_spikestrip = _spikeStrip;
waitUntil {isNull oev_spikestrip};
if(!isNil "life_action_spikeStripDeploy") then {player removeAction life_action_spikeStripDeploy;};
if(isNull _spikeStrip) exitWith {oev_spikestrip = ObjNull;};
_spikeStrip setPos [(getPos _spikeStrip select 0),(getPos _spikeStrip select 1),0];
private _dam_obj = _spikeStrip;
_dam_obj setDamage 1;
life_action_spikeStripPickup = _obj_main addAction["Pack up Spike Strip",OEC_fnc_packupSpikes,"",0,false,false,"",' _spikes = nearestObjects[getPos player,["Land_Razorwire_F"],8] select 0; !isNil "_spikes" && !isNil {(_spikes getVariable "O_droppedItem")}'];
[[_spikeStrip],"OES_fnc_spikeStrip",false,false] spawn OEC_fnc_MP; //Send it to the server for monitoring.