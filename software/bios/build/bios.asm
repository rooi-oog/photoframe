
build/bios.elf:     file format elf32-lm32


Disassembly of section .text:

00000000 <_ftext>:
       0:	98 00 00 00 	xor r0,r0,r0
       4:	d0 00 00 00 	wcsr IE,r0
       8:	78 01 00 00 	mvhi r1,0x0
       c:	38 21 00 00 	ori r1,r1,0x0
      10:	d0 e1 00 00 	wcsr EBA,r1
      14:	98 42 10 00 	xor r2,r2,r2
      18:	e0 00 00 32 	bi e0 <_crt0>
      1c:	34 00 00 00 	nop

00000020 <_breakpoint_handler>:
      20:	e0 00 00 00 	bi 20 <_breakpoint_handler>
      24:	34 00 00 00 	nop
      28:	34 00 00 00 	nop
      2c:	34 00 00 00 	nop
      30:	34 00 00 00 	nop
      34:	34 00 00 00 	nop
      38:	34 00 00 00 	nop
      3c:	34 00 00 00 	nop

00000040 <_instruction_bus_error_handler>:
      40:	e0 00 00 00 	bi 40 <_instruction_bus_error_handler>
      44:	34 00 00 00 	nop
      48:	34 00 00 00 	nop
      4c:	34 00 00 00 	nop
      50:	34 00 00 00 	nop
      54:	34 00 00 00 	nop
      58:	34 00 00 00 	nop
      5c:	34 00 00 00 	nop

00000060 <_watchpoint_hander>:
      60:	e0 00 00 00 	bi 60 <_watchpoint_hander>
      64:	34 00 00 00 	nop
      68:	34 00 00 00 	nop
      6c:	34 00 00 00 	nop
      70:	34 00 00 00 	nop
      74:	34 00 00 00 	nop
      78:	34 00 00 00 	nop
      7c:	34 00 00 00 	nop

00000080 <_data_bus_error_handler>:
      80:	e0 00 00 00 	bi 80 <_data_bus_error_handler>
      84:	34 00 00 00 	nop
      88:	34 00 00 00 	nop
      8c:	34 00 00 00 	nop
      90:	34 00 00 00 	nop
      94:	34 00 00 00 	nop
      98:	34 00 00 00 	nop
      9c:	34 00 00 00 	nop

000000a0 <_divide_by_zero_handler>:
      a0:	e0 00 00 00 	bi a0 <_divide_by_zero_handler>
      a4:	34 00 00 00 	nop
      a8:	34 00 00 00 	nop
      ac:	34 00 00 00 	nop
      b0:	34 00 00 00 	nop
      b4:	34 00 00 00 	nop
      b8:	34 00 00 00 	nop
      bc:	34 00 00 00 	nop

000000c0 <_interrupt_handler>:
      c0:	5b 9d 00 00 	sw (sp+0),ra
      c4:	f8 00 00 17 	calli 120 <.save_all>
      c8:	f8 00 04 5e 	calli 1240 <isr>
      cc:	e0 00 00 25 	bi 160 <.restore_all_and_eret>
      d0:	34 00 00 00 	nop
      d4:	34 00 00 00 	nop
      d8:	34 00 00 00 	nop
      dc:	34 00 00 00 	nop

000000e0 <_crt0>:
      e0:	78 1c 20 6f 	mvhi sp,0x206f
      e4:	3b 9c ff fc 	ori sp,sp,0xfffc
      e8:	78 1a 00 00 	mvhi gp,0x0
      ec:	3b 5a 2c 40 	ori gp,gp,0x2c40
      f0:	78 01 20 50 	mvhi r1,0x2050
      f4:	38 21 00 00 	ori r1,r1,0x0
      f8:	78 03 20 52 	mvhi r3,0x2052
      fc:	38 63 10 28 	ori r3,r3,0x1028

00000100 <.clearBSS>:
     100:	44 23 00 04 	be r1,r3,110 <.callMain>
     104:	58 20 00 00 	sw (r1+0),r0
     108:	34 21 00 04 	addi r1,r1,4
     10c:	e3 ff ff fd 	bi 100 <.clearBSS>

00000110 <.callMain>:
     110:	b8 40 08 00 	mv r1,r2
     114:	34 02 00 00 	mvi r2,0
     118:	34 03 00 00 	mvi r3,0
     11c:	e0 00 02 48 	bi a3c <main>

00000120 <.save_all>:
     120:	37 9c ff c8 	addi sp,sp,-56
     124:	5b 81 00 04 	sw (sp+4),r1
     128:	5b 82 00 08 	sw (sp+8),r2
     12c:	5b 83 00 0c 	sw (sp+12),r3
     130:	5b 84 00 10 	sw (sp+16),r4
     134:	5b 85 00 14 	sw (sp+20),r5
     138:	5b 86 00 18 	sw (sp+24),r6
     13c:	5b 87 00 1c 	sw (sp+28),r7
     140:	5b 88 00 20 	sw (sp+32),r8
     144:	5b 89 00 24 	sw (sp+36),r9
     148:	5b 8a 00 28 	sw (sp+40),r10
     14c:	5b 9e 00 30 	sw (sp+48),ea
     150:	5b 9f 00 34 	sw (sp+52),ba
     154:	2b 81 00 38 	lw r1,(sp+56)
     158:	5b 81 00 2c 	sw (sp+44),r1
     15c:	c3 a0 00 00 	ret

00000160 <.restore_all_and_eret>:
     160:	2b 81 00 04 	lw r1,(sp+4)
     164:	2b 82 00 08 	lw r2,(sp+8)
     168:	2b 83 00 0c 	lw r3,(sp+12)
     16c:	2b 84 00 10 	lw r4,(sp+16)
     170:	2b 85 00 14 	lw r5,(sp+20)
     174:	2b 86 00 18 	lw r6,(sp+24)
     178:	2b 87 00 1c 	lw r7,(sp+28)
     17c:	2b 88 00 20 	lw r8,(sp+32)
     180:	2b 89 00 24 	lw r9,(sp+36)
     184:	2b 8a 00 28 	lw r10,(sp+40)
     188:	2b 9d 00 2c 	lw ra,(sp+44)
     18c:	2b 9e 00 30 	lw ea,(sp+48)
     190:	2b 9f 00 34 	lw ba,(sp+52)
     194:	37 9c 00 38 	addi sp,sp,56
     198:	c3 c0 00 00 	eret

0000019c <vsnprintf>:
     19c:	37 9c ff 88 	addi sp,sp,-120
     1a0:	5b 8b 00 44 	sw (sp+68),r11
     1a4:	5b 8c 00 40 	sw (sp+64),r12
     1a8:	5b 8d 00 3c 	sw (sp+60),r13
     1ac:	5b 8e 00 38 	sw (sp+56),r14
     1b0:	5b 8f 00 34 	sw (sp+52),r15
     1b4:	5b 90 00 30 	sw (sp+48),r16
     1b8:	5b 91 00 2c 	sw (sp+44),r17
     1bc:	5b 92 00 28 	sw (sp+40),r18
     1c0:	5b 93 00 24 	sw (sp+36),r19
     1c4:	5b 94 00 20 	sw (sp+32),r20
     1c8:	5b 95 00 1c 	sw (sp+28),r21
     1cc:	5b 96 00 18 	sw (sp+24),r22
     1d0:	5b 97 00 14 	sw (sp+20),r23
     1d4:	5b 98 00 10 	sw (sp+16),r24
     1d8:	5b 99 00 0c 	sw (sp+12),r25
     1dc:	5b 9b 00 08 	sw (sp+8),fp
     1e0:	5b 9d 00 04 	sw (sp+4),ra
     1e4:	5b 83 00 78 	sw (sp+120),r3
     1e8:	48 02 00 bd 	bg r0,r2,4dc <vsnprintf+0x340>
     1ec:	b4 22 60 00 	add r12,r1,r2
     1f0:	b8 40 90 00 	mv r18,r2
     1f4:	b8 20 88 00 	mv r17,r1
     1f8:	b8 80 78 00 	mv r15,r4
     1fc:	51 81 00 03 	bgeu r12,r1,208 <vsnprintf+0x6c>
     200:	a4 20 90 00 	not r18,r1
     204:	34 0c ff ff 	mvi r12,-1
     208:	2b 86 00 78 	lw r6,(sp+120)
     20c:	ba 20 58 00 	mv r11,r17
     210:	10 c2 00 00 	lb r2,(r6+0)
     214:	44 40 01 8a 	be r2,r0,83c <vsnprintf+0x6a0>
     218:	78 01 00 00 	mvhi r1,0x0
     21c:	38 21 24 48 	ori r1,r1,0x2448
     220:	28 2e 00 00 	lw r14,(r1+0)
     224:	78 01 00 00 	mvhi r1,0x0
     228:	38 21 24 4c 	ori r1,r1,0x244c
     22c:	28 39 00 00 	lw r25,(r1+0)
     230:	78 01 00 00 	mvhi r1,0x0
     234:	38 21 24 50 	ori r1,r1,0x2450
     238:	28 37 00 00 	lw r23,(r1+0)
     23c:	78 01 00 00 	mvhi r1,0x0
     240:	38 21 24 54 	ori r1,r1,0x2454
     244:	28 38 00 00 	lw r24,(r1+0)
     248:	34 10 00 25 	mvi r16,37
     24c:	34 0d 00 10 	mvi r13,16
     250:	34 13 00 09 	mvi r19,9
     254:	34 15 00 2e 	mvi r21,46
     258:	34 14 ff df 	mvi r20,-33
     25c:	34 16 00 20 	mvi r22,32
     260:	44 50 00 21 	be r2,r16,2e4 <vsnprintf+0x148>
     264:	b8 c0 08 00 	mv r1,r6
     268:	51 6c 00 03 	bgeu r11,r12,274 <vsnprintf+0xd8>
     26c:	31 62 00 00 	sb (r11+0),r2
     270:	2b 81 00 78 	lw r1,(sp+120)
     274:	35 6b 00 01 	addi r11,r11,1
     278:	34 26 00 01 	addi r6,r1,1
     27c:	5b 86 00 78 	sw (sp+120),r6
     280:	10 22 00 01 	lb r2,(r1+1)
     284:	5c 40 ff f7 	bne r2,r0,260 <vsnprintf+0xc4>
     288:	c9 71 08 00 	sub r1,r11,r17
     28c:	4c 12 00 03 	bge r0,r18,298 <vsnprintf+0xfc>
     290:	51 6c 00 9f 	bgeu r11,r12,50c <vsnprintf+0x370>
     294:	31 60 00 00 	sb (r11+0),r0
     298:	2b 9d 00 04 	lw ra,(sp+4)
     29c:	2b 8b 00 44 	lw r11,(sp+68)
     2a0:	2b 8c 00 40 	lw r12,(sp+64)
     2a4:	2b 8d 00 3c 	lw r13,(sp+60)
     2a8:	2b 8e 00 38 	lw r14,(sp+56)
     2ac:	2b 8f 00 34 	lw r15,(sp+52)
     2b0:	2b 90 00 30 	lw r16,(sp+48)
     2b4:	2b 91 00 2c 	lw r17,(sp+44)
     2b8:	2b 92 00 28 	lw r18,(sp+40)
     2bc:	2b 93 00 24 	lw r19,(sp+36)
     2c0:	2b 94 00 20 	lw r20,(sp+32)
     2c4:	2b 95 00 1c 	lw r21,(sp+28)
     2c8:	2b 96 00 18 	lw r22,(sp+24)
     2cc:	2b 97 00 14 	lw r23,(sp+20)
     2d0:	2b 98 00 10 	lw r24,(sp+16)
     2d4:	2b 99 00 0c 	lw r25,(sp+12)
     2d8:	2b 9b 00 08 	lw fp,(sp+8)
     2dc:	37 9c 00 78 	addi sp,sp,120
     2e0:	c3 a0 00 00 	ret
     2e4:	34 1b 00 00 	mvi fp,0
     2e8:	34 c4 00 01 	addi r4,r6,1
     2ec:	5b 84 00 78 	sw (sp+120),r4
     2f0:	10 c3 00 01 	lb r3,(r6+1)
     2f4:	34 61 ff e0 	addi r1,r3,-32
     2f8:	20 21 00 ff 	andi r1,r1,0xff
     2fc:	54 2d 00 14 	bgu r1,r13,34c <vsnprintf+0x1b0>
     300:	3c 21 00 02 	sli r1,r1,2
     304:	b5 c1 08 00 	add r1,r14,r1
     308:	28 21 00 00 	lw r1,(r1+0)
     30c:	c0 20 00 00 	b r1
     310:	3b 7b 00 01 	ori fp,fp,0x1
     314:	b8 80 30 00 	mv r6,r4
     318:	e3 ff ff f4 	bi 2e8 <vsnprintf+0x14c>
     31c:	3b 7b 00 10 	ori fp,fp,0x10
     320:	b8 80 30 00 	mv r6,r4
     324:	e3 ff ff f1 	bi 2e8 <vsnprintf+0x14c>
     328:	3b 7b 00 04 	ori fp,fp,0x4
     32c:	b8 80 30 00 	mv r6,r4
     330:	e3 ff ff ee 	bi 2e8 <vsnprintf+0x14c>
     334:	3b 7b 00 20 	ori fp,fp,0x20
     338:	b8 80 30 00 	mv r6,r4
     33c:	e3 ff ff eb 	bi 2e8 <vsnprintf+0x14c>
     340:	3b 7b 00 08 	ori fp,fp,0x8
     344:	b8 80 30 00 	mv r6,r4
     348:	e3 ff ff e8 	bi 2e8 <vsnprintf+0x14c>
     34c:	34 61 ff d0 	addi r1,r3,-48
     350:	20 21 00 ff 	andi r1,r1,0xff
     354:	54 33 00 18 	bgu r1,r19,3b4 <vsnprintf+0x218>
     358:	37 81 00 78 	addi r1,sp,120
     35c:	f8 00 06 5e 	calli 1cd4 <skip_atoi>
     360:	2b 84 00 78 	lw r4,(sp+120)
     364:	b8 20 28 00 	mv r5,r1
     368:	34 06 ff ff 	mvi r6,-1
     36c:	10 83 00 00 	lb r3,(r4+0)
     370:	5c 75 00 16 	bne r3,r21,3c8 <vsnprintf+0x22c>
     374:	34 82 00 01 	addi r2,r4,1
     378:	5b 82 00 78 	sw (sp+120),r2
     37c:	10 83 00 01 	lb r3,(r4+1)
     380:	34 61 ff d0 	addi r1,r3,-48
     384:	20 21 00 ff 	andi r1,r1,0xff
     388:	54 33 00 31 	bgu r1,r19,44c <vsnprintf+0x2b0>
     38c:	37 81 00 78 	addi r1,sp,120
     390:	5b 85 00 48 	sw (sp+72),r5
     394:	f8 00 06 50 	calli 1cd4 <skip_atoi>
     398:	2b 84 00 78 	lw r4,(sp+120)
     39c:	2b 85 00 48 	lw r5,(sp+72)
     3a0:	a4 20 10 00 	not r2,r1
     3a4:	14 42 00 1f 	sri r2,r2,31
     3a8:	10 83 00 00 	lb r3,(r4+0)
     3ac:	a0 22 30 00 	and r6,r1,r2
     3b0:	e0 00 00 06 	bi 3c8 <vsnprintf+0x22c>
     3b4:	34 01 00 2a 	mvi r1,42
     3b8:	34 05 ff ff 	mvi r5,-1
     3bc:	44 61 00 41 	be r3,r1,4c0 <vsnprintf+0x324>
     3c0:	34 06 ff ff 	mvi r6,-1
     3c4:	44 75 ff ec 	be r3,r21,374 <vsnprintf+0x1d8>
     3c8:	a0 74 40 00 	and r8,r3,r20
     3cc:	b1 00 40 00 	sextb r8,r8
     3d0:	64 67 00 68 	cmpei r7,r3,104
     3d4:	64 61 00 74 	cmpei r1,r3,116
     3d8:	65 09 00 4c 	cmpei r9,r8,76
     3dc:	b8 e1 08 00 	or r1,r7,r1
     3e0:	65 02 00 5a 	cmpei r2,r8,90
     3e4:	b9 21 08 00 	or r1,r9,r1
     3e8:	b8 41 08 00 	or r1,r2,r1
     3ec:	44 20 01 0d 	be r1,r0,820 <vsnprintf+0x684>
     3f0:	34 81 00 01 	addi r1,r4,1
     3f4:	5b 81 00 78 	sw (sp+120),r1
     3f8:	b8 60 38 00 	mv r7,r3
     3fc:	34 02 00 6c 	mvi r2,108
     400:	10 83 00 01 	lb r3,(r4+1)
     404:	44 e2 00 09 	be r7,r2,428 <vsnprintf+0x28c>
     408:	34 62 ff db 	addi r2,r3,-37
     40c:	34 09 00 53 	mvi r9,83
     410:	20 42 00 ff 	andi r2,r2,0xff
     414:	54 49 00 eb 	bgu r2,r9,7c0 <vsnprintf+0x624>
     418:	3c 42 00 02 	sli r2,r2,2
     41c:	b6 e2 10 00 	add r2,r23,r2
     420:	28 42 00 00 	lw r2,(r2+0)
     424:	c0 40 00 00 	b r2
     428:	44 67 00 3b 	be r3,r7,514 <vsnprintf+0x378>
     42c:	34 62 ff db 	addi r2,r3,-37
     430:	20 42 00 ff 	andi r2,r2,0xff
     434:	34 07 00 53 	mvi r7,83
     438:	54 47 00 e2 	bgu r2,r7,7c0 <vsnprintf+0x624>
     43c:	3c 42 00 02 	sli r2,r2,2
     440:	b7 02 10 00 	add r2,r24,r2
     444:	28 42 00 00 	lw r2,(r2+0)
     448:	c0 40 00 00 	b r2
     44c:	34 01 00 2a 	mvi r1,42
     450:	44 61 00 f6 	be r3,r1,828 <vsnprintf+0x68c>
     454:	b8 40 20 00 	mv r4,r2
     458:	34 06 00 00 	mvi r6,0
     45c:	e3 ff ff db 	bi 3c8 <vsnprintf+0x22c>
     460:	3b 7b 00 40 	ori fp,fp,0x40
     464:	34 04 00 10 	mvi r4,16
     468:	34 01 00 4c 	mvi r1,76
     46c:	44 e1 00 1e 	be r7,r1,4e4 <vsnprintf+0x348>
     470:	34 01 00 6c 	mvi r1,108
     474:	35 e2 00 04 	addi r2,r15,4
     478:	44 e1 00 e1 	be r7,r1,7fc <vsnprintf+0x660>
     47c:	34 01 ff df 	mvi r1,-33
     480:	a0 e1 08 00 	and r1,r7,r1
     484:	34 03 00 5a 	mvi r3,90
     488:	44 23 00 30 	be r1,r3,548 <vsnprintf+0x3ac>
     48c:	34 01 00 74 	mvi r1,116
     490:	44 e1 00 f2 	be r7,r1,858 <vsnprintf+0x6bc>
     494:	34 03 00 68 	mvi r3,104
     498:	23 61 00 02 	andi r1,fp,0x2
     49c:	44 e3 01 2b 	be r7,r3,948 <vsnprintf+0x7ac>
     4a0:	29 e3 00 00 	lw r3,(r15+0)
     4a4:	b8 40 78 00 	mv r15,r2
     4a8:	44 20 00 11 	be r1,r0,4ec <vsnprintf+0x350>
     4ac:	5b 83 00 6c 	sw (sp+108),r3
     4b0:	14 63 00 1f 	sri r3,r3,31
     4b4:	5b 83 00 68 	sw (sp+104),r3
     4b8:	2b 83 00 6c 	lw r3,(sp+108)
     4bc:	e0 00 00 0c 	bi 4ec <vsnprintf+0x350>
     4c0:	29 e5 00 00 	lw r5,(r15+0)
     4c4:	34 c4 00 02 	addi r4,r6,2
     4c8:	5b 84 00 78 	sw (sp+120),r4
     4cc:	35 ef 00 04 	addi r15,r15,4
     4d0:	10 c3 00 02 	lb r3,(r6+2)
     4d4:	48 05 00 24 	bg r0,r5,564 <vsnprintf+0x3c8>
     4d8:	e3 ff ff ba 	bi 3c0 <vsnprintf+0x224>
     4dc:	34 01 00 00 	mvi r1,0
     4e0:	e3 ff ff 6e 	bi 298 <vsnprintf+0xfc>
     4e4:	29 e3 00 04 	lw r3,(r15+4)
     4e8:	35 ef 00 08 	addi r15,r15,8
     4ec:	b9 60 08 00 	mv r1,r11
     4f0:	bb 60 38 00 	mv r7,fp
     4f4:	b9 80 10 00 	mv r2,r12
     4f8:	f8 00 06 0e 	calli 1d30 <number>
     4fc:	b8 20 58 00 	mv r11,r1
     500:	2b 81 00 78 	lw r1,(sp+120)
     504:	34 26 00 01 	addi r6,r1,1
     508:	e3 ff ff 5d 	bi 27c <vsnprintf+0xe0>
     50c:	31 80 ff ff 	sb (r12+-1),r0
     510:	e3 ff ff 62 	bi 298 <vsnprintf+0xfc>
     514:	34 81 00 02 	addi r1,r4,2
     518:	5b 81 00 78 	sw (sp+120),r1
     51c:	10 83 00 02 	lb r3,(r4+2)
     520:	34 07 00 4c 	mvi r7,76
     524:	b8 20 20 00 	mv r4,r1
     528:	34 61 ff db 	addi r1,r3,-37
     52c:	20 21 00 ff 	andi r1,r1,0xff
     530:	34 02 00 53 	mvi r2,83
     534:	54 22 00 a2 	bgu r1,r2,7bc <vsnprintf+0x620>
     538:	3c 21 00 02 	sli r1,r1,2
     53c:	b7 21 08 00 	add r1,r25,r1
     540:	28 21 00 00 	lw r1,(r1+0)
     544:	c0 20 00 00 	b r1
     548:	29 e1 00 00 	lw r1,(r15+0)
     54c:	b8 40 78 00 	mv r15,r2
     550:	5b 81 00 54 	sw (sp+84),r1
     554:	14 21 00 1f 	sri r1,r1,31
     558:	2b 83 00 54 	lw r3,(sp+84)
     55c:	5b 81 00 50 	sw (sp+80),r1
     560:	e3 ff ff e3 	bi 4ec <vsnprintf+0x350>
     564:	c8 05 28 00 	sub r5,r0,r5
     568:	3b 7b 00 10 	ori fp,fp,0x10
     56c:	e3 ff ff 95 	bi 3c0 <vsnprintf+0x224>
     570:	b8 80 08 00 	mv r1,r4
     574:	51 6c ff 40 	bgeu r11,r12,274 <vsnprintf+0xd8>
     578:	34 01 00 25 	mvi r1,37
     57c:	31 61 00 00 	sb (r11+0),r1
     580:	2b 81 00 78 	lw r1,(sp+120)
     584:	e3 ff ff 3c 	bi 274 <vsnprintf+0xd8>
     588:	23 7b 00 10 	andi fp,fp,0x10
     58c:	34 a2 ff ff 	addi r2,r5,-1
     590:	47 60 00 e1 	be fp,r0,914 <vsnprintf+0x778>
     594:	35 e4 00 04 	addi r4,r15,4
     598:	51 6c 00 03 	bgeu r11,r12,5a4 <vsnprintf+0x408>
     59c:	29 e1 00 00 	lw r1,(r15+0)
     5a0:	31 61 00 00 	sb (r11+0),r1
     5a4:	35 63 00 01 	addi r3,r11,1
     5a8:	34 41 00 01 	addi r1,r2,1
     5ac:	b5 61 58 00 	add r11,r11,r1
     5b0:	b8 60 08 00 	mv r1,r3
     5b4:	48 40 00 06 	bg r2,r0,5cc <vsnprintf+0x430>
     5b8:	2b 81 00 78 	lw r1,(sp+120)
     5bc:	b8 80 78 00 	mv r15,r4
     5c0:	b8 60 58 00 	mv r11,r3
     5c4:	34 26 00 01 	addi r6,r1,1
     5c8:	e3 ff ff 2d 	bi 27c <vsnprintf+0xe0>
     5cc:	50 2c 00 02 	bgeu r1,r12,5d4 <vsnprintf+0x438>
     5d0:	30 36 00 00 	sb (r1+0),r22
     5d4:	34 21 00 01 	addi r1,r1,1
     5d8:	5c 2b ff fd 	bne r1,r11,5cc <vsnprintf+0x430>
     5dc:	2b 81 00 78 	lw r1,(sp+120)
     5e0:	b4 62 58 00 	add r11,r3,r2
     5e4:	b8 80 78 00 	mv r15,r4
     5e8:	34 26 00 01 	addi r6,r1,1
     5ec:	e3 ff ff 24 	bi 27c <vsnprintf+0xe0>
     5f0:	34 01 ff ff 	mvi r1,-1
     5f4:	5c a1 00 03 	bne r5,r1,600 <vsnprintf+0x464>
     5f8:	3b 7b 00 01 	ori fp,fp,0x1
     5fc:	34 05 00 08 	mvi r5,8
     600:	29 e3 00 00 	lw r3,(r15+0)
     604:	b9 60 08 00 	mv r1,r11
     608:	bb 60 38 00 	mv r7,fp
     60c:	34 04 00 10 	mvi r4,16
     610:	b9 80 10 00 	mv r2,r12
     614:	f8 00 05 c7 	calli 1d30 <number>
     618:	b8 20 58 00 	mv r11,r1
     61c:	2b 81 00 78 	lw r1,(sp+120)
     620:	35 ef 00 04 	addi r15,r15,4
     624:	34 26 00 01 	addi r6,r1,1
     628:	e3 ff ff 15 	bi 27c <vsnprintf+0xe0>
     62c:	29 e3 00 00 	lw r3,(r15+0)
     630:	35 ef 00 04 	addi r15,r15,4
     634:	44 60 00 b4 	be r3,r0,904 <vsnprintf+0x768>
     638:	b8 60 08 00 	mv r1,r3
     63c:	b8 c0 10 00 	mv r2,r6
     640:	5b 83 00 4c 	sw (sp+76),r3
     644:	5b 85 00 48 	sw (sp+72),r5
     648:	f8 00 03 72 	calli 1410 <strnlen>
     64c:	2b 85 00 48 	lw r5,(sp+72)
     650:	23 7b 00 10 	andi fp,fp,0x10
     654:	2b 83 00 4c 	lw r3,(sp+76)
     658:	34 a4 ff ff 	addi r4,r5,-1
     65c:	47 60 00 86 	be fp,r0,874 <vsnprintf+0x6d8>
     660:	4c 01 00 34 	bge r0,r1,730 <vsnprintf+0x594>
     664:	b5 61 48 00 	add r9,r11,r1
     668:	51 6c 00 31 	bgeu r11,r12,72c <vsnprintf+0x590>
     66c:	b9 20 40 00 	mv r8,r9
     670:	51 89 00 02 	bgeu r12,r9,678 <vsnprintf+0x4dc>
     674:	b9 80 40 00 	mv r8,r12
     678:	35 6a 00 04 	addi r10,r11,4
     67c:	34 7d 00 04 	addi ra,r3,4
     680:	b9 63 30 00 	or r6,r11,r3
     684:	a5 60 10 00 	not r2,r11
     688:	35 67 00 01 	addi r7,r11,1
     68c:	f0 6a 50 00 	cmpgeu r10,r3,r10
     690:	f1 7d e8 00 	cmpgeu ra,r11,ra
     694:	20 c6 00 03 	andi r6,r6,0x3
     698:	b4 48 10 00 	add r2,r2,r8
     69c:	e4 06 30 00 	cmpe r6,r0,r6
     6a0:	74 42 00 08 	cmpgui r2,r2,0x8
     6a4:	f1 07 d8 00 	cmpgeu fp,r8,r7
     6a8:	b9 5d 50 00 	or r10,r10,ra
     6ac:	a0 5b 10 00 	and r2,r2,fp
     6b0:	a0 ca 30 00 	and r6,r6,r10
     6b4:	a0 c2 30 00 	and r6,r6,r2
     6b8:	b9 60 10 00 	mv r2,r11
     6bc:	44 c0 00 21 	be r6,r0,740 <vsnprintf+0x5a4>
     6c0:	34 0a 00 01 	mvi r10,1
     6c4:	54 e8 00 02 	bgu r7,r8,6cc <vsnprintf+0x530>
     6c8:	c9 0b 50 00 	sub r10,r8,r11
     6cc:	01 47 00 02 	srui r7,r10,2
     6d0:	b8 60 30 00 	mv r6,r3
     6d4:	3c e7 00 02 	sli r7,r7,2
     6d8:	b5 67 38 00 	add r7,r11,r7
     6dc:	28 db 00 00 	lw fp,(r6+0)
     6e0:	34 42 00 04 	addi r2,r2,4
     6e4:	34 c6 00 04 	addi r6,r6,4
     6e8:	58 5b ff fc 	sw (r2+-4),fp
     6ec:	5c e2 ff fc 	bne r7,r2,6dc <vsnprintf+0x540>
     6f0:	34 02 ff fc 	mvi r2,-4
     6f4:	a1 42 10 00 	and r2,r10,r2
     6f8:	b5 62 58 00 	add r11,r11,r2
     6fc:	b4 62 18 00 	add r3,r3,r2
     700:	44 4a 00 0b 	be r2,r10,72c <vsnprintf+0x590>
     704:	10 66 00 00 	lb r6,(r3+0)
     708:	35 62 00 01 	addi r2,r11,1
     70c:	31 66 00 00 	sb (r11+0),r6
     710:	50 48 00 07 	bgeu r2,r8,72c <vsnprintf+0x590>
     714:	10 66 00 01 	lb r6,(r3+1)
     718:	35 62 00 02 	addi r2,r11,2
     71c:	31 66 00 01 	sb (r11+1),r6
     720:	50 48 00 03 	bgeu r2,r8,72c <vsnprintf+0x590>
     724:	10 62 00 02 	lb r2,(r3+2)
     728:	31 62 00 02 	sb (r11+2),r2
     72c:	b9 20 58 00 	mv r11,r9
     730:	34 83 00 01 	addi r3,r4,1
     734:	b5 63 18 00 	add r3,r11,r3
     738:	48 a1 00 15 	bg r5,r1,78c <vsnprintf+0x5f0>
     73c:	e3 ff ff 71 	bi 500 <vsnprintf+0x364>
     740:	10 62 00 00 	lb r2,(r3+0)
     744:	35 6b 00 01 	addi r11,r11,1
     748:	34 63 00 01 	addi r3,r3,1
     74c:	31 62 ff ff 	sb (r11+-1),r2
     750:	55 0b ff fc 	bgu r8,r11,740 <vsnprintf+0x5a4>
     754:	e3 ff ff f6 	bi 72c <vsnprintf+0x590>
     758:	34 04 00 0a 	mvi r4,10
     75c:	e3 ff ff 43 	bi 468 <vsnprintf+0x2cc>
     760:	34 04 00 08 	mvi r4,8
     764:	e3 ff ff 41 	bi 468 <vsnprintf+0x2cc>
     768:	3b 7b 00 02 	ori fp,fp,0x2
     76c:	34 04 00 0a 	mvi r4,10
     770:	e3 ff ff 3e 	bi 468 <vsnprintf+0x2cc>
     774:	29 e3 00 00 	lw r3,(r15+0)
     778:	c9 71 10 00 	sub r2,r11,r17
     77c:	35 ef 00 04 	addi r15,r15,4
     780:	34 86 00 02 	addi r6,r4,2
     784:	58 62 00 00 	sw (r3+0),r2
     788:	e3 ff fe bd 	bi 27c <vsnprintf+0xe0>
     78c:	51 6c 00 02 	bgeu r11,r12,794 <vsnprintf+0x5f8>
     790:	31 76 00 00 	sb (r11+0),r22
     794:	35 6b 00 01 	addi r11,r11,1
     798:	c8 6b 10 00 	sub r2,r3,r11
     79c:	48 41 ff fc 	bg r2,r1,78c <vsnprintf+0x5f0>
     7a0:	e3 ff ff 58 	bi 500 <vsnprintf+0x364>
     7a4:	29 e2 00 00 	lw r2,(r15+0)
     7a8:	c9 71 18 00 	sub r3,r11,r17
     7ac:	34 86 00 02 	addi r6,r4,2
     7b0:	58 43 00 00 	sw (r2+0),r3
     7b4:	35 ef 00 04 	addi r15,r15,4
     7b8:	e3 ff fe b1 	bi 27c <vsnprintf+0xe0>
     7bc:	b8 80 08 00 	mv r1,r4
     7c0:	51 6c 00 05 	bgeu r11,r12,7d4 <vsnprintf+0x638>
     7c4:	34 01 00 25 	mvi r1,37
     7c8:	31 61 00 00 	sb (r11+0),r1
     7cc:	2b 81 00 78 	lw r1,(sp+120)
     7d0:	10 23 00 00 	lb r3,(r1+0)
     7d4:	35 62 00 01 	addi r2,r11,1
     7d8:	44 60 00 1c 	be r3,r0,848 <vsnprintf+0x6ac>
     7dc:	50 4c 00 03 	bgeu r2,r12,7e8 <vsnprintf+0x64c>
     7e0:	31 63 00 01 	sb (r11+1),r3
     7e4:	2b 81 00 78 	lw r1,(sp+120)
     7e8:	35 6b 00 02 	addi r11,r11,2
     7ec:	34 26 00 01 	addi r6,r1,1
     7f0:	e3 ff fe a3 	bi 27c <vsnprintf+0xe0>
     7f4:	35 e2 00 04 	addi r2,r15,4
     7f8:	34 04 00 0a 	mvi r4,10
     7fc:	23 61 00 02 	andi r1,fp,0x2
     800:	29 e3 00 00 	lw r3,(r15+0)
     804:	b8 40 78 00 	mv r15,r2
     808:	44 20 ff 39 	be r1,r0,4ec <vsnprintf+0x350>
     80c:	5b 83 00 5c 	sw (sp+92),r3
     810:	14 63 00 1f 	sri r3,r3,31
     814:	5b 83 00 58 	sw (sp+88),r3
     818:	2b 83 00 5c 	lw r3,(sp+92)
     81c:	e3 ff ff 34 	bi 4ec <vsnprintf+0x350>
     820:	34 07 ff ff 	mvi r7,-1
     824:	e3 ff ff 41 	bi 528 <vsnprintf+0x38c>
     828:	34 84 00 02 	addi r4,r4,2
     82c:	29 e1 00 00 	lw r1,(r15+0)
     830:	5b 84 00 78 	sw (sp+120),r4
     834:	35 ef 00 04 	addi r15,r15,4
     838:	e3 ff fe da 	bi 3a0 <vsnprintf+0x204>
     83c:	34 01 00 00 	mvi r1,0
     840:	4c 12 fe 96 	bge r0,r18,298 <vsnprintf+0xfc>
     844:	e3 ff fe 93 	bi 290 <vsnprintf+0xf4>
     848:	b8 20 30 00 	mv r6,r1
     84c:	b8 40 58 00 	mv r11,r2
     850:	34 21 ff ff 	addi r1,r1,-1
     854:	e3 ff fe 8a 	bi 27c <vsnprintf+0xe0>
     858:	29 e1 00 00 	lw r1,(r15+0)
     85c:	b8 40 78 00 	mv r15,r2
     860:	5b 81 00 64 	sw (sp+100),r1
     864:	14 21 00 1f 	sri r1,r1,31
     868:	2b 83 00 64 	lw r3,(sp+100)
     86c:	5b 81 00 60 	sw (sp+96),r1
     870:	e3 ff ff 1f 	bi 4ec <vsnprintf+0x350>
     874:	c8 a1 10 00 	sub r2,r5,r1
     878:	b5 62 10 00 	add r2,r11,r2
     87c:	48 a1 00 05 	bg r5,r1,890 <vsnprintf+0x6f4>
     880:	34 a2 ff fe 	addi r2,r5,-2
     884:	b8 80 28 00 	mv r5,r4
     888:	b8 40 20 00 	mv r4,r2
     88c:	e3 ff ff 75 	bi 660 <vsnprintf+0x4c4>
     890:	51 6c 00 02 	bgeu r11,r12,898 <vsnprintf+0x6fc>
     894:	31 76 00 00 	sb (r11+0),r22
     898:	35 6b 00 01 	addi r11,r11,1
     89c:	5c 4b ff fd 	bne r2,r11,890 <vsnprintf+0x6f4>
     8a0:	c8 25 28 00 	sub r5,r1,r5
     8a4:	b4 a4 28 00 	add r5,r5,r4
     8a8:	34 a4 ff ff 	addi r4,r5,-1
     8ac:	e3 ff ff 6d 	bi 660 <vsnprintf+0x4c4>
     8b0:	3b 7b 00 40 	ori fp,fp,0x40
     8b4:	35 e2 00 04 	addi r2,r15,4
     8b8:	34 04 00 10 	mvi r4,16
     8bc:	e3 ff ff d0 	bi 7fc <vsnprintf+0x660>
     8c0:	3b 7b 00 02 	ori fp,fp,0x2
     8c4:	35 e2 00 04 	addi r2,r15,4
     8c8:	34 04 00 0a 	mvi r4,10
     8cc:	e3 ff ff cc 	bi 7fc <vsnprintf+0x660>
     8d0:	35 e2 00 04 	addi r2,r15,4
     8d4:	34 04 00 08 	mvi r4,8
     8d8:	e3 ff ff c9 	bi 7fc <vsnprintf+0x660>
     8dc:	35 e2 00 04 	addi r2,r15,4
     8e0:	34 04 00 10 	mvi r4,16
     8e4:	e3 ff ff c6 	bi 7fc <vsnprintf+0x660>
     8e8:	29 e3 00 00 	lw r3,(r15+0)
     8ec:	c9 71 10 00 	sub r2,r11,r17
     8f0:	35 ef 00 04 	addi r15,r15,4
     8f4:	34 86 00 01 	addi r6,r4,1
     8f8:	b8 80 08 00 	mv r1,r4
     8fc:	58 62 00 00 	sw (r3+0),r2
     900:	e3 ff fe 5f 	bi 27c <vsnprintf+0xe0>
     904:	78 01 00 00 	mvhi r1,0x0
     908:	38 21 24 44 	ori r1,r1,0x2444
     90c:	28 23 00 00 	lw r3,(r1+0)
     910:	e3 ff ff 4a 	bi 638 <vsnprintf+0x49c>
     914:	b5 62 08 00 	add r1,r11,r2
     918:	48 40 00 06 	bg r2,r0,930 <vsnprintf+0x794>
     91c:	34 a2 ff fe 	addi r2,r5,-2
     920:	35 e4 00 04 	addi r4,r15,4
     924:	55 8b ff 1e 	bgu r12,r11,59c <vsnprintf+0x400>
     928:	35 63 00 01 	addi r3,r11,1
     92c:	e3 ff ff 23 	bi 5b8 <vsnprintf+0x41c>
     930:	51 6c 00 02 	bgeu r11,r12,938 <vsnprintf+0x79c>
     934:	31 76 00 00 	sb (r11+0),r22
     938:	35 6b 00 01 	addi r11,r11,1
     93c:	5d 61 ff fd 	bne r11,r1,930 <vsnprintf+0x794>
     940:	34 02 ff ff 	mvi r2,-1
     944:	e3 ff ff 14 	bi 594 <vsnprintf+0x3f8>
     948:	29 e3 00 00 	lw r3,(r15+0)
     94c:	5c 20 00 04 	bne r1,r0,95c <vsnprintf+0x7c0>
     950:	20 63 ff ff 	andi r3,r3,0xffff
     954:	b8 40 78 00 	mv r15,r2
     958:	e3 ff fe e5 	bi 4ec <vsnprintf+0x350>
     95c:	dc 60 18 00 	sexth r3,r3
     960:	5b 83 00 74 	sw (sp+116),r3
     964:	14 63 00 1f 	sri r3,r3,31
     968:	b8 40 78 00 	mv r15,r2
     96c:	5b 83 00 70 	sw (sp+112),r3
     970:	2b 83 00 74 	lw r3,(sp+116)
     974:	e3 ff fe de 	bi 4ec <vsnprintf+0x350>

00000978 <serial_load_firmware>:
     978:	37 9c ff ec 	addi sp,sp,-20
     97c:	5b 8b 00 14 	sw (sp+20),r11
     980:	5b 8c 00 10 	sw (sp+16),r12
     984:	5b 8d 00 0c 	sw (sp+12),r13
     988:	5b 8e 00 08 	sw (sp+8),r14
     98c:	5b 9d 00 04 	sw (sp+4),ra
     990:	b8 20 68 00 	mv r13,r1
     994:	b8 20 58 00 	mv r11,r1
     998:	34 2c 00 04 	addi r12,r1,4
     99c:	f8 00 00 f2 	calli d64 <uart_read>
     9a0:	31 61 00 00 	sb (r11+0),r1
     9a4:	35 6b 00 01 	addi r11,r11,1
     9a8:	5d 6c ff fd 	bne r11,r12,99c <serial_load_firmware+0x24>
     9ac:	29 a3 00 00 	lw r3,(r13+0)
     9b0:	78 02 00 10 	mvhi r2,0x10
     9b4:	54 62 00 19 	bgu r3,r2,a18 <serial_load_firmware+0xa0>
     9b8:	00 63 00 02 	srui r3,r3,2
     9bc:	34 0e 00 00 	mvi r14,0
     9c0:	44 60 00 0b 	be r3,r0,9ec <serial_load_firmware+0x74>
     9c4:	35 8b ff fc 	addi r11,r12,-4
     9c8:	f8 00 00 e7 	calli d64 <uart_read>
     9cc:	31 61 00 08 	sb (r11+8),r1
     9d0:	35 6b 00 01 	addi r11,r11,1
     9d4:	5d 6c ff fd 	bne r11,r12,9c8 <serial_load_firmware+0x50>
     9d8:	29 a1 00 00 	lw r1,(r13+0)
     9dc:	35 ce 00 01 	addi r14,r14,1
     9e0:	35 8c 00 04 	addi r12,r12,4
     9e4:	00 21 00 02 	srui r1,r1,2
     9e8:	54 2e ff f7 	bgu r1,r14,9c4 <serial_load_firmware+0x4c>
     9ec:	78 02 00 00 	mvhi r2,0x0
     9f0:	38 42 2a d0 	ori r2,r2,0x2ad0
     9f4:	28 41 00 00 	lw r1,(r2+0)
     9f8:	f8 00 01 db 	calli 1164 <printf>
     9fc:	2b 9d 00 04 	lw ra,(sp+4)
     a00:	2b 8b 00 14 	lw r11,(sp+20)
     a04:	2b 8c 00 10 	lw r12,(sp+16)
     a08:	2b 8d 00 0c 	lw r13,(sp+12)
     a0c:	2b 8e 00 08 	lw r14,(sp+8)
     a10:	37 9c 00 14 	addi sp,sp,20
     a14:	c3 a0 00 00 	ret
     a18:	78 04 00 00 	mvhi r4,0x0
     a1c:	38 84 2a d4 	ori r4,r4,0x2ad4
     a20:	28 81 00 00 	lw r1,(r4+0)
     a24:	f8 00 01 d0 	calli 1164 <printf>
     a28:	34 01 00 01 	mvi r1,1
     a2c:	f8 00 01 37 	calli f08 <uart_force_sync>
     a30:	34 01 00 00 	mvi r1,0
     a34:	d0 01 00 00 	wcsr IE,r1
     a38:	e0 00 00 00 	bi a38 <serial_load_firmware+0xc0>

00000a3c <main>:
     a3c:	78 0a ff ef 	mvhi r10,0xffef
     a40:	39 4a ff e4 	ori r10,r10,0xffe4
     a44:	b7 8a e0 00 	add sp,sp,r10
     a48:	5b 8b 00 14 	sw (sp+20),r11
     a4c:	5b 8c 00 10 	sw (sp+16),r12
     a50:	5b 8d 00 0c 	sw (sp+12),r13
     a54:	5b 8e 00 08 	sw (sp+8),r14
     a58:	5b 9d 00 04 	sw (sp+4),ra
     a5c:	34 01 00 01 	mvi r1,1
     a60:	38 02 10 04 	mvu r2,0x1004
     a64:	78 42 30 00 	orhi r2,r2,0x3000
     a68:	58 41 00 00 	sw (r2+0),r1
     a6c:	34 02 00 00 	mvi r2,0
     a70:	d0 22 00 00 	wcsr IM,r2
     a74:	d0 01 00 00 	wcsr IE,r1
     a78:	f8 00 01 04 	calli e88 <uart_init>
     a7c:	78 02 00 00 	mvhi r2,0x0
     a80:	38 42 2a d8 	ori r2,r2,0x2ad8
     a84:	28 41 00 00 	lw r1,(r2+0)
     a88:	38 0b 4b 40 	mvu r11,0x4b40
     a8c:	79 6b 00 4c 	orhi r11,r11,0x4c
     a90:	38 0c 10 50 	mvu r12,0x1050
     a94:	79 8c 30 00 	orhi r12,r12,0x3000
     a98:	f8 00 01 b3 	calli 1164 <printf>
     a9c:	78 05 00 00 	mvhi r5,0x0
     aa0:	38 a5 2a dc 	ori r5,r5,0x2adc
     aa4:	28 a1 00 00 	lw r1,(r5+0)
     aa8:	34 02 00 05 	mvi r2,5
     aac:	f8 00 01 ae 	calli 1164 <printf>
     ab0:	29 8d 00 00 	lw r13,(r12+0)
     ab4:	f8 00 00 c0 	calli db4 <uart_read_nonblock>
     ab8:	5c 20 00 0d 	bne r1,r0,aec <main+0xb0>
     abc:	29 81 00 00 	lw r1,(r12+0)
     ac0:	b5 6d 58 00 	add r11,r11,r13
     ac4:	c9 61 58 00 	sub r11,r11,r1
     ac8:	4d 60 ff fa 	bge r11,r0,ab0 <main+0x74>
     acc:	78 02 00 00 	mvhi r2,0x0
     ad0:	38 42 2a e0 	ori r2,r2,0x2ae0
     ad4:	28 41 00 00 	lw r1,(r2+0)
     ad8:	78 0d 10 10 	mvhi r13,0x1010
     adc:	f8 00 01 a2 	calli 1164 <printf>
     ae0:	38 01 ff ff 	mvu r1,0xffff
     ae4:	78 21 00 03 	orhi r1,r1,0x3
     ae8:	e0 00 00 18 	bi b48 <main+0x10c>
     aec:	f8 00 00 9e 	calli d64 <uart_read>
     af0:	34 02 00 11 	mvi r2,17
     af4:	44 22 00 30 	be r1,r2,bb4 <main+0x178>
     af8:	34 02 00 22 	mvi r2,34
     afc:	5c 22 00 28 	bne r1,r2,b9c <main+0x160>
     b00:	78 05 00 00 	mvhi r5,0x0
     b04:	38 a5 2a f4 	ori r5,r5,0x2af4
     b08:	28 a1 00 00 	lw r1,(r5+0)
     b0c:	78 02 00 10 	mvhi r2,0x10
     b10:	38 42 00 20 	ori r2,r2,0x20
     b14:	b7 82 68 00 	add r13,sp,r2
     b18:	38 0b ff f8 	mvu r11,0xfff8
     b1c:	79 6b ff ef 	orhi r11,r11,0xffef
     b20:	f8 00 01 91 	calli 1164 <printf>
     b24:	b5 ab 58 00 	add r11,r13,r11
     b28:	b9 60 08 00 	mv r1,r11
     b2c:	fb ff ff 93 	calli 978 <serial_load_firmware>
     b30:	29 6e 00 00 	lw r14,(r11+0)
     b34:	01 ce 00 02 	srui r14,r14,2
     b38:	35 c1 ff ff 	addi r1,r14,-1
     b3c:	45 c0 00 11 	be r14,r0,b80 <main+0x144>
     b40:	78 02 ff f0 	mvhi r2,0xfff0
     b44:	b5 a2 68 00 	add r13,r13,r2
     b48:	38 02 00 01 	mvu r2,0x1
     b4c:	78 42 08 00 	orhi r2,r2,0x800
     b50:	b4 22 08 00 	add r1,r1,r2
     b54:	3c 22 00 02 	sli r2,r1,2
     b58:	38 05 ff fc 	mvu r5,0xfffc
     b5c:	78 a5 df ff 	orhi r5,r5,0xdfff
     b60:	78 01 20 00 	mvhi r1,0x2000
     b64:	34 24 00 04 	addi r4,r1,4
     b68:	b4 85 18 00 	add r3,r4,r5
     b6c:	b5 a3 18 00 	add r3,r13,r3
     b70:	28 63 00 00 	lw r3,(r3+0)
     b74:	58 23 00 00 	sw (r1+0),r3
     b78:	b8 80 08 00 	mv r1,r4
     b7c:	5c 82 ff fa 	bne r4,r2,b64 <main+0x128>
     b80:	34 01 00 01 	mvi r1,1
     b84:	f8 00 00 e1 	calli f08 <uart_force_sync>
     b88:	34 01 00 00 	mvi r1,0
     b8c:	d0 01 00 00 	wcsr IE,r1
     b90:	d0 21 00 00 	wcsr IM,r1
     b94:	78 01 20 00 	mvhi r1,0x2000
     b98:	c0 20 00 00 	b r1
     b9c:	44 20 ff cc 	be r1,r0,acc <main+0x90>
     ba0:	78 05 00 00 	mvhi r5,0x0
     ba4:	38 a5 2a f8 	ori r5,r5,0x2af8
     ba8:	28 a1 00 00 	lw r1,(r5+0)
     bac:	f8 00 01 6e 	calli 1164 <printf>
     bb0:	e0 00 00 00 	bi bb0 <main+0x174>
     bb4:	78 05 00 00 	mvhi r5,0x0
     bb8:	38 a5 2a e4 	ori r5,r5,0x2ae4
     bbc:	28 a1 00 00 	lw r1,(r5+0)
     bc0:	78 02 00 10 	mvhi r2,0x10
     bc4:	38 42 00 20 	ori r2,r2,0x20
     bc8:	b7 82 68 00 	add r13,sp,r2
     bcc:	38 0c ff f8 	mvu r12,0xfff8
     bd0:	79 8c ff ef 	orhi r12,r12,0xffef
     bd4:	f8 00 01 64 	calli 1164 <printf>
     bd8:	b5 ac 60 00 	add r12,r13,r12
     bdc:	b9 80 08 00 	mv r1,r12
     be0:	fb ff ff 66 	calli 978 <serial_load_firmware>
     be4:	78 05 00 00 	mvhi r5,0x0
     be8:	38 a5 2a e8 	ori r5,r5,0x2ae8
     bec:	28 a1 00 00 	lw r1,(r5+0)
     bf0:	29 8e 00 00 	lw r14,(r12+0)
     bf4:	78 0b 10 10 	mvhi r11,0x1010
     bf8:	f8 00 01 5b 	calli 1164 <printf>
     bfc:	29 82 00 00 	lw r2,(r12+0)
     c00:	35 81 00 08 	addi r1,r12,8
     c04:	b9 60 18 00 	mv r3,r11
     c08:	f8 00 05 97 	calli 2264 <flash_write_data>
     c0c:	29 81 00 00 	lw r1,(r12+0)
     c10:	00 21 00 02 	srui r1,r1,2
     c14:	44 20 00 12 	be r1,r0,c5c <main+0x220>
     c18:	29 64 00 00 	lw r4,(r11+0)
     c1c:	29 83 00 08 	lw r3,(r12+8)
     c20:	5c 83 00 14 	bne r4,r3,c70 <main+0x234>
     c24:	78 02 04 04 	mvhi r2,0x404
     c28:	b4 22 08 00 	add r1,r1,r2
     c2c:	3c 21 00 02 	sli r1,r1,2
     c30:	b9 60 10 00 	mv r2,r11
     c34:	38 05 00 08 	mvu r5,0x8
     c38:	78 a5 ef f0 	orhi r5,r5,0xeff0
     c3c:	e0 00 00 06 	bi c54 <main+0x218>
     c40:	b4 45 18 00 	add r3,r2,r5
     c44:	b5 83 18 00 	add r3,r12,r3
     c48:	28 44 00 00 	lw r4,(r2+0)
     c4c:	28 63 00 00 	lw r3,(r3+0)
     c50:	5c 83 00 09 	bne r4,r3,c74 <main+0x238>
     c54:	34 42 00 04 	addi r2,r2,4
     c58:	5c 22 ff fa 	bne r1,r2,c40 <main+0x204>
     c5c:	78 02 00 00 	mvhi r2,0x0
     c60:	38 42 2a f0 	ori r2,r2,0x2af0
     c64:	28 41 00 00 	lw r1,(r2+0)
     c68:	f8 00 01 3f 	calli 1164 <printf>
     c6c:	e3 ff ff b2 	bi b34 <main+0xf8>
     c70:	b9 60 10 00 	mv r2,r11
     c74:	78 05 00 00 	mvhi r5,0x0
     c78:	38 a5 2a ec 	ori r5,r5,0x2aec
     c7c:	28 a1 00 00 	lw r1,(r5+0)
     c80:	f8 00 01 39 	calli 1164 <printf>
     c84:	e0 00 00 00 	bi c84 <main+0x248>

00000c88 <uart_isr>:
     c88:	38 02 00 08 	mvu r2,0x8
     c8c:	78 42 30 00 	orhi r2,r2,0x3000
     c90:	28 41 00 00 	lw r1,(r2+0)
     c94:	58 41 00 00 	sw (r2+0),r1
     c98:	20 22 00 02 	andi r2,r1,0x2
     c9c:	44 40 00 10 	be r2,r0,cdc <uart_isr+0x54>
     ca0:	78 02 00 00 	mvhi r2,0x0
     ca4:	38 42 2a fc 	ori r2,r2,0x2afc
     ca8:	28 43 00 00 	lw r3,(r2+0)
     cac:	78 07 00 00 	mvhi r7,0x0
     cb0:	78 02 30 00 	mvhi r2,0x3000
     cb4:	28 45 00 00 	lw r5,(r2+0)
     cb8:	38 e7 2b 00 	ori r7,r7,0x2b00
     cbc:	28 66 00 00 	lw r6,(r3+0)
     cc0:	28 62 00 00 	lw r2,(r3+0)
     cc4:	28 e4 00 00 	lw r4,(r7+0)
     cc8:	34 42 00 01 	addi r2,r2,1
     ccc:	b4 86 20 00 	add r4,r4,r6
     cd0:	20 42 0f ff 	andi r2,r2,0xfff
     cd4:	30 85 00 00 	sb (r4+0),r5
     cd8:	58 62 00 00 	sw (r3+0),r2
     cdc:	20 21 00 04 	andi r1,r1,0x4
     ce0:	44 20 00 16 	be r1,r0,d38 <uart_isr+0xb0>
     ce4:	78 01 00 00 	mvhi r1,0x0
     ce8:	78 04 00 00 	mvhi r4,0x0
     cec:	38 21 2b 04 	ori r1,r1,0x2b04
     cf0:	38 84 2b 08 	ori r4,r4,0x2b08
     cf4:	28 22 00 00 	lw r2,(r1+0)
     cf8:	28 83 00 00 	lw r3,(r4+0)
     cfc:	28 41 00 00 	lw r1,(r2+0)
     d00:	28 63 00 00 	lw r3,(r3+0)
     d04:	44 61 00 10 	be r3,r1,d44 <uart_isr+0xbc>
     d08:	78 05 00 00 	mvhi r5,0x0
     d0c:	38 a5 2b 0c 	ori r5,r5,0x2b0c
     d10:	28 a4 00 00 	lw r4,(r5+0)
     d14:	34 23 00 01 	addi r3,r1,1
     d18:	b4 81 08 00 	add r1,r4,r1
     d1c:	10 24 00 00 	lb r4,(r1+0)
     d20:	38 01 ff ff 	mvu r1,0xffff
     d24:	78 21 00 01 	orhi r1,r1,0x1
     d28:	a0 61 08 00 	and r1,r3,r1
     d2c:	78 03 30 00 	mvhi r3,0x3000
     d30:	58 64 00 00 	sw (r3+0),r4
     d34:	58 41 00 00 	sw (r2+0),r1
     d38:	34 01 00 01 	mvi r1,1
     d3c:	d0 41 00 00 	wcsr IP,r1
     d40:	c3 a0 00 00 	ret
     d44:	78 07 00 00 	mvhi r7,0x0
     d48:	38 e7 2b 10 	ori r7,r7,0x2b10
     d4c:	28 e1 00 00 	lw r1,(r7+0)
     d50:	34 02 00 01 	mvi r2,1
     d54:	58 22 00 00 	sw (r1+0),r2
     d58:	34 01 00 01 	mvi r1,1
     d5c:	d0 41 00 00 	wcsr IP,r1
     d60:	c3 a0 00 00 	ret

00000d64 <uart_read>:
     d64:	78 01 00 00 	mvhi r1,0x0
     d68:	78 05 00 00 	mvhi r5,0x0
     d6c:	38 21 2b 14 	ori r1,r1,0x2b14
     d70:	38 a5 2b 18 	ori r5,r5,0x2b18
     d74:	28 23 00 00 	lw r3,(r1+0)
     d78:	28 a4 00 00 	lw r4,(r5+0)
     d7c:	28 62 00 00 	lw r2,(r3+0)
     d80:	28 81 00 00 	lw r1,(r4+0)
     d84:	44 41 ff fe 	be r2,r1,d7c <uart_read+0x18>
     d88:	78 05 00 00 	mvhi r5,0x0
     d8c:	28 64 00 00 	lw r4,(r3+0)
     d90:	38 a5 2b 1c 	ori r5,r5,0x2b1c
     d94:	28 61 00 00 	lw r1,(r3+0)
     d98:	28 a2 00 00 	lw r2,(r5+0)
     d9c:	34 21 00 01 	addi r1,r1,1
     da0:	b4 44 10 00 	add r2,r2,r4
     da4:	20 21 0f ff 	andi r1,r1,0xfff
     da8:	58 61 00 00 	sw (r3+0),r1
     dac:	10 41 00 00 	lb r1,(r2+0)
     db0:	c3 a0 00 00 	ret

00000db4 <uart_read_nonblock>:
     db4:	78 02 00 00 	mvhi r2,0x0
     db8:	38 42 2b 20 	ori r2,r2,0x2b20
     dbc:	28 41 00 00 	lw r1,(r2+0)
     dc0:	78 03 00 00 	mvhi r3,0x0
     dc4:	38 63 2b 24 	ori r3,r3,0x2b24
     dc8:	28 22 00 00 	lw r2,(r1+0)
     dcc:	28 61 00 00 	lw r1,(r3+0)
     dd0:	28 21 00 00 	lw r1,(r1+0)
     dd4:	fc 41 08 00 	cmpne r1,r2,r1
     dd8:	c3 a0 00 00 	ret

00000ddc <uart_write>:
     ddc:	b0 20 08 00 	sextb r1,r1
     de0:	90 20 18 00 	rcsr r3,IM
     de4:	34 02 00 00 	mvi r2,0
     de8:	d0 22 00 00 	wcsr IM,r2
     dec:	78 04 00 00 	mvhi r4,0x0
     df0:	38 84 2b 28 	ori r4,r4,0x2b28
     df4:	28 82 00 00 	lw r2,(r4+0)
     df8:	28 42 00 00 	lw r2,(r2+0)
     dfc:	44 40 00 09 	be r2,r0,e20 <uart_write+0x44>
     e00:	78 02 30 00 	mvhi r2,0x3000
     e04:	58 41 00 00 	sw (r2+0),r1
     e08:	34 42 00 08 	addi r2,r2,8
     e0c:	28 41 00 00 	lw r1,(r2+0)
     e10:	20 21 00 01 	andi r1,r1,0x1
     e14:	44 20 ff fe 	be r1,r0,e0c <uart_write+0x30>
     e18:	d0 23 00 00 	wcsr IM,r3
     e1c:	c3 a0 00 00 	ret
     e20:	78 07 00 00 	mvhi r7,0x0
     e24:	38 e7 2b 2c 	ori r7,r7,0x2b2c
     e28:	28 e2 00 00 	lw r2,(r7+0)
     e2c:	28 44 00 00 	lw r4,(r2+0)
     e30:	44 80 00 06 	be r4,r0,e48 <uart_write+0x6c>
     e34:	58 40 00 00 	sw (r2+0),r0
     e38:	78 02 30 00 	mvhi r2,0x3000
     e3c:	58 41 00 00 	sw (r2+0),r1
     e40:	d0 23 00 00 	wcsr IM,r3
     e44:	c3 a0 00 00 	ret
     e48:	78 02 00 00 	mvhi r2,0x0
     e4c:	38 42 2b 30 	ori r2,r2,0x2b30
     e50:	28 45 00 00 	lw r5,(r2+0)
     e54:	78 07 00 00 	mvhi r7,0x0
     e58:	38 e7 2b 34 	ori r7,r7,0x2b34
     e5c:	28 a6 00 00 	lw r6,(r5+0)
     e60:	28 e4 00 00 	lw r4,(r7+0)
     e64:	34 c2 00 01 	addi r2,r6,1
     e68:	b4 86 20 00 	add r4,r4,r6
     e6c:	38 06 ff ff 	mvu r6,0xffff
     e70:	78 c6 00 01 	orhi r6,r6,0x1
     e74:	a0 46 10 00 	and r2,r2,r6
     e78:	30 81 00 00 	sb (r4+0),r1
     e7c:	58 a2 00 00 	sw (r5+0),r2
     e80:	d0 23 00 00 	wcsr IM,r3
     e84:	c3 a0 00 00 	ret

00000e88 <uart_init>:
     e88:	78 02 00 00 	mvhi r2,0x0
     e8c:	38 42 2b 38 	ori r2,r2,0x2b38
     e90:	28 41 00 00 	lw r1,(r2+0)
     e94:	78 03 00 00 	mvhi r3,0x0
     e98:	38 63 2b 3c 	ori r3,r3,0x2b3c
     e9c:	58 20 00 00 	sw (r1+0),r0
     ea0:	28 61 00 00 	lw r1,(r3+0)
     ea4:	78 03 00 00 	mvhi r3,0x0
     ea8:	38 63 2b 40 	ori r3,r3,0x2b40
     eac:	28 62 00 00 	lw r2,(r3+0)
     eb0:	78 03 00 00 	mvhi r3,0x0
     eb4:	38 63 2b 44 	ori r3,r3,0x2b44
     eb8:	58 40 00 00 	sw (r2+0),r0
     ebc:	28 62 00 00 	lw r2,(r3+0)
     ec0:	78 03 00 00 	mvhi r3,0x0
     ec4:	38 63 2b 48 	ori r3,r3,0x2b48
     ec8:	58 40 00 00 	sw (r2+0),r0
     ecc:	28 62 00 00 	lw r2,(r3+0)
     ed0:	58 20 00 00 	sw (r1+0),r0
     ed4:	34 01 00 01 	mvi r1,1
     ed8:	58 41 00 00 	sw (r2+0),r1
     edc:	d0 41 00 00 	wcsr IP,r1
     ee0:	38 01 00 08 	mvu r1,0x8
     ee4:	78 21 30 00 	orhi r1,r1,0x3000
     ee8:	28 22 00 00 	lw r2,(r1+0)
     eec:	58 22 00 00 	sw (r1+0),r2
     ef0:	34 02 00 03 	mvi r2,3
     ef4:	58 22 00 04 	sw (r1+4),r2
     ef8:	90 20 08 00 	rcsr r1,IM
     efc:	38 21 00 01 	ori r1,r1,0x1
     f00:	d0 21 00 00 	wcsr IM,r1
     f04:	c3 a0 00 00 	ret

00000f08 <uart_force_sync>:
     f08:	44 20 00 06 	be r1,r0,f20 <uart_force_sync+0x18>
     f0c:	78 02 00 00 	mvhi r2,0x0
     f10:	38 42 2b 4c 	ori r2,r2,0x2b4c
     f14:	28 43 00 00 	lw r3,(r2+0)
     f18:	28 62 00 00 	lw r2,(r3+0)
     f1c:	44 40 ff ff 	be r2,r0,f18 <uart_force_sync+0x10>
     f20:	78 03 00 00 	mvhi r3,0x0
     f24:	38 63 2b 50 	ori r3,r3,0x2b50
     f28:	28 62 00 00 	lw r2,(r3+0)
     f2c:	58 41 00 00 	sw (r2+0),r1
     f30:	c3 a0 00 00 	ret

00000f34 <console_set_write_hook>:
     f34:	78 03 00 00 	mvhi r3,0x0
     f38:	38 63 2b 54 	ori r3,r3,0x2b54
     f3c:	28 62 00 00 	lw r2,(r3+0)
     f40:	58 41 00 00 	sw (r2+0),r1
     f44:	c3 a0 00 00 	ret

00000f48 <console_set_read_hook>:
     f48:	78 04 00 00 	mvhi r4,0x0
     f4c:	38 84 2b 58 	ori r4,r4,0x2b58
     f50:	28 83 00 00 	lw r3,(r4+0)
     f54:	58 61 00 00 	sw (r3+0),r1
     f58:	78 03 00 00 	mvhi r3,0x0
     f5c:	38 63 2b 5c 	ori r3,r3,0x2b5c
     f60:	28 61 00 00 	lw r1,(r3+0)
     f64:	58 22 00 00 	sw (r1+0),r2
     f68:	c3 a0 00 00 	ret

00000f6c <readchar>:
     f6c:	37 9c ff f8 	addi sp,sp,-8
     f70:	5b 8b 00 08 	sw (sp+8),r11
     f74:	5b 9d 00 04 	sw (sp+4),ra
     f78:	78 01 00 00 	mvhi r1,0x0
     f7c:	38 21 2b 60 	ori r1,r1,0x2b60
     f80:	28 2b 00 00 	lw r11,(r1+0)
     f84:	e0 00 00 03 	bi f90 <readchar+0x24>
     f88:	29 61 00 00 	lw r1,(r11+0)
     f8c:	5c 20 00 08 	bne r1,r0,fac <readchar+0x40>
     f90:	fb ff ff 89 	calli db4 <uart_read_nonblock>
     f94:	44 20 ff fd 	be r1,r0,f88 <readchar+0x1c>
     f98:	fb ff ff 73 	calli d64 <uart_read>
     f9c:	2b 9d 00 04 	lw ra,(sp+4)
     fa0:	2b 8b 00 08 	lw r11,(sp+8)
     fa4:	37 9c 00 08 	addi sp,sp,8
     fa8:	c3 a0 00 00 	ret
     fac:	d8 20 00 00 	call r1
     fb0:	44 20 ff f8 	be r1,r0,f90 <readchar+0x24>
     fb4:	78 02 00 00 	mvhi r2,0x0
     fb8:	38 42 2b 64 	ori r2,r2,0x2b64
     fbc:	28 41 00 00 	lw r1,(r2+0)
     fc0:	28 21 00 00 	lw r1,(r1+0)
     fc4:	d8 20 00 00 	call r1
     fc8:	e3 ff ff f5 	bi f9c <readchar+0x30>

00000fcc <readchar_nonblock>:
     fcc:	37 9c ff fc 	addi sp,sp,-4
     fd0:	5b 9d 00 04 	sw (sp+4),ra
     fd4:	fb ff ff 78 	calli db4 <uart_read_nonblock>
     fd8:	5c 20 00 0b 	bne r1,r0,1004 <readchar_nonblock+0x38>
     fdc:	78 03 00 00 	mvhi r3,0x0
     fe0:	38 63 2b 68 	ori r3,r3,0x2b68
     fe4:	28 62 00 00 	lw r2,(r3+0)
     fe8:	28 42 00 00 	lw r2,(r2+0)
     fec:	44 40 00 03 	be r2,r0,ff8 <readchar_nonblock+0x2c>
     ff0:	d8 40 00 00 	call r2
     ff4:	fc 01 08 00 	cmpne r1,r0,r1
     ff8:	2b 9d 00 04 	lw ra,(sp+4)
     ffc:	37 9c 00 04 	addi sp,sp,4
    1000:	c3 a0 00 00 	ret
    1004:	34 01 00 01 	mvi r1,1
    1008:	2b 9d 00 04 	lw ra,(sp+4)
    100c:	37 9c 00 04 	addi sp,sp,4
    1010:	c3 a0 00 00 	ret

00001014 <puts>:
    1014:	37 9c ff ec 	addi sp,sp,-20
    1018:	5b 8b 00 14 	sw (sp+20),r11
    101c:	5b 8c 00 10 	sw (sp+16),r12
    1020:	5b 8d 00 0c 	sw (sp+12),r13
    1024:	5b 8e 00 08 	sw (sp+8),r14
    1028:	5b 9d 00 04 	sw (sp+4),ra
    102c:	b8 20 60 00 	mv r12,r1
    1030:	90 20 70 00 	rcsr r14,IM
    1034:	34 01 00 01 	mvi r1,1
    1038:	d0 21 00 00 	wcsr IM,r1
    103c:	11 8b 00 00 	lb r11,(r12+0)
    1040:	78 01 00 00 	mvhi r1,0x0
    1044:	38 21 2b 6c 	ori r1,r1,0x2b6c
    1048:	28 2d 00 00 	lw r13,(r1+0)
    104c:	45 60 00 0a 	be r11,r0,1074 <puts+0x60>
    1050:	b9 60 08 00 	mv r1,r11
    1054:	fb ff ff 62 	calli ddc <uart_write>
    1058:	29 a2 00 00 	lw r2,(r13+0)
    105c:	b9 60 08 00 	mv r1,r11
    1060:	35 8c 00 01 	addi r12,r12,1
    1064:	44 40 00 13 	be r2,r0,10b0 <puts+0x9c>
    1068:	d8 40 00 00 	call r2
    106c:	11 8b 00 00 	lb r11,(r12+0)
    1070:	5d 60 ff f8 	bne r11,r0,1050 <puts+0x3c>
    1074:	34 01 00 0a 	mvi r1,10
    1078:	fb ff ff 59 	calli ddc <uart_write>
    107c:	29 a2 00 00 	lw r2,(r13+0)
    1080:	44 40 00 03 	be r2,r0,108c <puts+0x78>
    1084:	34 01 00 0a 	mvi r1,10
    1088:	d8 40 00 00 	call r2
    108c:	d0 2e 00 00 	wcsr IM,r14
    1090:	34 01 00 01 	mvi r1,1
    1094:	2b 9d 00 04 	lw ra,(sp+4)
    1098:	2b 8b 00 14 	lw r11,(sp+20)
    109c:	2b 8c 00 10 	lw r12,(sp+16)
    10a0:	2b 8d 00 0c 	lw r13,(sp+12)
    10a4:	2b 8e 00 08 	lw r14,(sp+8)
    10a8:	37 9c 00 14 	addi sp,sp,20
    10ac:	c3 a0 00 00 	ret
    10b0:	11 8b 00 00 	lb r11,(r12+0)
    10b4:	5d 60 ff e7 	bne r11,r0,1050 <puts+0x3c>
    10b8:	e3 ff ff ef 	bi 1074 <puts+0x60>

000010bc <putsnonl>:
    10bc:	37 9c ff ec 	addi sp,sp,-20
    10c0:	5b 8b 00 14 	sw (sp+20),r11
    10c4:	5b 8c 00 10 	sw (sp+16),r12
    10c8:	5b 8d 00 0c 	sw (sp+12),r13
    10cc:	5b 8e 00 08 	sw (sp+8),r14
    10d0:	5b 9d 00 04 	sw (sp+4),ra
    10d4:	b8 20 60 00 	mv r12,r1
    10d8:	90 20 70 00 	rcsr r14,IM
    10dc:	34 01 00 01 	mvi r1,1
    10e0:	d0 21 00 00 	wcsr IM,r1
    10e4:	11 8b 00 00 	lb r11,(r12+0)
    10e8:	78 01 00 00 	mvhi r1,0x0
    10ec:	38 21 2b 70 	ori r1,r1,0x2b70
    10f0:	28 2d 00 00 	lw r13,(r1+0)
    10f4:	45 60 00 0a 	be r11,r0,111c <putsnonl+0x60>
    10f8:	b9 60 08 00 	mv r1,r11
    10fc:	fb ff ff 38 	calli ddc <uart_write>
    1100:	29 a2 00 00 	lw r2,(r13+0)
    1104:	b9 60 08 00 	mv r1,r11
    1108:	35 8c 00 01 	addi r12,r12,1
    110c:	44 40 00 0c 	be r2,r0,113c <putsnonl+0x80>
    1110:	d8 40 00 00 	call r2
    1114:	11 8b 00 00 	lb r11,(r12+0)
    1118:	5d 60 ff f8 	bne r11,r0,10f8 <putsnonl+0x3c>
    111c:	d0 2e 00 00 	wcsr IM,r14
    1120:	2b 9d 00 04 	lw ra,(sp+4)
    1124:	2b 8b 00 14 	lw r11,(sp+20)
    1128:	2b 8c 00 10 	lw r12,(sp+16)
    112c:	2b 8d 00 0c 	lw r13,(sp+12)
    1130:	2b 8e 00 08 	lw r14,(sp+8)
    1134:	37 9c 00 14 	addi sp,sp,20
    1138:	c3 a0 00 00 	ret
    113c:	11 8b 00 00 	lb r11,(r12+0)
    1140:	5d 60 ff ee 	bne r11,r0,10f8 <putsnonl+0x3c>
    1144:	d0 2e 00 00 	wcsr IM,r14
    1148:	2b 9d 00 04 	lw ra,(sp+4)
    114c:	2b 8b 00 14 	lw r11,(sp+20)
    1150:	2b 8c 00 10 	lw r12,(sp+16)
    1154:	2b 8d 00 0c 	lw r13,(sp+12)
    1158:	2b 8e 00 08 	lw r14,(sp+8)
    115c:	37 9c 00 14 	addi sp,sp,20
    1160:	c3 a0 00 00 	ret

00001164 <printf>:
    1164:	37 9c fe c8 	addi sp,sp,-312
    1168:	5b 8b 00 18 	sw (sp+24),r11
    116c:	5b 8c 00 14 	sw (sp+20),r12
    1170:	5b 8d 00 10 	sw (sp+16),r13
    1174:	5b 8e 00 0c 	sw (sp+12),r14
    1178:	5b 8f 00 08 	sw (sp+8),r15
    117c:	5b 9d 00 04 	sw (sp+4),ra
    1180:	5b 81 01 1c 	sw (sp+284),r1
    1184:	5b 83 01 24 	sw (sp+292),r3
    1188:	5b 82 01 20 	sw (sp+288),r2
    118c:	b8 20 18 00 	mv r3,r1
    1190:	5b 84 01 28 	sw (sp+296),r4
    1194:	34 02 01 00 	mvi r2,256
    1198:	37 84 01 20 	addi r4,sp,288
    119c:	37 81 00 1c 	addi r1,sp,28
    11a0:	5b 85 01 2c 	sw (sp+300),r5
    11a4:	5b 86 01 30 	sw (sp+304),r6
    11a8:	5b 87 01 34 	sw (sp+308),r7
    11ac:	5b 88 01 38 	sw (sp+312),r8
    11b0:	f8 00 03 a7 	calli 204c <vscnprintf>
    11b4:	37 82 00 1c 	addi r2,sp,28
    11b8:	b8 20 68 00 	mv r13,r1
    11bc:	b4 41 08 00 	add r1,r2,r1
    11c0:	30 20 00 00 	sb (r1+0),r0
    11c4:	90 20 70 00 	rcsr r14,IM
    11c8:	34 01 00 01 	mvi r1,1
    11cc:	d0 21 00 00 	wcsr IM,r1
    11d0:	13 8c 00 1c 	lb r12,(sp+28)
    11d4:	78 01 00 00 	mvhi r1,0x0
    11d8:	38 21 2b 74 	ori r1,r1,0x2b74
    11dc:	b8 40 58 00 	mv r11,r2
    11e0:	28 2f 00 00 	lw r15,(r1+0)
    11e4:	45 80 00 0a 	be r12,r0,120c <printf+0xa8>
    11e8:	b9 80 08 00 	mv r1,r12
    11ec:	fb ff fe fc 	calli ddc <uart_write>
    11f0:	29 e2 00 00 	lw r2,(r15+0)
    11f4:	b9 80 08 00 	mv r1,r12
    11f8:	35 6b 00 01 	addi r11,r11,1
    11fc:	44 40 00 0e 	be r2,r0,1234 <printf+0xd0>
    1200:	d8 40 00 00 	call r2
    1204:	11 6c 00 00 	lb r12,(r11+0)
    1208:	5d 80 ff f8 	bne r12,r0,11e8 <printf+0x84>
    120c:	d0 2e 00 00 	wcsr IM,r14
    1210:	b9 a0 08 00 	mv r1,r13
    1214:	2b 9d 00 04 	lw ra,(sp+4)
    1218:	2b 8b 00 18 	lw r11,(sp+24)
    121c:	2b 8c 00 14 	lw r12,(sp+20)
    1220:	2b 8d 00 10 	lw r13,(sp+16)
    1224:	2b 8e 00 0c 	lw r14,(sp+12)
    1228:	2b 8f 00 08 	lw r15,(sp+8)
    122c:	37 9c 01 38 	addi sp,sp,312
    1230:	c3 a0 00 00 	ret
    1234:	11 6c 00 00 	lb r12,(r11+0)
    1238:	5d 80 ff ec 	bne r12,r0,11e8 <printf+0x84>
    123c:	e3 ff ff f4 	bi 120c <printf+0xa8>

00001240 <isr>:
    1240:	90 40 10 00 	rcsr r2,IP
    1244:	90 20 08 00 	rcsr r1,IM
    1248:	a0 22 08 00 	and r1,r1,r2
    124c:	20 21 00 01 	andi r1,r1,0x1
    1250:	5c 20 00 02 	bne r1,r0,1258 <isr+0x18>
    1254:	c3 a0 00 00 	ret
    1258:	37 9c ff fc 	addi sp,sp,-4
    125c:	5b 9d 00 04 	sw (sp+4),ra
    1260:	fb ff fe 8a 	calli c88 <uart_isr>
    1264:	2b 9d 00 04 	lw ra,(sp+4)
    1268:	37 9c 00 04 	addi sp,sp,4
    126c:	c3 a0 00 00 	ret

00001270 <strchr>:
    1270:	10 23 00 00 	lb r3,(r1+0)
    1274:	b0 40 10 00 	sextb r2,r2
    1278:	44 62 00 05 	be r3,r2,128c <strchr+0x1c>
    127c:	44 60 00 05 	be r3,r0,1290 <strchr+0x20>
    1280:	34 21 00 01 	addi r1,r1,1
    1284:	10 23 00 00 	lb r3,(r1+0)
    1288:	5c 62 ff fd 	bne r3,r2,127c <strchr+0xc>
    128c:	c3 a0 00 00 	ret
    1290:	34 01 00 00 	mvi r1,0
    1294:	c3 a0 00 00 	ret

00001298 <strrchr>:
    1298:	b8 20 20 00 	mv r4,r1
    129c:	10 21 00 00 	lb r1,(r1+0)
    12a0:	44 20 00 0c 	be r1,r0,12d0 <strrchr+0x38>
    12a4:	b8 80 08 00 	mv r1,r4
    12a8:	34 21 00 01 	addi r1,r1,1
    12ac:	10 23 00 00 	lb r3,(r1+0)
    12b0:	5c 60 ff fe 	bne r3,r0,12a8 <strrchr+0x10>
    12b4:	b0 40 10 00 	sextb r2,r2
    12b8:	10 23 00 00 	lb r3,(r1+0)
    12bc:	44 62 00 04 	be r3,r2,12cc <strrchr+0x34>
    12c0:	34 21 ff ff 	addi r1,r1,-1
    12c4:	50 24 ff fd 	bgeu r1,r4,12b8 <strrchr+0x20>
    12c8:	34 01 00 00 	mvi r1,0
    12cc:	c3 a0 00 00 	ret
    12d0:	b8 80 08 00 	mv r1,r4
    12d4:	e3 ff ff f8 	bi 12b4 <strrchr+0x1c>

000012d8 <strnchr>:
    12d8:	44 40 00 0e 	be r2,r0,1310 <strnchr+0x38>
    12dc:	10 24 00 00 	lb r4,(r1+0)
    12e0:	44 80 00 0c 	be r4,r0,1310 <strnchr+0x38>
    12e4:	b0 60 18 00 	sextb r3,r3
    12e8:	44 83 00 0b 	be r4,r3,1314 <strnchr+0x3c>
    12ec:	34 24 00 01 	addi r4,r1,1
    12f0:	b4 22 10 00 	add r2,r1,r2
    12f4:	e0 00 00 05 	bi 1308 <strnchr+0x30>
    12f8:	10 85 00 00 	lb r5,(r4+0)
    12fc:	34 84 00 01 	addi r4,r4,1
    1300:	44 a0 00 04 	be r5,r0,1310 <strnchr+0x38>
    1304:	44 a3 00 04 	be r5,r3,1314 <strnchr+0x3c>
    1308:	b8 80 08 00 	mv r1,r4
    130c:	5c 82 ff fb 	bne r4,r2,12f8 <strnchr+0x20>
    1310:	34 01 00 00 	mvi r1,0
    1314:	c3 a0 00 00 	ret

00001318 <strcpy>:
    1318:	b8 20 18 00 	mv r3,r1
    131c:	34 42 00 01 	addi r2,r2,1
    1320:	10 44 ff ff 	lb r4,(r2+-1)
    1324:	34 63 00 01 	addi r3,r3,1
    1328:	30 64 ff ff 	sb (r3+-1),r4
    132c:	5c 80 ff fc 	bne r4,r0,131c <strcpy+0x4>
    1330:	c3 a0 00 00 	ret

00001334 <strncpy>:
    1334:	44 60 00 09 	be r3,r0,1358 <strncpy+0x24>
    1338:	b4 23 18 00 	add r3,r1,r3
    133c:	b8 20 20 00 	mv r4,r1
    1340:	10 45 00 00 	lb r5,(r2+0)
    1344:	34 84 00 01 	addi r4,r4,1
    1348:	fc 05 30 00 	cmpne r6,r0,r5
    134c:	30 85 ff ff 	sb (r4+-1),r5
    1350:	b4 46 10 00 	add r2,r2,r6
    1354:	5c 64 ff fb 	bne r3,r4,1340 <strncpy+0xc>
    1358:	c3 a0 00 00 	ret

0000135c <strcmp>:
    135c:	34 42 00 01 	addi r2,r2,1
    1360:	10 24 00 00 	lb r4,(r1+0)
    1364:	40 43 ff ff 	lbu r3,(r2+-1)
    1368:	34 21 00 01 	addi r1,r1,1
    136c:	c8 83 18 00 	sub r3,r4,r3
    1370:	b0 60 18 00 	sextb r3,r3
    1374:	5c 60 00 04 	bne r3,r0,1384 <strcmp+0x28>
    1378:	5c 80 ff f9 	bne r4,r0,135c <strcmp>
    137c:	34 01 00 00 	mvi r1,0
    1380:	c3 a0 00 00 	ret
    1384:	b8 60 08 00 	mv r1,r3
    1388:	c3 a0 00 00 	ret

0000138c <strncmp>:
    138c:	4c 03 00 13 	bge r0,r3,13d8 <strncmp+0x4c>
    1390:	10 26 00 00 	lb r6,(r1+0)
    1394:	40 44 00 00 	lbu r4,(r2+0)
    1398:	34 45 00 01 	addi r5,r2,1
    139c:	c8 c4 20 00 	sub r4,r6,r4
    13a0:	b0 80 20 00 	sextb r4,r4
    13a4:	5c 80 00 0f 	bne r4,r0,13e0 <strncmp+0x54>
    13a8:	34 24 00 01 	addi r4,r1,1
    13ac:	44 c0 00 0b 	be r6,r0,13d8 <strncmp+0x4c>
    13b0:	b4 43 18 00 	add r3,r2,r3
    13b4:	44 65 00 09 	be r3,r5,13d8 <strncmp+0x4c>
    13b8:	34 a5 00 01 	addi r5,r5,1
    13bc:	10 86 00 00 	lb r6,(r4+0)
    13c0:	40 a1 ff ff 	lbu r1,(r5+-1)
    13c4:	34 84 00 01 	addi r4,r4,1
    13c8:	c8 c1 08 00 	sub r1,r6,r1
    13cc:	b0 20 08 00 	sextb r1,r1
    13d0:	5c 20 00 03 	bne r1,r0,13dc <strncmp+0x50>
    13d4:	5c c0 ff f8 	bne r6,r0,13b4 <strncmp+0x28>
    13d8:	34 01 00 00 	mvi r1,0
    13dc:	c3 a0 00 00 	ret
    13e0:	b8 80 08 00 	mv r1,r4
    13e4:	c3 a0 00 00 	ret

000013e8 <strlen>:
    13e8:	10 22 00 00 	lb r2,(r1+0)
    13ec:	44 40 00 07 	be r2,r0,1408 <strlen+0x20>
    13f0:	b8 20 10 00 	mv r2,r1
    13f4:	34 42 00 01 	addi r2,r2,1
    13f8:	10 43 00 00 	lb r3,(r2+0)
    13fc:	5c 60 ff fe 	bne r3,r0,13f4 <strlen+0xc>
    1400:	c8 41 08 00 	sub r1,r2,r1
    1404:	c3 a0 00 00 	ret
    1408:	34 01 00 00 	mvi r1,0
    140c:	c3 a0 00 00 	ret

00001410 <strnlen>:
    1410:	44 40 00 0f 	be r2,r0,144c <strnlen+0x3c>
    1414:	10 23 00 00 	lb r3,(r1+0)
    1418:	44 60 00 0d 	be r3,r0,144c <strnlen+0x3c>
    141c:	34 23 00 01 	addi r3,r1,1
    1420:	b4 22 10 00 	add r2,r1,r2
    1424:	e0 00 00 04 	bi 1434 <strnlen+0x24>
    1428:	34 63 00 01 	addi r3,r3,1
    142c:	10 64 ff ff 	lb r4,(r3+-1)
    1430:	44 80 00 05 	be r4,r0,1444 <strnlen+0x34>
    1434:	b8 60 28 00 	mv r5,r3
    1438:	5c 62 ff fc 	bne r3,r2,1428 <strnlen+0x18>
    143c:	c8 61 08 00 	sub r1,r3,r1
    1440:	c3 a0 00 00 	ret
    1444:	c8 a1 08 00 	sub r1,r5,r1
    1448:	c3 a0 00 00 	ret
    144c:	34 01 00 00 	mvi r1,0
    1450:	c3 a0 00 00 	ret

00001454 <memcmp>:
    1454:	b8 20 20 00 	mv r4,r1
    1458:	4c 03 00 11 	bge r0,r3,149c <memcmp+0x48>
    145c:	40 21 00 00 	lbu r1,(r1+0)
    1460:	40 45 00 00 	lbu r5,(r2+0)
    1464:	c8 25 08 00 	sub r1,r1,r5
    1468:	5c 20 00 0a 	bne r1,r0,1490 <memcmp+0x3c>
    146c:	b4 83 18 00 	add r3,r4,r3
    1470:	e0 00 00 05 	bi 1484 <memcmp+0x30>
    1474:	40 85 00 00 	lbu r5,(r4+0)
    1478:	40 46 00 00 	lbu r6,(r2+0)
    147c:	c8 a6 28 00 	sub r5,r5,r6
    1480:	5c a0 00 05 	bne r5,r0,1494 <memcmp+0x40>
    1484:	34 84 00 01 	addi r4,r4,1
    1488:	34 42 00 01 	addi r2,r2,1
    148c:	5c 64 ff fa 	bne r3,r4,1474 <memcmp+0x20>
    1490:	c3 a0 00 00 	ret
    1494:	b8 a0 08 00 	mv r1,r5
    1498:	c3 a0 00 00 	ret
    149c:	34 01 00 00 	mvi r1,0
    14a0:	c3 a0 00 00 	ret

000014a4 <memset>:
    14a4:	44 60 00 47 	be r3,r0,15c0 <memset+0x11c>
    14a8:	c8 01 20 00 	sub r4,r0,r1
    14ac:	34 69 ff ff 	addi r9,r3,-1
    14b0:	34 05 00 05 	mvi r5,5
    14b4:	b0 40 10 00 	sextb r2,r2
    14b8:	20 84 00 03 	andi r4,r4,0x3
    14bc:	50 a9 00 39 	bgeu r5,r9,15a0 <memset+0xfc>
    14c0:	37 9c ff fc 	addi sp,sp,-4
    14c4:	5b 8b 00 04 	sw (sp+4),r11
    14c8:	b8 20 38 00 	mv r7,r1
    14cc:	44 80 00 0e 	be r4,r0,1504 <memset+0x60>
    14d0:	30 22 00 00 	sb (r1+0),r2
    14d4:	34 05 00 01 	mvi r5,1
    14d8:	34 27 00 01 	addi r7,r1,1
    14dc:	34 69 ff fe 	addi r9,r3,-2
    14e0:	44 85 00 09 	be r4,r5,1504 <memset+0x60>
    14e4:	30 22 00 01 	sb (r1+1),r2
    14e8:	34 05 00 03 	mvi r5,3
    14ec:	34 27 00 02 	addi r7,r1,2
    14f0:	34 69 ff fd 	addi r9,r3,-3
    14f4:	5c 85 00 04 	bne r4,r5,1504 <memset+0x60>
    14f8:	34 27 00 03 	addi r7,r1,3
    14fc:	30 22 00 02 	sb (r1+2),r2
    1500:	34 69 ff fc 	addi r9,r3,-4
    1504:	20 45 00 ff 	andi r5,r2,0xff
    1508:	c8 64 18 00 	sub r3,r3,r4
    150c:	b8 a0 40 00 	mv r8,r5
    1510:	3c ab 00 10 	sli r11,r5,16
    1514:	00 66 00 02 	srui r6,r3,2
    1518:	3c a5 00 18 	sli r5,r5,24
    151c:	3d 0a 00 08 	sli r10,r8,8
    1520:	b8 ab 28 00 	or r5,r5,r11
    1524:	3c c6 00 02 	sli r6,r6,2
    1528:	b8 aa 28 00 	or r5,r5,r10
    152c:	b4 24 20 00 	add r4,r1,r4
    1530:	b8 a8 28 00 	or r5,r5,r8
    1534:	b4 c4 30 00 	add r6,r6,r4
    1538:	58 85 00 00 	sw (r4+0),r5
    153c:	34 84 00 04 	addi r4,r4,4
    1540:	5c 86 ff fe 	bne r4,r6,1538 <memset+0x94>
    1544:	34 05 ff fc 	mvi r5,-4
    1548:	a0 65 28 00 	and r5,r3,r5
    154c:	b4 e5 20 00 	add r4,r7,r5
    1550:	c9 25 48 00 	sub r9,r9,r5
    1554:	44 65 00 10 	be r3,r5,1594 <memset+0xf0>
    1558:	30 82 00 00 	sb (r4+0),r2
    155c:	45 20 00 0e 	be r9,r0,1594 <memset+0xf0>
    1560:	30 82 00 01 	sb (r4+1),r2
    1564:	34 03 00 01 	mvi r3,1
    1568:	45 23 00 0b 	be r9,r3,1594 <memset+0xf0>
    156c:	30 82 00 02 	sb (r4+2),r2
    1570:	34 03 00 02 	mvi r3,2
    1574:	45 23 00 08 	be r9,r3,1594 <memset+0xf0>
    1578:	30 82 00 03 	sb (r4+3),r2
    157c:	34 03 00 03 	mvi r3,3
    1580:	45 23 00 05 	be r9,r3,1594 <memset+0xf0>
    1584:	30 82 00 04 	sb (r4+4),r2
    1588:	34 03 00 04 	mvi r3,4
    158c:	45 23 00 02 	be r9,r3,1594 <memset+0xf0>
    1590:	30 82 00 05 	sb (r4+5),r2
    1594:	2b 8b 00 04 	lw r11,(sp+4)
    1598:	37 9c 00 04 	addi sp,sp,4
    159c:	c3 a0 00 00 	ret
    15a0:	30 22 00 00 	sb (r1+0),r2
    15a4:	45 20 00 07 	be r9,r0,15c0 <memset+0x11c>
    15a8:	30 22 00 01 	sb (r1+1),r2
    15ac:	34 03 00 01 	mvi r3,1
    15b0:	45 23 00 04 	be r9,r3,15c0 <memset+0x11c>
    15b4:	30 22 00 02 	sb (r1+2),r2
    15b8:	34 03 00 02 	mvi r3,2
    15bc:	5d 23 00 02 	bne r9,r3,15c4 <memset+0x120>
    15c0:	c3 a0 00 00 	ret
    15c4:	30 22 00 03 	sb (r1+3),r2
    15c8:	34 03 00 03 	mvi r3,3
    15cc:	45 23 ff fd 	be r9,r3,15c0 <memset+0x11c>
    15d0:	30 22 00 04 	sb (r1+4),r2
    15d4:	34 03 00 04 	mvi r3,4
    15d8:	45 23 ff fa 	be r9,r3,15c0 <memset+0x11c>
    15dc:	30 22 00 05 	sb (r1+5),r2
    15e0:	c3 a0 00 00 	ret

000015e4 <memcpy>:
    15e4:	44 60 00 24 	be r3,r0,1674 <memcpy+0x90>
    15e8:	20 24 00 01 	andi r4,r1,0x1
    15ec:	5c 80 00 23 	bne r4,r0,1678 <memcpy+0x94>
    15f0:	20 44 00 01 	andi r4,r2,0x1
    15f4:	b8 40 28 00 	mv r5,r2
    15f8:	5c 80 00 5a 	bne r4,r0,1760 <memcpy+0x17c>
    15fc:	b8 20 20 00 	mv r4,r1
    1600:	34 06 00 02 	mvi r6,2
    1604:	4c c3 00 09 	bge r6,r3,1628 <memcpy+0x44>
    1608:	20 86 00 02 	andi r6,r4,0x2
    160c:	44 c0 00 51 	be r6,r0,1750 <memcpy+0x16c>
    1610:	1c 45 00 00 	lh r5,(r2+0)
    1614:	34 42 00 02 	addi r2,r2,2
    1618:	34 63 ff fe 	addi r3,r3,-2
    161c:	0c 85 00 00 	sh (r4+0),r5
    1620:	b8 40 28 00 	mv r5,r2
    1624:	34 84 00 02 	addi r4,r4,2
    1628:	20 a5 00 02 	andi r5,r5,0x2
    162c:	5c a0 00 4f 	bne r5,r0,1768 <memcpy+0x184>
    1630:	14 65 00 02 	sri r5,r3,2
    1634:	44 a0 00 0a 	be r5,r0,165c <memcpy+0x78>
    1638:	3c a8 00 02 	sli r8,r5,2
    163c:	b8 40 28 00 	mv r5,r2
    1640:	b4 88 38 00 	add r7,r4,r8
    1644:	34 a5 00 04 	addi r5,r5,4
    1648:	28 a6 ff fc 	lw r6,(r5+-4)
    164c:	34 84 00 04 	addi r4,r4,4
    1650:	58 86 ff fc 	sw (r4+-4),r6
    1654:	5c 87 ff fc 	bne r4,r7,1644 <memcpy+0x60>
    1658:	b4 48 10 00 	add r2,r2,r8
    165c:	20 65 00 02 	andi r5,r3,0x2
    1660:	5c a0 00 37 	bne r5,r0,173c <memcpy+0x158>
    1664:	20 63 00 01 	andi r3,r3,0x1
    1668:	44 60 00 03 	be r3,r0,1674 <memcpy+0x90>
    166c:	10 42 00 00 	lb r2,(r2+0)
    1670:	30 82 00 00 	sb (r4+0),r2
    1674:	c3 a0 00 00 	ret
    1678:	10 44 00 00 	lb r4,(r2+0)
    167c:	34 42 00 01 	addi r2,r2,1
    1680:	20 46 00 01 	andi r6,r2,0x1
    1684:	30 24 00 00 	sb (r1+0),r4
    1688:	34 63 ff ff 	addi r3,r3,-1
    168c:	34 24 00 01 	addi r4,r1,1
    1690:	b8 40 28 00 	mv r5,r2
    1694:	44 c0 ff db 	be r6,r0,1600 <memcpy+0x1c>
    1698:	44 60 ff f7 	be r3,r0,1674 <memcpy+0x90>
    169c:	34 88 00 04 	addi r8,r4,4
    16a0:	34 47 00 04 	addi r7,r2,4
    16a4:	f0 48 40 00 	cmpgeu r8,r2,r8
    16a8:	f0 87 38 00 	cmpgeu r7,r4,r7
    16ac:	34 66 ff ff 	addi r6,r3,-1
    16b0:	b8 82 28 00 	or r5,r4,r2
    16b4:	74 c6 00 08 	cmpgui r6,r6,0x8
    16b8:	20 a5 00 03 	andi r5,r5,0x3
    16bc:	b9 07 38 00 	or r7,r8,r7
    16c0:	e4 05 28 00 	cmpe r5,r0,r5
    16c4:	a0 c7 30 00 	and r6,r6,r7
    16c8:	a0 a6 28 00 	and r5,r5,r6
    16cc:	44 a0 00 4c 	be r5,r0,17fc <memcpy+0x218>
    16d0:	00 67 00 02 	srui r7,r3,2
    16d4:	b8 40 28 00 	mv r5,r2
    16d8:	3c e7 00 02 	sli r7,r7,2
    16dc:	b8 80 30 00 	mv r6,r4
    16e0:	b4 e2 38 00 	add r7,r7,r2
    16e4:	28 a8 00 00 	lw r8,(r5+0)
    16e8:	34 c6 00 04 	addi r6,r6,4
    16ec:	34 a5 00 04 	addi r5,r5,4
    16f0:	58 c8 ff fc 	sw (r6+-4),r8
    16f4:	5c a7 ff fc 	bne r5,r7,16e4 <memcpy+0x100>
    16f8:	34 05 ff fc 	mvi r5,-4
    16fc:	a0 65 28 00 	and r5,r3,r5
    1700:	c8 65 30 00 	sub r6,r3,r5
    1704:	b4 85 20 00 	add r4,r4,r5
    1708:	b4 45 10 00 	add r2,r2,r5
    170c:	44 65 ff da 	be r3,r5,1674 <memcpy+0x90>
    1710:	10 45 00 00 	lb r5,(r2+0)
    1714:	34 c3 ff ff 	addi r3,r6,-1
    1718:	30 85 00 00 	sb (r4+0),r5
    171c:	44 60 ff d6 	be r3,r0,1674 <memcpy+0x90>
    1720:	10 45 00 01 	lb r5,(r2+1)
    1724:	34 03 00 02 	mvi r3,2
    1728:	30 85 00 01 	sb (r4+1),r5
    172c:	44 c3 ff d2 	be r6,r3,1674 <memcpy+0x90>
    1730:	10 42 00 02 	lb r2,(r2+2)
    1734:	30 82 00 02 	sb (r4+2),r2
    1738:	c3 a0 00 00 	ret
    173c:	1c 45 00 00 	lh r5,(r2+0)
    1740:	34 84 00 02 	addi r4,r4,2
    1744:	34 42 00 02 	addi r2,r2,2
    1748:	0c 85 ff fe 	sh (r4+-2),r5
    174c:	e3 ff ff c6 	bi 1664 <memcpy+0x80>
    1750:	20 a5 00 02 	andi r5,r5,0x2
    1754:	44 a0 ff b7 	be r5,r0,1630 <memcpy+0x4c>
    1758:	14 69 00 01 	sri r9,r3,1
    175c:	e0 00 00 05 	bi 1770 <memcpy+0x18c>
    1760:	b8 20 20 00 	mv r4,r1
    1764:	e3 ff ff ce 	bi 169c <memcpy+0xb8>
    1768:	14 69 00 01 	sri r9,r3,1
    176c:	45 20 ff be 	be r9,r0,1664 <memcpy+0x80>
    1770:	34 88 00 04 	addi r8,r4,4
    1774:	34 47 00 04 	addi r7,r2,4
    1778:	f0 48 40 00 	cmpgeu r8,r2,r8
    177c:	f0 87 38 00 	cmpgeu r7,r4,r7
    1780:	35 26 ff ff 	addi r6,r9,-1
    1784:	b8 44 28 00 	or r5,r2,r4
    1788:	74 c6 00 0b 	cmpgui r6,r6,0xb
    178c:	20 a5 00 03 	andi r5,r5,0x3
    1790:	b9 07 38 00 	or r7,r8,r7
    1794:	e4 05 28 00 	cmpe r5,r0,r5
    1798:	a0 c7 30 00 	and r6,r6,r7
    179c:	a0 a6 28 00 	and r5,r5,r6
    17a0:	44 a0 00 1e 	be r5,r0,1818 <memcpy+0x234>
    17a4:	01 27 00 01 	srui r7,r9,1
    17a8:	b8 40 28 00 	mv r5,r2
    17ac:	3c e7 00 02 	sli r7,r7,2
    17b0:	b8 80 30 00 	mv r6,r4
    17b4:	b4 e2 38 00 	add r7,r7,r2
    17b8:	28 a8 00 00 	lw r8,(r5+0)
    17bc:	34 c6 00 04 	addi r6,r6,4
    17c0:	34 a5 00 04 	addi r5,r5,4
    17c4:	58 c8 ff fc 	sw (r6+-4),r8
    17c8:	5c a7 ff fc 	bne r5,r7,17b8 <memcpy+0x1d4>
    17cc:	34 07 ff fe 	mvi r7,-2
    17d0:	a1 27 38 00 	and r7,r9,r7
    17d4:	3c e5 00 01 	sli r5,r7,1
    17d8:	3d 28 00 01 	sli r8,r9,1
    17dc:	b4 85 30 00 	add r6,r4,r5
    17e0:	b4 45 28 00 	add r5,r2,r5
    17e4:	45 27 00 03 	be r9,r7,17f0 <memcpy+0x20c>
    17e8:	1c a5 00 00 	lh r5,(r5+0)
    17ec:	0c c5 00 00 	sh (r6+0),r5
    17f0:	b4 48 10 00 	add r2,r2,r8
    17f4:	b4 88 20 00 	add r4,r4,r8
    17f8:	e3 ff ff 9b 	bi 1664 <memcpy+0x80>
    17fc:	b4 83 18 00 	add r3,r4,r3
    1800:	34 42 00 01 	addi r2,r2,1
    1804:	10 45 ff ff 	lb r5,(r2+-1)
    1808:	34 84 00 01 	addi r4,r4,1
    180c:	30 85 ff ff 	sb (r4+-1),r5
    1810:	5c 64 ff fc 	bne r3,r4,1800 <memcpy+0x21c>
    1814:	c3 a0 00 00 	ret
    1818:	3d 28 00 01 	sli r8,r9,1
    181c:	b8 40 30 00 	mv r6,r2
    1820:	b4 88 48 00 	add r9,r4,r8
    1824:	b8 80 28 00 	mv r5,r4
    1828:	34 c6 00 02 	addi r6,r6,2
    182c:	1c c7 ff fe 	lh r7,(r6+-2)
    1830:	34 a5 00 02 	addi r5,r5,2
    1834:	0c a7 ff fe 	sh (r5+-2),r7
    1838:	5c a9 ff fc 	bne r5,r9,1828 <memcpy+0x244>
    183c:	e3 ff ff ed 	bi 17f0 <memcpy+0x20c>

00001840 <memmove>:
    1840:	34 68 ff ff 	addi r8,r3,-1
    1844:	54 22 00 28 	bgu r1,r2,18e4 <memmove+0xa4>
    1848:	44 60 00 26 	be r3,r0,18e0 <memmove+0xa0>
    184c:	34 47 00 04 	addi r7,r2,4
    1850:	34 26 00 04 	addi r6,r1,4
    1854:	f0 27 38 00 	cmpgeu r7,r1,r7
    1858:	f0 46 30 00 	cmpgeu r6,r2,r6
    185c:	b8 22 28 00 	or r5,r1,r2
    1860:	75 04 00 08 	cmpgui r4,r8,0x8
    1864:	20 a5 00 03 	andi r5,r5,0x3
    1868:	b8 e6 30 00 	or r6,r7,r6
    186c:	e4 05 28 00 	cmpe r5,r0,r5
    1870:	a0 86 20 00 	and r4,r4,r6
    1874:	a0 a4 20 00 	and r4,r5,r4
    1878:	44 80 00 29 	be r4,r0,191c <memmove+0xdc>
    187c:	00 66 00 02 	srui r6,r3,2
    1880:	b8 40 20 00 	mv r4,r2
    1884:	3c c6 00 02 	sli r6,r6,2
    1888:	b8 20 28 00 	mv r5,r1
    188c:	b4 c2 30 00 	add r6,r6,r2
    1890:	28 87 00 00 	lw r7,(r4+0)
    1894:	34 a5 00 04 	addi r5,r5,4
    1898:	34 84 00 04 	addi r4,r4,4
    189c:	58 a7 ff fc 	sw (r5+-4),r7
    18a0:	5c 86 ff fc 	bne r4,r6,1890 <memmove+0x50>
    18a4:	34 04 ff fc 	mvi r4,-4
    18a8:	a0 64 20 00 	and r4,r3,r4
    18ac:	b4 24 28 00 	add r5,r1,r4
    18b0:	b4 44 10 00 	add r2,r2,r4
    18b4:	c9 04 40 00 	sub r8,r8,r4
    18b8:	44 64 00 0a 	be r3,r4,18e0 <memmove+0xa0>
    18bc:	10 43 00 00 	lb r3,(r2+0)
    18c0:	30 a3 00 00 	sb (r5+0),r3
    18c4:	45 00 00 07 	be r8,r0,18e0 <memmove+0xa0>
    18c8:	10 44 00 01 	lb r4,(r2+1)
    18cc:	34 03 00 01 	mvi r3,1
    18d0:	30 a4 00 01 	sb (r5+1),r4
    18d4:	45 03 00 03 	be r8,r3,18e0 <memmove+0xa0>
    18d8:	10 42 00 02 	lb r2,(r2+2)
    18dc:	30 a2 00 02 	sb (r5+2),r2
    18e0:	c3 a0 00 00 	ret
    18e4:	b4 23 20 00 	add r4,r1,r3
    18e8:	b4 43 10 00 	add r2,r2,r3
    18ec:	44 60 ff fd 	be r3,r0,18e0 <memmove+0xa0>
    18f0:	34 42 ff ff 	addi r2,r2,-1
    18f4:	10 43 00 00 	lb r3,(r2+0)
    18f8:	34 84 ff ff 	addi r4,r4,-1
    18fc:	30 83 00 00 	sb (r4+0),r3
    1900:	44 24 ff f8 	be r1,r4,18e0 <memmove+0xa0>
    1904:	34 42 ff ff 	addi r2,r2,-1
    1908:	10 43 00 00 	lb r3,(r2+0)
    190c:	34 84 ff ff 	addi r4,r4,-1
    1910:	30 83 00 00 	sb (r4+0),r3
    1914:	5c 24 ff f7 	bne r1,r4,18f0 <memmove+0xb0>
    1918:	e3 ff ff f2 	bi 18e0 <memmove+0xa0>
    191c:	b4 23 18 00 	add r3,r1,r3
    1920:	b8 20 20 00 	mv r4,r1
    1924:	34 42 00 01 	addi r2,r2,1
    1928:	10 45 ff ff 	lb r5,(r2+-1)
    192c:	34 84 00 01 	addi r4,r4,1
    1930:	30 85 ff ff 	sb (r4+-1),r5
    1934:	5c 83 ff fc 	bne r4,r3,1924 <memmove+0xe4>
    1938:	c3 a0 00 00 	ret

0000193c <strstr>:
    193c:	10 4a 00 00 	lb r10,(r2+0)
    1940:	b8 20 38 00 	mv r7,r1
    1944:	45 40 00 20 	be r10,r0,19c4 <strstr+0x88>
    1948:	b8 40 08 00 	mv r1,r2
    194c:	34 21 00 01 	addi r1,r1,1
    1950:	10 23 00 00 	lb r3,(r1+0)
    1954:	5c 60 ff fe 	bne r3,r0,194c <strstr+0x10>
    1958:	c8 22 40 00 	sub r8,r1,r2
    195c:	b8 e0 08 00 	mv r1,r7
    1960:	45 00 00 19 	be r8,r0,19c4 <strstr+0x88>
    1964:	10 e1 00 00 	lb r1,(r7+0)
    1968:	44 20 00 1e 	be r1,r0,19e0 <strstr+0xa4>
    196c:	b8 e0 08 00 	mv r1,r7
    1970:	34 21 00 01 	addi r1,r1,1
    1974:	10 23 00 00 	lb r3,(r1+0)
    1978:	5c 60 ff fe 	bne r3,r0,1970 <strstr+0x34>
    197c:	c8 27 48 00 	sub r9,r1,r7
    1980:	49 09 00 16 	bg r8,r9,19d8 <strstr+0x9c>
    1984:	b8 e0 08 00 	mv r1,r7
    1988:	21 4a 00 ff 	andi r10,r10,0xff
    198c:	b4 e8 38 00 	add r7,r7,r8
    1990:	b4 29 48 00 	add r9,r1,r9
    1994:	4c 08 00 0c 	bge r0,r8,19c4 <strstr+0x88>
    1998:	40 23 00 00 	lbu r3,(r1+0)
    199c:	5c 6a 00 0b 	bne r3,r10,19c8 <strstr+0x8c>
    19a0:	b8 40 20 00 	mv r4,r2
    19a4:	b8 20 18 00 	mv r3,r1
    19a8:	e0 00 00 04 	bi 19b8 <strstr+0x7c>
    19ac:	40 66 00 00 	lbu r6,(r3+0)
    19b0:	40 85 00 00 	lbu r5,(r4+0)
    19b4:	5c c5 00 05 	bne r6,r5,19c8 <strstr+0x8c>
    19b8:	34 63 00 01 	addi r3,r3,1
    19bc:	34 84 00 01 	addi r4,r4,1
    19c0:	5c 67 ff fb 	bne r3,r7,19ac <strstr+0x70>
    19c4:	c3 a0 00 00 	ret
    19c8:	34 21 00 01 	addi r1,r1,1
    19cc:	c9 21 18 00 	sub r3,r9,r1
    19d0:	34 e7 00 01 	addi r7,r7,1
    19d4:	4c 68 ff f0 	bge r3,r8,1994 <strstr+0x58>
    19d8:	34 01 00 00 	mvi r1,0
    19dc:	c3 a0 00 00 	ret
    19e0:	34 09 00 00 	mvi r9,0
    19e4:	e3 ff ff e7 	bi 1980 <strstr+0x44>

000019e8 <strtoul>:
    19e8:	37 9c ff f4 	addi sp,sp,-12
    19ec:	5b 8b 00 0c 	sw (sp+12),r11
    19f0:	5b 8c 00 08 	sw (sp+8),r12
    19f4:	5b 8d 00 04 	sw (sp+4),r13
    19f8:	10 24 00 00 	lb r4,(r1+0)
    19fc:	5c 60 00 28 	bne r3,r0,1a9c <strtoul+0xb4>
    1a00:	34 05 00 30 	mvi r5,48
    1a04:	34 03 00 0a 	mvi r3,10
    1a08:	44 85 00 34 	be r4,r5,1ad8 <strtoul+0xf0>
    1a0c:	34 09 00 00 	mvi r9,0
    1a10:	34 0b 00 09 	mvi r11,9
    1a14:	34 0a ff df 	mvi r10,-33
    1a18:	34 0c 00 05 	mvi r12,5
    1a1c:	34 0d 00 19 	mvi r13,25
    1a20:	10 28 00 00 	lb r8,(r1+0)
    1a24:	21 04 00 ff 	andi r4,r8,0xff
    1a28:	a0 8a 28 00 	and r5,r4,r10
    1a2c:	34 86 ff d0 	addi r6,r4,-48
    1a30:	34 a5 ff bf 	addi r5,r5,-65
    1a34:	20 c6 00 ff 	andi r6,r6,0xff
    1a38:	34 87 ff 9f 	addi r7,r4,-97
    1a3c:	20 a5 00 ff 	andi r5,r5,0xff
    1a40:	51 66 00 15 	bgeu r11,r6,1a94 <strtoul+0xac>
    1a44:	20 e7 00 ff 	andi r7,r7,0xff
    1a48:	51 85 00 09 	bgeu r12,r5,1a6c <strtoul+0x84>
    1a4c:	44 40 00 02 	be r2,r0,1a54 <strtoul+0x6c>
    1a50:	58 41 00 00 	sw (r2+0),r1
    1a54:	b9 20 08 00 	mv r1,r9
    1a58:	2b 8b 00 0c 	lw r11,(sp+12)
    1a5c:	2b 8c 00 08 	lw r12,(sp+8)
    1a60:	2b 8d 00 04 	lw r13,(sp+4)
    1a64:	37 9c 00 0c 	addi sp,sp,12
    1a68:	c3 a0 00 00 	ret
    1a6c:	34 85 ff e0 	addi r5,r4,-32
    1a70:	54 ed 00 02 	bgu r7,r13,1a78 <strtoul+0x90>
    1a74:	20 a4 00 ff 	andi r4,r5,0xff
    1a78:	34 84 ff c9 	addi r4,r4,-55
    1a7c:	88 69 28 00 	mul r5,r3,r9
    1a80:	54 64 00 02 	bgu r3,r4,1a88 <strtoul+0xa0>
    1a84:	e3 ff ff f2 	bi 1a4c <strtoul+0x64>
    1a88:	34 21 00 01 	addi r1,r1,1
    1a8c:	b4 a4 48 00 	add r9,r5,r4
    1a90:	e3 ff ff e4 	bi 1a20 <strtoul+0x38>
    1a94:	35 04 ff d0 	addi r4,r8,-48
    1a98:	e3 ff ff f9 	bi 1a7c <strtoul+0x94>
    1a9c:	34 05 00 10 	mvi r5,16
    1aa0:	5c 65 ff db 	bne r3,r5,1a0c <strtoul+0x24>
    1aa4:	34 05 00 30 	mvi r5,48
    1aa8:	5c 85 ff d9 	bne r4,r5,1a0c <strtoul+0x24>
    1aac:	40 24 00 01 	lbu r4,(r1+1)
    1ab0:	34 06 00 19 	mvi r6,25
    1ab4:	34 85 ff 9f 	addi r5,r4,-97
    1ab8:	20 a5 00 ff 	andi r5,r5,0xff
    1abc:	54 a6 00 03 	bgu r5,r6,1ac8 <strtoul+0xe0>
    1ac0:	34 84 ff e0 	addi r4,r4,-32
    1ac4:	20 84 00 ff 	andi r4,r4,0xff
    1ac8:	34 05 00 58 	mvi r5,88
    1acc:	5c 85 ff d0 	bne r4,r5,1a0c <strtoul+0x24>
    1ad0:	34 21 00 02 	addi r1,r1,2
    1ad4:	e3 ff ff ce 	bi 1a0c <strtoul+0x24>
    1ad8:	40 23 00 01 	lbu r3,(r1+1)
    1adc:	34 05 00 19 	mvi r5,25
    1ae0:	34 26 00 01 	addi r6,r1,1
    1ae4:	34 64 ff 9f 	addi r4,r3,-97
    1ae8:	20 84 00 ff 	andi r4,r4,0xff
    1aec:	54 85 00 03 	bgu r4,r5,1af8 <strtoul+0x110>
    1af0:	34 63 ff e0 	addi r3,r3,-32
    1af4:	20 63 00 ff 	andi r3,r3,0xff
    1af8:	34 04 00 58 	mvi r4,88
    1afc:	44 64 00 04 	be r3,r4,1b0c <strtoul+0x124>
    1b00:	b8 c0 08 00 	mv r1,r6
    1b04:	34 03 00 08 	mvi r3,8
    1b08:	e3 ff ff c1 	bi 1a0c <strtoul+0x24>
    1b0c:	40 23 00 02 	lbu r3,(r1+2)
    1b10:	34 05 00 09 	mvi r5,9
    1b14:	34 64 ff d0 	addi r4,r3,-48
    1b18:	20 84 00 ff 	andi r4,r4,0xff
    1b1c:	50 a4 00 06 	bgeu r5,r4,1b34 <strtoul+0x14c>
    1b20:	20 63 00 df 	andi r3,r3,0xdf
    1b24:	34 63 ff bf 	addi r3,r3,-65
    1b28:	20 63 00 ff 	andi r3,r3,0xff
    1b2c:	34 04 00 05 	mvi r4,5
    1b30:	54 64 ff f4 	bgu r3,r4,1b00 <strtoul+0x118>
    1b34:	34 21 00 02 	addi r1,r1,2
    1b38:	34 03 00 10 	mvi r3,16
    1b3c:	e3 ff ff b4 	bi 1a0c <strtoul+0x24>

00001b40 <strtol>:
    1b40:	37 9c ff f0 	addi sp,sp,-16
    1b44:	5b 8b 00 10 	sw (sp+16),r11
    1b48:	5b 8c 00 0c 	sw (sp+12),r12
    1b4c:	5b 8d 00 08 	sw (sp+8),r13
    1b50:	5b 9d 00 04 	sw (sp+4),ra
    1b54:	10 24 00 00 	lb r4,(r1+0)
    1b58:	34 06 00 2d 	mvi r6,45
    1b5c:	44 86 00 3b 	be r4,r6,1c48 <strtol+0x108>
    1b60:	b8 40 48 00 	mv r9,r2
    1b64:	b8 60 28 00 	mv r5,r3
    1b68:	44 60 00 26 	be r3,r0,1c00 <strtol+0xc0>
    1b6c:	34 02 00 10 	mvi r2,16
    1b70:	44 62 00 3f 	be r3,r2,1c6c <strtol+0x12c>
    1b74:	34 04 00 00 	mvi r4,0
    1b78:	34 0d 00 09 	mvi r13,9
    1b7c:	34 0c ff df 	mvi r12,-33
    1b80:	34 0b 00 05 	mvi r11,5
    1b84:	34 0a 00 19 	mvi r10,25
    1b88:	10 28 00 00 	lb r8,(r1+0)
    1b8c:	21 02 00 ff 	andi r2,r8,0xff
    1b90:	a0 4c 18 00 	and r3,r2,r12
    1b94:	34 47 ff d0 	addi r7,r2,-48
    1b98:	34 63 ff bf 	addi r3,r3,-65
    1b9c:	20 e7 00 ff 	andi r7,r7,0xff
    1ba0:	34 46 ff 9f 	addi r6,r2,-97
    1ba4:	20 63 00 ff 	andi r3,r3,0xff
    1ba8:	51 a7 00 26 	bgeu r13,r7,1c40 <strtol+0x100>
    1bac:	20 c6 00 ff 	andi r6,r6,0xff
    1bb0:	51 63 00 0a 	bgeu r11,r3,1bd8 <strtol+0x98>
    1bb4:	45 20 00 02 	be r9,r0,1bbc <strtol+0x7c>
    1bb8:	59 21 00 00 	sw (r9+0),r1
    1bbc:	b8 80 08 00 	mv r1,r4
    1bc0:	2b 9d 00 04 	lw ra,(sp+4)
    1bc4:	2b 8b 00 10 	lw r11,(sp+16)
    1bc8:	2b 8c 00 0c 	lw r12,(sp+12)
    1bcc:	2b 8d 00 08 	lw r13,(sp+8)
    1bd0:	37 9c 00 10 	addi sp,sp,16
    1bd4:	c3 a0 00 00 	ret
    1bd8:	34 43 ff e0 	addi r3,r2,-32
    1bdc:	54 ca 00 02 	bgu r6,r10,1be4 <strtol+0xa4>
    1be0:	20 62 00 ff 	andi r2,r3,0xff
    1be4:	34 42 ff c9 	addi r2,r2,-55
    1be8:	88 a4 18 00 	mul r3,r5,r4
    1bec:	54 a2 00 02 	bgu r5,r2,1bf4 <strtol+0xb4>
    1bf0:	e3 ff ff f1 	bi 1bb4 <strtol+0x74>
    1bf4:	34 21 00 01 	addi r1,r1,1
    1bf8:	b4 62 20 00 	add r4,r3,r2
    1bfc:	e3 ff ff e3 	bi 1b88 <strtol+0x48>
    1c00:	34 02 00 30 	mvi r2,48
    1c04:	34 05 00 0a 	mvi r5,10
    1c08:	5c 82 ff db 	bne r4,r2,1b74 <strtol+0x34>
    1c0c:	40 22 00 01 	lbu r2,(r1+1)
    1c10:	34 04 00 19 	mvi r4,25
    1c14:	34 25 00 01 	addi r5,r1,1
    1c18:	34 43 ff 9f 	addi r3,r2,-97
    1c1c:	20 63 00 ff 	andi r3,r3,0xff
    1c20:	54 64 00 03 	bgu r3,r4,1c2c <strtol+0xec>
    1c24:	34 42 ff e0 	addi r2,r2,-32
    1c28:	20 42 00 ff 	andi r2,r2,0xff
    1c2c:	34 03 00 58 	mvi r3,88
    1c30:	44 43 00 1c 	be r2,r3,1ca0 <strtol+0x160>
    1c34:	b8 a0 08 00 	mv r1,r5
    1c38:	34 05 00 08 	mvi r5,8
    1c3c:	e3 ff ff ce 	bi 1b74 <strtol+0x34>
    1c40:	35 02 ff d0 	addi r2,r8,-48
    1c44:	e3 ff ff e9 	bi 1be8 <strtol+0xa8>
    1c48:	34 21 00 01 	addi r1,r1,1
    1c4c:	fb ff ff 67 	calli 19e8 <strtoul>
    1c50:	c8 01 08 00 	sub r1,r0,r1
    1c54:	2b 9d 00 04 	lw ra,(sp+4)
    1c58:	2b 8b 00 10 	lw r11,(sp+16)
    1c5c:	2b 8c 00 0c 	lw r12,(sp+12)
    1c60:	2b 8d 00 08 	lw r13,(sp+8)
    1c64:	37 9c 00 10 	addi sp,sp,16
    1c68:	c3 a0 00 00 	ret
    1c6c:	34 02 00 30 	mvi r2,48
    1c70:	5c 82 ff c1 	bne r4,r2,1b74 <strtol+0x34>
    1c74:	40 22 00 01 	lbu r2,(r1+1)
    1c78:	34 04 00 19 	mvi r4,25
    1c7c:	34 43 ff 9f 	addi r3,r2,-97
    1c80:	20 63 00 ff 	andi r3,r3,0xff
    1c84:	54 64 00 03 	bgu r3,r4,1c90 <strtol+0x150>
    1c88:	34 42 ff e0 	addi r2,r2,-32
    1c8c:	20 42 00 ff 	andi r2,r2,0xff
    1c90:	34 03 00 58 	mvi r3,88
    1c94:	5c 43 ff b8 	bne r2,r3,1b74 <strtol+0x34>
    1c98:	34 21 00 02 	addi r1,r1,2
    1c9c:	e3 ff ff b6 	bi 1b74 <strtol+0x34>
    1ca0:	40 22 00 02 	lbu r2,(r1+2)
    1ca4:	34 04 00 09 	mvi r4,9
    1ca8:	34 43 ff d0 	addi r3,r2,-48
    1cac:	20 63 00 ff 	andi r3,r3,0xff
    1cb0:	50 83 00 06 	bgeu r4,r3,1cc8 <strtol+0x188>
    1cb4:	20 42 00 df 	andi r2,r2,0xdf
    1cb8:	34 42 ff bf 	addi r2,r2,-65
    1cbc:	20 42 00 ff 	andi r2,r2,0xff
    1cc0:	34 03 00 05 	mvi r3,5
    1cc4:	54 43 ff dc 	bgu r2,r3,1c34 <strtol+0xf4>
    1cc8:	34 21 00 02 	addi r1,r1,2
    1ccc:	34 05 00 10 	mvi r5,16
    1cd0:	e3 ff ff a9 	bi 1b74 <strtol+0x34>

00001cd4 <skip_atoi>:
    1cd4:	28 24 00 00 	lw r4,(r1+0)
    1cd8:	b8 20 30 00 	mv r6,r1
    1cdc:	34 02 00 09 	mvi r2,9
    1ce0:	40 81 00 00 	lbu r1,(r4+0)
    1ce4:	34 21 ff d0 	addi r1,r1,-48
    1ce8:	20 21 00 ff 	andi r1,r1,0xff
    1cec:	54 22 00 0f 	bgu r1,r2,1d28 <skip_atoi+0x54>
    1cf0:	34 84 00 01 	addi r4,r4,1
    1cf4:	34 01 00 00 	mvi r1,0
    1cf8:	34 07 00 09 	mvi r7,9
    1cfc:	58 c4 00 00 	sw (r6+0),r4
    1d00:	40 83 00 00 	lbu r3,(r4+0)
    1d04:	08 22 00 0a 	muli r2,r1,10
    1d08:	10 85 ff ff 	lb r5,(r4+-1)
    1d0c:	34 63 ff d0 	addi r3,r3,-48
    1d10:	20 63 00 ff 	andi r3,r3,0xff
    1d14:	b4 45 10 00 	add r2,r2,r5
    1d18:	34 41 ff d0 	addi r1,r2,-48
    1d1c:	34 84 00 01 	addi r4,r4,1
    1d20:	50 e3 ff f7 	bgeu r7,r3,1cfc <skip_atoi+0x28>
    1d24:	c3 a0 00 00 	ret
    1d28:	34 01 00 00 	mvi r1,0
    1d2c:	c3 a0 00 00 	ret

00001d30 <number>:
    1d30:	37 9c ff 98 	addi sp,sp,-104
    1d34:	5b 8b 00 24 	sw (sp+36),r11
    1d38:	5b 8c 00 20 	sw (sp+32),r12
    1d3c:	5b 8d 00 1c 	sw (sp+28),r13
    1d40:	5b 8e 00 18 	sw (sp+24),r14
    1d44:	5b 8f 00 14 	sw (sp+20),r15
    1d48:	5b 90 00 10 	sw (sp+16),r16
    1d4c:	5b 91 00 0c 	sw (sp+12),r17
    1d50:	5b 92 00 08 	sw (sp+8),r18
    1d54:	5b 93 00 04 	sw (sp+4),r19
    1d58:	b8 20 40 00 	mv r8,r1
    1d5c:	78 01 00 00 	mvhi r1,0x0
    1d60:	38 21 2b 78 	ori r1,r1,0x2b78
    1d64:	20 e9 00 40 	andi r9,r7,0x40
    1d68:	28 2c 00 00 	lw r12,(r1+0)
    1d6c:	5d 20 00 04 	bne r9,r0,1d7c <number+0x4c>
    1d70:	78 01 00 00 	mvhi r1,0x0
    1d74:	38 21 2b 7c 	ori r1,r1,0x2b7c
    1d78:	28 2c 00 00 	lw r12,(r1+0)
    1d7c:	20 f0 00 10 	andi r16,r7,0x10
    1d80:	34 89 ff fe 	addi r9,r4,-2
    1d84:	34 0a 00 22 	mvi r10,34
    1d88:	46 00 00 82 	be r16,r0,1f90 <number+0x260>
    1d8c:	34 01 ff fe 	mvi r1,-2
    1d90:	a0 e1 38 00 	and r7,r7,r1
    1d94:	34 01 00 00 	mvi r1,0
    1d98:	55 2a 00 43 	bgu r9,r10,1ea4 <number+0x174>
    1d9c:	ba 00 90 00 	mv r18,r16
    1da0:	34 0f 00 20 	mvi r15,32
    1da4:	20 e1 00 02 	andi r1,r7,0x2
    1da8:	20 f1 00 20 	andi r17,r7,0x20
    1dac:	44 20 00 81 	be r1,r0,1fb0 <number+0x280>
    1db0:	4c 60 00 48 	bge r3,r0,1ed0 <number+0x1a0>
    1db4:	c8 03 18 00 	sub r3,r0,r3
    1db8:	34 a5 ff ff 	addi r5,r5,-1
    1dbc:	34 13 00 2d 	mvi r19,45
    1dc0:	5e 20 00 4c 	bne r17,r0,1ef0 <number+0x1c0>
    1dc4:	34 0d 00 00 	mvi r13,0
    1dc8:	37 87 00 28 	addi r7,sp,40
    1dcc:	c4 64 08 00 	modu r1,r3,r4
    1dd0:	35 a9 00 01 	addi r9,r13,1
    1dd4:	b5 81 08 00 	add r1,r12,r1
    1dd8:	40 2a 00 00 	lbu r10,(r1+0)
    1ddc:	b4 e9 08 00 	add r1,r7,r9
    1de0:	8c 64 58 00 	divu r11,r3,r4
    1de4:	30 2a ff ff 	sb (r1+-1),r10
    1de8:	b9 20 70 00 	mv r14,r9
    1dec:	50 64 00 82 	bgeu r3,r4,1ff4 <number+0x2c4>
    1df0:	e0 00 00 4b 	bi 1f1c <number+0x1ec>
    1df4:	50 62 00 02 	bgeu r3,r2,1dfc <number+0xcc>
    1df8:	30 6f 00 00 	sb (r3+0),r15
    1dfc:	34 63 00 01 	addi r3,r3,1
    1e00:	c8 23 28 00 	sub r5,r1,r3
    1e04:	48 a0 ff fc 	bg r5,r0,1df4 <number+0xc4>
    1e08:	a5 60 08 00 	not r1,r11
    1e0c:	14 21 00 1f 	sri r1,r1,31
    1e10:	35 65 ff ff 	addi r5,r11,-1
    1e14:	a1 61 58 00 	and r11,r11,r1
    1e18:	c8 ab 28 00 	sub r5,r5,r11
    1e1c:	35 6b 00 01 	addi r11,r11,1
    1e20:	b5 0b 40 00 	add r8,r8,r11
    1e24:	34 ab ff ff 	addi r11,r5,-1
    1e28:	c9 4e 08 00 	sub r1,r10,r14
    1e2c:	b5 01 08 00 	add r1,r8,r1
    1e30:	34 03 00 30 	mvi r3,48
    1e34:	49 4e 00 68 	bg r10,r14,1fd4 <number+0x2a4>
    1e38:	b9 00 08 00 	mv r1,r8
    1e3c:	b4 ed 20 00 	add r4,r7,r13
    1e40:	b8 20 18 00 	mv r3,r1
    1e44:	b4 29 38 00 	add r7,r1,r9
    1e48:	50 62 00 03 	bgeu r3,r2,1e54 <number+0x124>
    1e4c:	40 86 00 00 	lbu r6,(r4+0)
    1e50:	30 66 00 00 	sb (r3+0),r6
    1e54:	34 63 00 01 	addi r3,r3,1
    1e58:	c8 e3 30 00 	sub r6,r7,r3
    1e5c:	34 84 ff ff 	addi r4,r4,-1
    1e60:	48 c0 ff fa 	bg r6,r0,1e48 <number+0x118>
    1e64:	b4 29 08 00 	add r1,r1,r9
    1e68:	4c 05 00 0f 	bge r0,r5,1ea4 <number+0x174>
    1e6c:	35 64 00 01 	addi r4,r11,1
    1e70:	b8 20 18 00 	mv r3,r1
    1e74:	34 06 00 20 	mvi r6,32
    1e78:	b4 24 20 00 	add r4,r1,r4
    1e7c:	50 62 00 02 	bgeu r3,r2,1e84 <number+0x154>
    1e80:	30 66 00 00 	sb (r3+0),r6
    1e84:	34 63 00 01 	addi r3,r3,1
    1e88:	c8 83 28 00 	sub r5,r4,r3
    1e8c:	48 a0 ff fc 	bg r5,r0,1e7c <number+0x14c>
    1e90:	a5 60 10 00 	not r2,r11
    1e94:	14 42 00 1f 	sri r2,r2,31
    1e98:	a1 62 10 00 	and r2,r11,r2
    1e9c:	34 42 00 01 	addi r2,r2,1
    1ea0:	b4 22 08 00 	add r1,r1,r2
    1ea4:	2b 8b 00 24 	lw r11,(sp+36)
    1ea8:	2b 8c 00 20 	lw r12,(sp+32)
    1eac:	2b 8d 00 1c 	lw r13,(sp+28)
    1eb0:	2b 8e 00 18 	lw r14,(sp+24)
    1eb4:	2b 8f 00 14 	lw r15,(sp+20)
    1eb8:	2b 90 00 10 	lw r16,(sp+16)
    1ebc:	2b 91 00 0c 	lw r17,(sp+12)
    1ec0:	2b 92 00 08 	lw r18,(sp+8)
    1ec4:	2b 93 00 04 	lw r19,(sp+4)
    1ec8:	37 9c 00 68 	addi sp,sp,104
    1ecc:	c3 a0 00 00 	ret
    1ed0:	20 e1 00 04 	andi r1,r7,0x4
    1ed4:	5c 20 00 4b 	bne r1,r0,2000 <number+0x2d0>
    1ed8:	20 e7 00 08 	andi r7,r7,0x8
    1edc:	34 13 00 00 	mvi r19,0
    1ee0:	44 e0 00 03 	be r7,r0,1eec <number+0x1bc>
    1ee4:	34 a5 ff ff 	addi r5,r5,-1
    1ee8:	34 13 00 20 	mvi r19,32
    1eec:	46 20 00 05 	be r17,r0,1f00 <number+0x1d0>
    1ef0:	34 01 00 10 	mvi r1,16
    1ef4:	44 81 00 54 	be r4,r1,2044 <number+0x314>
    1ef8:	64 81 00 08 	cmpei r1,r4,8
    1efc:	c8 a1 28 00 	sub r5,r5,r1
    1f00:	5c 60 ff b1 	bne r3,r0,1dc4 <number+0x94>
    1f04:	34 01 00 30 	mvi r1,48
    1f08:	33 81 00 28 	sb (sp+40),r1
    1f0c:	34 0d 00 00 	mvi r13,0
    1f10:	34 0e 00 01 	mvi r14,1
    1f14:	34 09 00 01 	mvi r9,1
    1f18:	37 87 00 28 	addi r7,sp,40
    1f1c:	b9 c0 50 00 	mv r10,r14
    1f20:	4d c6 00 02 	bge r14,r6,1f28 <number+0x1f8>
    1f24:	b8 c0 50 00 	mv r10,r6
    1f28:	c8 aa 28 00 	sub r5,r5,r10
    1f2c:	34 ab ff ff 	addi r11,r5,-1
    1f30:	5e 40 00 07 	bne r18,r0,1f4c <number+0x21c>
    1f34:	b5 05 08 00 	add r1,r8,r5
    1f38:	34 03 00 20 	mvi r3,32
    1f3c:	48 a0 00 1f 	bg r5,r0,1fb8 <number+0x288>
    1f40:	34 a1 ff fe 	addi r1,r5,-2
    1f44:	b9 60 28 00 	mv r5,r11
    1f48:	b8 20 58 00 	mv r11,r1
    1f4c:	46 60 00 04 	be r19,r0,1f5c <number+0x22c>
    1f50:	51 02 00 02 	bgeu r8,r2,1f58 <number+0x228>
    1f54:	31 13 00 00 	sb (r8+0),r19
    1f58:	35 08 00 01 	addi r8,r8,1
    1f5c:	46 20 00 05 	be r17,r0,1f70 <number+0x240>
    1f60:	34 01 00 08 	mvi r1,8
    1f64:	44 81 00 33 	be r4,r1,2030 <number+0x300>
    1f68:	34 01 00 10 	mvi r1,16
    1f6c:	44 81 00 28 	be r4,r1,200c <number+0x2dc>
    1f70:	5e 00 ff ae 	bne r16,r0,1e28 <number+0xf8>
    1f74:	35 64 00 01 	addi r4,r11,1
    1f78:	b9 00 18 00 	mv r3,r8
    1f7c:	b5 04 08 00 	add r1,r8,r4
    1f80:	48 a0 ff 9d 	bg r5,r0,1df4 <number+0xc4>
    1f84:	b9 60 28 00 	mv r5,r11
    1f88:	35 6b ff ff 	addi r11,r11,-1
    1f8c:	e3 ff ff a7 	bi 1e28 <number+0xf8>
    1f90:	34 01 00 00 	mvi r1,0
    1f94:	55 2a ff c4 	bgu r9,r10,1ea4 <number+0x174>
    1f98:	20 e1 00 01 	andi r1,r7,0x1
    1f9c:	20 f2 00 11 	andi r18,r7,0x11
    1fa0:	34 0f 00 30 	mvi r15,48
    1fa4:	5c 20 ff 80 	bne r1,r0,1da4 <number+0x74>
    1fa8:	34 0f 00 20 	mvi r15,32
    1fac:	e3 ff ff 7e 	bi 1da4 <number+0x74>
    1fb0:	34 13 00 00 	mvi r19,0
    1fb4:	e3 ff ff ce 	bi 1eec <number+0x1bc>
    1fb8:	51 02 00 02 	bgeu r8,r2,1fc0 <number+0x290>
    1fbc:	31 03 00 00 	sb (r8+0),r3
    1fc0:	35 08 00 01 	addi r8,r8,1
    1fc4:	5d 01 ff fd 	bne r8,r1,1fb8 <number+0x288>
    1fc8:	34 0b ff fe 	mvi r11,-2
    1fcc:	34 05 ff ff 	mvi r5,-1
    1fd0:	e3 ff ff df 	bi 1f4c <number+0x21c>
    1fd4:	51 02 00 02 	bgeu r8,r2,1fdc <number+0x2ac>
    1fd8:	31 03 00 00 	sb (r8+0),r3
    1fdc:	35 08 00 01 	addi r8,r8,1
    1fe0:	5d 01 ff fd 	bne r8,r1,1fd4 <number+0x2a4>
    1fe4:	b4 ed 20 00 	add r4,r7,r13
    1fe8:	b8 20 18 00 	mv r3,r1
    1fec:	b4 29 38 00 	add r7,r1,r9
    1ff0:	e3 ff ff 96 	bi 1e48 <number+0x118>
    1ff4:	b9 20 68 00 	mv r13,r9
    1ff8:	b9 60 18 00 	mv r3,r11
    1ffc:	e3 ff ff 74 	bi 1dcc <number+0x9c>
    2000:	34 a5 ff ff 	addi r5,r5,-1
    2004:	34 13 00 2b 	mvi r19,43
    2008:	e3 ff ff b9 	bi 1eec <number+0x1bc>
    200c:	51 02 00 03 	bgeu r8,r2,2018 <number+0x2e8>
    2010:	34 01 00 30 	mvi r1,48
    2014:	31 01 00 00 	sb (r8+0),r1
    2018:	35 01 00 01 	addi r1,r8,1
    201c:	50 22 00 03 	bgeu r1,r2,2028 <number+0x2f8>
    2020:	11 81 00 21 	lb r1,(r12+33)
    2024:	31 01 00 01 	sb (r8+1),r1
    2028:	35 08 00 02 	addi r8,r8,2
    202c:	e3 ff ff d1 	bi 1f70 <number+0x240>
    2030:	51 02 00 03 	bgeu r8,r2,203c <number+0x30c>
    2034:	34 01 00 30 	mvi r1,48
    2038:	31 01 00 00 	sb (r8+0),r1
    203c:	35 08 00 01 	addi r8,r8,1
    2040:	e3 ff ff cc 	bi 1f70 <number+0x240>
    2044:	34 a5 ff fe 	addi r5,r5,-2
    2048:	e3 ff ff ae 	bi 1f00 <number+0x1d0>

0000204c <vscnprintf>:
    204c:	37 9c ff f8 	addi sp,sp,-8
    2050:	5b 8b 00 08 	sw (sp+8),r11
    2054:	5b 9d 00 04 	sw (sp+4),ra
    2058:	b8 40 58 00 	mv r11,r2
    205c:	fb ff f8 50 	calli 19c <vsnprintf>
    2060:	49 61 00 02 	bg r11,r1,2068 <vscnprintf+0x1c>
    2064:	35 61 ff ff 	addi r1,r11,-1
    2068:	2b 9d 00 04 	lw ra,(sp+4)
    206c:	2b 8b 00 08 	lw r11,(sp+8)
    2070:	37 9c 00 08 	addi sp,sp,8
    2074:	c3 a0 00 00 	ret

00002078 <snprintf>:
    2078:	37 9c ff e4 	addi sp,sp,-28
    207c:	5b 9d 00 04 	sw (sp+4),ra
    2080:	5b 84 00 0c 	sw (sp+12),r4
    2084:	37 84 00 0c 	addi r4,sp,12
    2088:	5b 83 00 08 	sw (sp+8),r3
    208c:	5b 85 00 10 	sw (sp+16),r5
    2090:	5b 86 00 14 	sw (sp+20),r6
    2094:	5b 87 00 18 	sw (sp+24),r7
    2098:	5b 88 00 1c 	sw (sp+28),r8
    209c:	fb ff f8 40 	calli 19c <vsnprintf>
    20a0:	2b 9d 00 04 	lw ra,(sp+4)
    20a4:	37 9c 00 1c 	addi sp,sp,28
    20a8:	c3 a0 00 00 	ret

000020ac <scnprintf>:
    20ac:	37 9c ff e0 	addi sp,sp,-32
    20b0:	5b 8b 00 08 	sw (sp+8),r11
    20b4:	5b 9d 00 04 	sw (sp+4),ra
    20b8:	5b 84 00 10 	sw (sp+16),r4
    20bc:	37 84 00 10 	addi r4,sp,16
    20c0:	b8 40 58 00 	mv r11,r2
    20c4:	5b 83 00 0c 	sw (sp+12),r3
    20c8:	5b 85 00 14 	sw (sp+20),r5
    20cc:	5b 86 00 18 	sw (sp+24),r6
    20d0:	5b 87 00 1c 	sw (sp+28),r7
    20d4:	5b 88 00 20 	sw (sp+32),r8
    20d8:	fb ff f8 31 	calli 19c <vsnprintf>
    20dc:	49 61 00 02 	bg r11,r1,20e4 <scnprintf+0x38>
    20e0:	35 61 ff ff 	addi r1,r11,-1
    20e4:	2b 9d 00 04 	lw ra,(sp+4)
    20e8:	2b 8b 00 08 	lw r11,(sp+8)
    20ec:	37 9c 00 20 	addi sp,sp,32
    20f0:	c3 a0 00 00 	ret

000020f4 <vsprintf>:
    20f4:	37 9c ff fc 	addi sp,sp,-4
    20f8:	5b 9d 00 04 	sw (sp+4),ra
    20fc:	b8 60 20 00 	mv r4,r3
    2100:	b8 40 18 00 	mv r3,r2
    2104:	38 02 ff ff 	mvu r2,0xffff
    2108:	78 42 7f ff 	orhi r2,r2,0x7fff
    210c:	fb ff f8 24 	calli 19c <vsnprintf>
    2110:	2b 9d 00 04 	lw ra,(sp+4)
    2114:	37 9c 00 04 	addi sp,sp,4
    2118:	c3 a0 00 00 	ret

0000211c <sprintf>:
    211c:	37 9c ff e0 	addi sp,sp,-32
    2120:	5b 9d 00 04 	sw (sp+4),ra
    2124:	5b 82 00 08 	sw (sp+8),r2
    2128:	5b 83 00 0c 	sw (sp+12),r3
    212c:	5b 84 00 10 	sw (sp+16),r4
    2130:	b8 40 18 00 	mv r3,r2
    2134:	37 84 00 0c 	addi r4,sp,12
    2138:	38 02 ff ff 	mvu r2,0xffff
    213c:	78 42 7f ff 	orhi r2,r2,0x7fff
    2140:	5b 85 00 14 	sw (sp+20),r5
    2144:	5b 86 00 18 	sw (sp+24),r6
    2148:	5b 87 00 1c 	sw (sp+28),r7
    214c:	5b 88 00 20 	sw (sp+32),r8
    2150:	fb ff f8 13 	calli 19c <vsnprintf>
    2154:	2b 9d 00 04 	lw ra,(sp+4)
    2158:	37 9c 00 20 	addi sp,sp,32
    215c:	c3 a0 00 00 	ret

00002160 <rand>:
    2160:	78 01 00 00 	mvhi r1,0x0
    2164:	38 21 2b 80 	ori r1,r1,0x2b80
    2168:	28 22 00 00 	lw r2,(r1+0)
    216c:	28 43 00 00 	lw r3,(r2+0)
    2170:	3c 61 00 07 	sli r1,r3,7
    2174:	b4 23 08 00 	add r1,r1,r3
    2178:	38 03 62 e9 	mvu r3,0x62e9
    217c:	78 63 36 19 	orhi r3,r3,0x3619
    2180:	b4 23 08 00 	add r1,r1,r3
    2184:	58 41 00 00 	sw (r2+0),r1
    2188:	c3 a0 00 00 	ret

0000218c <abort>:
    218c:	37 9c ff fc 	addi sp,sp,-4
    2190:	5b 9d 00 04 	sw (sp+4),ra
    2194:	78 02 00 00 	mvhi r2,0x0
    2198:	38 42 2b 84 	ori r2,r2,0x2b84
    219c:	28 41 00 00 	lw r1,(r2+0)
    21a0:	fb ff fb f1 	calli 1164 <printf>
    21a4:	e0 00 00 00 	bi 21a4 <abort+0x18>

000021a8 <flash_block_erase>:
    21a8:	38 02 ff ff 	mvu r2,0xffff
    21ac:	78 42 00 ff 	orhi r2,r2,0xff
    21b0:	78 03 10 00 	mvhi r3,0x1000
    21b4:	a0 22 08 00 	and r1,r1,r2
    21b8:	78 02 06 00 	mvhi r2,0x600
    21bc:	58 62 00 00 	sw (r3+0),r2
    21c0:	78 02 d8 00 	mvhi r2,0xd800
    21c4:	b8 22 08 00 	or r1,r1,r2
    21c8:	58 61 00 00 	sw (r3+0),r1
    21cc:	38 02 10 50 	mvu r2,0x1050
    21d0:	78 42 30 00 	orhi r2,r2,0x3000
    21d4:	28 43 00 00 	lw r3,(r2+0)
    21d8:	38 01 67 e0 	mvu r1,0x67e0
    21dc:	78 21 00 35 	orhi r1,r1,0x35
    21e0:	b4 61 18 00 	add r3,r3,r1
    21e4:	28 41 00 00 	lw r1,(r2+0)
    21e8:	54 61 ff ff 	bgu r3,r1,21e4 <flash_block_erase+0x3c>
    21ec:	c3 a0 00 00 	ret

000021f0 <flash_page_program>:
    21f0:	38 03 01 00 	mvu r3,0x100
    21f4:	78 63 10 00 	orhi r3,r3,0x1000
    21f8:	38 07 fe fc 	mvu r7,0xfefc
    21fc:	78 e7 ef ff 	orhi r7,r7,0xefff
    2200:	38 06 02 00 	mvu r6,0x200
    2204:	78 c6 10 00 	orhi r6,r6,0x1000
    2208:	34 65 00 04 	addi r5,r3,4
    220c:	b4 a7 20 00 	add r4,r5,r7
    2210:	b4 44 20 00 	add r4,r2,r4
    2214:	28 84 00 00 	lw r4,(r4+0)
    2218:	58 64 00 00 	sw (r3+0),r4
    221c:	b8 a0 18 00 	mv r3,r5
    2220:	5c a6 ff fa 	bne r5,r6,2208 <flash_page_program+0x18>
    2224:	38 02 ff ff 	mvu r2,0xffff
    2228:	78 42 00 ff 	orhi r2,r2,0xff
    222c:	78 03 10 00 	mvhi r3,0x1000
    2230:	a0 22 08 00 	and r1,r1,r2
    2234:	78 02 06 00 	mvhi r2,0x600
    2238:	58 62 00 00 	sw (r3+0),r2
    223c:	78 02 02 00 	mvhi r2,0x200
    2240:	b8 22 08 00 	or r1,r1,r2
    2244:	58 61 00 00 	sw (r3+0),r1
    2248:	38 02 10 50 	mvu r2,0x1050
    224c:	78 42 30 00 	orhi r2,r2,0x3000
    2250:	28 43 00 00 	lw r3,(r2+0)
    2254:	34 63 1b 58 	addi r3,r3,7000
    2258:	28 41 00 00 	lw r1,(r2+0)
    225c:	54 61 ff ff 	bgu r3,r1,2258 <flash_page_program+0x68>
    2260:	c3 a0 00 00 	ret

00002264 <flash_write_data>:
    2264:	37 9c ff c4 	addi sp,sp,-60
    2268:	5b 8b 00 3c 	sw (sp+60),r11
    226c:	5b 8c 00 38 	sw (sp+56),r12
    2270:	5b 8d 00 34 	sw (sp+52),r13
    2274:	5b 8e 00 30 	sw (sp+48),r14
    2278:	5b 8f 00 2c 	sw (sp+44),r15
    227c:	5b 90 00 28 	sw (sp+40),r16
    2280:	5b 91 00 24 	sw (sp+36),r17
    2284:	5b 92 00 20 	sw (sp+32),r18
    2288:	5b 93 00 1c 	sw (sp+28),r19
    228c:	5b 94 00 18 	sw (sp+24),r20
    2290:	5b 95 00 14 	sw (sp+20),r21
    2294:	5b 96 00 10 	sw (sp+16),r22
    2298:	5b 97 00 0c 	sw (sp+12),r23
    229c:	5b 98 00 08 	sw (sp+8),r24
    22a0:	5b 9d 00 04 	sw (sp+4),ra
    22a4:	00 50 00 10 	srui r16,r2,16
    22a8:	b8 40 78 00 	mv r15,r2
    22ac:	78 02 00 00 	mvhi r2,0x0
    22b0:	38 42 2c 30 	ori r2,r2,0x2c30
    22b4:	b8 20 58 00 	mv r11,r1
    22b8:	28 41 00 00 	lw r1,(r2+0)
    22bc:	36 02 00 01 	addi r2,r16,1
    22c0:	b8 60 70 00 	mv r14,r3
    22c4:	fb ff fb a8 	calli 1164 <printf>
    22c8:	78 01 00 00 	mvhi r1,0x0
    22cc:	38 21 2c 34 	ori r1,r1,0x2c34
    22d0:	28 32 00 00 	lw r18,(r1+0)
    22d4:	b9 c0 68 00 	mv r13,r14
    22d8:	34 17 00 00 	mvi r23,0
    22dc:	78 18 10 00 	mvhi r24,0x1000
    22e0:	78 16 06 00 	mvhi r22,0x600
    22e4:	38 15 ff ff 	mvu r21,0xffff
    22e8:	7a b5 00 ff 	orhi r21,r21,0xff
    22ec:	78 14 d8 00 	mvhi r20,0xd800
    22f0:	38 0c 10 50 	mvu r12,0x1050
    22f4:	79 8c 30 00 	orhi r12,r12,0x3000
    22f8:	38 13 67 e0 	mvu r19,0x67e0
    22fc:	7a 73 00 35 	orhi r19,r19,0x35
    2300:	78 11 00 01 	mvhi r17,0x1
    2304:	a1 b5 08 00 	and r1,r13,r21
    2308:	5b 16 00 00 	sw (r24+0),r22
    230c:	b8 34 08 00 	or r1,r1,r20
    2310:	5b 01 00 00 	sw (r24+0),r1
    2314:	29 82 00 00 	lw r2,(r12+0)
    2318:	b4 53 10 00 	add r2,r2,r19
    231c:	29 81 00 00 	lw r1,(r12+0)
    2320:	54 41 ff ff 	bgu r2,r1,231c <flash_write_data+0xb8>
    2324:	b9 a0 18 00 	mv r3,r13
    2328:	ba e0 10 00 	mv r2,r23
    232c:	ba 40 08 00 	mv r1,r18
    2330:	fb ff fb 8d 	calli 1164 <printf>
    2334:	b5 b1 68 00 	add r13,r13,r17
    2338:	36 e1 00 01 	addi r1,r23,1
    233c:	46 17 00 03 	be r16,r23,2348 <flash_write_data+0xe4>
    2340:	b8 20 b8 00 	mv r23,r1
    2344:	e3 ff ff f0 	bi 2304 <flash_write_data+0xa0>
    2348:	78 02 00 00 	mvhi r2,0x0
    234c:	38 42 2c 38 	ori r2,r2,0x2c38
    2350:	28 50 00 00 	lw r16,(r2+0)
    2354:	01 ef 00 08 	srui r15,r15,8
    2358:	34 16 00 00 	mvi r22,0
    235c:	c9 cb 70 00 	sub r14,r14,r11
    2360:	38 14 01 00 	mvu r20,0x100
    2364:	7a 94 10 00 	orhi r20,r20,0x1000
    2368:	38 0d fe fc 	mvu r13,0xfefc
    236c:	79 ad ef ff 	orhi r13,r13,0xefff
    2370:	38 0c 02 00 	mvu r12,0x200
    2374:	79 8c 10 00 	orhi r12,r12,0x1000
    2378:	78 17 10 00 	mvhi r23,0x1000
    237c:	78 13 06 00 	mvhi r19,0x600
    2380:	38 12 ff ff 	mvu r18,0xffff
    2384:	7a 52 00 ff 	orhi r18,r18,0xff
    2388:	78 11 02 00 	mvhi r17,0x200
    238c:	38 15 10 50 	mvu r21,0x1050
    2390:	7a b5 30 00 	orhi r21,r21,0x3000
    2394:	b5 6e 20 00 	add r4,r11,r14
    2398:	ba 80 08 00 	mv r1,r20
    239c:	34 23 00 04 	addi r3,r1,4
    23a0:	b4 6d 10 00 	add r2,r3,r13
    23a4:	b5 62 10 00 	add r2,r11,r2
    23a8:	28 42 00 00 	lw r2,(r2+0)
    23ac:	58 22 00 00 	sw (r1+0),r2
    23b0:	b8 60 08 00 	mv r1,r3
    23b4:	5c 6c ff fa 	bne r3,r12,239c <flash_write_data+0x138>
    23b8:	a0 92 08 00 	and r1,r4,r18
    23bc:	5a f3 00 00 	sw (r23+0),r19
    23c0:	b8 31 08 00 	or r1,r1,r17
    23c4:	5a e1 00 00 	sw (r23+0),r1
    23c8:	2a a2 00 00 	lw r2,(r21+0)
    23cc:	34 42 1b 58 	addi r2,r2,7000
    23d0:	2a a1 00 00 	lw r1,(r21+0)
    23d4:	54 41 ff ff 	bgu r2,r1,23d0 <flash_write_data+0x16c>
    23d8:	ba c0 10 00 	mv r2,r22
    23dc:	ba 00 08 00 	mv r1,r16
    23e0:	fb ff fb 61 	calli 1164 <printf>
    23e4:	35 6b 01 00 	addi r11,r11,256
    23e8:	36 c1 00 01 	addi r1,r22,1
    23ec:	45 f6 00 03 	be r15,r22,23f8 <flash_write_data+0x194>
    23f0:	b8 20 b0 00 	mv r22,r1
    23f4:	e3 ff ff e8 	bi 2394 <flash_write_data+0x130>
    23f8:	2b 9d 00 04 	lw ra,(sp+4)
    23fc:	2b 8b 00 3c 	lw r11,(sp+60)
    2400:	2b 8c 00 38 	lw r12,(sp+56)
    2404:	2b 8d 00 34 	lw r13,(sp+52)
    2408:	2b 8e 00 30 	lw r14,(sp+48)
    240c:	2b 8f 00 2c 	lw r15,(sp+44)
    2410:	2b 90 00 28 	lw r16,(sp+40)
    2414:	2b 91 00 24 	lw r17,(sp+36)
    2418:	2b 92 00 20 	lw r18,(sp+32)
    241c:	2b 93 00 1c 	lw r19,(sp+28)
    2420:	2b 94 00 18 	lw r20,(sp+24)
    2424:	2b 95 00 14 	lw r21,(sp+20)
    2428:	2b 96 00 10 	lw r22,(sp+16)
    242c:	2b 97 00 0c 	lw r23,(sp+12)
    2430:	2b 98 00 08 	lw r24,(sp+8)
    2434:	37 9c 00 3c 	addi sp,sp,60
    2438:	c3 a0 00 00 	ret
