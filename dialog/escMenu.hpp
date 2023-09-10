#define GUI_GRID_WAbs			((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs			(GUI_GRID_WAbs / 1.2)
#define GUI_GRID_H			(GUI_GRID_HAbs / 25)
#define GUI_GRID_Y			(safezoneY + safezoneH - GUI_GRID_HAbs)

class OlyExTitle : Life_A3RscTitle {
	idc = -1;
	text = "西海岸生活服";
	y = (7.5 * GUI_GRID_H + GUI_GRID_Y);
};

class OlyExWebsite : Life_A3RscButtonMenu {
	idc = -1;
	text = "服务器官方YY:1460266422";
	url = "https://z.yy.com/w0rTkeeIZg12";
	y = (8.62 * GUI_GRID_H + GUI_GRID_Y);
};

class OlyExTeamspeak : Life_A3RscButtonMenu {
	idc = -1;
	text = "QQ群：870988619";
	url = "https://jq.qq.com/?_wv=1027&k=QFCi2DZq";
	y = (9.72 * GUI_GRID_H + GUI_GRID_Y);
};

class OlyExDiscord : Life_A3RscButtonMenu {
	idc = -1;
	text = "帮派入驻领取福利";
	url = "https://jq.qq.com/?_wv=1027&k=QFCi2DZq";
	y = (10.8 * GUI_GRID_H + GUI_GRID_Y);
};

class OlyExStats : Life_A3RscButtonMenu {
  idc = -1;
  text = "漏洞外挂举报有奖";
  url = "QQ群：870988619/";
  y = (11.9 * GUI_GRID_H + GUI_GRID_Y);
};

class OlyExWiki : Life_A3RscButtonMenu {
  idc = -1;
  text = "服务器赞助私聊管理";
	url = "QQ群：870988619/";
  y = (13 * GUI_GRID_H + GUI_GRID_Y);
};

//18.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))
