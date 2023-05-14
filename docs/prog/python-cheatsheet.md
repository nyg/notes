---
title: Python cheatsheet
---

```py
# int bases

>>> 0b101010
# 42
>>> 0o10
# 8
>>> 0x10
# 16

# int to binary, octal, hex string representation

>>> bin(42)
'0b101010'
>>> oct(8)
'0o10'
>>> hex(16)
'0x10'

# int to bytes object
>>> 0x41424344.to_bytes(4, byteorder='big')
b'ABCD'

>>> int.from_bytes(b'ABCD', byteorder='little')
1145258561  # 0x44434241

# bytes object to hex string

>>> b'ABCD'.hex()
'41424344'

>>> b'ABCD'.hex(':')
'41:42:43:44'
```
