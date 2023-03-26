---
title: Wireshark
---

```sh
# only beacon frame
wlan.fc.type_subtype == 0x8

sniff(iface='en0', prn=lambda x: x.show2(), monitor=True, filter='link[25] == 0x80', count=1)
sniff(iface='en0', prn=hexdump, monitor=True, filter='link[25] == 0x80', count=1)

# works
sudo tcpdump -I -i en0 -ddd -s 65535 'wlan type mgt subtype probe-req'

# scapy – doesn't work
sudo tcpdump -p -i en0 -ddd -s 65535 'wlan type mgt subtype probe-req'
```
