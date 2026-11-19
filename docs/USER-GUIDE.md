# AI Music user guide

AI Music makes original music on your own computer. It is not copied from anyone's recordings, so you can play it on a live stream without copyright claims. You pick a style with one click, add or remove instruments, and send the sound to OBS.

Button names below are the text you will see on screen.

- [What you need](#what-you-need)
- [Install on Windows](#install-on-windows)
- [Install on macOS or Linux](#install-on-macos-or-linux)
- [Sound packs](#sound-packs)
- [Pick a style and instruments](#pick-a-style-and-instruments)
- [Connect it to OBS](#connect-it-to-obs)
- [The tray icon](#the-tray-icon)
- [Update](#update)
- [Uninstall](#uninstall)
- [If something goes wrong](#if-something-goes-wrong)
- [Where AI Music keeps its files](#where-ai-music-keeps-its-files)

---

## What you need

- **Windows 11, or Windows 10 (64-bit).** Windows 10 needs Microsoft Edge WebView2 for the app window. Most PCs already have it; without it AI Music opens in your web browser instead.
- **Or macOS 11 or later, or 64-bit Linux.** On these, AI Music runs in your web browser and plays through the browser or OBS.
- About 15 MB for the app. Each sound pack is extra; all of them together are about 9 GB.
- About 200–350 MB of free memory while it plays.
- No administrator rights. AI Music only uses the internet when you download it or a sound pack.

## Install on Windows

### With the one-line installer

1. Open **PowerShell**: press the Windows key, type `PowerShell`, and press Enter.
2. Paste this line and press Enter:

   ```powershell
   irm https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest/download/install.ps1 | iex
   ```

3. It downloads AI Music, checks the checksum, installs it for your Windows account, and opens it.

To install sound packs at the same time, put `$env:AI_MUSIC_SOUNDS = "all";` (or a list such as `"piano,drums"`) in front of the line. See [Sound packs](#sound-packs).

To also have AI Music start when you sign in, put `$env:AI_MUSIC_RUN_AT_LOGIN = "1";` in front of the line.

### By hand

1. Download `ai-music-windows-x64.exe` from the [latest release](https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest).
2. Optional: check the file. In PowerShell, in your Downloads folder, run `Get-FileHash .\ai-music-windows-x64.exe`. The long code it prints must match the line for that file in the release's `SHA256SUMS`.
3. Double-click the file. If Windows shows **Windows protected your PC**, click **More info**, then **Run anyway** (see [why](../README.md#windows-protected-your-pc--unknown-publisher)). AI Music opens and works straight away.
4. To install it properly (Start menu entry, uninstall from Settings), open a Command Prompt in the Downloads folder and run:

   ```
   ai-music-windows-x64.exe install
   ```

   - A box asks **Install AI Music for your Windows account?** Click **OK**.
   - A box asks **Start AI Music automatically when you sign in to Windows?** Click **Yes** if this is your streaming PC.
   - A box says **AI Music is installed. It will open now.** Click **OK**.

AI Music is then in the Start menu (search for **AI Music**). The app goes into `%LOCALAPPDATA%\Programs\AI Music`.

## Install on macOS or Linux

### With the one-line installer

Open **Terminal**, paste this line and press Enter:

```sh
curl -fsSL https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest/download/install.sh | sh
```

It installs `ai-music` into `~/.local/bin` and checks its checksum. To pick another folder, put `AI_MUSIC_INSTALL_DIR=/path/to/folder` before `sh`. To add sound packs, put `AI_MUSIC_SOUNDS=all` (or `AI_MUSIC_SOUNDS=piano,drums`) before `sh`.

Then start it:

```sh
~/.local/bin/ai-music
```

It opens AI Music in your web browser. Leave the Terminal window open while you use it, or run `ai-music serve -headless &` to keep it in the background. If `~/.local/bin` is on your `PATH`, plain `ai-music` works.

### By hand

1. Download the file for your computer from the [latest release](https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest): `ai-music-macos-arm64` (Apple silicon), `ai-music-macos-x64` (Intel Mac), `ai-music-linux-x64` or `ai-music-linux-arm64`.
2. Optional: check it with `shasum -a 256 ai-music-macos-arm64` (macOS) or `sha256sum ai-music-linux-x64` (Linux), and compare with `SHA256SUMS`.
3. Make it runnable and start it: `chmod +x ai-music-macos-arm64 && ./ai-music-macos-arm64`.
4. On macOS, if it says the developer cannot be verified: right-click the file in Finder, choose **Open**, then **Open** again. Or run `xattr -d com.apple.quarantine ai-music-macos-arm64` once.

On macOS and Linux the music plays through the browser tab (tick **Listen in this window**) or through OBS. There is no native speaker output on these systems yet.

## Sound packs

The sound packs are recordings of real instruments. AI Music works without them, using its own synthesised instruments. Each pack you add makes those instruments sound like the real thing. Packs can be added in any order, and each one only adds its own instruments.

All packs are in the [sound packs release](https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/tag/sounds-v1).

| Pack | What is in it | Size |
|---|---|---|
| `piano` | Grand piano (every key, four dynamics), more pianos and zithers | about 1.5 GB |
| `keys` | Upright piano, organs, electric pianos | about 0.5 GB |
| `harp` | Concert and folk harp | about 0.15 GB |
| `mallets-percussion` | Vibraphone, marimba, glockenspiel, kalimba, bells, congas, bongos, tambourine, timpani, orchestral percussion | about 0.55 GB |
| `drums` | Jazz-club kit, rock/pop kit, hip-hop breaks kit, claps | about 0.95 GB |
| `guitar-acoustic` | Steel-string and nylon-string acoustic guitars | about 1.35 GB |
| `guitar-electric` | Clean electric and jazz (archtop) guitars | about 0.8 GB |
| `guitar-rock` | Overdriven and palm-muted rock guitars | about 0.7 GB |
| `bass` | Bass guitars (finger, picked, funk) | about 0.5 GB |
| `orchestra` | String sections, double bass, trumpet, trombone, horn, flute, clarinet | about 1 GB |
| `winds` | Alto and tenor saxophone, recorder, harmonica, pipe organ | about 0.55 GB |
| `synths` | Recorded analog-style synths: brass, string machine, pads, choir, leads, bass, chord stabs | about 0.15 GB |

### Add packs with the installer

Run the one-line installer again with `AI_MUSIC_SOUNDS` set:

```powershell
$env:AI_MUSIC_SOUNDS = "piano,drums,bass"; irm https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest/download/install.ps1 | iex
```

```sh
curl -fsSL https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest/download/install.sh | AI_MUSIC_SOUNDS=piano,drums,bass sh
```

`all` installs every pack. Each pack is checked against `SHA256SUMS` before it is installed. Restart AI Music afterwards (tray icon, **Quit**, then open it again) so it loads the new sounds.

### Add packs by hand

1. Download the pack zip, for example `ai-music-sounds-piano-1.zip`, and the `SHA256SUMS` file from the [sound packs release](https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/tag/sounds-v1).
2. Open AI Music and click **Sound library**.
3. Open `SHA256SUMS` in a text editor. Copy the 64 letters and digits at the start of the line for your zip.
4. Paste them into the checksum box.
5. Into **Or a file on this computer**, type the full path of the zip, for example `C:\Users\YourName\Downloads\ai-music-sounds-piano-1.zip`.
6. Click **Install from file**. The line under the buttons shows progress, and ends with **Installed … files. New instruments are ready.**

You can also do this from a terminal: `ai-music sounds install -file ai-music-sounds-piano-1.zip -sha256 <checksum>`.

If a checksum does not match, nothing is installed and the message says **checksum mismatch**. Download the file again.

## Pick a style and instruments

**Pick a style.** Under **Styles**, click a button, for example **Lo-fi**, **Rock**, **Jazz** or **Hip Hop**. Music starts within a few seconds, and a new tune follows when each one ends.

**Change the instruments.** Under **Instruments in this music**:

- **On** / **Off** mutes or unmutes an instrument.
- **Level** makes it quieter or louder.
- **×** removes it.
- **+ Add instrument** opens the instrument list. Click one to add it. Greyed-out instruments need a sound pack.
- **Try** plays any instrument on its own, so you can hear it first.

Changes blend in after a few seconds. The other instruments keep playing.

**Change the feel.** Click **Tune settings**. Choose a **Mood**, a **Tempo** (leave **Auto** ticked to let AI Music choose) and an **Energy**, then click **Apply (starts a new tune)**.

**Make your own style.** Click **Make your own style**, type a **Name**, pick what to **Start from**, set mood, tempo and energy, tick the instruments, and click **Save style** (or **Save & play**). Your style becomes a new button under **Styles**; click its **×** to delete it.

**Sound check.** Open **Sound check (no style needed)** to hear instruments and drum kits on their own or up to six together, without picking a style. The stream music is turned down while you listen.

**Other buttons.** **New tune** plays a different tune in the same style. **Stop** and **Play** pause and resume. **Volume** sets the level. **Save this tune as WAV** saves the current tune; stems and MIDI can be exported too. **Listen in this window** plays the music in the AI Music window; turn it off when OBS is playing it, so you don't hear it twice.

## Connect it to OBS

AI Music only listens on your own computer, at `http://127.0.0.1:8770`. If that port is busy it uses the next free one; the number is in the `port` file in the AI Music data folder (see [below](#where-ai-music-keeps-its-files)).

### Browser Source (simplest)

1. In OBS, under **Sources**, click **+** and choose **Browser**. Name it `AI Music`.
2. Set **URL** to `http://127.0.0.1:8770/player`, **Width** `300`, **Height** `100`.
3. Tick **Control audio via OBS**.
4. Untick **Shutdown source when not visible**, so the music keeps playing when you switch scenes.
5. Click **OK**. AI Music now has its own slider in the OBS **Audio Mixer**.

### Media Source

1. Under **Sources**, click **+** and choose **Media Source**. Name it `AI Music`.
2. Untick **Local File** and set **Input** to `http://127.0.0.1:8770/stream.wav`.
3. Click **OK**.

### OBS Companion

[OBS Companion](https://github.com/support-leagueorbit/OBS-Companion) has AI Music built in:

1. In Companion, open **Settings**, then **Music**, and turn on **Use the AI Music app**. The card says **Connected** when it finds AI Music.
2. Turn on **Start the music engine with Companion** to have Companion start and stop AI Music for you.
3. In Companion's **Music** tab you get the same controls as above. Per scene, you can choose a style and mood; the music changes at the next bar when that scene goes live.

## The tray icon

On Windows (and on Linux desktops with a system tray), closing the AI Music window keeps the music playing. Click the music-note icon near the clock to get the menu:

- **Show AI Music** opens the window again.
- **Pause** / **Play**.
- **Start when I sign in** (Windows, when installed).
- **Quit (stops the music)**.

## Update

Run the one-line installer again, or download the new file and run `ai-music-windows-x64.exe install` again. Your styles, settings and sound packs stay. Quit AI Music from the tray icon first, so the new version starts cleanly.

## Uninstall

**Windows:** open **Settings**, **Apps**, **Installed apps**, find **AI Music**, click the three dots, then **Uninstall**. A box asks whether to also delete your saved styles, settings and sound packs. **No** keeps them for a later reinstall; **Yes** deletes them. If it is not listed, run `"%LOCALAPPDATA%\Programs\AI Music\ai-music.exe" uninstall`.

**macOS / Linux:** delete the `ai-music` file (from `~/.local/bin` if you used the installer). To remove styles, settings and sound packs too, delete the data folder (see [below](#where-ai-music-keeps-its-files)).

## If something goes wrong

| What you see | What to do |
|---|---|
| No sound in OBS. | Check the source is in the scene and not muted in the **Audio Mixer**, and that AI Music says **Playing**. For a Browser Source, check **Control audio via OBS** is ticked. |
| No sound in the AI Music window. | Tick **Listen in this window** and check **Volume**. |
| A page says "Open AI Music from the app". | The sign-in expired. Close that tab and open AI Music from the Start menu or the tray icon (**Show AI Music**). |
| The OBS source shows an error. | AI Music may be using another port: check the `port` file in the data folder and use that number instead of `8770`. Make sure AI Music is running. |
| The window is blank, or it opens in your browser. | Windows 10 may lack Microsoft Edge WebView2. The browser works the same way. |
| Instruments are greyed out. | They need a sound pack. See [Sound packs](#sound-packs). |
| "checksum mismatch". | The download is damaged or the checksum is from another line. Download again and copy the checksum from the line for that exact file. |
| "Windows protected your PC". | Click **More info**, then **Run anyway**. See [why](../README.md#windows-protected-your-pc--unknown-publisher). |
| Music stops, or the window will not open. | Quit from the tray icon and start AI Music again. |
| You want to see error messages. | Quit AI Music and run `ai-music serve` in a terminal (on Windows: `"%LOCALAPPDATA%\Programs\AI Music\ai-music.exe" serve`). Messages appear there. |

Still stuck? Open an [issue](https://github.com/support-leagueorbit/OBS-Companion-AI-Music/issues) with what you did, what you saw, and any message from the terminal. Don't include the `api-token` file or its contents.

## Where AI Music keeps its files

| | Data folder |
|---|---|
| Windows | `%APPDATA%\ai-music` |
| macOS | `~/Library/Application Support/ai-music` |
| Linux | `~/.config/ai-music` |

It holds `styles.json` (your styles), `settings.json`, `port`, `api-token` (a private key used only on your computer; never share it) and the `sounds` folder with the installed packs. To start fresh, quit AI Music and delete `styles.json` and `settings.json`. The built-in styles always stay.
