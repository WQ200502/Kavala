ctrlSetText[68432,format["You have %1 hex icon rolls available!",player getVariable["hexRedemptions",0]]];

if(player getVariable["hexRedemptions",0] < 1) then {
	ctrlEnable[675843,false];
} else {
	ctrlEnable[675843,true];
};