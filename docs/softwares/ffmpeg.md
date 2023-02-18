# ffmpeg

### map

Use `-map x:y` to select a particular stream (can be used multiple times).

### copy

`-c:v/a/s` to copy streams without re-encoding.

### LotR

```sh
ffmpeg -i in.mkv -map 0:0 -map 0:6 -map 0:19 -c:v copy -c:a copy -c:s copy out.mkv

ffmpeg -i INFILE.mp4 -vcodec copy -acodec copy -ss 00:01:00.000 -t 00:00:10.000 OUTFILE.mp4
```
