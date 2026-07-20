<p align="center">
  <a href="./README.md">
    <img src="https://img.shields.io/badge/Language-%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87-2ea44f?style=for-the-badge" alt="简体中文">
  </a>
  <a href="./README.en.md">
    <img src="https://img.shields.io/badge/Language-English-0969da?style=for-the-badge" alt="English">
  </a>
</p>

# CS2 Config

This is a customized CS2 configuration for Steam userdata account ID `89582913`. The repository mirrors the Steam root directory layout, so you can download the ZIP, extract it, and copy its contents directly into your Steam root folder.

## Installation

1. Download and extract the repository ZIP.
2. Copy the extracted `steamapps` and `userdata` folders into your Steam root directory, such as `C:\Steam`.
3. Start CS2 and run `exec autoexec` in the console, or confirm that the game automatically loaded `autoexec.cfg`.
4. It is recommended to set `userdata/89582913/730/local/cfg/cs2_video.txt` to read-only. This configuration keeps shadows at the lowest quality while retaining a longer shadow distance than the in-game settings menu exposes.

Main directories:

- Game scripts: `steamapps/common/Counter-Strike Global Offensive/game/csgo/cfg`
- User configuration: `userdata/89582913/730`

> `89582913` is a Steam userdata ID. Replace it with the appropriate userdata ID when using this configuration with another Steam account.

## Windows Backup and Synchronization Scripts

The repository root contains three personal maintenance scripts:

| Script | Purpose |
| --- | --- |
| [`备份730逐个文件和CFG后启动Steam.bat`](./备份730逐个文件和CFG后启动Steam.bat) | Uses `730-Original` as the sole file manifest and backs up each corresponding file from the primary account at `C:\Steam\userdata\89582913\730`. Future additions or removals in the manifest require no script changes. Missing files do not stop the backup; they are listed together after the 730 backup finishes. The script also backs up `autoexec.cfg` and every `wifi-*` CFG, retains the five newest timestamped backups for each group, and launches Steam when finished. |
| [`同步主账号730.bat`](./同步主账号730.bat) | Deletes the primary account's entire `730` folder, recreates it, and directly copies every file from `%OneDrive%\CS2\cfg\730`. It then copies all CFG files from `%OneDrive%\CS2\cs2\cs2` into the game's CFG directory without clearing that directory. It only processes account `89582913` and does not start Steam. |
| [`同步所有账号730-Onedrive.bat`](./同步所有账号730-Onedrive.bat) | Scans `C:\Steam\userdata` and only processes real Steam account directories containing `config\localconfig.vdf`. Each account's existing `730` folder is completely deleted, then the same restore source is copied in full. After all accounts are processed, the shared CFG files are restored once without clearing the game's CFG directory. |

The scripts use these fixed paths and environment settings:

- Steam root: `C:\Steam`
- OneDrive environment variable: `%OneDrive%`
- Complete 730 restore source: `%OneDrive%\CS2\cfg\730`
- CFG restore source: `%OneDrive%\CS2\cs2\cs2`
- Game CFG directory: `C:\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg`
- Backup selection template: `%OneDrive%\CS2\730-Original`
- Game CFG directory: `C:\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg`

Recommended workflow:

1. Fully exit Steam before running either synchronization script so Steam cannot rewrite configuration files during the operation.
2. For routine launches, run `备份730逐个文件和CFG后启动Steam.bat`. It saves the configuration left by the previous session before starting Steam.
3. Run `同步主账号730.bat` when you need to restore the primary account.
4. Only run `同步所有账号730-Onedrive.bat` when every Steam account on the computer should use the same configuration.

> Both synchronization scripts permanently delete the target account's entire `730` folder without comparing individual files, then copy the entire restore source. Before running either script, confirm that `%OneDrive%\CS2\cfg\730` is the complete version you intend to restore and that OneDrive has finished syncing.

## Custom Key Bindings

| Key | Function |
| --- | --- |
| `/` | Toggles the microphone between always-on and off. The first press opens the microphone; the second press closes it. |
| `Mouse4` | Standard push-to-talk, used separately from `/` for different situations. |
| `F5` | Cycles through all-chat messages: `GET LEETIFY` → `!allstar`. |
| `F6` | Cycles through three English GLHF and commendation messages. |
| `F7` | Cycles through two Chinese commendation messages. |
| `F8` | Sends the Chinese message explaining that the daily commendation limit has been reached. |
| `O` | Cycles between the recoil-following crosshair (`wifi-crosshair6.cfg`) and the personal regular crosshair (`wifi-crosshair5.cfg`). The selected result is announced in team chat. |
| `Mouse5` | Cycles between two viewmodel presets: `x=-2, y=-2, z=2, fov=54` ↔ `x=1, y=1, z=-1, fov=60`. |
| `V` | Places a player ping and runs `wifi-watch-this-spot.cfg` to send a bilingual warning through the chat wheel. |
| `-` | Sends `-98hp` in team chat. |
| `.` | Toggles `voice_loopback` so you can monitor your own in-game microphone. |
| `\` | Toggles the main volume between `0.1` and `1`, with a team-chat notification. |
| `[` | Sends `<<<` in team chat. |
| `]` | Sends `>>>` in team chat. |
| `=` | Sends `Save` in team chat. |
| `Caps Lock` | Switches the weapon between the left and right hand. |
| `K` | Toggles `r_drawothermodels 1/2` and sends `.drop` in team chat. The model command requires an environment where cheats are allowed. |
| `Alt` | Attempts to enable `sv_cheats`, toggles `r_aoproxy_show`, and selects `slot12`. Cheat-protected commands do not work on official servers. |

The F5, F6, and F7 cycles restart from their first message whenever the game restarts or `autoexec` is executed again.

Complete chat-message order:

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

## Standard Key Bindings

| Category | Keys and functions |
| --- | --- |
| Movement | `W/A/S/D` moves forward, left, backward, and right; `Shift` walks; `Ctrl` crouches; `Space` or mouse wheel down jumps; Up Arrow looks upward. |
| Weapons | `Mouse1` attacks; `Mouse2` uses secondary attack; `R` reloads; `Q` selects the previous weapon; `G` drops; `E` uses. |
| Weapon slots | Number keys `1–9` select `slot1–slot9`; `0` selects `slot10`; mouse wheel up selects the previous inventory item. |
| Buying | `B` opens the buy menu; `F3` autobuys; `F4` rebuys; `,` buys primary ammunition; `Delete` sells everything back. |
| Communication | `Z/X/C` open the three radio menus; `Mouse3` opens radial radio; `Y` opens all chat; `U` opens team chat. |
| Interface | `Tab` shows the scoreboard; `I` toggles the loadout display; backtick opens the console; `Esc` cancels or returns. |
| Other | `F` inspects the weapon; `T` opens the spray menu; `H` is unbound. |

## CFG Files

| File | Purpose |
| --- | --- |
| `autoexec.cfg` | Aliases and bindings for microphone control, chat-message cycles, crosshairs, and viewmodels. |
| `wifi-crosshair1.cfg`–`wifi-crosshair6.cfg` | Saved crosshair presets. The O key currently uses presets 5 and 6. |
| `wifi-watch-this-spot.cfg` | Chat-wheel location warning used by the V key. |
| `wifi-low-hp.cfg` | Spare low-health chat-wheel message script. |

## Complete Backup Driven by 730-Original

Real-world testing showed that keeping only four configuration files causes some game settings to be lost. The repository's `userdata/89582913/730` now contains the tested set that restores all settings, including files under `local` and `remote`, `*_lastclouded`, slots 1–3, `socache.dt`, and `remotecache.vdf`.

The backup script no longer embeds a fixed list of filenames. `%OneDrive%\CS2\730-Original` is the sole manifest:

- Adding a file to the manifest automatically includes it in the next backup.
- Removing a file from the manifest automatically excludes it from the next backup.
- If a manifest file is missing from the game's 730 folder, the script continues and prints all missing items together after the 730 backup finishes.
- A backup snapshot contains the manifest files that were present in the game's 730 folder at that time.

Restoration remains intentionally simple: the synchronization scripts delete the target account's entire `730` folder and directly copy everything from `%OneDrive%\CS2\cfg\730`. They do not compare the restore source against `730-Original`, so the restore source itself must be verified as correct and complete beforehand.
