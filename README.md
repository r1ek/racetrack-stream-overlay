# racetrack-stream-overlay

Transparent live overlay for an in-car phone stream (CameraFi Live / IRL Pro web overlay): speed, per-race-hour average and top speed, total distance, learned track map, race clock, Instagram handle. Optional GPS lap timer (`laps=1`).

Defaults are set for WTF Motorsport at Mannergute Mõõduvõtt (Opel Astra, start 12:00, 8 h, @WTF.motorsport), so the bare URL works: https://r1ek.github.io/racetrack-stream-overlay/

Single static `index.html`, no build. Host on GitHub Pages and paste the URL into the streaming app's web overlay.

## How it works

- GPS from the same phone (`navigator.geolocation`), ~1 Hz; or `?rtirl=<pull key>` to read the RealtimeIRL app's location instead (if the overlay WebView has no GPS access).
- Track and start/finish are learned: the first time the car returns within 15 m of an earlier point in the same direction (after `minlap` s), that point becomes the timing line and the loop becomes the map. Works for any layout and ignores the pit-exit run-in.
- Laps > 1.5 × best or > 3 min are "(boks/aegl.)", laps with a GPS gap "(?)"; neither counts as best. After a crossing the line re-arms only once the car is > 150 m away, so a parked car cannot add laps.
- State is kept in `localStorage` per `session`; it resets itself if the car is > 2 km from the saved origin.

## URL parameters

| Param | Example | Meaning |
|---|---|---|
| `team`, `car` | `team=Opel%20Astra&car=57` | top-left label (default team `Opel Astra`) |
| `laps` | `laps=1` | show GPS lap timer instead of hourly stats |
| `drivers` | `drivers=Keir@12:00,Mart@14:00` | current driver by local time |
| `start`, `dur` | `start=12:00&dur=8` | race clock and hourly stats window (default 12:00, 8 h) |
| `session` | `session=mm57` | separate saved state per event |
| `reset` | `reset=1` | clear saved state once |
| `rtirl` | `rtirl=PULLKEY` | use RealtimeIRL instead of phone GPS |
| `sf` | `sf=58.40,24.45,135` | fixed timing line lat,lon,heading° (skip learning) |
| `minlap`, `gate`, `maxacc`, `maxgap` | `minlap=60` | min lap s (default 60), gate half-width m (25), max GPS accuracy m (30), max fix gap s (5) |
| `ig` | `ig=WTF.motorsport` | Instagram icon + @HANDLE label (default WTF.motorsport; `ig=` to hide) |
| `scale`, `hide` | `scale=1.2&hide=team,map` | size, hide boxes (`team`,`stint`,`lap`,`spd`,`map`,`ig`) |
| `demo`, `speedup` | `demo=1&speedup=20` | simulated laps for testing |

Lap times are GPS-based (±0.5–1 s at 1 Hz), not official timing.
