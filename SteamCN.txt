[index]
[#1]## 前前前言
[#2]## Part1 生成配置文件
*[#3]### 「初阶使用」保姆式教学
*[#4]### 「进阶使用」始于挂卡，不止于挂卡
[#5]## Part2 Let's Get Started 部署ASF真的很简单
*[#6]### 开袋即食调料包 For Linux
*[#7]### 开袋即食调料包 For Windows
[#8]## Part3 与正在运行的ASF交互
*[#9]### 使用「交互式控制台」
*[#10]### 使用Steam群组
*[#11]### 使用ASF的IPC功能
[#12]## Part4 接入机器人（高阶应用）
*[#13]### Telegram机器人
*[#14]### QQ机器人
[/index]

本帖的前身是《[url=https://steamcn.com/t376807-1-1]从零开始的ASF详细食用手册（windows限定）[/url]》，我一年前写的在windows上部署ASF的教程。
给了几个下载链接，记录了几个步骤，其实乏善可陈，没什么干货。

但是没关系！重置版教程来了，REMASTERED！
这次争取写好一点。

目前预定完成和尚未完成的内容：见目录。
本帖所有内容均在[url=https://github.com/rakuyo42/EasierUsageForASF]Github[/url]上更新，本项目遵循MIT协议开源。
[page]
[size=7]Part1 生成配置文件[/size]

[size=5]自己动手丰衣足食[/size]

windows不必赘述，随便用个文本编辑器就行。
还是多嘴一句，推荐使用sublime或者editplus。即使是日常使用，最好也不要用windows自带的记事本。
自带的记事本以及写字板由于历史遗留问题，保存的时候会自动在文件开头加一个肉眼看不到的字符，可能导致各种各样的问题。
而且关键是完全不知道加了有什么卵用，很神必。
[quote]在Windows平台下，使用系统的记事本以UTF-8编码格式存储了一个文本文件，但是由于Microsoft开发记事本的团队使用了一个非常怪异的行为来保存UTF-8编码的文件，它们自作聪明地在每个文件开头添加了0xefbbbf（十六进制）的字符，所以我们就会遇到很多不可思议的问题，比如，网页第一行可能会显示一个“？”，明明正确的程序一编译就报出语法错误，等等。[/quote]
linux使用vim直接建立文本文档（nano是什么？没听过不清楚不了解）。
首先确定你当前工作目录在「ArchiSteamFarm(ASF主程序所在目录)/config/」下。
执行「vim 文件名」进入编辑界面（文件不存在会自动创建），按主键盘的字母I（大写的i）键，进入插入模式（左下角显示INSERT）。

在外面复制好你要输入的内容，点击鼠标右键。
如果你的ssh客户端是xshell右键应该会有弹窗，选择粘贴不用我说了8。
如果你的ssh客户端是putty右键应该直接就粘贴上了，如果没有，就按住Shift再右键一次。

编辑好文件内容后，按ESC从插入模式退回到命令模式，输入「:wq」（:是半角冒号，wq一定要小写）并按回车来保存文件内容并退出。

或者你直接在外面编辑好配置文件，使用WinSCP之类的SFTP/FTP客户端或者宝塔面板之类的东西直接传文件也行。
当然传过去的配置文件一定要放在「ArchiSteamFarm(ASF主程序所在目录)/config/」这个目录下。

[size=5]好麻烦有没有现成能用的啊[/size]

官方的「[url=https://justarchinet.github.io/ASF-WebConfigGenerator/#/]ASF配置文件生成器[/url]」

不知道怎么配置？
官方的「[url=https://github.com/JustArchiNET/ArchiSteamFarm/wiki/Configuration-zh-CN]ASF配置相关中文wiki[/url]」
[spoiler]想当年我写上一个教程的时候还没有中文wiki，我自己照着wiki一行一行翻译的呜呜呜[/spoiler]
[page]
[size=6]1.1 「初阶使用」保姆式教学[/size]

[size=5]1.1.1 没时间解释了先跑起来[/size]

新建一个文本文档，输入
[code]{
  "SteamLogin": "你的steam用户名",
  "SteamPassword": "你的steam密码",
  "Enabled": true
}[/code]
[quote]注意：账号&密码需要包含在双引号中，Enabled选项的true不能。[/quote]
保存为「bot.json」，文件名其实无所谓，取什么都行。
叫humun.json也行，robot.json也行，不过扩展名一定是json。

把这个文件放到「ArchiSteamFarm(ASF主程序所在目录)/config/」目录下。

配置完成，启动ASF。

[size=5]1.1.2 交互式控制台是什么听起来很炫酷的样子我要这个给我弄这个[/size]

官方wiki解释：
[attachimg]725912[/attachimg]

好了让我们开启它，新建一个文本文档，输入
[code]{
  "SteamOwnerID": 你在上一步中配置的那个steam账号的64位id
}[/code]
保存为「ASF.json」，[b]必须叫ASF.json[/b]。
把这个文件放到「ArchiSteamFarm(ASF主程序所在目录)/config/」目录下。

配置完成，启动ASF。

[size=4]P.S. 我怎么知道我steam64位id是多少？[/size]

如果你安装了Enhanced Steam浏览器扩展，个人资料页面应该有：
[attachimg]725916[/attachimg]
这个链接结尾的17位数字就是你steam账号的64位id（相当于steam账号的身份证号码，永久固定且唯一）

如果你[b]没有设置过[/b]个人资料的自定义URL，甚至你个人资料页面的链接直接就是。
[attachimg]725919[/attachimg]

实在找不到去[url=https://steamrepcn.com/]Steamrep[/url]查自己。
[attachimg]725920[/attachimg]

[page]
[size=6]1.2 「进阶使用」始于挂卡，不止于挂卡[/size]

「虽然搞不太清楚什么情况，但我先放一个神秘链接在这.jpg」

「[url=https://github.com/JustArchiNET/ArchiSteamFarm/wiki/Configuration-zh-CN]官方Github的ASF配置相关中文Wiki[/url]」

本部分结束。

[spoil]开玩笑。
不过现在中文wiki也有了，动手能力强的自己对照着wiki就能完全吃透ASF这个工具了。

但如果你不想折腾的话，这里提供一些常用的使用场景。

[size=5]1.2.1 常用配置[/size]
进入「[url=https://justarchinet.github.io/ASF-WebConfigGenerator/#/bot]官方ASF配置文件生成器[/url]」，修改你想要自定义的选项（没动过的选项不会生成，配置文件里没有的选项一律使用默认值）。
修改完之后拉到网页最下面，点击下载，获得配置文件。

当然你也可以手动改配置文件，在你的steam账号配置文件*.json（*是你的账号备注，可以随便取。除了ASF.json，ASF是全局配置）中编辑选项：
[code]{
  "SteamLogin": "你的steam用户名",
  "SteamPassword": "你的steam密码",
  "Enabled": true,
  "新选项A": 新选项的值a,
  "新选项B": 新选项的值b
}[/code][quote]注意：
一、有些选项的「值」类型为「字符串 string」，则必须用半角双引号「"value"」包含起来。
二、每个选项最后有一个半角逗号「,」。如果缺少则会造成JSON格式错误，导致ASF无法解析配置文件。只有最后一个选项末尾的逗号可以省略。[/quote]
之后的选项示例仅列出选项本身，不再列出整个配置文件，自行对号入座。

[size=5]1.2.2 杂项[/size]
[quote][code]  "AcceptGifts": true,[/code]自动接受礼物。
我是关了的。个人看法：他人表达了自己的心意，不管你接不接受，一定要正视才算礼貌。
如果送你礼物的百分之百是代购……对不起，当我放了个P吧。[/quote]
[quote][code]  "AutoSteamSaleEvent": true,[/code]每天自动完成探索队列。
有什么用？夏促/圣诞等活动的时候探索队列掉卡，记得吗。[/quote]
[quote][code]  "BotBehaviour": 8,[/code]自动去除所有库存通知。
强迫症救星。[/quote]
[size=5]1.2.3 挂卡时自定义信息[/size]
[quote][code]  "CustomGamePlayedWhileFarming": “挂卡中”,[/code]如果设置了此项，则挂卡时会显示「非Steam游戏中：你设置的值」。
删掉这个选项或将其值设置为「""」或「null」(注意null不带引号) 则会显示正在游玩当前挂卡的游戏。[/quote]
[size=5]1.2.4 闲置时挂时长[/size]
[quote][code]  "GamesPlayedWhileIdle": [
    你要挂的游戏A的appid,
    你要挂的游戏B的appid
  ],[/code]如果设置了此项，则挂卡时会显示你正在游玩列表中的游戏（最多可以同时挂32款游戏，但无法保证显示顺序）。
删掉这个选项或将其值设置为「null」(注意null不带引号) 则会显示你什么都没玩。[/quote]
[size=5]1.2.5 闲置时自定义信息[/size]
[quote][code]  "CustomGamePlayedWhileIdle": “雀魂麻将majsoul”,[/code]如果设置了此项，则闲置时会显示「非Steam游戏中：你设置的值」。
删掉这个选项或将其值设置为「""」或「null」(注意null不带引号) 则会显示当前真实状态（正在游玩挂时长的游戏或什么都没玩）。[/quote]
[/spoil]

[page]
[size=7]Part2 Get Started 部署ASF真的很简单[/size]

目前ASF升级到V4版本，基本上有坑都被趟得差不多了，现在已经非常好上手了。
脚本匆忙写就，有问题的地方还请多多指正。

这里简单讲下运行环境系统版本选择建议：
[list]
[*]如果你只有PC或者笔记本，有空的时候挂挂卡。
那你唯一的选择就是windows版。
除非你不嫌麻烦反手装一个linux虚拟机，我没什么好说的。
[*]如果你有一台魔法主机，可以重装系统，强烈建议装linux。
除非你要挂qq或者yy之类只有windows桌面客户端的软件，否则[b]服务器系统二选一，linux>>>windows[/b]。
[/list]
linux比较主流的有三种，centos/ubuntu/debian。
服务器一般不用ubuntu，原因有兴趣自行查阅。
centos最好上手，网上资料也最多，出了什么问题最好查。
debian资料相对少，稳定性最高，对超低端魔法主机（指128m甚至以下内存）的优化最好。
简单点说，除非你的魔法主机特别弟弟，只跑得动debian，那没什么办法。（或者你是追求稳定性>易用性的老鸟，不过老鸟肯定有一套自己的见解，也不会在这听我吹这种入门知识）
否则[b]新手无脑选centos[/b]比较好。

其实centos目前流行的又有6和7之分，[b]如果你重新装系统，两个都能选，选7。[/b]
[url=https://wiki.centos.org/zh/About/Product]2020年11月30日centos6就停止更新维护[/url]了，现在还坚持用6的基本上都是生产环境跑了60、70%内存的，实在牵扯太多。升级伤筋动骨，根本不现实。
当然了，如果你有自己的理由坚持用6，那我也没办法也没必要说服你用7。
linux发行版选择同理，windows和linux选择同理。总之还是看自己情况。

再多嘴一句，如果魔法主机配置实在很低，centos和debian都有minimal（微型版）的发行版可选，能不能装要看你的魔法主机提供商。

[page]
[size=6]2.1 开袋即食调料包 For Linux[/size]

[size=5]2.1.1 同类竞品[/size]
写完才发现已经有大佬已经写过了（[url=https://steamcn.com/t413908-1-1]【ASF挂卡】安装ASF的一键脚本[/url]），功能还比我写的强大得多。
不过我追求的是轻便快捷，两个脚本并不雷同，如果有喜欢折腾多功能的选手可以研究一下他家的。
我只写了最基本的几个功能，包括安装依赖->下载ASF->解压ASF->直接生成配置文件(可选)->利用screen后台运行(可选)。
此脚本只在CentOS 7系统中通过测试，Ubuntu和Debian八成用不了，后续有空再更新。

[size=5]2.1.2 安装命令[/size]
由于那堵墙越来越高，目前大部分魔法主机都受到了影响，于是shell脚本也做了分流。
如果你的魔法主机位于国外，比如搬瓦工/Vultr/RamNode等等，使用下面这条指令：
[code]yum install -y wget && wget -O ez_start_asf.sh https://github.com/rakuyo42/EasierUsageForASF/releases/download/v0.1.0/ASF-Seasoner-Linux.sh && sh ez_start_asf.sh[/code]
如果你的魔法主机位于国内，比如腾讯云/阿里云/华为云等等，使用下面这条指令：
[code]yum install -y wget && wget -O ez_start_asf.sh http://cdn.ews.ink/shell/centos/EasierStartForASF.sh && sh ez_start_asf.sh[/code]

[size=5]2.1.3 如何知道是否成功安装ASF[/size]
如果上一步的脚本成功执行到结束，在终端输入ll（两个小写的L）查看当前目录资源，结果应该像这样：
[attachimg]725546[/attachimg]
蓝色代表文件夹：[size=3][color=#00bfff]ArchiSteamFarm[/color][/size] 是ASF主程序目录
绿色代表可执行文件：[size=3]asf[/size] -> [color=#00ff00]ArchiSteamFarm/ArchiSteamFarm[/color] 是指向ArchiSteamFarm程序入口的软链接（类似快捷方式）
[b]如果有这个名为asf的快捷方式就证明ASF主程序安装完成了。[/b]

假如你想重装/更新ASF，只需要再运行一次此脚本，成功执行完成后会自动重装为最新的ASF。
脚本会自动将之前的ArchiSteamFarm目录打包成zip并移动到备份目录，这时再执行ll查看当前目录应该是：
[attachimg]725551[/attachimg]
[size=3][color=#00bfff]ArchiSteamFarm_backup[/color][/size] 是备份文件夹，里面装的是执行脚本前一个版本的压缩包。

[size=5]2.1.4 如何确保已经部署完成的ASF在正常工作[/size]
在终端执行[code]screen -r asf[/code]进入后台运行asf的screen，这个screen就是ASF正在运行的界面。

进入asf所在screen之后——
如果你想重启ASF程序，使用「Ctrl+C」组合键终止当前进程，然后输入[code]./asf[/code]回车重新启动ASF即可。
如果一切正常，使用「Ctrl+A+D」组合键从当前screen退出，回到主窗口。

执行[code]screen -ls[/code]查看所有screen，like this：
[attachimg]725572[/attachimg]
如果你想直接终止整个screen，执行[code]kill -9 [pid][/code]即可，如图例中应该执行「kill -9 632 」。

执行[code]screen -R [screen_name][/code]建立名为screen_name的screen并进入其中，如执行「screen -R AASSFF」进入名为AASSFF的新窗口。

[b]只要你看到ASF在screen中正常执行，直接关闭当前ssh会话即可。[/b]
当你退出会话后screen会自动挂起并在后台持续运行。

[size=5]2.1.5 常见问题[/size]
[list=1]
[*]脚本运行到安装依赖时显示安装screen失败
首先尝试[code]yum install -y screen[/code]手动安装一次，就算安装失败也可以看到是为什么失败的，因为脚本里安装无论成功失败都隐藏了安装信息。
手动安装也失败的话大概率是screen依赖的glibc版本有问题，可以参考《[url=https://www.cnblogs.com/xiaonanhai/p/8302058.html]Linux安装 Screen出现的问题[/url]》自行升级glibc。
[*]欢迎继续反馈。~
[/list]

[page]
[size=6]2.2 开袋即食调料包 For Windows[/size]

首先下载windows版的ASF。
官方链接：「[url=https://github.com/JustArchiNET/ArchiSteamFarm/releases/latest/download/ASF-win-x64.zip]官方Github下载[/url]」（最新的稳定版）
分流下载：「[url=https://pan.baidu.com/s/1eSF9gVi8YUpdS6gQfkNN8A]度盘分流[/url](提取码stcn) / [url=https://www.baiduwp.com/s/?surl=1eSF9gVi8YUpdS6gQfkNN8A&pwd=stcn]度盘在线下载[/url]」（截至2019/7/6最新的稳定版V4.0.2.7）
解压到某个文件夹。

这时其实已经部署完成，稍微配置一下就可以愉快地玩耍了。
如果你到这一步还不知道如何开始的话，接着往下看。

下载我写的快速部署脚本EasierStartForASF.bat，与解压后的ASF程序文件夹放在一起。
[size=4]推荐[/size]目录结构：
[code]└── ASF
  ├── ASF-win-x64/        #ASF-win-x64-V4.0.2.7.zip解压目录
  │ ├── ArchiSteamFarm.exe        #主程序
  │ ├── config/        #配置目录
  │ ├── zh-CN/        #简中语言包
  │ └── ...
  └── EasierStartForASF.bat[/code]
[size=4]把Part1中生成的ASF.json和bot.json两个配置文件都拖到脚本图标上即可。
脚本会自动把配置文件复制到正确的位置，并在脚本所在目录生成ArchiSteamFarm.exe的快捷方式ASF.ink。[/size]
OK，点击快捷方式ASF就能轻松启动了，你也可以把这个快捷方式改成任何你喜欢的名字，或者放到任何地方去。
如果路径有变化，再启动一次脚本（如果不想更新配置文件直接双击启动脚本即可），会重新生成新的快捷方式。

[size=5]TODO[/size]
如果把配置文件拖到脚本文件的图标上，在此之前已经存在同名配置文件，现在的脚本会直接覆盖，好像不太合适。
预定修改方向：如果检测到已经有同名配置文件，则自动备份同名配置文件，再放入新的配置文件。

[hide]
[size=4]windows快速部署ASF脚本下载链接[/size]
[quote]直接下载
[url=http://cdn.ews.ink/bat/EasierStartForASF.bat]http://cdn.ews.ink/bat/EasierStartForASF.bat[/url]
[/quote]
[quote]度盘分流（压缩包解压密码steamcn）
[url=https://pan.baidu.com/s/1XV6MwcX5LrZmJzWsRftE8A]https://pan.baidu.com/s/1XV6MwcX5LrZmJzWsRftE8A?提取码=[/url]stcn
[url=https://www.baiduwp.com/s/?surl=1XV6MwcX5LrZmJzWsRftE8A&pwd=stcn]https://www.baiduwp.com/s/?surl=1XV6MwcX5LrZmJzWsRftE8A&pwd=stcn[/url]
[/quote]
[/hide]
[page]
[size=7]Part3 与正在运行的ASF交互[/size]

具体有哪些命令请参看「[url=https://github.com/JustArchiNET/ArchiSteamFarm/wiki/Commands-zh-CN#命令-1]官方Github的命令相关中文Wiki的命令部分一栏[/url]」。

为了像我一样的懒癌着想这里列出最常用的几个：[quote][size=5]bot信息[/size]
[code]status <Bots>
显示指定机器人的状态。[/code]
[code]nickname <Bots> <Nickname>
将指定机器人的昵称更改为 Nickname。[/code]
[code]balance <Bots>
显示指定机器人的 Steam 钱包余额。[/code]
[code]owns <Bots> <Games>
检查指定机器人是否已拥有 Games。
示例：owns bot1 app/292030,name/Witcher[/code]
[/quote]
[quote][size=5]bot行为[/size]
[code]farm <Bots>
重新启动指定机器人的挂卡模块。[/code]
[code]pause <Bots>
永久暂停指定机器人的自动挂卡模块。 ASF 在本次会话中将不会再尝试对此帐户进行挂卡，除非您手动 resume 或者重启 ASF。[/code]
[code]pause~ <Bots>
临时暂停指定机器人的自动挂卡模块。 挂卡进程将会在下次游戏事件或者机器人断开连接时自动恢复。 您可以 resume 以恢复挂卡。[/code]
[code]resume <Bots>
恢复指定机器人的自动挂卡进程。[/code]
[code]addlicense <Bots> <GameIDs>
为指定机器人激活给定的 AppIDs（Steam 网络）或 SubIDs（Steam 商店），仅免费游戏有效。[/code]
[code]unpack <Bots>
拆开指定机器人库存中的所有补充包。[/code]
[code]redeem <Bots> <Keys>
为指定机器人激活给定的游戏序列号或钱包充值码。[/code]
[/quote]
[quote][size=5]ASF相关[/size]
[code]restart
重新启动 ASF 进程。[/code]
[code]version
显示 ASF 的版本号。[/code]
[/quote]
[page]

[size=6]3.1 使用「交互式控制台」[/size]

[attachimg]725912[/attachimg]
如果要使用asf的控制台，需要配置ASF.json里的SteamOwnerID选项，详见Part1的1.1.2部分。

配置正确后，在asf运行界面按「c」键开启「交互式控制台」，like this：
[attachimg]726035[/attachimg]

接下来输入对应的命令就好了。
具体指令清单查看「[url=https://github.com/JustArchiNET/ArchiSteamFarm/wiki/Commands-zh-CN#命令-1]官方Github的命令相关中文Wiki的命令部分一栏[/url]」或本帖的Part3导言部分。

[page]
[size=6]3.2 使用Steam群组[/size]

首先新建一个只有你自己的群组。
进入群组主页，在网址后面加上「/memberslistxml?xml=1」并访问。
比如本来是「steamcommunity.com/groups/你自定义的组链接/」——
那就访问「steamcommunity.com/groups/你自定义的组链接/memberslistxml?xml=1」。
第二行的「groupID64」就是你的组id，拿个小本本记好。

编辑bot.json，新加一行[code]  "SteamMasterClanID": 你的组id,[/code]
[quote]注意：
一、上面配置的「组id」不需要用双引号包围。
二、只有最后一行的末尾可以不加逗号。[/quote]
如果你在ASF.json中设定好了SteamOwnerID，那么已经配置完成了。

使用「64位id为SteamOwnerID的账号」往「64位id为SteamMasterClanID的群组」里发「!指令」（注意指令格式有感叹号!）消息就行了。
具体指令清单查看「[url=https://github.com/JustArchiNET/ArchiSteamFarm/wiki/Commands-zh-CN#命令-1]官方Github的命令相关中文Wiki的命令部分一栏[/url]」或本帖的Part3导言部分。
[quote]注意：
如果你有多个机器人，指令会发往所有在组里的机器人。
如果指令要限定特定机器人，使用「!指令 机器人昵称」格式的指令消息，如「!status bot1」。[/quote]
[page]
[size=6]3.3 使用ASF的IPC功能[/size]

[size=5]3.3.1 配置IPC[/size]

使用「[url=https://justarchinet.github.io/ASF-WebConfigGenerator/#/asf]官方ASF配置文件生成器[/url]」在「远程访问」一栏开启IPC，并设定好IPCPassword，再生成ASF.json；
[attachimg]740616[/attachimg]

[b][size=4]或者[/size][/b]直接编辑ASF.json：
[code]{
  "s_SteamOwnerID": "你的主账号64位id",
  "IPC": true,
  "IPCPassword": "推荐设置一个IPC密码"
}[/code][quote]注意：
一、有些选项的「值」类型为「字符串 string」，则必须用半角双引号「像这样"value"」包含起来。
二、每个选项最后有一个半角逗号「,」。如果缺少则会造成JSON格式错误，导致ASF无法解析配置文件。只有最后一个选项末尾的逗号可以省略。[/quote]
[size=5]3.3.2 启动IPC[/size]

编辑好配置后启动ASF，看到「IPC服务已就绪！」就成功了。
[attachimg]740619[/attachimg]
然后直接访问「[url=http://127.0.0.1:1242/]http://127.0.0.1:1242/[/url]」就可以了。（仅限运行ASF的本地访问）

[size=5]3.3.3 进阶用法：IPC的高级设置[/size]

如果你想在外网访问，新建一个文本文档，输入：[code]{
    "Kestrel": {
        "Endpoints": {
            "outernet-http-ipv4": {
                "Url": "http://*:1242"
            }
        }
    }
}[/code]
保存为「IPC.config」，放到「ArchiSteamFarm(ASF主程序所在目录)/config/」目录下，启动ASF，现在就可以在外网访问你的ASF了。
[quote]警告：这样会使你的IPC接口暴露到外网，即[b]任何人在任何一台联网终端上都可以[/b]访问你的ASF。
（当然最终他要有密码才能进入控制界面）
详情参考「[url=https://github.com/JustArchiNET/ArchiSteamFarm/wiki/IPC-zh-CN#自定义配置]IPC相关中文wiki自定义配置部分[/url]」。[/quote]
更推荐的做法是不去新建「IPC.config」，直接使用默认配置，再用Apache或者Nginx反向代理「127.0.0.1:1242」。
详细步骤本文不再赘述，请动手能力强的同学自行研究。
（推荐nginx，小巧精致，而且个人觉得做反代比apache好用。）

[page]
[size=7]Part4 接入机器人（高阶应用）[/size]

本文在Part3部分的「3.3 使用ASF的IPC功能」一节中所介绍使用IPC的方式是「直接通过浏览器访问」。
这样访问到的是「[url=https://github.com/JustArchiNET/ArchiSteamFarm/wiki/IPC-zh-CN#asf-ui]ASF-ui[/url]」，属于ASF的IPC几层接口里最高层的用法。

其实ASF的IPC底层开放了RESTful接口，因此你可以利用「[url=https://github.com/JustArchiNET/ArchiSteamFarm/wiki/IPC-zh-CN#asf-api]ASF API[/url]」做很多二次开发。（比如最直接的接入机器人）
具体调试接口可以使用「[url=https://github.com/JustArchiNET/ArchiSteamFarm/wiki/IPC-zh-CN#swagger-文档]Swagger文档[/url]」以及Postman工具。
[page]
[size=6]4.1 Telegram机器人[/size]

[size=5]4.1.1 申请bot[/size]
首先找[url=https://t.me/BotFather]@BotFather[/url]new一个机器人，对话就可以啦，很简单。
[attachimg]741908[/attachimg]

[size=5]4.1.2 启动bot服务端[/size]

[list=1]
[*]下载我写的asf-tg机器人
[*]确定网络畅通（确保你能打开[url=https://t.me/RakuyoASFBot]这个页面[/url]）
[*]把之前设定好的IPC地址和IPC密码填进配置文件
（如果没有修改过IPC相关配置，而且ASF和机器人程序在同一台服务器上的话可以跳过这一步）
[*]把你在上一步(4.1.1)中申请机器人的token填进配置文件
[*]把你telegram的chat id填进配置文件（如果不知道自己的chatid可以找[url=https://t.me/RakuyoASFBot]它[/url]随便说点什么它会告诉你）
[*]Enjoy it!
[/list]

[hide]
[size=4]Rakuyo的ASF-Telegram机器人 Version 0.1.1[/size]
[quote]直接下载
[url=https://github.com/rakuyo42/asf-telegram-bot/releases/download/v0.1.1/ASF-TGbot.v0.1.1.exe]https://github.com/rakuyo42/asf- ... SF-TGbot.v0.1.1.exe[/url]
[/quote]
[quote]度盘分流（压缩包解压密码steamcn）
[url=https://pan.baidu.com/s/1AsHKTTfyx0_ID_mGuxF3Pw]https://pan.baidu.com/s/1AsHKTTfyx0_ID_mGuxF3Pw?提取码=[/url]stcn
[url=https://www.baiduwp.com/s/?surl=1AsHKTTfyx0_ID_mGuxF3Pw&pwd=stcn]https://www.baiduwp.com/s/?surl=1AsHKTTfyx0_ID_mGuxF3Pw&pwd=stcn[/url]
[/quote]
[/hide]

[page]
[size=6]4.2 QQ机器人[/size]

懒得写太底层的了……在现有的机器人里选了应该是目前最主流的qq机器人「[url=https://cqp.cc/]酷Q[/url]」。
接着选SDK，最开始考虑用「[url=https://github.com/richardchien/coolq-http-api]酷Q的HTTP API[/url]」再接入「[url=https://github.com/richardchien/nonebot]nonebot[/url]」（然后玩结巴分词玩了很久OTZ）。
后来觉得跑了酷Q还要另外跑一个机器人程序来专门处理业务逻辑有点累赘，就决定用原生（指go）写成插件形式，用起来也比较简便。

其实到今天（2019.7.26）之前几天就写完了，没更新是忙着给沙雕群友写其他插件（和玩只狼丢狼）。
[attachimg]740676[/attachimg]
突发奇想决定把本来预定分开写的两个插件（asf机器人/steam助手）整合到一起，于是回炉了。
虽然整合到同一个插件了，但两套功能可以分开使用。先[size=4][b]重构asf机器人，争取测完没啥大问题就更新[/b][/size]。
[attachimg]740681[/attachimg]
写的「[url=https://github.com/rakuyo42/cpk-by-rakuyo/tree/master/cpks]酷Q插件[/url]」，丢个地址跑路，大家有缘再见。
