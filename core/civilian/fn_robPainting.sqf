if((_this select 0) isEqualType 0) exitWith {
  6 cutRsc ["life_timer","PLAIN DOWN"];
  _display = uiNamespace getVariable "life_timer";
  _timer = _display displayCtrl 38301;
  _timer ctrlSetTextColor [0,242,255,1];
  _time = time + 420;
  if(_this select 0 == 0) then {
    _time = time + 300;
  };
  if(_this select 1) then {
    _time = time + (_this select 0);
  };
  while {true} do {
    if (isNull _display) then {
      6 cutRsc ["life_timer","PLAIN DOWN"];
      _display = uiNamespace getVariable "life_timer";
      _timer = _display displayCtrl 38301;
      _timer ctrlSetTextColor [0,242,255,1];
    };
    if (round(_time - time) < 1) exitWith {};
    if !(oev_artGallery) exitWith {};
    _timer ctrlSetText format["%1",[(_time - time),"MM:SS"] call BIS_fnc_secondsToString];
    uiSleep 0.09;
  };
  6 cutText ["","PLAIN DOWN"];
};

if(oev_artGallery) exitWith {hint "已经有人在抢劫美术馆了！";};
if(oev_action_inUse) exitWith {hint "请先完成你正在做的事情！";};
if(oev_robPaintingCD > time) exitWith {hint "请等待5分钟，然后再试图抢劫另一幅画！";};
if([west,2] call OEC_fnc_playerCount < 4) exitWith {hint "一定有4个或更多的警察在线才可以抢劫美术馆！";};
if(currentWeapon player isEqualTo "" || currentMagazine player in ["30Rnd_9x21_Mag","16Rnd_9x21_Mag","11Rnd_45ACP_Mag","30Rnd_9x21_Mag_SMG_02","6Rnd_45ACP_Cylinder","9Rnd_45ACP_Mag"]) exitWith {hint "你需要一把5.56口径或更高口径的枪！";};
if(currentMagazine player isEqualTo "") exitWith {hint "你需要弹药！";};
if((altis_bank getVariable ["chargeplaced",false]) || (altis_bank_1 getVariable ["chargeplaced",false]) || (altis_bank_2 getVariable ["chargeplaced",false])) exitWith {hint "银行营业时，你不能抢劫美术馆！";};
_bwBldg = nearestObject [[20898.6,19221.7,0.00143909],"Land_Dome_Big_F"];
if((_bwBldg getVariable ["chargeplaced",false]) || (fed_bank getVariable ["chargeplaced",false]) || (jailwall getVariable ["chargeplaced",false])) exitWith {hint "你不能在联邦活动期间抢劫美术馆！";};

_itemName = "";
_size = _this select 3;
_painting = _this select 0;
_cpRate = 0.00064;
if(_size == 0) then {
  _itemName = "paintingSm";
  _cpRate = 0.00088;
} else {
  _itemName = "paintingLg";
};
_diff = [_itemName,1,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
if(_diff <= 0) exitWith {hint "您没有足够的库存空间来容纳这幅画！";};

oev_artgallery = true;
publicVariable "oev_artgallery";

[3,"<t color='#ff2222'><t size='2.2'><t align='center'>美术馆<br/><t color='#FFC966'><t align='center'><t size='1.2'>卡瓦拉美术馆的一幅价值连城的画被人抢走了！",false,[]] remoteExec["OEC_fnc_broadcast",-2,false];
[_size,false] remoteExec["OEC_fnc_robPainting",(playableUnits select {side _x == west || group _x isEqualTo group player})];
[gallery_siren,"galleryAlarm"] remoteExec["OEC_fnc_say3D",((position player nearEntities ["Man", 50]) select {isPlayer _x})];
[0,player,_size] remoteExec["OES_fnc_artGallery",2];

disableSerialization;
_title = "Stealing Painting";
5 cutRsc["life_progress","PLAIN DOWN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

_exit = false;
while {true} do {
	uiSleep 0.26;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	_cP = _cP + _cpRate;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if (_cP >= 1) exitWith {};
  if !(alive player) exitWith {
    _exit = true;
  };
  if (!(isNull objectParent player) || player getVariable["restrained",false]) exitWith {
    _exit = true;
    hint "你必须呆在那幅画附近才能偷走它！";
  };
  if (player distance _painting > 15) exitWith {
    _exit = true;
    hint "你必须呆在离这幅画15米以内才能偷走它！";
  };
};
5 cutText["","PLAIN DOWN"];

if(_exit) exitWith {
  oev_artgallery = false;
  publicVariable "oev_artgallery";
  if(oev_numRobAttempted >= 1) then {
    oev_numRobAttempted = 0;
    oev_robPaintingCD = time+300;
  } else {
    oev_numRobAttempted = oev_numRobAttempted+1;
  };
};

oev_numRobAttempted = 0;
_diff = [_itemName,1,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
if(_diff <= 0) exitWith {hint "您没有足够的库存空间来存放这幅画！";};

_painting setVariable["cooldown",true,true];
[3,"<t color='#ff2222'><t size='2.2'><t align='center'>美术馆<br/><t color='#FFC966'><t align='center'><t size='1.2'>卡瓦拉美术馆的一幅画被偷了！",false,[]] remoteExec["OEC_fnc_broadcast",-2,false];
[1,_painting,(getObjectTextures _painting) select 0,player,_size] remoteExec["OES_fnc_artGallery",2];
_painting setObjectTextureGlobal[0, ""];

[true,_itemName,1] call OEC_fnc_handleInv;

oev_artgallery = false;
publicVariable "oev_artgallery";
