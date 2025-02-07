---
title: nftables
---

```shell
# reset
sudo nft flush ruleset

# reload defaults
sudo systemctl restart nftables

# list all rules
sudo nft list table inet filter

# allow outgoing traffic already established
sudo nft add rule inet filter output ct state established,related accept

# drop outgoing traffic to LAN
sudo nft add rule inet filter output ip daddr 192.168.1.0/24 drop

# persist rules
sudo nft list ruleset | sudo tee /etc/nftables.conf

# validate rules
sudo nft -f /etc/nftables.conf

# fix permissions
sudo chmod 600 /etc/nftables.conf
```
