
build/bios.elf:     формат файла elf32-littleriscv


Дизассемблирование раздела .text:

00000000 <_ftext>:
   0:	00000093          	li	ra,0
   4:	00000113          	li	sp,0
   8:	00000193          	li	gp,0
   c:	00000213          	li	tp,0
  10:	00000293          	li	t0,0
  14:	00000313          	li	t1,0
  18:	00000393          	li	t2,0
  1c:	00000413          	li	s0,0
  20:	00000493          	li	s1,0
  24:	00000513          	li	a0,0
  28:	00000593          	li	a1,0
  2c:	00000613          	li	a2,0
  30:	00000693          	li	a3,0
  34:	00000713          	li	a4,0
  38:	00000793          	li	a5,0
  3c:	00000813          	li	a6,0
  40:	00000893          	li	a7,0
  44:	00000913          	li	s2,0
  48:	00000993          	li	s3,0
  4c:	00000a13          	li	s4,0
  50:	00000a93          	li	s5,0
  54:	00000b13          	li	s6,0
  58:	00000b93          	li	s7,0
  5c:	00000c13          	li	s8,0
  60:	00000c93          	li	s9,0
  64:	00000d13          	li	s10,0
  68:	00000d93          	li	s11,0
  6c:	00000e13          	li	t3,0
  70:	00000e93          	li	t4,0
  74:	00000f13          	li	t5,0
  78:	00000f93          	li	t6,0
  7c:	20100137          	lui	sp,0x20100
  80:	ffc10113          	addi	sp,sp,-4 # 200ffffc <_fstack>
  84:	20000517          	auipc	a0,0x20000
  88:	f7c50513          	addi	a0,a0,-132 # 20000000 <_ebss>
  8c:	20000597          	auipc	a1,0x20000
  90:	f7458593          	addi	a1,a1,-140 # 20000000 <_ebss>
  94:	00b55863          	bge	a0,a1,a4 <callMain>

00000098 <loop_init_bss>:
  98:	00052023          	sw	zero,0(a0)
  9c:	00450513          	addi	a0,a0,4
  a0:	feb54ce3          	blt	a0,a1,98 <loop_init_bss>

000000a4 <callMain>:
  a4:	008000ef          	jal	ra,ac <main>

000000a8 <inf_loop>:
  a8:	0000006f          	j	a8 <inf_loop>

000000ac <main>:
  ac:	ff010113          	addi	sp,sp,-16
  b0:	00812623          	sw	s0,12(sp)
  b4:	01010413          	addi	s0,sp,16
  b8:	00000793          	li	a5,0
  bc:	00078513          	mv	a0,a5
  c0:	00c12403          	lw	s0,12(sp)
  c4:	01010113          	addi	sp,sp,16
  c8:	00008067          	ret
