---
title: hashcat
---

* Hashcat options: https://hashcat.net/wiki/doku.php?id=hashcat

## Potfile

The potfile is where hashcat stores cracked hashes. It is usually in `~/.hashcat` and named `hashcat.potfile` but can also be close to where the hashcat binary is, e.g. in `/usr/local/Cellar/hashcat/6.2.6_1/share/hashcat/` on macOS when installed with brew.

```sh
# show cracked hashes
hashcat -m<hash-type> hashes-to-crack.txt --show

# show uncracked hashes
hashcat -m<hash-type> hashes-to-crack.txt --left

# disable writing to the potfile or looking into the potfile for any alreay
# cracked hashes
--potfile-disabled

# specify a custom potfile
--potfile-path=mydir/current.potfile

# specify an output file for cracked hashes, the difference with the potfile is
# that potfile is searched for cracked hashes before hashcat starts the cracking
# process, which is not the case for the output file
-o output.txt
```

## Optimisations

* The workload profile can be changed, from `-w1` to `-w4` (2 is the default), but after some tests it doesn't seem to change much. Using `-w3` should be fine. Full option name is: `--workload-profile`.
* Running optimized kernels with `-O` will limit password length but can improve **or worsen** performances, e.g. for hashtype 1000, `-O` gives 8MH/s, without it goes up to 12MH/s.
* Force OpenCL GPU with `-D2 -d3` (2: OpenCL backend type, 3: backend device).


## Examples

```sh
hashcat -D2 -d3 -O -a3 -w3 -m1000 hash-file mask-file
hashcat -d3 -a3 -m1100 -i '***:Administrator' -1 ?l ?1?1?1?1?1?1?1?1
hashcat -d3 -a3 -m2100 -i '$DCC2$10240#Administrator#***' -1 ?l ?1?1?1?1?1?1?1?1?1
hashcat -d3 -a0 -m1100 '***:Administrator' Top304Thousand-probable-v2.txt
```
