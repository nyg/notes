# radare2

```sh
# start r2
# -AA perform aaa analysis
# -r provide rarun2 script (e.g. for stdin)
# -d debug mode
# -w writeable
r2 -AA -r *.rr2 -d -w my-bin

afl # function list
aaa # symbol analysis

s sym/addr # seek a symbol or address

axt # cross references

iz # strings

db  # breakpoints f2
ds  # step int    f7
dso # step over   f8
dc  # continue    f9

# visual modes
V
v!
# <tab> to choose panel
# <"> to modify content
# <-> to split panel

dr <reg>
dr 1 # show reg flags

pdf [@ sym.fn] # print disassembly

pdg # decompile with Ghidra

pf z @ addr/reg # print format

afvd     # see all variables
.afvd s1 # specific var
x/128x @ rsp

# change opcodes (jmp etc.), needs -w for persistence
s addr
pd 1
wx 74
pd 1
q
```
