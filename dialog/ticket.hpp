class Life_ticket_give
{
	idd = 2650;
	name = "life_ticket_give";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.3;
			y = 0.2;
			w = 0.47;
			h = (1 / 25);
		};

		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.3;
			y = 0.2 + (11 / 250);
			w = 0.47;
			h = 0.3 - (22 / 250);
		};
	};

	class controls
	{
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 2651;
			text = "";
			x = 0.3;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};

		class moneyEdit : Life_RscEdit
		{
			idc = 2652;

			text = "100";
			sizeEx = 0.030;
			x = 0.40; y = 0.30;
			w = 0.25; h = 0.03;
		};

		class payTicket: Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Ticket_GiveTicket";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_ticketGive";
			x = 0.45;
			y = 0.35;
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};

class Life_ticket_pay
{
	idd = 2600;
	name = "life_ticket_pay";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.3;
			y = 0.2;
			w = 0.47;
			h = (1 / 25);
		};

		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.3;
			y = 0.2 + (11 / 250);
			w = 0.47;
			h = 0.3 - (22 / 250);
		};
	};

	class controls
	{
		class InfoMsg : Life_RscStructuredText
		{
			idc = 2601;
			sizeEx = 0.020;
			text = "";
			x = 0.287;
			y = 0.2 + (11 / 250);
			w = 0.5; h = 0.12;
		};

		class payTicket: Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Ticket_PayTicket";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_ticketPay;";
			x = 0.2 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.42 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class refuseTicket : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Ticket_RefuseTicket";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "closeDialog 0;";
			x = 0.4 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.42 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};

class Life_invoice_give
{
	idd = 2650;
	name = "life_invoice_give";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.3;
			y = 0.2;
			w = 0.47;
			h = (1 / 25);
		};

		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.3;
			y = 0.2 + (11 / 250);
			w = 0.47;
			h = 0.3 - (22 / 250);
		};
	};

	class controls
	{
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 2651;
			text = "";
			x = 0.3;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};

		class moneyEdit : Life_RscEdit
		{
			idc = 2652;

			text = "100";
			sizeEx = 0.030;
			x = 0.40; y = 0.30;
			w = 0.25; h = 0.03;
		};

		class payTicket: Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Invoice_GiveInvoice";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_medicInvoiceGive";
			x = 0.45;
			y = 0.35;
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};

class Life_invoice_pay
{
	idd = 2600;
	name = "life_invoice_pay";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.3;
			y = 0.2;
			w = 0.47;
			h = (1 / 25);
		};

		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.3;
			y = 0.2 + (11 / 250);
			w = 0.47;
			h = 0.3 - (22 / 250);
		};
	};

	class controls
	{
		class InfoMsg : Life_RscStructuredText
		{
			idc = 2601;
			sizeEx = 0.020;
			text = "";
			x = 0.287;
			y = 0.2 + (11 / 250);
			w = 0.5; h = 0.12;
		};

		class payTicket: Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Invoice_PayInvoice";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_medicInvoicePay;";
			x = 0.2 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.42 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class refuseTicket : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Invoice_RefuseInvoice";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "closeDialog 0;";
			x = 0.4 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.42 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};

class Life_list_house_price
{
	idd = 2750;
	name = "life_list_house_price";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.3;
			y = 0.2;
			w = 0.47;
			h = (1 / 25);
		};

		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.3;
			y = 0.2 + (11 / 250);
			w = 0.47;
			h = 0.3 - (22 / 250);
		};
	};

	class controls
	{
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 2751;
			text = "输入一个值以列出要出售的房子";
			x = 0.3;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};

		class moneyEdit : Life_RscEdit
		{
			idc = 2752;

			text = "1250000";
			sizeEx = 0.030;
			x = 0.40; y = 0.30;
			w = 0.25; h = 0.03;
		};

		class payTicket: Life_RscButtonMenu {
			idc = -1;
			text = "出售清单";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[life_pInact_curTarget,1] spawn OEC_fnc_listHouse;";
			x = 0.45;
			y = 0.35;
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};