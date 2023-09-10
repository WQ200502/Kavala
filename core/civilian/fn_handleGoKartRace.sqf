//  File: fn_handleGoKartRace.sqf
//	Author: Kurt
#include "..\..\macro.h"
//	Description: Starts the race!
//Make them wait time
if(scriptAvailable(5)) exitWith {hint "You must wait some time before you can start another race!";};
//Flag for if in race
oev_isActiveRace = true;

//Mark the starting zone as a polygon
private _startPoly = [[14121.7,16452.6,0.00141144], [14123.4,16445.8,0.0014286], [14129.1,16447.2,0.00143051], [14127.5,16454,0.0014267]];
private _goKartPitPoly = [[14072.3,16451.4,0.00147629],[14159.1,16536.3,0.00146866],[14223.3,16484.3,0.00144386],[14192.7,16446.3,0.00150871],[14113.3,16420.3,0.00156975]];
private _triggerRadius = 4; // meters
private _secondsToStart = 5; // seconds
/*
_trg = createTrigger ["EmptyDetector", [14126.8,16450.4,0.00142479]];
_trg setTriggerArea [5, 2.5, 0, false];
_trg setTriggerActivation ["CIV", "PRESENT", true];
_trg setTriggerStatements ["this", "hint 'In start'", "hint 'Not in start'"]
*/

//Wait for player to get in their gokart
hint parseText format ["<t color='#ffff00'><t size='2'>Go Kart Time Trial</t></t><br/><br/>Get into your gokart and approach the starting line to begin the race!<br/><br/>The fastest time on Olympus is: %1s.", parseNumber(oev_title_pid select 5)];
private _goKarts = ["C_Kart_01_Blu_F","C_Kart_01_F","C_Kart_01_F","C_Kart_01_Red_F","C_Kart_01_Vrana_F"];
waitUntil{((!((vehicle player) isEqualTo player) && (typeOf (vehicle player) in _goKarts) &&  (getPos player) inPolygon _startPoly) || !(oev_isActiveRace))}; //Player gets in their kart and approaches start or they cancel
if !(oev_isActiveRace) exitWith {};
uiSleep 1;//Delay before counting down

//Initialize the arrow positions
private _goKartArrow1 = [14145.5,16454.6,0.00144005];
private _goKartArrow2 = [14165.2,16457.3,0.00143433];
private _goKartArrow3 = [14176.8,16465.3,0.0014286];
private _goKartArrow4 = [14189.8,16460,0.00149155];
private _goKartArrow5 = [14205.2,16480.7,0.00144577];
private _goKartArrow6 = [14197.6,16495.9,0.00147057];
private _goKartArrow7 = [14183.8,16495.7,0.00144768];
private _goKartArrow8 = [14173.9,16474.8,0.00146103];
private _goKartArrow9 = [14151,16467.8,0.00145149];
private _goKartArrow10 = [14146.5,16482.4,0.00140572];
private _goKartArrow11 = [14167.3,16488.8,0.00146866];
private _goKartArrow12 = [14172.3,16503.8,0.00144577];
private _goKartArrow13 = [14157.7,16502.7,0.00147057];
private _goKartArrow14 = [14141.4,16493.7,0.00138092];
private _goKartArrow15 = [14125,16491.5,0.0013752];
private _goKartArrow16 = [14131,16477.8,0.00147057];
private _goKartArrow17 = [14127,16465.3,0.0014801];
private _goKartArrow18 = [14112.5,16471.7,0.00154114];
private _goKartArrow19 = [14096.5,16461.5,0.00140572];
private _goKartArrow20 = [14087.8,16445.8,0.00142097];
private _goKartArrow21 = [14106.2,16444.4,0.00137329];
private _goKartArrow22 = [14128.8,16450.9,0.00145149];

//Initialize position array
private _allArrowPos = [];
_allArrowPos pushBack _goKartArrow1;
_allArrowPos pushBack _goKartArrow2;
_allArrowPos pushBack _goKartArrow3;
_allArrowPos pushBack _goKartArrow4;
_allArrowPos pushBack _goKartArrow5;
_allArrowPos pushBack _goKartArrow6;
_allArrowPos pushBack _goKartArrow7;
_allArrowPos pushBack _goKartArrow8;
_allArrowPos pushBack _goKartArrow9;
_allArrowPos pushBack _goKartArrow10;
_allArrowPos pushBack _goKartArrow11;
_allArrowPos pushBack _goKartArrow12;
_allArrowPos pushBack _goKartArrow13;
_allArrowPos pushBack _goKartArrow14;
_allArrowPos pushBack _goKartArrow15;
_allArrowPos pushBack _goKartArrow16;
_allArrowPos pushBack _goKartArrow17;
_allArrowPos pushBack _goKartArrow18;
_allArrowPos pushBack _goKartArrow19;
_allArrowPos pushBack _goKartArrow20;
_allArrowPos pushBack _goKartArrow21;
_allArrowPos pushBack _goKartArrow22;
private _numArrows = count _allArrowPos;

//Begin setup for the race
oev_currentGoKartMarker = "Sign_Arrow_Large_Blue_F" createVehicleLocal _goKartArrow1;
oev_currentGoKartMarkerFiller = "Sign_Arrow_Large_Blue_F" createVehicleLocal _goKartArrow1;

private _exit = false;
for "_i" from 0 to _secondsToStart do {
	if ((_secondsToStart - _i) isEqualTo 0) then {
		hint parseText format ["<t color='#00ff00'><t size='3'>GO!</t></t>"];
	} else {
		hint parseText format ["<t size='3'>%1</t>",_secondsToStart - _i];
	};
	if (!(typeOf (vehicle player) in _goKarts) || !((getPos player) inPolygon _startPoly)) exitWith {_exit = true;};
	uiSleep 1;
};
//Make sure to cancel if they have left the starting point or got out of their car
if (_exit) exitWith {hint parseText format ["<t color='#ff0000'><t size='2'>Race Ended</t></t><br/><br/>You must stay in your gokart at the starting line until you are set to go!"];oev_isActiveRace = false;deleteVehicle oev_currentGoKartMarker;deleteVehicle oev_currentGoKartMarkerFiller;};

//Spawn a thread to monitor conditions of the race at a shorter interval than checking trigger null status
private _raceTime = time;
[_goKarts,_goKartPitPoly,_raceTime] spawn{
	params [
		["_goKarts",[],[[]]],
		["_goKartPitPoly",[],[[]]],
		"_raceTime"
	];
	while {oev_isActiveRace} do {
		//Check to see the player is in a vehicle
		if ((vehicle player) isEqualTo player) exitWith {hint parseText format ["<t color='#ff0000'><t size='2'>Race Ended</t></t><br/><br/>You have left your vehicle! Your race has been cancelled."];oev_isActiveRace = false;};
		//Check to see the player is in a go kart
		if !(typeOf (vehicle player) in _goKarts) exitWith {hint parseText format ["<t color='#ff0000'><t size='2'>Race Ended</t></t><br/><br/>You are not in a go-kart! Your race has been cancelled."];oev_isActiveRace = false;};
		//Check to see if the player is in the gokart pit
		if !((getPos player) inPolygon _goKartPitPoly) exitWith {hint parseText format ["<t color='#ff0000'><t size='2'>Race Ended</t></t><br/><br/>You have left the race track! Your race has been cancelled."];oev_isActiveRace = false;};
		//Check to see if the player has been racing for over 5 minutes
		if ((time - _raceTime) > 5 * 60) exitWith {hint parseText format ["<t color='#ff0000'><t size='2'>Race Ended</t></t><br/><br/>Your time ran out, you only have 5 minutes to complete the course!"];oev_isActiveRace = false;};
		sleep 1;
	};
};

//Loop while the player is driving
private _successfulLap = false;
while {!(_successfulLap) && oev_isActiveRace} do {
	if (((getPosATL player) distance2D (_allArrowPos select oev_currentTriggerInc)) < _triggerRadius) then {
		oev_currentTriggerInc = oev_currentTriggerInc + 1;
		if (oev_currentTriggerInc >= (_numArrows)) exitWith {_successfulLap = true;};
		deleteVehicle oev_currentGoKartMarker;
		deleteVehicle oev_currentGoKartMarkerFiller;
		oev_currentGoKartMarker = "Sign_Arrow_Large_Blue_F" createVehicleLocal (_allArrowPos select oev_currentTriggerInc);
		oev_currentGoKartMarkerFiller = "Sign_Arrow_Large_Blue_F" createVehicleLocal (_allArrowPos select oev_currentTriggerInc);
		playSound "beep";
	};
	uiSleep 0.025;
};

//When the loop finishes run this if the player won
if (_successfulLap) then {
	//Get their time
	private _lapTime = time - _raceTime;
	//Server best time score!
	if(_lapTime < parseNumber(oev_title_pid select 5)) exitWith {
		hint parseText format ["<t color='#00ff00'><t size='2'>Race Finished</t></t><br/><br/>Congratulations! You have finished the race with a time of:<br/><br/><t size='2'>%1</t><br/><br/>这是你新的个人最佳成绩，也是在AMX最快的时间！",_lapTime];
		titleText[format["你最好有个新服务器。按ESC同步！"],"PLAIN DOWN"];
		["gokart_time",_lapTime] spawn OEC_fnc_statArrUp;
		oev_title_pid set [4,getPlayerUID player];
		oev_title_pid set [5,str(_lapTime)];
		publicVariable "oev_title_pid";
		[] spawn OEC_fnc_titleNotification;
	};
	//Check if they have played before (if not then set this score to be their new highest)
	if((oev_statsTable select 20) <= 0) exitWith {
		hint parseText format ["<t color='#00ff00'><t size='2'>Race Finished</t></t><br/><br/>Congratulations! You have finished the race with a time of:<br/><br/><t size='2'>%1</t><br/><br/>Since this is your first race, it is your new personal best!",_lapTime];
		titleText[format["You got a new personal best. Press ESC to sync!"],"PLAIN DOWN"];["gokart_time",_lapTime] spawn OEC_fnc_statArrUp;
	};
	//Check if they have beaten their highscore
	if(_lapTime < (oev_statsTable select 20)) exitWith {
		hint parseText format ["<t color='#00ff00'><t size='2'>Race Finished</t></t><br/><br/>Congratulations! You have finished the race with a time of:<br/><br/><t size='2'>%1</t><br/><br/>This is your new personal best!  Your old time was: %2.",_lapTime,(oev_statsTable select 20)];
		titleText[format["You got a new personal best. Press ESC to sync!"],"PLAIN DOWN"];["gokart_time",_lapTime] spawn OEC_fnc_statArrUp;
	};
	//If they haven't beaten their highscore just make a normal message
	hint parseText format ["<t color='#00ff00'><t size='2'>Race Finished</t></t><br/><br/>Congratulations! You have finished the race with a time of:<br/><br/><t size='2'>%1</t><br/><br/>Your personal best is: %2.",_lapTime,(oev_statsTable select 20)];
};
deleteVehicle oev_currentGoKartMarker;
deleteVehicle oev_currentGoKartMarkerFiller;
oev_isActiveRace = false;
oev_currentTriggerInc = 0;
