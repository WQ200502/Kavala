//  File: fn_groupMenu.sqf
//	Author: Bryan "Tonic" Boardwine

if(isNull oev_my_gang) then{
	["yMenuBrowseGroups"] spawn OEC_fnc_createDialog;//Not in a group, open group list where they can either join one or create a new one
}else{
	["yMenuGroups"] spawn OEC_fnc_createDialog;//Already in a group, open list to show players
};