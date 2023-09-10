_tablet = "Land_Tablet_01_F";
_objects = allMissionObjects _tablet;
{
	null = [_x] execVM "kitty_lockFolder\setupKeypads\setup.sqf";
} forEach _objects;