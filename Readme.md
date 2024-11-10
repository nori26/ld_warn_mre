## MRE for "`warning: creating DT_TEXTREL in a PIE`" on AMD64

### Objective
Reproduce the following error:
```
/usr/bin/ld: hoge.o: warning: relocation in read-only section `.text'
/usr/bin/ld: warning: creating DT_TEXTREL in a PIE
```

### Usage
To reproduce the error, run:
```
make
```

### Build Tool Information for Error Reproduction
To view build tool details for reproducing the error, run:
```
make info
```

### Asm
- clang-13
```
0000000000000000 <main>:
   0:   55                      push   rbp
   1:   48 89 e5                mov    rbp,rsp
   4:   48 b8 00 00 00 00 00    movabs rax,0x0
   b:   00 00 00 
                        6: R_X86_64_64  .rodata.str1.1
   e:   48 89 45 f8             mov    QWORD PTR [rbp-0x8],rax
  12:   31 c0                   xor    eax,eax
  14:   5d                      pop    rbp
  15:   c3                      ret
```
- clang-14
```
0000000000000000 <main>:
   0:   55                      push   rbp
   1:   48 89 e5                mov    rbp,rsp
   4:   48 8d 05 00 00 00 00    lea    rax,[rip+0x0]        # b <main+0xb>
                        7: R_X86_64_PC32        .L.str-0x4
   b:   48 89 45 f8             mov    QWORD PTR [rbp-0x8],rax
   f:   31 c0                   xor    eax,eax
  11:   5d                      pop    rbp
  12:   c3                      ret
```

### Reference

- [Clang 14.0.0 Release Notes](https://releases.llvm.org/14.0.0/tools/clang/docs/ReleaseNotes.html#build-system-changes)
> Linux distros can specify -DCLANG_DEFAULT_PIE_ON_LINUX=On to use -fPIE and -pie by default. This matches GCC installations on many Linux distros (configured with --enable-default-pie). ([D113372](https://reviews.llvm.org/D113372))

- [GNU ld 2.35 Release Notes](https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob_plain;f=ld/NEWS;hb=refs/tags/binutils-2_35)
> Add a command-line option for ELF linker, --warn-textrel, to warn that
  DT_TEXTREL is set in a position-independent executable or shared object.
