
.PHONY: all
all:
	@echo "Use specific command."

clean:
	rm *.elf *.o

MACHINE=rv64-virt
AS_INCLUDE=res/$(MACHINE)/
LDSDIR=res/$(MACHINE)
ASFLAGS=-march=rv64imac
CCFLAGS=-march=rv64imac -mabi=lp64 -mcmodel=medany
LDFLAGS=

ASM_SRC=src/asker.s
ASM_OBJ=asker.o
ASM_OUT=asker.elf
ASM_LDF=$(LDSDIR)/as-link.ld
.PHONY: asm-kernel
asm-kernel:
	riscv64-unknown-elf-as $(ASFLAGS) -g -I$(AS_INCLUDE) -o $(ASM_OBJ) $(ASM_SRC)
	riscv64-unknown-elf-ld -T $(ASM_LDF) -o $(ASM_OUT) $(ASM_OBJ)

.PHONY: c-kernel
c-kernel:
	riscv64-unknown-elf-as $(ASFLAGS) -I$(AS_INCLUDE) -g -o entry.o res/entry.s 
	riscv64-unknown-elf-gcc $(CCFLAGS) -static -nostdlib -ffreestanding -c -o cker.o src/cker.c 
	riscv64-unknown-elf-ld $(LDFLAGS) -T $(LDSDIR)/c-link.ld entry.o cker.o -o cker.elf

KERNEL=code.elf
.PHONY: run
run:
	qemu-system-riscv64 -machine virt -nographic  -bios none -kernel $(KERNEL)

RUSTC=rustc
SRC=src/res.rs
OUTDIR=build
RUSTTARGET=riscv64gc-unknown-none-elf
# RUSTTARGET=riscv32imac-unknown-none-elf
.PHONY: emit-ll
emit-ll:
	$(RUSTC) $(SRC) --emit llvm-ir --out-dir $(OUTDIR) \
		--target $(RUSTTARGET) \
		-Cpanic=abort -Coverflow-checks=off

RUST-LLD=rust-lld
RUST-LDSCRIPT=res/rv64-virt/rust-link.ld
.PHONY: build-rust
build-rust:
	$(RUSTC) $(SRC) --o $(OUTDIR)/rustker.elf \
		--target $(RUSTTARGET) \
		-Clinker=$(RUST-LLD) -Clink-arg=-T$(RUST-LDSCRIPT) \
		-Cpanic=abort -Coverflow-checks=off

bundle-tests: src/res.rs res.ll res-firv.s
	zip $@.zip $^
