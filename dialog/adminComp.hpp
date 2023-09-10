class life_admin_itemComp {
    idd = 100200;
    name= "life_admin_itemComp";
    movingEnable = 0;
    enableSimulation = 1;

    class controlsBackground {
        class Life_RscTitleBackground: Life_RscText {
            colorBackground[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R',0.3843])", "(profileNamespace getVariable ['GUI_BCG_RGB_G',0.7019])", "(profileNamespace getVariable ['GUI_BCG_RGB_B',0.8862])", "(profileNamespace getVariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            x = 0.1;
            y = 0.2;
            w = 0.64;
            h = (1 / 25);
        };

        class MainBackground: Life_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
            x = 0.1;
            y = 0.2 + (11 / 250);
            w = 0.64;
            h = 0.3 - (5 / 250);
        };
    };

    class controls {
        class Title: Life_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "管理员物品补偿";
            x = 0.1;
            y = 0.2;
            w = 0.6;
            h = (1 / 25);
        };

        class TicketHeader: Life_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "车票号码";
            x = 0.1;
            y = 0.25;
            w = 0.6;
            h = (1 / 25);
        };

        class TicketEdit: Life_RscEdit {
            idc = 100201;
            text = "";
            sizeEx = 0.035;
            x = 0.11;
            y = 0.3;
            w = 0.62;
            h = 0.03;
        };

        class MsgText: Life_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "简要说明";
            x = 0.1;
            y = 0.33;
            w = 0.6;
            h = (1 /25);
        };

        class MsgContentEdit: Life_RscEdit {
            idc = 100202;
            text = "";
            sizeEx = 0.035;
            x = 0.11;
            y = 0.38;
            w = 0.62;
            h = 0.03;
        };

        class MessageInfo: Life_RscStructuredText {
            colorBackground[] = {0, 0, 0, 0};
            idc = 100203;
            text = "这只用于补偿目的！";
            x = 0.1;
            y = 0.43;
            w = 0.6;
            h = .275;
        };

        class ConfirmButtonKey: Life_RscButtonMenu {
            idc = 100204;
            text = "Compensate";
            x = (6.25 / 40) + (4.2 / 40) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.51 + (1 / 50);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class CloseButtonKey: Life_RscButtonMenu {
            idc = -1;
            text = "$STR_Global_Close";
            onButtonClick = "closeDialog 0;";
            x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.51 + (1 / 50);
            w = (6.25 / 40);
            h = (1 / 25);
        };
    };
};

class life_admin_vehComp {
    idd = 100220;
    name= "life_admin_vehComp";
    movingEnable = 0;
    enableSimulation = 1;

    class controlsBackground {
        class Life_RscTitleBackground: Life_RscText {
            colorBackground[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R',0.3843])", "(profileNamespace getVariable ['GUI_BCG_RGB_G',0.7019])", "(profileNamespace getVariable ['GUI_BCG_RGB_B',0.8862])", "(profileNamespace getVariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            x = 0.1;
            y = 0.2;
            w = 0.64;
            h = (1 / 25);
        };

        class MainBackground: Life_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
            x = 0.1;
            y = 0.2 + (11 / 250);
            w = 0.64;
            h = 0.3 - (5 / 250);
        };
    };

    class controls {
        class Title: Life_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "行政车辆补偿";
            x = 0.1;
            y = 0.2;
            w = 0.6;
            h = (1 / 25);
        };

        class pidHeader: Life_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "玩家UID（17位）";
            x = 0.1;
            y = 0.25;
            w = 0.5;
            h = (1 / 25);
        };

        class pidContentEdit: Life_RscEdit {
            idc = 100221;
            text = "";
            sizeEx = 0.035;
            x = 0.11;
            y = 0.3;
            w = 0.40;
            h = 0.03;
        };

        class vehCompText: Life_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "车辆补偿";
            x = 0.1;
            y = 0.33;
            w = 0.6;
            h = (1 /25);
        };

        class vehicleList: Life_RscCombo {
            idc = 100222;
            text = "";
            colorBackground[] = {0, 0, 0, 1};
            x = 0.11;
            y = 0.38;
            w = 0.40;
            h = 0.04;
        };

        class MessageInfo: Life_RscStructuredText {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "这仅适用于民用车辆！";
            x = 0.1;
            y = 0.43;
            w = 0.6;
            h = .275;
        };

        class ConfirmButtonKey: Life_RscButtonMenu {
            idc = 100223;
            text = "补偿";
            x = (6.25 / 40) + (4.2 / 40) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.51 + (1 / 50);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class CloseButtonKey: Life_RscButtonMenu {
            idc = -1;
            text = "$STR_Global_Close";
            onButtonClick = "closeDialog 0;";
            x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.51 + (1 / 50);
            w = (6.25 / 40);
            h = (1 / 25);
        };
    };
};

class OED_admin_crateCreate {
    idd = 100240;
    name= "OED_admin_crateCreate";
    movingEnable = 0;
    enableSimulation = 1;

    class controlsBackground {
        class Life_RscTitleBackground: Life_RscText {
            colorBackground[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R',0.3843])", "(profileNamespace getVariable ['GUI_BCG_RGB_G',0.7019])", "(profileNamespace getVariable ['GUI_BCG_RGB_B',0.8862])", "(profileNamespace getVariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            x = 0.1;
            y = 0.2;
            w = 0.64;
            h = (1 / 25);
        };

        class MainBackground: Life_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
            x = 0.1;
            y = 0.2 + (11 / 250);
            w = 0.64;
            h = 0.3 - (5 / 250);
        };
    };

    class controls {
        class Title: Life_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "创建补偿箱";
            x = 0.1;
            y = 0.2;
            w = 0.6;
            h = (1 / 25);
        };

        class pidHeaderr: Life_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "玩家UID（17位）";
            x = 0.1;
            y = 0.25;
            w = 0.5;
            h = (1 / 25);
        };

        class pidContentEditt: Life_RscEdit {
            idc = 100241;
            text = "";
            sizeEx = 0.035;
            x = 0.11;
            y = 0.3;
            w = 0.40;
            h = 0.03;
        };

        class MessageInfo: Life_RscStructuredText {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "这仅是为了补偿玩家！";
            x = 0.1;
            y = 0.43;
            w = 0.6;
            h = .275;
        };

        class ConfirmButtonKey: Life_RscButtonMenu {
            idc = 100243;
            text = "创建";
            onButtonClick = "hint 'Compensation crates are no longer used.';";
            x = (6.25 / 40) + (4.2 / 40) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.51 + (1 / 50);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class CloseButtonKey: Life_RscButtonMenu {
            idc = -1;
            text = "$STR_Global_Close";
            onButtonClick = "closeDialog 0;";
            x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.51 + (1 / 50);
            w = (6.25 / 40);
            h = (1 / 25);
        };
    };
};