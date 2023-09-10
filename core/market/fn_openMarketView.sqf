/*

	Open pack-up dlg

*/
["yMenuMarket"] call OEC_fnc_createDialog;
disableSerialization;

waitUntil {!isnull (findDisplay 38000)};

//Refresh
[] spawn OEC_fnc_refreshMarketView;