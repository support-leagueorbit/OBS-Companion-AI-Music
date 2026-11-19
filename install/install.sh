#!/bin/sh
# AI Music installer for macOS and Linux (by LeagueOrbit).
#
#   curl -fsSL https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest/download/install.sh | sh
#
# Downloads only from this project's GitHub Releases and checks every file against the
# release's SHA256SUMS before using it. No root needed.
#
# Options (environment variables):
#   AI_MUSIC_SOUNDS       "all", "none" (default), or packs, e.g. "piano,drums,guitar-acoustic"
#   AI_MUSIC_INSTALL_DIR  where to put the ai-music program (default ~/.local/bin)
set -eu

REPO="https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases"
SOUNDS_TAG="sounds-v1"
SOUNDS_VERSION="1"

fail() {
	echo "AI Music install failed: $*" >&2
	exit 1
}

base="${AI_MUSIC_RELEASE_BASE:-$REPO}" # AI_MUSIC_RELEASE_BASE: for testing against a local copy
case "$base" in
https://*) ;;
http://127.0.0.1:* | http://localhost:*) ;;
*) fail "AI_MUSIC_RELEASE_BASE must be an https address" ;;
esac
base="${base%/}"

os="${AI_MUSIC_OS:-$(uname -s)}"
arch="${AI_MUSIC_ARCH:-$(uname -m)}"
case "$os" in
Darwin | darwin | macos) os=macos ;;
Linux | linux) os=linux ;;
*) fail "this installer is for macOS and Linux (found $os); on Windows use install.ps1" ;;
esac
case "$arch" in
x86_64 | amd64 | x64) arch=x64 ;;
arm64 | aarch64) arch=arm64 ;;
*) fail "no build for this processor ($arch)" ;;
esac
asset="ai-music-$os-$arch"

if command -v curl >/dev/null 2>&1; then
	fetch() { curl -fsSL --proto '=https,http' -o "$2" "$1" || fail "could not download $1"; }
elif command -v wget >/dev/null 2>&1; then
	fetch() { wget -q -O "$2" "$1" || fail "could not download $1"; }
else
	fail "curl or wget is needed"
fi
if command -v sha256sum >/dev/null 2>&1; then
	sha() { sha256sum "$1" | cut -d' ' -f1; }
elif command -v shasum >/dev/null 2>&1; then
	sha() { shasum -a 256 "$1" | cut -d' ' -f1; }
else
	fail "sha256sum or shasum is needed"
fi

# expected NAME SUMSFILE: the checksum listed for NAME ("hash  name" or "hash *name")
expected() {
	awk -v n="$1" '{ f = $2; sub(/^\*/, "", f); if (f == n && $1 ~ /^[0-9a-fA-F]+$/ && length($1) == 64) { print tolower($1); exit } }' "$2"
}

# check FILE NAME SUMSFILE
check() {
	want=$(expected "$2" "$3")
	[ -n "$want" ] || fail "$2 is not listed in SHA256SUMS"
	got=$(sha "$1")
	if [ "$got" != "$want" ]; then
		rm -f "$1"
		fail "checksum mismatch for $2 (got $got, expected $want). Nothing was installed from it."
	fi
}

work=$(mktemp -d 2>/dev/null || mktemp -d -t ai-music)
trap 'rm -rf "$work"' EXIT INT TERM

echo "Downloading AI Music ($os, $arch)..."
fetch "$base/latest/download/SHA256SUMS" "$work/SHA256SUMS"
fetch "$base/latest/download/$asset" "$work/$asset"
check "$work/$asset" "$asset" "$work/SHA256SUMS"
echo "Checksum OK."

dir="${AI_MUSIC_INSTALL_DIR:-$HOME/.local/bin}"
mkdir -p "$dir"
chmod 755 "$work/$asset"
mv -f "$work/$asset" "$dir/ai-music"
bin="$dir/ai-music"
echo "Installed: $bin"

want=$(printf '%s' "${AI_MUSIC_SOUNDS:-none}" | tr 'A-Z' 'a-z' | tr ',;' '  ')
if [ -n "$want" ] && [ "$want" != "none" ]; then
	fetch "$base/download/$SOUNDS_TAG/SHA256SUMS" "$work/SOUNDS-SHA256SUMS"
	available=$(awk -v v="$SOUNDS_VERSION" '{ f = $2; sub(/^\*/, "", f); p = "^ai-music-sounds-.+-" v "\\.zip$"; if (f ~ p) { sub(/^ai-music-sounds-/, "", f); sub("-" v "\\.zip$", "", f); print f } }' "$work/SOUNDS-SHA256SUMS" | sort)
	[ "$want" = "all" ] && want=$available
	for n in $want; do
		echo "$available" | grep -qx "$n" || fail "unknown sound pack '$n'. Packs: $(echo $available)"
	done
	for n in $want; do
		file="ai-music-sounds-$n-$SOUNDS_VERSION.zip"
		echo "Sound pack: $n..."
		fetch "$base/download/$SOUNDS_TAG/$file" "$work/$file"
		check "$work/$file" "$file" "$work/SOUNDS-SHA256SUMS"
		"$bin" sounds install -file "$work/$file" -sha256 "$(expected "$file" "$work/SOUNDS-SHA256SUMS")" || fail "installing $n"
		rm -f "$work/$file"
	done
	echo "Sound packs installed. If AI Music was running, stop it and start it again."
fi

echo "Done. Start AI Music with: $bin"
case ":$PATH:" in
*":$dir:"*) ;;
*) echo "(Tip: add $dir to your PATH to start it with just 'ai-music'.)" ;;
esac
