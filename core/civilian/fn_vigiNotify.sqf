// File: fn_vigiNotify.sqf
// Author: Bryan "Tonic" Boardwine
// Modified: Jesse "tkcjesse" Schultz
// From the AsYetUntitled Github --  AL.Altis/core/fn_welcomeNotification.sqf

disableSerialization;
[
        "",
        0,
        0.2,
        10,
        0,
        0,
        8
] spawn BIS_fnc_dynamicText;

createDialog "RscDisplayWelcome";

private _display = findDisplay 999999;
private _text1 = _display displayCtrl 1100;
private _buttonSpoiler = _display displayCtrl 2400;
private _textSpoiler = _display displayCtrl 1101;
private _text2 = _display displayCtrl 1102;
private _title = _display displayCtrl 1000;

private _message = "";
_message = _message + "<t align='center' size='8' shadow='0'></t><br/>";
_message = _message + "<t align='center' size='2' shadow='0'><t color='#ff9900'>治安规则</t></t><br/>";
_message = _message + "<t align='center'>______________________________________________________________________________________</t><br/><br/>";
_message = _message + "<t align='center' size='1' shadow='0'><t color='#ff9900'>单击“继续”表示您确认并同意以下规则<br/> 有关最新的规则，请访问我们论坛的信息部分</t> <t color='#f6ff00'>Olympus-Entertainment.com</t><br/><br/>";
_message = _message + "<t align='center'>______________________________________________________________________________________</t><br/><br/>";
_message = _message + "<t align='left'>1. 赏金猎人 <t color='#ff0000'>也不例外</t> 法律上说的。他们还必须遵循有关RDM、VDM等的服务器规则。<br/></t>";
_message = _message + "<t align='left'>_________________________________________</t><br/><br/>";
_message = _message + "<t align='left'>2. 在红色/非法区域开枪之前，赏金猎人无需宣布。<br/></t>";
_message = _message + "<t align='left'>      1. 赏金猎人和平民的区别只是他们可以把通缉犯关进监狱。<br/></t>";
_message = _message + "<t align='left'>            1. 您仍然可以从事非法活动，并可以被开罚单或被逮捕<br/></t>";
_message = _message + "<t align='left'>_________________________________________</t><br/><br/>";
_message = _message + "<t align='left'>3. 与关联的玩家 <t color='#ff0000'>meta-gaming</t> 而持有私刑许可证可能主观上受到行政处分。<br/></t>";
_message = _message + "<t align='left'>      1. 例如，如果一个玩家是抢劫或谋杀的受害者 <t color='#ff0000'>可能不会回来</t> 报仇入狱。<br/></t>";
_message = _message + "<t align='left'>      2. 你不能跟着一个正在犯法的玩家，继续一遍又一遍地收集他们的赏金。<br/></t>";
_message = _message + "<t align='left'>            1. 比如一个玩家被关进监狱， <t color='#ff0000'>您或您的团队成员</t> 只有这样你才能一次又一次地把他们放回监狱。<br/></t>";
_message = _message + "<t align='left'>      3. 你不能和一个玩家组队，然后让他们建立一个赏金，只是为了在最后收集。<br/></t>";
_message = _message + "<t align='left'>_________________________________________</t><br/><br/>";
_message = _message + "<t align='left'>4. 不要滥用私刑许可证。<br/></t>";
_message = _message + "<t align='left'>      1. 这包括不限制你的朋友或其他被军官限制的人。 <t color='#ff0000'>你是赏金猎人不是叛军</t>.<br/></t>";
_message = _message + "<t align='left'>      2. 不要把玩家送进监狱 <t color='#ff0000'>不到75000美元的赏金</t>.<br/></t>";
_message = _message + "<t align='left'>      3. 不要带通缉犯， <t color='#ff0000'>已经被限制了</t>, 除非他们要求你离开另一个赏金猎人。<br/></t>";
_message = _message + "<t align='left'>      4. 如果不需要玩家，不要把玩家从车里拉出来。<br/></t>";
_message = _message + "<t align='left'>      5. 不要把自己帮派的人送进监狱。<br/></t>";
_message = _message + "<t align='left'>      6. 你不能抢劫一个被通缉的玩家，然后把他们关进监狱作为赏金。<br/></t>";
_message = _message + "<t align='left'>            1. 这也包括你们组织的成员。<br/></t>";
_message = _message + "<t align='left'>_________________________________________</t><br/><br/>";
_message = _message + "<t align='left'>5. 无正当理由反复击倒其他玩家的义务兵将被视为RDM并将被处理。<br/></t>";
_message = _message + "<t align='left'>      1. 击倒一个玩家，让他们下来，因为你没有拉链是RDM。<br/></t>";
_message = _message + "<t align='left'>      2. 击倒一个违法而不在通缉名单上的玩家是RDM。<br/></t>";
_message = _message + "<t align='left'>            1. 如果你抢劫了一个非赏金猎人角色的玩家，那么它必须是普通的RP'd或者是RDM。<br/></t>";
_message = _message + "<t align='left'>      3. 在宣布自己是RDM之前，先用奖金击倒一个玩家（侧聊不被认为是宣布）。<br/></t>";
_message = _message + "<t align='left'>      4. 用悬赏击落一个在宣布你自己之后从你身边逃跑的玩家不是RDM。<br/></t>";
_message = _message + "<t align='left'>_________________________________________</t><br/><br/>";
_message = _message + "<t align='left'>6. 赏金猎人可以简单地说是——被拒绝、拒绝或尚未被警察部队接受，在阿尔蒂斯的生活中为正义服务的部队。但是，他们不是警察。因此，他们只被授权对头上有75000美元或更高赏金的人采取行动。你不执法，那是警察的工作。<br/></t>";
_message = _message + "<t align='left'>      1. 赏金猎人可能不会像其他平民一样在主要城市部署武器。如果APD成员要求赏金猎人收起武器，他/她必须采取适当行动避免起诉。<br/></t>";
_message = _message + "<t align='left'>      2. 赏金猎人决不应肆无忌惮或企图逮捕一名APD拘留者。如果APD要求援助，那就可以了，但不要碰到一个区域，大声喊着——我是一个警员，试图逮捕警官正在处理的人。<br/></t>";
_message = _message + "<t align='left'>      3. 如果你押送一个玩家，并有一个警察要求你停止，你需要停下来解释你在做什么。如果你以适当的方式抓获了被通缉的玩家，警察不能带走被通缉的玩家，并试图开罚单或将其送进监狱。<br/></t>";
_message = _message + "<t align='left'>            1. 如果你被通缉，APD可能会处理你，如果你拒绝支付门票，APD可能会相应地处理所有通缉的玩家。<br/></t>";
_message = _message + "<t align='left'>      4. 如果你 <t color='#ff0000'>拘捕通缉犯</t> 你必须:<br/></t>";
_message = _message + "<t align='left'>            1. 让玩家知道他们想要什么。<br/></t>";
_message = _message + "<t align='left'>            2. 让玩家知道他们的赏金数额。<br/></t>";
_message = _message + "<t align='left'>            3. 让玩家知道你会把他们送进监狱。<br/></t>";
_message = _message + "<t align='left'>            4. 带玩家去监狱。（民团前哨站（靠近地图标记位置））<br/></t>";
_message = _message + "<t align='left' size='1' shadow='0'><t color='#ffff1a'>5.如果多名警员与嫌疑人发生接触，塔斯可能会逮捕的警员。</t><br/><br/>";
_message = _message + "<t align='left' size='1.2' shadow='0'><t color='#73e600'>_______________ 赏金猎人等级奖励 _______________</t><br/><br/>";
_message = _message + "<t align='left' size='1' shadow='0'><t color='#00ffbf'>1级-0级警戒逮捕</t><br/>";
_message = _message + "<t align='left' size='1' shadow='0'><t color='#00ffbf'>设备 : P07</t><br/>";
_message = _message + "<t align='left' size='1.2' shadow='0'><t color='#5252ff'>______________________________</t><br/><br/>";
_message = _message + "<t align='left' size='1' shadow='0'><t color='#bf00ff'>Vigilante Tier 2 - 25 Arrests</t><br/>";
_message = _message + "<t align='left' size='1' shadow='0'><t color='#bf00ff'>设备 : P07, ACP-C2, Sting</t><br/>";
_message = _message + "<t align='left' size='1.2' shadow='0'><t color='#5252ff'>______________________________</t><br/><br/>";
_message = _message + "<t align='left' size='1' shadow='0'><t color='#ff00bf'>Vigilante Tier 3 - 50 Arrests</t><br/>";
_message = _message + "<t align='left' size='1' shadow='0'><t color='#ff00bf'>设备 : P07, ACP-C2, Sting, T3 Vest</t><br/>";
_message = _message + "<t align='left' size='1.2' shadow='0'><t color='#5252ff'>______________________________</t><br/><br/>";
_message = _message + "<t align='left' size='1' shadow='0'><t color='#40ff00'>Vigilante Tier 4 - 100 Arrests</t><br/>";
_message = _message + "<t align='left' size='1' shadow='0'><t color='#40ff00'>设备 : P07, ACP-C2, Sting, T3 Vest, SPAR16, SPAR16-GL</t><br/>";
_message = _message + "<t align='left' size='1.2' shadow='0'><t color='#5252ff'>______________________________</t><br/><br/>";
_message = _message + "<t align='left' size='1' shadow='0'><t color='#ff1a53'>Vigilante Tier 5 - 200 Arrests</t><br/>";
_message = _message + "<t align='left' size='1.1' shadow='0'><t color='#ff1a53'>设备 : P07, ACP-C2, Sting, T3 Vest, SPAR16, SPAR16-GL, SPAR16S</t><br/>";
_message = _message + "<t align='left' size='1' shadow='0'><t color='#ff1a53'>沟通能力：复活在阿提拉维吉 </t><br/>";
_message = _message + "<t align='left' size='2.5' shadow='0'><t color='#73e600'>____________________________________</t><br/><br/>";



//Fill only the first text
_text1 ctrlSetStructuredText (parseText _message);
_title ctrlSetText "西海岸警戒规则和信息";

//Resize StructuredText component to display the scrollbar if needed
_positionText1 = ctrlPosition _text1;
_yText1 = _positionText1 select 1;
_hText1 = ctrlTextHeight _text1;
_text1 ctrlSetPosition [_positionText1 select 0, _yText1, _positionText1 select 2, _hText1];
_text1 ctrlCommit 0;
//Hide second text, spoiler text and button
_buttonSpoiler ctrlSetFade 1;
_buttonSpoiler ctrlCommit 0;
_buttonSpoiler ctrlEnable false;
_textSpoiler ctrlSetFade 1;
_textSpoiler ctrlCommit 0;
_text2 ctrlSetFade 1;
_text2 ctrlCommit 0;
