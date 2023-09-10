waitUntil {!isNull player && player == player};
if(player diarySubjectExists "rules")exitwith{};

player createDiarySubject ["changelog","服务器贡献"];
player createDiarySubject ["serverrules","服务器常驻玩家名单"];
player createDiarySubject ["policerules","服务器规则"];
player createDiarySubject ["vigirules","警队规则"];
player createDiarySubject ["rrrules","按键指南"];
player createDiarySubject ["controls","医生规则"];
player createDiarySubject ["websiteinfo","新手指南"];

/*
Example
    player createDiaryRecord ["", //Container
        [
            "", //Subsection
                "
                    TEXT HERE<br/><br/>
                "
        ]
    ];
*/
player createDiaryRecord["changelog",
    [
        "服务器贡献",
            "

            "
    ]
];

player createDiaryRecord ["serverrules",
    [
        "服务器常驻玩家",
            "
1.请自行添加你的名字到群文件<br/>
<br/>

            "
    ]
];

player createDiaryRecord ["serverrules",
    [
        "服务器常驻帮派",
            "
1.请帮主自行添加你的帮派名字到群文件<br/>
2.Top<br/>
3.ATM<br/>
            "
    ]
];

// Police Section
player createDiaryRecord ["policerules",
    [
        "服务器规则",
            "
请查看QQ群文件<br/><br/>
            "
    ]
];

// Rescue & Recovery Section
player createDiaryRecord ["rrrules",
    [
        "按键指南",
            "
游戏内的基本按键操作，如需帮助可加入QQ群870988619或游戏内联系警察.<br/><br/>
                1: 通缉名单<br/>
                2: 打开手机<br/>
                4: Cop被盗车辆和RnR调度响应<br/>
                U: 锁上和打开汽车和房门<br/>
                左Shift+O：耳塞<br/>
                F: Cop和RR警报器<br/>
                左Shift+L：激活Cop和RR灯<br/>
                L: 普通前照灯<br/>
                L+手枪瞄准：Cop雷达<br/>
                左shift+F：汽笛鸣叫<br/>
                左Shift+T:打开车辆库存<br/>
                T: 车辆行李箱和房屋库存<br/>
                左 Shift + R: 束缚（仅限警察）<br/>
                Tab: 双手抱头<br/>
                R: 换弹<br/>
                F: 改变射击模式<br/>
                H: 放入枪套br/>
				ESC-配置-控件-自定义设置-使用动作<br/>
                使用动作  9: 标记车辆不会回库<br/>
                使用动作 10: 设置window为其他快捷键<br/>
                使用动作 11: 红牛<br/>
                使用动作 12: 耳塞<br/>
                使用动作 14: 致命开关（仅限Cop）<br/>
                使用动作 15: 道路装备（医疗）和钉带<br/>
                使用动作 16: 修复对象（医疗人员）<br/>
                使用动作 17: 使用诱饵车遥控器（仅限警察）<br/>
                使用动作 18: 自动奔跑<br/>
                使用动作 19: 血袋<br/>
                使用动作 20:使用海洛因<br/>
                左window键：主交互键<br/>
                用于捡起金钱, 与物品互动<br/>
                车辆（修理等）以及警察、RnR和赏金猎人<br/>
                与玩家互动。可以反弹到单个<br/>
                按capslk与玩家讲话<br/>
                ESC->配置->控制->自定义->使用操作/<br/>
            "
    ]
];

// Vigilante Section
player createDiaryRecord ["vigirules",
    [
        "警队规则",
            "
请阅读QQ群内警员规则<br/>
            "
    ]
];

// Controls Section

player createDiaryRecord ["controls",
    [
        "医生规则",
            "
请阅读QQ群内警员规则<br/><br/>
            "
    ]
];

//Website Info

player createDiaryRecord ["websiteinfo",
    [
        "新手指南",
            "           
请阅读QQ群内视频文件<br/><br/>

"			
    ]
];
