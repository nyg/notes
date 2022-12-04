# hashcat

### Brute force

```sh
hashcat -O -d 3 -a 3 -m 1100 -i '***:Administrator' -1 ?l ?1?1?1?1?1?1?1?1
hashcat -d 3 -a 3 -m 2100 -i '$DCC2$10240#Administrator#***' -1 ?l ?1?1?1?1?1?1?1?1?1
```

### Word list

```sh
hashcat -O -d 3 -a 0 -m 1100 '***:Administrator' Top304Thousand-probable-v2.txt
```
