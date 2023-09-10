#include "..\..\macro.h"
//  File: fn_clothing_parachute.sqf
//	Author: Bryan "Tonic" Boardwine
private["_filter","_ret"];
_filter = param [0,0,[0]];
//Classname, Custom Display name (use nil for Cfg->DisplayName, price

//Shop Title Name
ctrlSetText[3103,"Bruce's Parachutes"];

switch (_filter) do
{
	//Uniforms
	case 0:
	{
		_ret =
		[

		];

	};

	//Hats
	case 1:
	{
		_ret =
		[

		];

	};

	//Glasses
	case 2:
	{
		_ret =
		[

		];

	};

	//Vest
	case 3:
	{
		_ret = [];
	};

	//Backpacks
	case 4:
	{
		_ret =
		[
			["B_Parachute",nil,500]
		];

	};
};
_ret;