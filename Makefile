
.PHONY: all
all:
	@echo "Use specific command."

clean:
	rm build/* *.elf *.o

#-------------------------------------------
# General and tool settings
#-------------------------------------------

# General settings
BUILDDIR=build
MACHINE=rv64-virt

# Linker settings
LDSDIR=res/$(MACHINE)
LDFLAGS=

# Assembly settings
AS_INCLUDE=res/$(MACHINE)/
ASFLAGS=-march=rv64imac

# C compiler settings
CCFLAGS=-march=rv64imac -mabi=lp64 -mcmodel=medany

#-------------------------------------------
# Executing RISC-V code
#-------------------------------------------

KERNEL=code.elf
.PHONY: run
run:
	qemu-system-riscv64 -machine virt -nographic  -bios none -kernel $(KERNEL)

#-------------------------------------------
# Building example kernels
#-------------------------------------------

# Assembly kernel

ASM_SRC=src/asker.s
ASM_OBJ=$(BUILDDIR)/asker.o
ASM_OUT=$(BUILDDIR)/asker.elf
ASM_LDF=$(LDSDIR)/as-link.ld
.PHONY: asm-kernel
asm-kernel:
	riscv64-unknown-elf-as $(ASFLAGS) -g -I$(AS_INCLUDE) -o $(ASM_OBJ) $(ASM_SRC)
	riscv64-unknown-elf-ld -T $(ASM_LDF) -o $(ASM_OUT) $(ASM_OBJ)

# C kernel

C_SRC=src/cker.c
C_OBJ=$(BUILDDIR)/cker.o
C_ENTRY=$(BUILDDIR)/c_entry.o
C_OUT=$(BUILDDIR)/cker.elf
C_LDF=$(LDSDIR)/c-link.ld
.PHONY: c-kernel
c-kernel:
	riscv64-unknown-elf-as $(ASFLAGS) -I$(AS_INCLUDE) -g -o $(C_ENTRY) res/entry.s 
	riscv64-unknown-elf-gcc $(CCFLAGS) -static -nostdlib -ffreestanding -c -o $(C_OBJ) $(C_SRC) 
	riscv64-unknown-elf-ld $(LDFLAGS) -T $(C_LDF) $(C_ENTRY) $(C_OBJ) -o $(C_OUT)

#-------------------------------------------
# Rust builds
#-------------------------------------------

RUSTC=rustc
SRC=src/res.rs
OUTDIR=$(BUILDDIR)
RUSTTARGET=riscv64gc-unknown-none-elf

# Emit LLVM IR representation
.PHONY: rust-ll
rust-ll:
	$(RUSTC) $(SRC) --emit llvm-ir --out-dir $(OUTDIR) \
		--target $(RUSTTARGET) \
		-Cpanic=abort -Coverflow-checks=off

# Emit Assembly
.PHONY: rust-asm
rust-asm:
	$(RUSTC) $(SRC) --emit asm --out-dir $(OUTDIR) \
		--target $(RUSTTARGET) \
		-Cpanic=abort -Coverflow-checks=off

# Build kernel
RUST-LLD=riscv64-unknown-elf-ld
RUST-LDSCRIPT=res/rv64-virt/rust-link.ld
.PHONY: rust-kernel
rust-kernel:
	$(RUSTC) $(SRC) --o $(OUTDIR)/rustker.elf \
		--target $(RUSTTARGET) \
		-Clinker=$(RUST-LLD) -Clink-arg=-T$(RUST-LDSCRIPT) \
		-Cpanic=abort -Coverflow-checks=off

