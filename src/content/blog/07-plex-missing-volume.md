---
title: "The Plex Database Kept Breaking. Turns Out I Never Finished Setting It Up."
description: "I'd deleted the same two corrupted files twice without knowing why. Digging into the logs finally showed me what was actually wrong."
pubDate: 2026-03-14
heroImage: "blog07.jpg"
---

Plex was down again.

I pulled up the logs expecting the usual noise and found the same two files causing problems again. `com.plexapp.plugins.library.db-shm` and `com.plexapp.plugins.library.db-wal`. SQLite's write-ahead log and shared memory files, left in a broken state. I'd deleted them once before. They came back. Now here we were again.

Deleting them isn't really fixing anything. They're not the database. Plex recreates them automatically on startup. But something kept interrupting Plex mid-write and leaving them stranded. I needed to figure out what.

I got some advice pointing at the appdata location. Plex was mapped to `/mnt/user/appdata/binhex-plex` and apparently that path adds extra layers between Plex and the actual drive. The recommendation was to move it to `/mnt/cache/appdata/binhex-plex` to get it closer to the NVMe directly. I didn't fully understand why, but it sounded reasonable and I wanted Plex working again. So I stopped the container, copied everything over, updated the path in the container config, and started Plex back up.

It crashed immediately.

The logs were pretty clear about why:

```
mkdir: cannot create directory '/data/transcode': Permission denied
boost::filesystem::temp_directory_path: Not a directory: "/data/transcode"
```

Plex couldn't find its transcode directory. I checked the container config and saw a `TRANS_DIR` variable set to `/data/transcode`. Looked right. The directory existed on the host at `/mnt/user/data/transcode` with open permissions. Still crashing.

That's when I caught it. `TRANS_DIR` is just a variable. It tells Plex where to write transcode files inside the container. But there was no actual volume mapping for `/data`. The container had no idea where `/data` pointed on the host. The variable was configured correctly. The mount was just never there.

I added the mapping. Container path `/data` pointing to `/mnt/user/data` on the host. Started Plex again.

```
INFO success: start-script entered RUNNING state
```

Up.

Finding this made the WAL files click for me. I'd been deleting them without really understanding what put them there. Now it made sense. Every transcode attempt was reaching into a path that didn't exist. Something would fail mid-write. Those files would get left behind. I'd eventually notice Plex was down, delete them, and move on without knowing I'd be back doing the same thing again.

It wasn't the FUSE layer. It was a missing volume mount that had been missing from the beginning.

The appdata move to `/mnt/cache` was still worth doing. Direct NVMe access is better for a SQLite-heavy app. But it wasn't the root cause. The missing `/data` mapping was.

Community Apps templates get you 90% of the way there. Sometimes the other 10% is a variable that looks like a path but isn't wired to anything yet. Worth double-checking your mounts.

Hopefully its fixed?
