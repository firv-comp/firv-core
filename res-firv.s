	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0"
	.file	"res.1d92002b-cgu.0"
                                        # Start of file scope inline assembly
	.option	norvc
	.section	.init,"ax",@progbits
	.globl	_start
_start:
	.option	push
	.option	norelax
.Lpcrel_hi0:
	auipc	gp, %pcrel_hi(global_pointer)
	addi	gp, gp, %pcrel_lo(.Lpcrel_hi0)
	.option	pop
	# Setup stack 
.Lpcrel_hi1:
	auipc	sp, %pcrel_hi(stack_top)
	addi	sp, sp, %pcrel_lo(.Lpcrel_hi1)

	# Clear the BSS section 
.Lpcrel_hi2:
	auipc	t5, %pcrel_hi(bss_start)
	addi	t5, t5, %pcrel_lo(.Lpcrel_hi2)
.Lpcrel_hi3:
	auipc	t6, %pcrel_hi(bss_end)
	addi	t6, t6, %pcrel_lo(.Lpcrel_hi3)
bss_clear:
	sd	zero, 0(t5)
	addi	t5, t5, 8
	bgeu	t5, t6, bss_clear
start:
	tail	main

                                        # End of file scope inline assembly
	.text
	.hidden	rust_begin_unwind               # -- Begin function rust_begin_unwind
	.globl	rust_begin_unwind
	.p2align	1
	.type	rust_begin_unwind,@function
rust_begin_unwind:                      # @rust_begin_unwind
# %bb.0:                                # %start
.LBB0_1:                                # %bb1
                                        # =>This Inner Loop Header: Depth=1
	j	.LBB0_1
.Lfunc_end0:
	.size	rust_begin_unwind, .Lfunc_end0-rust_begin_unwind
                                        # -- End function
	.p2align	1                               # -- Begin function _ZN3res10mmio_write17h026cf25b8df1ecb7E
	.type	_ZN3res10mmio_write17h026cf25b8df1ecb7E,@function
_ZN3res10mmio_write17h026cf25b8df1ecb7E: # @_ZN3res10mmio_write17h026cf25b8df1ecb7E
# %bb.0:                                # %start
	sw	a1, 0(a0)
	ret
.Lfunc_end1:
	.size	_ZN3res10mmio_write17h026cf25b8df1ecb7E, .Lfunc_end1-_ZN3res10mmio_write17h026cf25b8df1ecb7E
                                        # -- End function
	.p2align	1                               # -- Begin function _ZN3res10mmio_write17h62fa57ded56c2eceE
	.type	_ZN3res10mmio_write17h62fa57ded56c2eceE,@function
_ZN3res10mmio_write17h62fa57ded56c2eceE: # @_ZN3res10mmio_write17h62fa57ded56c2eceE
# %bb.0:                                # %start
	sw	a1, 0(a0)
	ret
.Lfunc_end2:
	.size	_ZN3res10mmio_write17h62fa57ded56c2eceE, .Lfunc_end2-_ZN3res10mmio_write17h62fa57ded56c2eceE
                                        # -- End function
	.p2align	1                               # -- Begin function _ZN3res10mmio_write17h65e7cedf9a0572bdE
	.type	_ZN3res10mmio_write17h65e7cedf9a0572bdE,@function
_ZN3res10mmio_write17h65e7cedf9a0572bdE: # @_ZN3res10mmio_write17h65e7cedf9a0572bdE
# %bb.0:                                # %start
	sb	a1, 0(a0)
	ret
.Lfunc_end3:
	.size	_ZN3res10mmio_write17h65e7cedf9a0572bdE, .Lfunc_end3-_ZN3res10mmio_write17h65e7cedf9a0572bdE
                                        # -- End function
	.p2align	1                               # -- Begin function _ZN3res4exit17h19a12b7917e47b63E
	.type	_ZN3res4exit17h19a12b7917e47b63E,@function
_ZN3res4exit17h19a12b7917e47b63E:       # @_ZN3res4exit17h19a12b7917e47b63E
# %bb.0:                                # %start
	addi	sp, sp, -16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	lui	a0, 5
	addiw	a1, a0, 1365
	lui	a0, 256
	call	_ZN3res10mmio_write17h026cf25b8df1ecb7E
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end4:
	.size	_ZN3res4exit17h19a12b7917e47b63E, .Lfunc_end4-_ZN3res4exit17h19a12b7917e47b63E
                                        # -- End function
	.p2align	1                               # -- Begin function _ZN3res4putc17h892351fd00e80645E
	.type	_ZN3res4putc17h892351fd00e80645E,@function
_ZN3res4putc17h892351fd00e80645E:       # @_ZN3res4putc17h892351fd00e80645E
# %bb.0:                                # %start
	addi	sp, sp, -16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	lui	a0, 65536
	call	_ZN3res10mmio_write17h65e7cedf9a0572bdE
	lui	a0, 65536
	li	a1, 10
	call	_ZN3res10mmio_write17h62fa57ded56c2eceE
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end5:
	.size	_ZN3res4putc17h892351fd00e80645E, .Lfunc_end5-_ZN3res4putc17h892351fd00e80645E
                                        # -- End function
	.p2align	1                               # -- Begin function _ZN3res4sw_f17h03488dde6df3dbe1E
	.type	_ZN3res4sw_f17h03488dde6df3dbe1E,@function
_ZN3res4sw_f17h03488dde6df3dbe1E:       # @_ZN3res4sw_f17h03488dde6df3dbe1E
# %bb.0:                                # %FirvPrologue
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
	mv	a2, sp
	addi	sp, a2, -16
	sw	a0, -16(a2)
	lw	a2, -16(a2)
	mv	a3, sp
	addi	sp, a3, -16
	sw	a1, -16(a3)
	lw	a3, -16(a3)
	add	a4, a2, a3
	subw	a2, a2, a3
	mul	a2, a4, a2
	sw	a2, -20(s0)
	mv	a2, sp
	addi	sp, a2, -16
	sw	a0, -16(a2)
	lw	a0, -16(a2)
	mv	a2, sp
	addi	sp, a2, -16
	sw	a1, -16(a2)
	lw	a1, -16(a2)
	add	a2, a0, a1
	subw	a0, a0, a1
	mul	a0, a2, a0
	sw	a0, -24(s0)
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	bne	a0, a1, .LBB6_4
# %bb.1:                                # %ReturnBB
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	addi	a2, s0, -24
	addi	a3, s0, -20
	bne	a3, a2, .LBB6_3
# %bb.2:                                # %ReturnBB
	mv	a0, a1
.LBB6_3:                                # %ReturnBB
	addi	sp, s0, -32
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.LBB6_4:                                # %FirvFailBB
	unimp	
.Lfunc_end6:
	.size	_ZN3res4sw_f17h03488dde6df3dbe1E, .Lfunc_end6-_ZN3res4sw_f17h03488dde6df3dbe1E
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %start
	addi	sp, sp, -16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	li	a0, 2
	li	a1, 1
	call	_ZN3res4sw_f17h03488dde6df3dbe1E
	sext.w	a0, a0
	li	a1, 3
	bne	a0, a1, .LBB7_2
# %bb.1:                                # %bb2
	li	a0, 49
	j	.LBB7_3
.LBB7_2:                                # %bb3
	li	a0, 48
.LBB7_3:                                # %bb4
	call	_ZN3res4putc17h892351fd00e80645E
	call	_ZN3res4exit17h19a12b7917e47b63E
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end7:
	.size	main, .Lfunc_end7-main
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
