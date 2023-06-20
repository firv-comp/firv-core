	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1"
	.file	"firv.ll"
	.globl	sw_f                            # -- Begin function sw_f
	.p2align	1
	.type	sw_f,@function
sw_f:                                   # @sw_f
# %bb.0:
	add	a2, a0, a1
	sub	a0, a0, a1
	mul	a0, a2, a0
	ret
.Lfunc_end0:
	.size	sw_f, .Lfunc_end0-sw_f
                                        # -- End function
	.globl	sw_f_hardened                   # -- Begin function sw_f_hardened
	.p2align	1
	.type	sw_f_hardened,@function
sw_f_hardened:                          # @sw_f_hardened
# %bb.0:                                # %FirvPrologue
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	mv	a2, sp
	addi	sp, a2, -16
	sw	a0, -16(a2)
	lw	a2, -16(a2)
	mv	a3, sp
	addi	sp, a3, -16
	sw	a1, -16(a3)
	lw	a3, -16(a3)
	add	a4, a2, a3
	sub	a2, a2, a3
	mul	a2, a4, a2
	sw	a2, -12(s0)
	mv	a2, sp
	addi	sp, a2, -16
	sw	a0, -16(a2)
	lw	a0, -16(a2)
	mv	a2, sp
	addi	sp, a2, -16
	sw	a1, -16(a2)
	lw	a1, -16(a2)
	add	a2, a0, a1
	sub	a0, a0, a1
	mul	a0, a2, a0
	sw	a0, -16(s0)
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	bne	a0, a1, .LBB1_4
# %bb.1:                                # %ReturnBB
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	addi	a2, s0, -16
	addi	a3, s0, -12
	bne	a3, a2, .LBB1_3
# %bb.2:                                # %ReturnBB
	mv	a0, a1
.LBB1_3:                                # %ReturnBB
	addi	sp, s0, -16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.LBB1_4:                                # %FirvFailBB
	unimp	
.Lfunc_end1:
	.size	sw_f_hardened, .Lfunc_end1-sw_f_hardened
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
