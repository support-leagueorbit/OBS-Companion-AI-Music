# AI Music FAQ

### Can I really play this music on a monetized stream or video?

Yes. AI Music composes every tune itself on your computer, from rules about harmony, rhythm and song form. It does not copy, sample or learn from anyone's recordings, and LeagueOrbit claims no rights in the music it makes (see [LICENSE](../LICENSE), section 3). The optional instrument sounds are public-domain (CC0) recordings of single notes, which is like playing a real instrument.

### Will Content ID or a copyright bot flag it?

It shouldn't, because there is no existing recording for it to match. No automated system is perfect, though. If a claim does appear, the music came from AI Music, and you can dispute it on that basis.

### Is AI Music free? Will it stay free?

Yes. There is no account, subscription, advert or tracking. You may not sell it or change it; see [LICENSE](../LICENSE).

### Does it need the internet?

Only to download the app and, if you want them, the sound packs. After that it runs entirely on your computer and sends nothing anywhere. It only listens on `127.0.0.1` (your own computer), so other devices on your network can't reach it.

### Why does Windows say "unknown publisher" or "Windows protected your PC"?

The builds are not code-signed, because signing certificates cost money every year and AI Music is free. Check your download against the release's `SHA256SUMS` (the [install steps](../README.md#install) show the exact commands), then click **More info** and **Run anyway**. See the [README](../README.md#windows-protected-your-pc--unknown-publisher) for details.

### Do I need the sound packs?

No. Without them AI Music uses its own synthesised instruments, which work for every style. The packs make piano, guitars, drums, bass, orchestra and saxophone sound like real recordings. Install only the packs for the styles you use: for example `guitar-acoustic` and `drums` for soft rock and folk, or `piano`, `bass` and `drums` for jazz.

### How much space do the sound packs need?

About 9 GB for all of them, from 0.15 GB (`harp`, `synths`) to 1.5 GB (`piano`). See the [list](USER-GUIDE.md#sound-packs).

### Does it work with OBS Companion?

Yes. [OBS Companion](https://github.com/support-leagueorbit/OBS-Companion) uses AI Music as its music engine and can start it for you, and you can set a style per scene. See the [user guide](USER-GUIDE.md#obs-companion).

### Does it work with Streamlabs, XSplit or other software?

Any program that can play a web address or a browser source can use `http://127.0.0.1:8770/stream.wav` or `http://127.0.0.1:8770/player`.

### How much of my computer does it use?

Usually 160–240 MB of memory while playing, briefly up to about 350 MB while it prepares the next tune. It uses some CPU for a few seconds at the start of each tune, and very little in between, so it is fine on a streaming PC.

### Every tune in a style sounds a bit different. Is that right?

Yes. Each tune is newly composed, with its own melody, chords and key. Within a style the tempo and energy shift a little from tune to tune, and the drums and arrangement vary as a tune goes on, while the style keeps its character. If you want a tune again, save it as WAV.

### Does it run on macOS and Linux?

Yes. On macOS and Linux it runs in your web browser and plays through the browser tab or OBS. The Windows version also plays straight to your speakers and has a tray icon.

### Can I use the WAV or MIDI exports in my own productions?

Yes. Exported tunes, stems and MIDI files are yours to use, like the live music.

### Where are my styles and settings?

In the AI Music data folder: `%APPDATA%\ai-music` on Windows, `~/Library/Application Support/ai-music` on macOS, `~/.config/ai-music` on Linux. See the [user guide](USER-GUIDE.md#where-ai-music-keeps-its-files).

### I found a bug or have an idea.

Please open an [issue](https://github.com/support-leagueorbit/OBS-Companion-AI-Music/issues).
