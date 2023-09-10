["yMenuTitles"] call OEC_fnc_createDialog;
disableSerialization;

waitUntil {!isnull (findDisplay 41250)};
((findDisplay 41250) displayCtrl 41256) ctrlShow false;
//Refresh
[] spawn OEC_fnc_refreshTitleView;