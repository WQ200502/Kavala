disableSerialization;
waitUntil {!isNull (findDisplay 70002)};

if(oev_lastConquest != -1) then {
	ctrlEnable[70005+(oev_lastConquest*2),false];
};