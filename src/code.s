
.include "config.inc"

.section .init
.globl _start
_start:
    li s1, UART
    la s2, message
loop:
    lb s3, 0(s2)
    beq s3, zero, done
    sb s3, 0(s1)
    addi s2, s2, 1
    j loop
done:
    j shutdown

shutdown:
    li s1, SYSCON
    li s2, SHUTDOWN
    sw s2, 0(s1)
    j _start
    nop


.section .data
message:
  .string "Hello, world!\n"
