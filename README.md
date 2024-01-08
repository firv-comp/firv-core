# firv-core

## Prerequisites

* `git`
* GNU `make`

### Running RISC-V examples
* `qemu` (the `qemu-system-riscv64` binary)

### Simple kernels (asm, C)
* RISC-V GNU Toolkit (`riscv64-unknown-elf-*` binaries)

### Rust-based kernels
* `rustc` (for case of just RISC-V code execution)
* [firv-comp/firv-rust](https://github.com/firv-comp/firv-rust) (FIRV hardening)
* RISC-V GNU Toolkit (`riscv64-unknown-elf-*` binaries)

## Executing kernel code

The built kernel can be run with on a `qemu` machine:

```
qemu-system-riscv64 -nographic -machine virt -bios none -kernel code.elf 
```

## Building kernels

### Build test ASM kernel

The test asm kernel is located in `src/asker.s`

By default output will be placed in `build/asker.elf`

```
make asm-kernel
```

### Build test C kernel

The test C kernel is located in `src/cker.c`

By default output will be placed in `build/cker.elf`

```
make c-kernel
```

### Building from custom asm

The custom input assembly file: `res-firv.s`

The linker script: `res/rv64-virt/rust-link.ld` (example is rust-sourced assembly)

```
make asm-kernel \
    ASM_LDF=res/rv64-virt/rust-link.ld \
    ASM_SRC=res-firv.s \
    ASM_OBJ=firv.o \
    ASM_OUT=firv.elf 
```
## Rust commands

The rust-related commands default to usage of `rustc`, in case of using the `firv-rust`, specify the `RUSTC` parameter, e.g. `RUSTC=../firv-rust/build/host/stage1/bin/rustc`

### Build Rust kernel

Build the kernel from Rust sources

```
make rust-kernel \
    RUSTC=../firv-rust/build/host/stage1/bin/rustc \
    SRC=src/harden.rs
```

### Emit LLVM-IR

Emit the LLVM intermediate representation

```
make rust-ll \
    RUSTC=../firv-rust/build/host/stage1/bin/rustc \
    SRC=src/harden.rs
```

### Emit RISC-V ASM

Emit the RISC-V assembly

```
make rust-asm \
    RUSTC=../firv-rust/build/host/stage1/bin/rustc \
    SRC=src/harden.rs
```
