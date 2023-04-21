
.PHONY: all
all:
	@echo "Use specific command."

MACHINE=rv64-virt
AS_INCLUDE=res/$(MACHINE)/

%.o: src/%.s
	riscv64-unknown-elf-as $(ASFLAGS) -g -I$(AS_INCLUDE) -o $@ $<

LINKSCRIPT=res/$(MACHINE)/c-link.ld
%.elf: %.o
	riscv64-unknown-elf-ld -T $(LINKSCRIPT) -o $@ $<

ASFLAGS=-march=rv64im
CCFLAGS=-march=rv64im -mabi=lp64 -mcmodel=medany
LDFLAGS=
.PHONY: kernel
kernel:
	riscv64-unknown-elf-as $(ASFLAGS) res/entry.s -g -o entry.o -I$(AS_INCLUDE)
	riscv64-unknown-elf-gcc $(CCFLAGS) -static -nostdlib -ffreestanding src/code.c -c -o code.o
	riscv64-unknown-elf-ld $(LDFLAGS) -T res/rv64-virt/c-link.ld entry.o code.o -o code.elf
