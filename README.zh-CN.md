<p align="center">
  <a href="./README.md"><kbd>English</kbd></a>
  <a href="./README.zh-CN.md"><kbd>简体中文</kbd></a>
</p>

# CS2 Config

这是一套适用于 Steam 账号 `89582913` 的 CS2 配置。仓库目录已经按照 Steam 根目录组织，下载 ZIP 并解压后，可以直接把内容复制到 Steam 根目录。

## 安装

1. 下载并解压仓库 ZIP。
2. 将解压后的 `steamapps` 和 `userdata` 复制到 Steam 根目录，例如 `C:\Steam`。
3. 启动 CS2 后在控制台执行 `exec autoexec`，或者确认游戏已自动加载 `autoexec.cfg`。
4. 建议将 `userdata/89582913/730/local/cfg/cs2_video.txt` 设为只读。该文件使用最低阴影质量，同时保留比游戏设置界面更远的阴影距离。

主要目录：

- 游戏脚本：`steamapps/common/Counter-Strike Global Offensive/game/csgo/cfg`
- 用户配置：`userdata/89582913/730`

> `89582913` 是 Steam userdata ID。如果用于其他 Steam 账号，需要替换为对应账号的 userdata ID。

## Windows 备份与同步脚本

仓库根目录提供三个个人维护脚本：

| 脚本 | 功能 |
| --- | --- |
| [`备份730逐个文件和CFG后启动Steam.bat`](./备份730逐个文件和CFG后启动Steam.bat) | 从主账号 `C:\Steam\userdata\89582913\730` 中只备份 `730-Original` 列出的四个必要文件；同时备份 `autoexec.cfg` 和所有 `wifi-*` CFG。两类时间戳备份各保留最近 5 份，完成后启动 Steam。 |
| [`同步主账号730.bat`](./同步主账号730.bat) | 验证 OneDrive 中四个必要文件完整后，删除主账号的整个 `730`，再复制干净的四文件版本。只处理账号 `89582913`，不会启动 Steam。 |
| [`同步所有账号730-Onedrive.bat`](./同步所有账号730-Onedrive.bat) | 验证四个必要文件后，遍历 `C:\Steam\userdata`，只处理包含 `config\localconfig.vdf` 的真实 Steam 账号目录。每个账号原有的 `730` 都会被删除并替换成相同的四文件版本。 |

脚本使用以下固定路径和环境：

- Steam 根目录：`C:\Steam`
- OneDrive 环境变量：`%OneDrive%`
- 干净的 730：`%OneDrive%\CS2\cfg\730`
- 备份筛选模板：`%OneDrive%\CS2\730-Original`
- 游戏 CFG：`C:\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg`

推荐用法：

1. 执行同步脚本前完全退出 Steam，避免 Steam 在脚本运行期间重新写入配置。
2. 日常启动可以运行“备份 730 逐个文件和 CFG 后启动 Steam”，它会先保存上一轮游戏留下的配置，再启动 Steam。
3. 需要恢复主账号时运行“同步主账号 730”。
4. 需要让本机所有 Steam 账号使用同一套配置时，才运行“同步所有账号 730”。

> 两个同步脚本都会永久删除目标账号原有的整个 `730`，然后恢复四个必要文件。它们会在删除前检查源文件是否完整，但仍应确认 OneDrive 已同步完成。Steam/CS2 后续可能重新生成缓存文件，这是正常现象；备份脚本不会保存这些缓存。

## 自定义按键

| 按键 | 功能 |
| --- | --- |
| `/` | 切换麦克风常开/关闭。第一次按下常开，第二次按下关闭。 |
| `Mouse4` | 标准按住说话。与 `/` 分别用于不同场景。 |
| `F5` | 循环发送全体聊天：`GET LEETIFY` → `!allstar`。 |
| `F6` | 循环发送三条英文 GLHF/赞美引导消息。 |
| `F7` | 循环发送两条中文赞美引导消息。 |
| `F8` | 发送当日赞美次数已用完的中文说明。 |
| `O` | 在“跟随后坐力准星”（`wifi-crosshair6.cfg`）和“个人常规准星”（`wifi-crosshair5.cfg`）之间循环。切换结果会发送到队伍聊天。 |
| `Mouse5` | 在两套持枪视角之间循环：`x=-2, y=-2, z=2, fov=54` ↔ `x=1, y=1, z=-1, fov=60`。 |
| `V` | 标记位置，同时执行 `wifi-watch-this-spot.cfg` 发送中英文警告轮盘消息。 |
| `-` | 队伍聊天发送 `-98hp`。 |
| `.` | 切换 `voice_loopback`，用于监听自己的游戏内麦克风。 |
| `\` | 在 `0.1` 和 `1` 之间切换主音量，并在队伍聊天提示。 |
| `[` | 队伍聊天发送 `<<<`。 |
| `]` | 队伍聊天发送 `>>>`。 |
| `=` | 队伍聊天发送 `Save`。 |
| `Caps Lock` | 切换左右手持枪。 |
| `K` | 切换 `r_drawothermodels 1/2`，并在队伍聊天发送 `.drop`；模型命令需要允许作弊的环境。 |
| `Alt` | 尝试启用 `sv_cheats`、切换 `r_aoproxy_show`，然后选择 `slot12`；作弊相关命令在官方服务器不会生效。 |

F5、F6、F7 的循环状态在重新启动游戏或重新执行 `autoexec` 后，会从各自的第一条消息开始。

循环发言的完整顺序：

- **F5**
  1. `GET LEETIFY`
  2. `!allstar`
- **F6**
  1. `I wish everyone GLHF, and maintain a good attitude. After all, this is just a game. Happy is the most important thing. GLHF :)`
  2. `And does anyone want to compliment each other? I really want this.`
  3. `Open scoreboard > Click my name > Select Commend > Tick all 3 boxes > Click OK, please let me know, I can also commend you.`
- **F7**
  1. `但我更喜欢赞美，这对我很重要，能给我3个赞美吗？按住键盘TAB，点我的头像，找到并点击微笑。`
  2. `您将看到一个会话框，勾选3个选项并按提交，如果您的已提交，请告诉我，我也会提交给您！`
- **F8**
  - `对不起，给你点赞的时候提示无法完成，众所周知，一个账号一天只能提交3次，非常遗憾，但我保证我会点击下次为您服务，谢谢！`

## 常规按键

| 分类 | 按键与功能 |
| --- | --- |
| 移动 | `W/A/S/D` 前后左右，`Shift` 行走，`Ctrl` 下蹲，`Space` 或滚轮向下跳跃，方向键上抬头。 |
| 武器 | `Mouse1` 攻击，`Mouse2` 次要攻击，`R` 换弹，`Q` 上一件武器，`G` 丢弃，`E` 使用。 |
| 武器槽 | 数字 `1–9` 对应 `slot1–slot9`，`0` 对应 `slot10`，滚轮向上选择上一件物品。 |
| 购买 | `B` 购买菜单，`F3` 自动购买，`F4` 重新购买，`,` 购买主武器弹药，`Delete` 全部卖回。 |
| 交流 | `Z/X/C` 三组无线电菜单，`Mouse3` 径向无线电，`Y` 全体聊天，`U` 队伍聊天。 |
| 界面 | `Tab` 计分板，`I` 显示装备，反引号打开控制台，`Esc` 取消/返回。 |
| 其他 | `F` 检视武器，`T` 喷漆菜单，`H` 未绑定。 |

## CFG 文件

| 文件 | 用途 |
| --- | --- |
| `autoexec.cfg` | 麦克风、循环聊天、准星和持枪视角的 alias 与绑定。 |
| `wifi-crosshair1.cfg`–`wifi-crosshair6.cfg` | 保存的准星预设；当前 O 键使用第 5、6 套。 |
| `wifi-watch-this-spot.cfg` | V 键的位置警告轮盘消息。 |
| `wifi-low-hp.cfg` | 低血量轮盘消息备用脚本。 |

## 最小化的 730 备份

仓库只保留恢复设置真正需要的四个文件：

| 文件 | 保存内容 |
| --- | --- |
| `local/cfg/cs2_machine_convars.vcfg` | HUD、雷达、声音、客户端和机器相关设置。 |
| `local/cfg/cs2_user_convars_0_slot0.vcfg` | 灵敏度、准星、持枪视角等用户参数。 |
| `local/cfg/cs2_user_keys_0_slot0.vcfg` | 当前账号的按键绑定。 |
| `local/cfg/cs2_video.txt` | 分辨率、显示模式和图形质量。 |

以下内容属于自动生成或 Steam Cloud 缓存，不纳入备份恢复：

- `remote/`
- `remotecache.vdf`
- `*_lastclouded`
- 空的 `cs2_user_keys_0_slot1–3.vcfg`
- `socache.dt`
- `cnlauncher.txt`

这样恢复时只写入明确需要的设置，不会把旧云端状态、库存缓存或无效槽位带回游戏目录。
