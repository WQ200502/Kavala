//  File: fn_helpHints.sqf
//	Author: Jesse "tkcjesse" Schultz
//	Description: Informs new players of helpful stuff.

private _array = [
	"<t color='#ffff00' size='2' align='center'>Yy频道：</t><br/><br/><t align='center' size='1.5' color='#00ff99'>1460266422</t>",
	"<t color='#ffff00' size='2' align='center'>我们的QQ群：</t><br/><br/><t align='center' size='1.5' color='#00ff99'>870988619</t>",
	"<t color='#ffff00' size='2' align='center'>新手礼包领取方式</t><br/><br/><t align='center'>您可以加入我们的QQ群：870988619.寻求管理员获取！</t>",
	format ["<t color='#ffff00' size='2' align='center'>服务器规则</t><br/><br/><t align='center'>请加入服务器后必须查看服务器规则，违反规则将被严惩。感谢您在西海岸服务器上玩游戏！领取新手福利请加QQ群870988619</t>",olympus_server],
	"<t color='#ffff00' size='2' align='center'>申请警察</t><br/><br/>想加入警察或医生吗？您需要至少40小时的平民游戏时间在我们的服务器上。欲了解更多要求，请加入我们的QQ群870988619了解",
	"<t color='#ffff00' size='2' align='center'>规则-打劫信息</t><br/><br/>进行游戏时，你如果要打劫某位玩家，你需要先使用Shift+K给玩家发送打劫信息后才可以对其进行操作（打劫信号有效距离为50米，超出距离需要发送短信或者拨打电话）。",
	"<t color='#ffff00' size='2' align='center'>规则-战区大退</t><br/><br/>与。 在战斗区域内，大退游戏或自杀是违反规则的。 被投诉您将会得到办1天的处罚。",
	"<t color='#ffff00' size='2' align='center'>规则-载具撞人</t><br/><br/>在服务器中，如果你使用你的载具撞击了玩家，你需要做的是给被撞倒的玩家道歉并取得他的原谅，否则服务器将会对载具撞人的玩家处以一定的处罚（性质恶劣的会被永ban）。",
	"<t color='#ffff00' size='2' align='center'>规则-可直接击杀区域</t><br/><br/>服务器在以下区域可以不发打劫：叛军点、军火岛、黑市、被抢劫的NPC点、发生战斗的区域1公里范围内，除了以上区域不允许无警告击杀玩家，否则会赔钱。重则会被BAN（服务器保护未持枪赚钱的玩家，任何情况不允许击杀这种玩家）",
	"<t color='#ffff00' size='2' align='center'>新手指南</t><br/><br/>首先，你需要添加服务器官方QQ群：870988619.查看群文件的新手视频，然后不会的可以在群内问！",
	"<t color='#ffff00' size='2' align='center'>黑市</t><br/><br/>首先你需要有一个帮派，然后找到一个绿色的牌子占领它，然后你就可以在这加工你的非法物品了。",
	"<t color='#ffff00' size='2' align='center'>协警</t><br/><br/>在街上发现很多罪犯？在服务器上经过40个小时的游戏，经过警局的考核成为一名协警，走上街头！作为协警，你可以把通缉犯送进监狱！",
	format ["<t color='#ffff00' size='2' align='center'>西海岸服务器忠告</t><br/><br/>请仔细阅读群文件规则信息<br/>如果违反规则你将收到严厉的惩处<br/>Server 1: 202.189.7.80:2302<br/>You are currently on Server: %1",olympus_server],
	"<t color='#ffff00' size='2' align='center'>有用的提示</t><br/><br/>在服务器上工作超过10个小时后，可以在设置菜单中禁用像这样的自动有用提示！",
	"<t color='#ffff00' size='2' align='center'>举报玩家</t><br/><br/>你可以在我们的QQ群870988619举报违规玩家)有几率获得奖励。几乎所有的报告都需要证明（5分钟的视频或有效的截图）。有关可接受的证明形式的更多信息，请访问网站。",
	"<t color='#ffff00' size='2' align='center'>反馈有奖</t><br/><br/>你发现了外挂/BUG？你可以在QQ群：870988619反馈给管理员（西海岸论坛QQ群：870988619）报告漏洞)。你需要创建一个新的帐户，如果你没有一个。如果是有效的反馈，你将得到50-1000万的奖励",
	"<t color='#ffff00' size='2' align='center'>服务器消息</t><br/><br/>你知道我们是一个绿色的服务器吗？<br/> 你可以随时来到服务器玩耍，但是你一旦违反规则或者使用作弊软件、言语侮辱、使用BUG，那么我们就要对你说再见了！",
	"<t color='#ffff00' size='2' align='center'>标记车辆</t><br/><br/>服务器会自动清理废弃和/或未使用的车辆，因此请确保您在钥匙链菜单中标记任何要保留的车辆，或者只需在控件中绑定自定义操作9，即可更快、更轻松地标记车辆！"
];

private _stopRepeat = false;
while {true} do {
	if (!(life_newPlayerHints) && (O_stats_playtime_civ > 600)) exitWith {};
	uiSleep 30;
	_stopRepeat = false;
	if (!(_stopRepeat) && (player getVariable["statBounty",500]) > 0 && (player getVariable["statBounty",500]) < 1000000) then {
		hint parseText "<t color='#ffff00' size='2' align='center'>法院通知</t><br/><br/>苦海无边、回头是岸。如果你被通缉的价格低于100万美元并且没有限制性的指控，你可以在当地法院付清你的赏金！";
		_stopRepeat = true;
	} else {
		hint parseText (selectRandom _array);
	};
	uiSleep 600;
};