//	Author: Bryan "Tonic" Boardwine
//	Description: Reveals nearest objects within 15 automatically to help with picking
//	up various static objects on the ground such as money, water, etc.

//	Can be taxing on low-end systems or AMD CPU users.

private["_objects"];

_objects = nearestObjects[position player, ["Item_Base_F","Items_Base_F","Man","House_F"], 10];
{
	player reveal _x;
}foreach _objects;
