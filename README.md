# AI Music

**Original music for live streams, made on your own computer, free to use.**

AI Music composes new music while you stream. Pick a style with one click (lo-fi, synthwave, rock, jazz, hip hop, French house, cinematic and more), add or remove instruments, and send it to OBS. Every tune is composed by the program itself. It does not copy or learn from anyone's recordings, so the music it makes can be played on stream, in videos and in monetized content without copyright claims.

- 21 genres, from lo-fi and ambient to rock, funk, jazz, electronic and hip hop, with a real song form (intro, verses, choruses, bridge, outro).
- Add, remove, mute and mix instruments while the music plays. Changes blend in after a few seconds.
- Save your own styles as one-click buttons.
- Optional recorded instrument sounds: grand piano, guitars, bass, drum kits, orchestra, saxophone, synths and more. All are free public-domain (CC0) recordings, in separate downloads so you only fetch what you want.
- Export the current tune as WAV, stems or MIDI.
- Runs entirely on your PC. No account, no subscription and no internet needed after install.
- Made by LeagueOrbit.

## Works with OBS Companion

AI Music is the music engine of [**OBS Companion**](https://github.com/support-leagueorbit/OBS-Companion), LeagueOrbit's helper app for OBS Studio. In Companion's **Music** tab you can play and change AI Music from the same window as your scenes, and give each scene its own style and mood: the music changes at the next bar when that scene goes live.

To use them together, install both:

1. In OBS Companion, open **Settings**, then **Music**, and turn on **Use the AI Music app**. The card says **Connected** when it finds AI Music.
2. Turn on **Start the music engine with Companion** if you want Companion to start and stop AI Music for you.
3. Play and change the music from Companion's **Music** tab, and choose a style and mood for each scene.

AI Music also works on its own with any OBS setup (Browser Source or Media Source); see the [user guide](docs/USER-GUIDE.md#connect-it-to-obs).

## Install

### Option 1: download

Download from the [latest release](https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest):

| Your computer | File |
|---|---|
| Windows 10 / 11 (64-bit) | `ai-music-windows-x64.exe` |
| macOS, Apple silicon (M1 and later) | `ai-music-macos-arm64` |
| macOS, Intel | `ai-music-macos-x64` |
| Linux, 64-bit PC | `ai-music-linux-x64` |
| Linux, ARM 64-bit | `ai-music-linux-arm64` |

On Windows, double-click the file to try it, or install it by running `ai-music-windows-x64.exe install` (see the [user guide](docs/USER-GUIDE.md)). Each release has a `SHA256SUMS` file to check your download against.

The recorded instrument sounds are optional, and come from the [sound packs release](https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/tag/sounds-v1). Without them, AI Music uses its built-in synthesised instruments.

### Option 2: one line in a terminal

These scripts download only from this project's GitHub Releases, and check every file against the release's SHA-256 checksums before using it.

**Windows** (PowerShell):

```powershell
irm https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest/download/install.ps1 | iex
```

**macOS / Linux** (Terminal):

```sh
curl -fsSL https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest/download/install.sh | sh
```

To add recorded sounds at the same time, set `AI_MUSIC_SOUNDS` to `all`, or to a list of packs such as `piano,drums,guitar-acoustic`:

```powershell
$env:AI_MUSIC_SOUNDS = "all"; irm https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest/download/install.ps1 | iex
```

```sh
curl -fsSL https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest/download/install.sh | AI_MUSIC_SOUNDS=all sh
```

You can run the same line again later to update, or to add more packs. The [user guide](docs/USER-GUIDE.md#sound-packs) lists every pack and its size.

## Sound packs

AI Music plays every style with its built-in synthesised instruments. The optional sound packs add recorded instruments, such as a grand piano, real guitars, drum kits and an orchestra. Each pack is a separate zip in the [sound packs release](https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/tag/sounds-v1), so you only download what you want:

| Pack | What is in it | Size |
|---|---|---|
| `piano` | Grand piano (every key, four dynamics), more pianos and zithers | about 1.5 GB |
| `keys` | Upright piano, organs, electric pianos | about 0.5 GB |
| `harp` | Concert and folk harp | about 0.15 GB |
| `mallets-percussion` | Vibraphone, marimba, glockenspiel, kalimba, bells, hand drums, timpani | about 0.55 GB |
| `drums` | Jazz-club kit, rock/pop kit, hip-hop breaks kit, claps | about 0.95 GB |
| `guitar-acoustic` | Steel-string and nylon-string acoustic guitars | about 1.35 GB |
| `guitar-electric` | Clean electric and jazz guitars | about 0.8 GB |
| `guitar-rock` | Overdriven and palm-muted rock guitars | about 0.7 GB |
| `bass` | Bass guitars (finger, picked, funk) | about 0.5 GB |
| `orchestra` | String sections, double bass, brass, flute, clarinet | about 1 GB |
| `winds` | Alto and tenor saxophone, recorder, harmonica, pipe organ | about 0.55 GB |
| `synths` | Recorded analog-style synths: brass, strings, pads, choir, leads, bass, stabs | about 0.15 GB |

There are three ways to install them:

- **With the one-line installer.** Set `AI_MUSIC_SOUNDS` as shown above. The installer checks each zip against the release's `SHA256SUMS` before it installs it.
- **From the app.** Open **Sound library**, paste the zip's checksum from `SHA256SUMS`, type the zip's path, and click **Install from file**. Restart AI Music afterwards so it loads the new sounds.
- **From a terminal.** Run `ai-music sounds install -file ai-music-sounds-piano-1.zip -sha256 <checksum>`.

Packs install side by side, and you can add more at any time. Instruments that need a pack you don't have are greyed out in the app. The [user guide](docs/USER-GUIDE.md#sound-packs) has the details.

### "Windows protected your PC" / "unknown publisher"

AI Music is free, and its builds are not code-signed, because a signing certificate is a paid yearly service. So when you open a downloaded copy, Windows SmartScreen may show **Windows protected your PC** or **Unknown publisher**. This is Windows saying it does not recognise the publisher. It is not saying the file is harmful.

To check that your copy is the real one, compare its SHA-256 checksum with the `SHA256SUMS` file of the release. In PowerShell, run `Get-FileHash .\ai-music-windows-x64.exe`. The one-line installer does this check for you. If the checksums match, click **More info**, then **Run anyway**.

On macOS, a downloaded file may be blocked with "cannot be opened because the developer cannot be verified". Right-click the file and choose **Open**, or use the one-line installer, which does not trigger this.

## Help

- [User guide](docs/USER-GUIDE.md): install, sound packs, styles and instruments, OBS, uninstall
- [FAQ](docs/FAQ.md)
- [Changelog](CHANGELOG.md)

## Support

Found a problem? Open an [issue](https://github.com/support-leagueorbit/OBS-Companion-AI-Music/issues), or email **support@leagueorbit.com**.

## Licence and credits

AI Music is free to use, including for monetized streams and videos. You may not sell it or modify it. The music it makes is yours to use as you like. See [LICENSE](LICENSE).

The recorded instruments in the sound packs are public-domain (CC0 1.0) libraries. CC0 needs no credit, but we credit their makers anyway, with thanks:

- **Versilian Studios**: VCSL and VSCO 2 Community Edition
- **Meta's Creative Audio team**: Meta Piano, Meta Steel Guitar, Meta Nylon Guitar (Meta Open Sound)
- **Karoryfer Samples**: Virtuosity Drums (with Versilian Studios), Swirly Drums, Unruly Drums, Frankensnare, Growlybass, Fashionbass, Emilyguitar, Shinyguitar, Black and Green Guitars, Weresax
- **FreePats project**: Spanish classical guitar, electric bass, electric guitars

The synth sounds are single notes recorded from the factory patches of [Surge XT](https://surge-synthesizer.github.io/), the free open-source synthesizer by the Surge Synth Team. No Surge XT code or patch files are included.

Full credits, each library's licence text, and a SHA-256 checksum of every sound file are in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) and [licenses/](licenses/).
