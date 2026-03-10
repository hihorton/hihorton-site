---
title: 'I Rebuilt My Entire Homelab'
description: 'Two days of restructuring Unraid, building a TrueNAS NAS from scratch, and what happened when the boot drive died halfway through.'
pubDate: 'Mar 10 2026'
heroImage: '../../assets/blog06.jpg'
---

My homelab has been running for years but I never really designed it.

It just grew. Containers got added, shares got created, data ended up wherever there was space. My wife's photos and documents lived on the same server as linux ISOs. I had no idea what was irreplaceable and what wasn't.

I decided to fix it.

---

## The Problem I Was Trying to Solve

I had an Unraid server doing everything, media server, arr stack, personal file storage, Docker containers, VMs. It worked, but it was a mess.

I also had spare hardware sitting unused. An i3 system with four 8TB SAS drives and nothing to do.

The reasoning was simple: I had the hardware, and having everything on one machine means one point of failure. If something happens to the Unraid box, I wanted the stuff that actually matters to exist somewhere else.

So I built a dedicated backup target.

- **Unraid** — still the primary for everything. Media, containers, personal shares.
- **TrueNAS SCALE** — a separate machine that mirrors the important stuff via rsync overnight.

Once I framed it that way the rest of the decisions were easy.

---

## Building the Backup NAS

I installed TrueNAS SCALE on the i3 build and set up a ZFS pool with the four HGST drives — two mirrored vdevs, about 14TB usable.

Datasets map directly to what I'm backing up from Unraid:

- `tank/photos` — family photos
- `tank/wifesname` — my wife's personal files
- `tank/michael` — my personal data
- `tank/backups` — Time Machine and misc

Nightly rsync jobs push from Unraid to TrueNAS on a staggered schedule. No `--delete` flag on the personal data — TrueNAS is an archive, not a mirror. If something gets accidentally deleted on Unraid it stays on TrueNAS until I clean it up intentionally.

I also deleted a 58GB recovery folder during the migration that hadn't been touched in ten years. If I haven't needed it in a decade I'm not going to need it.

---

## Cleaning Up Unraid

With the backup strategy in place I restructured Unraid's shares from scratch.

Years of accumulation meant things were scattered without any real logic. I took the opportunity to reorganize everything intentionally. Consistent paths, containers on an isolated network, clear separation between what's permanent and what's disposable.

It's the same thinking I've been applying on the AWS side. Design it right from the start instead of inheriting someone else's mess.

---

## The Flash Drive

On day two I noticed the Unraid boot USB showing 100% full in the dashboard.

The Nvidia Driver plugin had been quietly storing 406MB of driver packages on the flash drive. I didn't know it did that. I deleted the packages folder but it was already too late — the FAT32 filesystem had started throwing I/O errors from running out of space while I was working.

I couldn't remount it. Couldn't create a backup. Couldn't repair it while the system was running.

I had to replace the USB drive entirely.

Here's what I learned from that: all my actual data was fine. The array was untouched. Appdata was intact. TrueNAS was untouched. Rebuilding the Unraid config from a new flash drive took a couple hours because I knew what I was doing the second time around.

The backup I should have taken at the start of the project would have made it faster. That's the habit I'm building now — flash backup after every significant change, automated to the array nightly.

---

## What's Running Now

The stack feels intentional in a way it didn't before.

Two media servers running with GPU hardware transcoding. Automated quality management so I don't have to think about it. A self-hosted photo library pulling from the NAS over the network.

Remote access through Tailscale for anything internal, Cloudflare Tunnel for anything I want reachable without a VPN.

Three automated backup jobs run overnight. Personal data to the NAS, configs mirrored to a backup pool, boot config archived to the array.

---

## What I Took Away

I've been learning cloud infrastructure for a while now and a lot of the same thinking applies here — least privilege, separation of concerns, don't put everything in one place, automate what you'll otherwise forget.

The flash drive failure was frustrating in the moment but it validated the whole point of the restructure. The irreplaceable data was safe because I had moved it somewhere designed to protect it. The rest was just configuration that could be rebuilt.

That's the goal. Know what matters, protect that, and make everything else recoverable.
