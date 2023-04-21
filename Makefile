
.PHONY: all
all:
	@echo "Use specific command."

clean:
	rm *.elf *.o

MACHINE=rv64-virt
AS_INCLUDE=res/$(MACHINE)/
LDSDIR=res/$(MACHINE)
ASFLAGS=-march=rv64im
CCFLAGS=-march=rv64im -mabi=lp64 -mcmodel=medany
LDFLAGS=

.PHONY: asm-kernel
asm-kernel:
	riscv64-unknown-elf-as $(ASFLAGS) -g -I$(AS_INCLUDE) -o asker.o src/asker.s
	riscv64-unknown-elf-ld -T $(LDSDIR)/as-link.ld -o asker.elf asker.o

.PHONY: c-kernel
c-kernel:
	riscv64-unknown-elf-as $(ASFLAGS) -I$(AS_INCLUDE) -g -o entry.o res/entry.s 
	riscv64-unknown-elf-gcc $(CCFLAGS) -static -nostdlib -ffreestanding -c -o cker.o src/cker.c 
	riscv64-unknown-elf-ld $(LDFLAGS) -T $(LDSDIR)/c-link.ld entry.o cker.o -o cker.elf
