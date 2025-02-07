---
title: QEMU
---

```shell
# https://qemu-project.gitlab.io/qemu/system/target-avr.html
# https://qemu-project.gitlab.io/qemu/system/monitor.html

screendump <filename>

(s)top, (c)ont

# virtual memory dump
# format: he(x), signed (d)ecimal, (u)nsigned, (o)ctal, (c)har, asm (i)nstruction
# size: (b)yte, (h)alf word, (w)ord, g (64 bits)
x/<{count}{format}{size}> addr

# physical memory dump
xp/<format> addr

# print
p/<format> addr

# read/write I/O ports
i/<format> addr val
o/<format> addr val

sendkeys <keys> # separate multiple keys with a dash, use hex value for keys

# save memory to disk
memsave addr size file
pmemsave addr size file
dump-guest-memory

# ring buffer char dev ??

# storage keys
dump-skeys filename

qemu-io <device> <command>

info	network
			chardev*
			block*
			blockstats
			block-jobs
			registers*
			lapic
			cpus
			pci
			mem
			mtree*
			usb
			usbhost
			vnc
			qtree*
			roms*
			memdev
			memory-devices
			skeys
			dump
			ramblock*
```
