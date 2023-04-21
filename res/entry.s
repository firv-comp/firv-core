.option norvc
.section .init

.global _start
_start:
    .option push
    .option norelax
	la gp, global_pointer
    .option pop

    /* Setup stack */
	la sp, stack_top
 
	/* Clear the BSS section */
	la t5, bss_start
	la t6, bss_end
bss_clear:
	sd zero, (t5)
	addi t5, t5, 8
	bgeu t5, t6, bss_clear

start:
    tail main
