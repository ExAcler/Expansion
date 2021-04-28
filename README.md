# 简介

Expansion 是适用于德州仪器公司 TI-Nspire 系列计算器的五人三国杀游戏。游戏基于 TI-Lua 平台打造，保证了最大的兼容性。希望您能够杀的愉快！

# 基本操作

TI-Nspire 计算器的按键在 Expansion 中的意义如下：
- enter 键：确认操作或选择
- esc (退出) 键：取消操作、从出牌阶段进入弃牌阶段
- tab 键：选择要使用的手牌
- 左、右方向键：移动选取卡牌
- 上、下方向键：上下浏览选项菜单或本方武将技能
- 数字 0 键：选择或取消选择本方可响应的他人主公技
- 数字 1 ~ 4 键：选择或取消选择本方可使用的出牌阶段武将技能
- 字母 a ~ d 键：于部分技能中选择要弃置的武器/防具/+1马/-1马；a 键选择发动丈八蛇矛的武器技能
- ctrl 键 + menu (菜单) 键：调出游戏菜单

# 如何下载

您可以在 [这里](https://github.com/ExAcler/Expansion/releases) 下载预编译好的 tns 文件，也可以自行进行编译最新版本，步骤如下：
1. 创建 Debug 文件夹；
2. 运行 Compile.exe 文件；
3. 查看 Debug 文件夹下的 dest.lua 文件。

有两种方法来生成最后的 tns 文件：
1. 运行 Build.bat 文件，在 Debug 文件夹下会生成 Expansion.tns 文件 (此方法会导致部分中文字显示乱码)；
2. 自行复制 dest.lua 的所有内容至 TI-Nspire 学生或教师软件的 Script Editor 中。

# 如何贡献本项目

您可以通过 Pull Request 的形式对本项目进行贡献，唯需获得我们的批准。
如您有兴趣加入我们的开发团队，请发知乎私信给知乎专栏**你的计算器**的专栏作者：[小林露露](https://www.zhihu.com/people/kobayashi-lulu)或[朽木家的优姬](https://www.zhihu.com/people/xiu-mu-jia-de-you-ji)。

# 许可证

本项目是完全的自由软件，允许您在遵循 GNU GPL v3 许可证的前提下自由修改、演绎和分发。详情请搜索 **GNU GPL v3协议** 或参阅 LICENCE 文件 (英语)。
我们保留追究任何违反协议者法律责任的权利。
