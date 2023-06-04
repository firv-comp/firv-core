firv-core
===

Run kernel code with:

```
qemu-system-riscv64 -nographic -machine virt -bios none -kernel code.elf 
```

Building from custom asm (here `res-firv.s`):
```
make asm-kernel \
    ASM_LDF=res/rv64-virt/rust-link.ld \
    ASM_SRC=res-firv.s \
    ASM_OBJ=firv.o \
    ASM_OUT=firv.elf 
```
