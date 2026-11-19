# Third-party notices

AI Music is made by LeagueOrbit. It includes, or can download, the third-party components below. Their licences apply to those components.

## Music

Every tune is composed by AI Music itself. It does not use, copy or learn from any recording, so it carries no third-party rights.

## Compiled into the app

| Component | Licence | Used for |
|---|---|---|
| The Go standard library and runtime (The Go Authors) | BSD-3-Clause | the whole program |
| golang.org/x/sys (The Go Authors) | BSD-3-Clause | Windows system calls |
| github.com/jchv/go-webview2 | MIT | the app window on Windows |
| github.com/jchv/go-winloader | MIT | loading the WebView2 runtime |
| fyne.io/systray | BSD-3-Clause | the tray icon |
| github.com/godbus/dbus/v5 | BSD-2-Clause | the tray icon on Linux |

The full licence texts are in [licenses/go-modules.txt](licenses/go-modules.txt).

## Recorded instrument sounds (optional sound packs)

All the recordings are CC0 1.0 Universal (a public-domain dedication): free to use, change and share, including commercially, with no attribution required. We credit their makers anyway, with thanks. Each library's licence text, and a SHA-256 checksum of every file we use, are in [licenses/](licenses/).

| Library | Made by | Source | In pack | Checksums / licence |
|---|---|---|---|---|
| Versilian Community Sample Library (VCSL): pianos, harps, mallets, percussion, tenor sax, pipe organ, recorder, harmonica, kalimba | Versilian Studios LLC | [github.com/sgossner/VCSL](https://github.com/sgossner/VCSL) | piano, harp, mallets-percussion, winds | vcsl-wav.sha256, vcsl-CC0-1.0.txt |
| VSCO 2 Community Edition: strings, brass, woodwinds, organ, upright piano, orchestral percussion | Versilian Studios LLC | [github.com/sgossner/VSCO-2-CE](https://github.com/sgossner/VSCO-2-CE) | keys, orchestra, mallets-percussion | vsco-wav.sha256, vsco-percussion-wav.sha256, vsco-CC0-1.0.txt |
| Meta Piano, Meta Steel Guitar, Meta Nylon Guitar (Meta Open Sound) | Meta's Creative Audio team | [github.com/facebookincubator/Meta-open-sound](https://github.com/facebookincubator/Meta-open-sound) | piano, guitar-acoustic | meta-*-wav.sha256, meta-*-CC0-1.0.txt |
| Virtuosity Drums (converted from FLAC to WAV) | Versilian Studios and Karoryfer Samples | [github.com/sfzinstruments/virtuosity_drums](https://github.com/sfzinstruments/virtuosity_drums) | drums | virtuosity-wav.sha256, virtuosity-CC0-1.0.txt |
| Swirly Drums, Unruly Drums, Frankensnare (claps) | Karoryfer Samples | [github.com/sfzinstruments](https://github.com/sfzinstruments) | drums | swirly-wav.sha256, unruly-drums-wav.sha256, frankensnare-claps-wav.sha256 and the matching CC0 texts |
| Growlybass, Fashionbass | Karoryfer Samples | [github.com/sfzinstruments](https://github.com/sfzinstruments) | bass | growlybass-wav.sha256, fashionbass-wav.sha256 and CC0 texts |
| Emilyguitar, Shinyguitar, Black and Green Guitars | Karoryfer Samples | [github.com/sfzinstruments](https://github.com/sfzinstruments) | guitar-electric, guitar-rock | emilyguitar-wav.sha256, shinyguitar-wav-sfz.sha256, black-and-green-guitars-wav-sfz.sha256 and CC0 texts |
| Weresax (alto saxophone) | Karoryfer Samples | [github.com/sfzinstruments](https://github.com/sfzinstruments) | winds | weresax-wav-sfz.sha256, weresax-CC0-1.0.txt |
| FreePats: Spanish classical guitar, electric bass YR, electric guitar FSBS clean and dist1 (converted from FLAC to WAV) | FreePats project | [freepats.zenvoid.org](https://freepats.zenvoid.org/) | guitar-acoustic, guitar-electric, guitar-rock, bass | freepats-sfz.sha256, freepats-wav.sha256, freepats-*-CC0-1.0.txt |

### Synthesizer recordings (synths and keys packs)

The electric pianos, synth brass, string machine, pads, choir, leads, analog bass, house organ and chord stabs are recordings of single notes played on **Surge XT**, the free and open-source synthesizer by the Surge Synth Team and contributors ([surge-synthesizer.github.io](https://surge-synthesizer.github.io/), GPL-3.0-or-later), using its factory patches. No Surge XT code or patch file is included; only the recorded audio, which is not covered by the GPL. Details: [licenses/surge-xt-renders.txt](licenses/surge-xt-renders.txt).
