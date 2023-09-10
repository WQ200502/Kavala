//  File: fn_licensesRead.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Outprints the licenses. DESCRIPTIONEND

private["_licenses","_civ"];
_civ = param [0,"",[""]];
_licenses = param [1,(localize "STR_Cop_NoLicenses"),[""]];
_tier = param [2,"",[""]];
_mode = param [3,0,[0]];

if (_mode == 0) then {
	hint parseText format["<t color='#FF0000'><t size='2'>%1</t></t><br/><t color='#FFD700'><t size='1.5'>" +(localize "STR_Cop_Licenses")+ "</t></t><br/>%2",_civ,_licenses];
} else {
	hint parseText format["<t color='#FF0000'><t size='2'>%1</t></t><br/><t color='#FFD700'><t size='1.5'>" +(localize "STR_Cop_Licenses")+ "</t></t><br/>%2" + "<t color='#FFD700'><t size='1.5'>" +(localize "STR_Cop_Vigi_Tier")+ "</t></t><br/>" + "%3",_civ,_licenses,_tier];
};
