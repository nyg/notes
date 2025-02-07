---
title: GDB
---

```shell
# Lists all functions known to the debugger.
info functions

# Displays information about the executable file being debugged.
info files

# Shows the values of CPU registers.
info reg

# Prints the value of register r24 (useful for debugging architectures like AVR).
print $r24

# Prints the value of SREG (Status Register) in hexadecimal format.
p/x $SREG

# Sets the value of register r24 to 1.
set $r24=1

# Sets a breakpoint at the specified memory address (addr).
b *addr

# Searches memory from address 0x0 to 0xfff for the string "a string".
find 0x0, 0xfff, "a string"
```
