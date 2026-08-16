# TOBIA — The Forge

A standalone native Flutter dashboard & identity app, forged on a phone.

**Not a web wrapper. Pure Flutter widgets.**

- OLED-black canvas, molten gold + emerald accents
- Live device stats (battery, thermal zone, health) via a Kotlin platform channel
- 5-scene "Forge" story: Vessel → Forge → Gateway → Trove → Eye
- System health pills
- Emil-grade motion: custom easing, transform-only, staggered reveals
- Vanilla Flutter — no slop, no frameworks

Built on-device from the very class of device it runs on. The phonemaker.

## Build
GitHub Actions builds the signed APK on every push to `main`.
Artifact: `tobia-forge-apk` → `app-release.apk`
