# StarCraft: Brood War Cache Cleaner
For MacOS with Apple silicon

Deletes the contents of the Battle.net Agent cache once per minute **only while StarCraft: Brood War is running**.

Uses `launchd` (macOS native scheduler).

## Why

According to user *george* on the Blizzard forums   https://us.forums.blizzard.com/en/starcraft/t/solved-fix-menu-slowness-on-newer-macs-m-series/3862
>Blizzard has packaged Starcraft with an embedded Chromium for UI elements. Both StarCraft and this Chromium are built for x86 processors, e.g. Intel CPUs. The newer Macs have ARM processors built by Apple. Your mac transparently translates these x86 programs to ARM under the hood, and usually it can be pretty fast. This is why the game is pretty smooth on MacOS.
>
>But the UI elements use the embedded Chromium; they are created using HTML/Javascript under the hood. And Chromium uses something called V8, which runs UI code very fast using dynamic compilation called just-in-time compilation (JIT). Because the Chromium binary is x86, the JIT engine in V8 will dynamically compile Javascript to x86 machine code. This adds a lot of overhead, because as time goes on the jit engine will compile more and more things.

George suggested running starcraft with arg 
> --js-flags=--jitless

but this method worked better for me.

---

## Files

- `starcraft_bw_cache_cleaner.sh`  
  Cache cleanup script

- `com.starcraft.bw.cachecleaner.plist`  
  `launchd` LaunchAgent (runs every 60 seconds)

---

## Installation

### 1. Move script to /bin/ dir and make it executable
or anywhere else you want. Make sure the plist points to the right place.

```bash
sudo cp starcraft_bw_cache_cleaner.sh /usr/local/bin/starcraft_bw_cache_cleaner.sh

sudo chmod +x /usr/local/bin/starcraft_bw_cache_cleaner.sh
```

### 2. Move plist and load  wih launchctl
```bash
mv com.starcraft.bw.launchcleaner.plist  ~/Library/LaunchAgents/com.starcraft.bw.cachecleaner.plist

launchctl load ~/Library/LaunchAgents/com.starcraft.bw.cachecleaner.plist
```


Make sure its running
```bash
launchctl list | grep starcraft
```
should show something like

```bash
-	0	com.starcraft.bw.cachecleaner
```

Stop the script at any time with
```bash
launchctl unload com.starcraft.bw.cachecleaner
```
