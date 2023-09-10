//	Description: Resets stacked eventhandlers, often without doing this code form other servers is still on the client
{
	_EVH = _x;
	_namespaceId = "BIS_stackedEventHandlers_";
	_namespaceEVH = _namespaceId + _EVH;
	_oldCode = missionNameSpace getVariable [_namespaceEVH, []];
	{
		private "_itemId";
		_itemId	= _x param [0,"",[""]];
		[_itemId,_EVH] call bis_fnc_removeStackedEventHandler;
	}forEach _oldCode;
} forEach ["oneachframe", "onpreloadstarted", "onpreloadfinished", "onmapsingleclick", "onplayerconnected", "onplayerdisconnected"];