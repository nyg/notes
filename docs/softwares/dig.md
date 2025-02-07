---
title: dig
---

```shell
# ask dns server 8.8.8.8 for all records concerning my-domain.com
dig @8.8.8.8 -p 53 my-domain.com. any in
# -q domain-name
# -t record type
# -c class (in, ch)
# +short, useful for scripts

# more on dns classes (e.g. in, ch)
# https://stackoverflow.com/q/52986291/5536516


# zone transfer, used to copy zone records from one dns server to another
# AXFR (ApeX transFeR?) is the dns query type for a zone transfer
dig @… my-domain.com. axfr

# -p doesn't seem to be very well supported
host -l -a -p 2211 deans-transfers.express 46.101.107.117

# soa records and zone tranfers
# https://www.cloudflare.com/en-gb/learning/dns/dns-records/dns-soa-record/


# bind info
dig @… version.bind. any ch
dig @… hostname.bind. any ch
dig @… authors.bind. any ch
```
