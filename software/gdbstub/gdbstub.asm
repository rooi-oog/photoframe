
./gdbstub.elf:     file format elf32-lm32


Disassembly of section .text:

40000000 <_ftext>:
40000000:	98 00 00 00 	xor r0,r0,r0
40000004:	d0 00 00 00 	wcsr IE,r0
40000008:	34 1f 00 00 	mvi ba,0
4000000c:	e0 00 00 05 	bi 40000020 <_breakpoint_handler>
40000010:	34 00 00 00 	nop
40000014:	34 00 00 00 	nop
40000018:	34 00 00 00 	nop
4000001c:	34 00 00 00 	nop

40000020 <_breakpoint_handler>:
40000020:	98 00 00 00 	xor r0,r0,r0
40000024:	78 00 40 00 	mvhi r0,0x4000
40000028:	38 00 1f fc 	mvu r0,0x1ffc
4000002c:	58 1d 00 00 	sw (r0+0),ra
40000030:	f8 00 00 34 	calli 40000100 <save_all>
40000034:	5b 9f 00 80 	sw (sp+128),ba
40000038:	f8 00 01 d2 	calli 40000780 <handle_exception>
4000003c:	e0 00 00 8f 	bi 40000278 <b_restore_and_return>

40000040 <_instruction_bus_error_handler>:
40000040:	98 00 00 00 	xor r0,r0,r0
40000044:	78 00 40 00 	mvhi r0,0x4000
40000048:	38 00 1f fc 	mvu r0,0x1ffc
4000004c:	58 1d 00 00 	sw (r0+0),ra
40000050:	f8 00 00 2c 	calli 40000100 <save_all>
40000054:	5b 9e 00 80 	sw (sp+128),ea
40000058:	f8 00 01 ca 	calli 40000780 <handle_exception>
4000005c:	e0 00 00 79 	bi 40000240 <e_restore_and_return>

40000060 <_watchpoint_handler>:
40000060:	98 00 00 00 	xor r0,r0,r0
40000064:	78 00 40 00 	mvhi r0,0x4000
40000068:	38 00 1f fc 	mvu r0,0x1ffc
4000006c:	58 1d 00 00 	sw (r0+0),ra
40000070:	f8 00 00 24 	calli 40000100 <save_all>
40000074:	5b 9f 00 80 	sw (sp+128),ba
40000078:	f8 00 01 c2 	calli 40000780 <handle_exception>
4000007c:	e0 00 00 7f 	bi 40000278 <b_restore_and_return>

40000080 <_data_bus_error_handler>:
40000080:	98 00 00 00 	xor r0,r0,r0
40000084:	78 00 40 00 	mvhi r0,0x4000
40000088:	38 00 1f fc 	mvu r0,0x1ffc
4000008c:	58 1d 00 00 	sw (r0+0),ra
40000090:	f8 00 00 1c 	calli 40000100 <save_all>
40000094:	5b 9e 00 80 	sw (sp+128),ea
40000098:	f8 00 01 ba 	calli 40000780 <handle_exception>
4000009c:	e0 00 00 69 	bi 40000240 <e_restore_and_return>

400000a0 <_divide_by_zero_handler>:
400000a0:	98 00 00 00 	xor r0,r0,r0
400000a4:	78 00 40 00 	mvhi r0,0x4000
400000a8:	38 00 1f fc 	mvu r0,0x1ffc
400000ac:	58 1d 00 00 	sw (r0+0),ra
400000b0:	f8 00 00 14 	calli 40000100 <save_all>
400000b4:	5b 9e 00 80 	sw (sp+128),ea
400000b8:	f8 00 01 b2 	calli 40000780 <handle_exception>
400000bc:	e0 00 00 61 	bi 40000240 <e_restore_and_return>

400000c0 <_interrupt_handler>:
400000c0:	98 00 00 00 	xor r0,r0,r0
400000c4:	78 00 40 00 	mvhi r0,0x4000
400000c8:	38 00 1f fc 	mvu r0,0x1ffc
400000cc:	58 1d 00 00 	sw (r0+0),ra
400000d0:	f8 00 00 0c 	calli 40000100 <save_all>
400000d4:	5b 9e 00 80 	sw (sp+128),ea
400000d8:	f8 00 01 aa 	calli 40000780 <handle_exception>
400000dc:	e0 00 00 59 	bi 40000240 <e_restore_and_return>

400000e0 <_system_call_handler>:
400000e0:	98 00 00 00 	xor r0,r0,r0
400000e4:	78 00 40 00 	mvhi r0,0x4000
400000e8:	38 00 1f fc 	mvu r0,0x1ffc
400000ec:	58 1d 00 00 	sw (r0+0),ra
400000f0:	f8 00 00 04 	calli 40000100 <save_all>
400000f4:	5b 9e 00 80 	sw (sp+128),ea
400000f8:	f8 00 01 a2 	calli 40000780 <handle_exception>
400000fc:	e0 00 00 51 	bi 40000240 <e_restore_and_return>

40000100 <save_all>:
40000100:	34 00 ff 64 	mvi r0,-156
40000104:	58 01 00 04 	sw (r0+4),r1
40000108:	58 02 00 08 	sw (r0+8),r2
4000010c:	58 03 00 0c 	sw (r0+12),r3
40000110:	58 04 00 10 	sw (r0+16),r4
40000114:	58 05 00 14 	sw (r0+20),r5
40000118:	58 06 00 18 	sw (r0+24),r6
4000011c:	58 07 00 1c 	sw (r0+28),r7
40000120:	58 08 00 20 	sw (r0+32),r8
40000124:	58 09 00 24 	sw (r0+36),r9
40000128:	58 0a 00 28 	sw (r0+40),r10
4000012c:	58 0b 00 2c 	sw (r0+44),r11
40000130:	58 0c 00 30 	sw (r0+48),r12
40000134:	58 0d 00 34 	sw (r0+52),r13
40000138:	58 0e 00 38 	sw (r0+56),r14
4000013c:	58 0f 00 3c 	sw (r0+60),r15
40000140:	58 10 00 40 	sw (r0+64),r16
40000144:	58 11 00 44 	sw (r0+68),r17
40000148:	58 12 00 48 	sw (r0+72),r18
4000014c:	58 13 00 4c 	sw (r0+76),r19
40000150:	58 14 00 50 	sw (r0+80),r20
40000154:	58 15 00 54 	sw (r0+84),r21
40000158:	58 16 00 58 	sw (r0+88),r22
4000015c:	58 17 00 5c 	sw (r0+92),r23
40000160:	58 18 00 60 	sw (r0+96),r24
40000164:	58 19 00 64 	sw (r0+100),r25
40000168:	58 1a 00 68 	sw (r0+104),gp
4000016c:	58 1b 00 6c 	sw (r0+108),fp
40000170:	58 1c 00 70 	sw (r0+112),sp
40000174:	58 1e 00 78 	sw (r0+120),ea
40000178:	58 1f 00 7c 	sw (r0+124),ba
4000017c:	90 e0 08 00 	rcsr r1,EBA
40000180:	58 01 00 88 	sw (r0+136),r1
40000184:	91 20 08 00 	rcsr r1,DEBA
40000188:	58 01 00 8c 	sw (r0+140),r1
4000018c:	90 00 08 00 	rcsr r1,IE
40000190:	58 01 00 90 	sw (r0+144),r1
40000194:	90 20 08 00 	rcsr r1,IM
40000198:	58 01 00 94 	sw (r0+148),r1
4000019c:	90 40 08 00 	rcsr r1,IP
400001a0:	58 01 00 98 	sw (r0+152),r1
400001a4:	23 a1 00 ff 	andi r1,ra,0xff
400001a8:	00 21 00 05 	srui r1,r1,5
400001ac:	58 01 00 84 	sw (r0+132),r1
400001b0:	58 00 00 74 	sw (r0+116),r0
400001b4:	28 1c 00 74 	lw sp,(r0+116)
400001b8:	98 00 00 00 	xor r0,r0,r0
400001bc:	2b 81 00 9c 	lw r1,(sp+156)
400001c0:	5b 81 00 74 	sw (sp+116),r1
400001c4:	5b 80 00 00 	sw (sp+0),r0
400001c8:	bb 80 08 00 	mv r1,sp
400001cc:	c3 a0 00 00 	ret

400001d0 <restore_gp>:
400001d0:	2b 81 00 04 	lw r1,(sp+4)
400001d4:	2b 82 00 08 	lw r2,(sp+8)
400001d8:	2b 83 00 0c 	lw r3,(sp+12)
400001dc:	2b 84 00 10 	lw r4,(sp+16)
400001e0:	2b 85 00 14 	lw r5,(sp+20)
400001e4:	2b 86 00 18 	lw r6,(sp+24)
400001e8:	2b 87 00 1c 	lw r7,(sp+28)
400001ec:	2b 88 00 20 	lw r8,(sp+32)
400001f0:	2b 89 00 24 	lw r9,(sp+36)
400001f4:	2b 8a 00 28 	lw r10,(sp+40)
400001f8:	2b 8b 00 2c 	lw r11,(sp+44)
400001fc:	2b 8c 00 30 	lw r12,(sp+48)
40000200:	2b 8d 00 34 	lw r13,(sp+52)
40000204:	2b 8e 00 38 	lw r14,(sp+56)
40000208:	2b 8f 00 3c 	lw r15,(sp+60)
4000020c:	2b 90 00 40 	lw r16,(sp+64)
40000210:	2b 91 00 44 	lw r17,(sp+68)
40000214:	2b 92 00 48 	lw r18,(sp+72)
40000218:	2b 93 00 4c 	lw r19,(sp+76)
4000021c:	2b 94 00 50 	lw r20,(sp+80)
40000220:	2b 95 00 54 	lw r21,(sp+84)
40000224:	2b 96 00 58 	lw r22,(sp+88)
40000228:	2b 97 00 5c 	lw r23,(sp+92)
4000022c:	2b 98 00 60 	lw r24,(sp+96)
40000230:	2b 99 00 64 	lw r25,(sp+100)
40000234:	2b 9a 00 68 	lw gp,(sp+104)
40000238:	2b 9b 00 6c 	lw fp,(sp+108)
4000023c:	c3 a0 00 00 	ret

40000240 <e_restore_and_return>:
40000240:	fb ff ff e4 	calli 400001d0 <restore_gp>
40000244:	2b 9d 00 74 	lw ra,(sp+116)
40000248:	2b 9f 00 7c 	lw ba,(sp+124)
4000024c:	2b 9e 00 88 	lw ea,(sp+136)
40000250:	d0 fe 00 00 	wcsr EBA,ea
40000254:	2b 9e 00 8c 	lw ea,(sp+140)
40000258:	d1 3e 00 00 	wcsr DEBA,ea
4000025c:	2b 9e 00 90 	lw ea,(sp+144)
40000260:	d0 1e 00 00 	wcsr IE,ea
40000264:	2b 9e 00 94 	lw ea,(sp+148)
40000268:	d0 3e 00 00 	wcsr IM,ea
4000026c:	2b 9e 00 80 	lw ea,(sp+128)
40000270:	2b 9c 00 70 	lw sp,(sp+112)
40000274:	c3 c0 00 00 	eret

40000278 <b_restore_and_return>:
40000278:	fb ff ff d6 	calli 400001d0 <restore_gp>
4000027c:	2b 9d 00 74 	lw ra,(sp+116)
40000280:	2b 9e 00 78 	lw ea,(sp+120)
40000284:	2b 9f 00 88 	lw ba,(sp+136)
40000288:	d0 ff 00 00 	wcsr EBA,ba
4000028c:	2b 9f 00 8c 	lw ba,(sp+140)
40000290:	d1 3f 00 00 	wcsr DEBA,ba
40000294:	2b 9f 00 90 	lw ba,(sp+144)
40000298:	d0 1f 00 00 	wcsr IE,ba
4000029c:	2b 9f 00 94 	lw ba,(sp+148)
400002a0:	d0 3f 00 00 	wcsr IM,ba
400002a4:	2b 9f 00 80 	lw ba,(sp+128)
400002a8:	2b 9c 00 70 	lw sp,(sp+112)
400002ac:	c3 e0 00 00 	bret

400002b0 <clear_bss>:
400002b0:	78 01 40 00 	mvhi r1,0x4000
400002b4:	38 21 18 00 	ori r1,r1,0x1800
400002b8:	78 02 40 00 	mvhi r2,0x4000
400002bc:	38 42 1e 74 	ori r2,r2,0x1e74
400002c0:	44 22 00 04 	be r1,r2,400002d0 <clear_bss+0x20>
400002c4:	58 20 00 00 	sw (r1+0),r0
400002c8:	34 21 00 04 	addi r1,r1,4
400002cc:	e3 ff ff fd 	bi 400002c0 <clear_bss+0x10>
400002d0:	c3 a0 00 00 	ret

400002d4 <get_debug_char>:
400002d4:	38 02 00 08 	mvu r2,0x8
400002d8:	78 42 30 00 	orhi r2,r2,0x3000
400002dc:	28 41 00 00 	lw r1,(r2+0)
400002e0:	20 21 00 02 	andi r1,r1,0x2
400002e4:	44 20 ff fe 	be r1,r0,400002dc <get_debug_char+0x8>
400002e8:	34 01 00 02 	mvi r1,2
400002ec:	58 41 00 00 	sw (r2+0),r1
400002f0:	78 01 30 00 	mvhi r1,0x3000
400002f4:	28 21 00 00 	lw r1,(r1+0)
400002f8:	b0 20 08 00 	sextb r1,r1
400002fc:	c3 a0 00 00 	ret

40000300 <put_debug_char>:
40000300:	78 02 30 00 	mvhi r2,0x3000
40000304:	58 41 00 00 	sw (r2+0),r1
40000308:	34 42 00 08 	addi r2,r2,8
4000030c:	28 41 00 00 	lw r1,(r2+0)
40000310:	20 21 00 01 	andi r1,r1,0x1
40000314:	44 20 ff fe 	be r1,r0,4000030c <put_debug_char+0xc>
40000318:	c3 a0 00 00 	ret

4000031c <mem2hex>:
4000031c:	78 04 40 00 	mvhi r4,0x4000
40000320:	38 84 10 78 	ori r4,r4,0x1078
40000324:	28 87 00 00 	lw r7,(r4+0)
40000328:	b4 23 40 00 	add r8,r1,r3
4000032c:	b8 40 28 00 	mv r5,r2
40000330:	5c 28 00 05 	bne r1,r8,40000344 <mem2hex+0x28>
40000334:	3c 61 00 01 	sli r1,r3,1
40000338:	b4 41 08 00 	add r1,r2,r1
4000033c:	30 20 00 00 	sb (r1+0),r0
40000340:	c3 a0 00 00 	ret
40000344:	34 21 00 01 	addi r1,r1,1
40000348:	40 24 ff ff 	lbu r4,(r1+-1)
4000034c:	34 a5 00 02 	addi r5,r5,2
40000350:	00 86 00 04 	srui r6,r4,4
40000354:	20 84 00 0f 	andi r4,r4,0xf
40000358:	b4 e6 30 00 	add r6,r7,r6
4000035c:	40 c6 00 00 	lbu r6,(r6+0)
40000360:	b4 e4 20 00 	add r4,r7,r4
40000364:	40 84 00 00 	lbu r4,(r4+0)
40000368:	30 a6 ff fe 	sb (r5+-2),r6
4000036c:	30 a4 ff ff 	sb (r5+-1),r4
40000370:	e3 ff ff f0 	bi 40000330 <mem2hex+0x14>

40000374 <cmd_status>:
40000374:	37 9c ff f4 	addi sp,sp,-12
40000378:	5b 8b 00 0c 	sw (sp+12),r11
4000037c:	5b 8c 00 08 	sw (sp+8),r12
40000380:	5b 9d 00 04 	sw (sp+4),ra
40000384:	b8 20 58 00 	mv r11,r1
40000388:	28 21 00 84 	lw r1,(r1+132)
4000038c:	78 03 40 00 	mvhi r3,0x4000
40000390:	38 63 10 7c 	ori r3,r3,0x107c
40000394:	20 22 00 07 	andi r2,r1,0x7
40000398:	28 61 00 00 	lw r1,(r3+0)
4000039c:	34 0c 00 3b 	mvi r12,59
400003a0:	b4 22 08 00 	add r1,r1,r2
400003a4:	78 02 40 00 	mvhi r2,0x4000
400003a8:	38 42 10 80 	ori r2,r2,0x1080
400003ac:	10 24 00 00 	lb r4,(r1+0)
400003b0:	28 41 00 00 	lw r1,(r2+0)
400003b4:	34 02 00 54 	mvi r2,84
400003b8:	30 22 00 00 	sb (r1+0),r2
400003bc:	78 02 40 00 	mvhi r2,0x4000
400003c0:	38 42 10 84 	ori r2,r2,0x1084
400003c4:	28 43 00 00 	lw r3,(r2+0)
400003c8:	14 82 00 04 	sri r2,r4,4
400003cc:	20 84 00 0f 	andi r4,r4,0xf
400003d0:	20 42 00 0f 	andi r2,r2,0xf
400003d4:	b4 62 10 00 	add r2,r3,r2
400003d8:	40 42 00 00 	lbu r2,(r2+0)
400003dc:	b4 64 18 00 	add r3,r3,r4
400003e0:	30 22 00 01 	sb (r1+1),r2
400003e4:	40 62 00 00 	lbu r2,(r3+0)
400003e8:	34 03 00 04 	mvi r3,4
400003ec:	30 22 00 02 	sb (r1+2),r2
400003f0:	34 02 00 32 	mvi r2,50
400003f4:	30 22 00 03 	sb (r1+3),r2
400003f8:	34 02 30 3a 	mvi r2,12346
400003fc:	0c 22 00 04 	sh (r1+4),r2
40000400:	78 01 40 00 	mvhi r1,0x4000
40000404:	38 21 10 88 	ori r1,r1,0x1088
40000408:	28 22 00 00 	lw r2,(r1+0)
4000040c:	35 61 00 80 	addi r1,r11,128
40000410:	fb ff ff c3 	calli 4000031c <mem2hex>
40000414:	34 02 00 31 	mvi r2,49
40000418:	30 22 00 01 	sb (r1+1),r2
4000041c:	34 02 00 63 	mvi r2,99
40000420:	30 22 00 02 	sb (r1+2),r2
40000424:	34 02 00 3a 	mvi r2,58
40000428:	30 2c 00 00 	sb (r1+0),r12
4000042c:	30 22 00 03 	sb (r1+3),r2
40000430:	34 03 00 04 	mvi r3,4
40000434:	34 22 00 04 	addi r2,r1,4
40000438:	35 61 00 70 	addi r1,r11,112
4000043c:	fb ff ff b8 	calli 4000031c <mem2hex>
40000440:	30 2c 00 00 	sb (r1+0),r12
40000444:	30 20 00 01 	sb (r1+1),r0
40000448:	2b 9d 00 04 	lw ra,(sp+4)
4000044c:	2b 8b 00 0c 	lw r11,(sp+12)
40000450:	2b 8c 00 08 	lw r12,(sp+8)
40000454:	37 9c 00 0c 	addi sp,sp,12
40000458:	c3 a0 00 00 	ret

4000045c <hex>:
4000045c:	b8 20 18 00 	mv r3,r1
40000460:	34 21 ff 9f 	addi r1,r1,-97
40000464:	20 21 00 ff 	andi r1,r1,0xff
40000468:	34 04 00 05 	mvi r4,5
4000046c:	54 24 00 03 	bgu r1,r4,40000478 <hex+0x1c>
40000470:	34 61 ff a9 	addi r1,r3,-87
40000474:	c3 a0 00 00 	ret
40000478:	34 62 ff d0 	addi r2,r3,-48
4000047c:	20 45 00 ff 	andi r5,r2,0xff
40000480:	34 01 00 09 	mvi r1,9
40000484:	54 a1 00 03 	bgu r5,r1,40000490 <hex+0x34>
40000488:	b8 40 08 00 	mv r1,r2
4000048c:	e3 ff ff fa 	bi 40000474 <hex+0x18>
40000490:	34 62 ff bf 	addi r2,r3,-65
40000494:	20 42 00 ff 	andi r2,r2,0xff
40000498:	34 01 ff ff 	mvi r1,-1
4000049c:	54 44 ff f6 	bgu r2,r4,40000474 <hex+0x18>
400004a0:	34 61 ff c9 	addi r1,r3,-55
400004a4:	e3 ff ff f4 	bi 40000474 <hex+0x18>

400004a8 <hex2mem>:
400004a8:	37 9c ff e8 	addi sp,sp,-24
400004ac:	5b 8b 00 18 	sw (sp+24),r11
400004b0:	5b 8c 00 14 	sw (sp+20),r12
400004b4:	5b 8d 00 10 	sw (sp+16),r13
400004b8:	5b 8e 00 0c 	sw (sp+12),r14
400004bc:	5b 8f 00 08 	sw (sp+8),r15
400004c0:	5b 9d 00 04 	sw (sp+4),ra
400004c4:	34 0d 00 00 	mvi r13,0
400004c8:	b8 20 70 00 	mv r14,r1
400004cc:	b8 40 78 00 	mv r15,r2
400004d0:	b8 60 58 00 	mv r11,r3
400004d4:	49 6d 00 0c 	bg r11,r13,40000504 <hex2mem+0x5c>
400004d8:	4d 60 00 02 	bge r11,r0,400004e0 <hex2mem+0x38>
400004dc:	34 0b 00 00 	mvi r11,0
400004e0:	b5 eb 08 00 	add r1,r15,r11
400004e4:	2b 9d 00 04 	lw ra,(sp+4)
400004e8:	2b 8b 00 18 	lw r11,(sp+24)
400004ec:	2b 8c 00 14 	lw r12,(sp+20)
400004f0:	2b 8d 00 10 	lw r13,(sp+16)
400004f4:	2b 8e 00 0c 	lw r14,(sp+12)
400004f8:	2b 8f 00 08 	lw r15,(sp+8)
400004fc:	37 9c 00 18 	addi sp,sp,24
40000500:	c3 a0 00 00 	ret
40000504:	41 c1 00 00 	lbu r1,(r14+0)
40000508:	35 ce 00 02 	addi r14,r14,2
4000050c:	fb ff ff d4 	calli 4000045c <hex>
40000510:	3c 2c 00 1c 	sli r12,r1,28
40000514:	41 c1 ff ff 	lbu r1,(r14+-1)
40000518:	15 8c 00 18 	sri r12,r12,24
4000051c:	fb ff ff d0 	calli 4000045c <hex>
40000520:	b5 ed 10 00 	add r2,r15,r13
40000524:	b9 81 08 00 	or r1,r12,r1
40000528:	30 41 00 00 	sb (r2+0),r1
4000052c:	35 ad 00 01 	addi r13,r13,1
40000530:	e3 ff ff e9 	bi 400004d4 <hex2mem+0x2c>

40000534 <hex2int>:
40000534:	37 9c ff ec 	addi sp,sp,-20
40000538:	5b 8b 00 14 	sw (sp+20),r11
4000053c:	5b 8c 00 10 	sw (sp+16),r12
40000540:	5b 8d 00 0c 	sw (sp+12),r13
40000544:	5b 8e 00 08 	sw (sp+8),r14
40000548:	5b 9d 00 04 	sw (sp+4),ra
4000054c:	34 0c 00 00 	mvi r12,0
40000550:	b8 20 70 00 	mv r14,r1
40000554:	b8 40 68 00 	mv r13,r2
40000558:	58 40 00 00 	sw (r2+0),r0
4000055c:	29 cb 00 00 	lw r11,(r14+0)
40000560:	11 61 00 00 	lb r1,(r11+0)
40000564:	44 20 00 04 	be r1,r0,40000574 <hex2int+0x40>
40000568:	20 21 00 ff 	andi r1,r1,0xff
4000056c:	fb ff ff bc 	calli 4000045c <hex>
40000570:	4c 20 00 09 	bge r1,r0,40000594 <hex2int+0x60>
40000574:	b9 80 08 00 	mv r1,r12
40000578:	2b 9d 00 04 	lw ra,(sp+4)
4000057c:	2b 8b 00 14 	lw r11,(sp+20)
40000580:	2b 8c 00 10 	lw r12,(sp+16)
40000584:	2b 8d 00 0c 	lw r13,(sp+12)
40000588:	2b 8e 00 08 	lw r14,(sp+8)
4000058c:	37 9c 00 14 	addi sp,sp,20
40000590:	c3 a0 00 00 	ret
40000594:	29 a3 00 00 	lw r3,(r13+0)
40000598:	35 6b 00 01 	addi r11,r11,1
4000059c:	35 8c 00 01 	addi r12,r12,1
400005a0:	3c 63 00 04 	sli r3,r3,4
400005a4:	b8 61 18 00 	or r3,r3,r1
400005a8:	59 a3 00 00 	sw (r13+0),r3
400005ac:	59 cb 00 00 	sw (r14+0),r11
400005b0:	e3 ff ff eb 	bi 4000055c <hex2int+0x28>

400005b4 <put_packet.constprop.5>:
400005b4:	37 9c ff e8 	addi sp,sp,-24
400005b8:	5b 8b 00 18 	sw (sp+24),r11
400005bc:	5b 8c 00 14 	sw (sp+20),r12
400005c0:	5b 8d 00 10 	sw (sp+16),r13
400005c4:	5b 8e 00 0c 	sw (sp+12),r14
400005c8:	5b 8f 00 08 	sw (sp+8),r15
400005cc:	5b 9d 00 04 	sw (sp+4),ra
400005d0:	78 01 40 00 	mvhi r1,0x4000
400005d4:	38 21 10 8c 	ori r1,r1,0x108c
400005d8:	28 2d 00 00 	lw r13,(r1+0)
400005dc:	34 0f 00 2b 	mvi r15,43
400005e0:	34 01 00 24 	mvi r1,36
400005e4:	fb ff ff 47 	calli 40000300 <put_debug_char>
400005e8:	78 01 40 00 	mvhi r1,0x4000
400005ec:	38 21 10 90 	ori r1,r1,0x1090
400005f0:	28 2c 00 00 	lw r12,(r1+0)
400005f4:	34 0b 00 00 	mvi r11,0
400005f8:	11 81 00 00 	lb r1,(r12+0)
400005fc:	35 8c 00 01 	addi r12,r12,1
40000600:	20 2e 00 ff 	andi r14,r1,0xff
40000604:	5d c0 00 15 	bne r14,r0,40000658 <put_packet.constprop.5+0xa4>
40000608:	34 01 00 23 	mvi r1,35
4000060c:	fb ff ff 3d 	calli 40000300 <put_debug_char>
40000610:	01 61 00 04 	srui r1,r11,4
40000614:	21 6b 00 0f 	andi r11,r11,0xf
40000618:	b5 a1 08 00 	add r1,r13,r1
4000061c:	10 21 00 00 	lb r1,(r1+0)
40000620:	b5 ab 58 00 	add r11,r13,r11
40000624:	fb ff ff 37 	calli 40000300 <put_debug_char>
40000628:	11 61 00 00 	lb r1,(r11+0)
4000062c:	fb ff ff 35 	calli 40000300 <put_debug_char>
40000630:	fb ff ff 29 	calli 400002d4 <get_debug_char>
40000634:	5c 2f ff eb 	bne r1,r15,400005e0 <put_packet.constprop.5+0x2c>
40000638:	2b 9d 00 04 	lw ra,(sp+4)
4000063c:	2b 8b 00 18 	lw r11,(sp+24)
40000640:	2b 8c 00 14 	lw r12,(sp+20)
40000644:	2b 8d 00 10 	lw r13,(sp+16)
40000648:	2b 8e 00 0c 	lw r14,(sp+12)
4000064c:	2b 8f 00 08 	lw r15,(sp+8)
40000650:	37 9c 00 18 	addi sp,sp,24
40000654:	c3 a0 00 00 	ret
40000658:	b5 6e 58 00 	add r11,r11,r14
4000065c:	fb ff ff 29 	calli 40000300 <put_debug_char>
40000660:	21 6b 00 ff 	andi r11,r11,0xff
40000664:	e3 ff ff e5 	bi 400005f8 <put_packet.constprop.5+0x44>

40000668 <strcpy.constprop.7>:
40000668:	78 03 40 00 	mvhi r3,0x4000
4000066c:	38 63 10 94 	ori r3,r3,0x1094
40000670:	28 62 00 00 	lw r2,(r3+0)
40000674:	34 21 00 01 	addi r1,r1,1
40000678:	10 23 ff ff 	lb r3,(r1+-1)
4000067c:	34 42 00 01 	addi r2,r2,1
40000680:	30 43 ff ff 	sb (r2+-1),r3
40000684:	5c 60 ff fc 	bne r3,r0,40000674 <strcpy.constprop.7+0xc>
40000688:	78 02 40 00 	mvhi r2,0x4000
4000068c:	38 42 10 94 	ori r2,r2,0x1094
40000690:	28 41 00 00 	lw r1,(r2+0)
40000694:	c3 a0 00 00 	ret

40000698 <cmd_mem_write>:
40000698:	37 9c ff ec 	addi sp,sp,-20
4000069c:	5b 8b 00 08 	sw (sp+8),r11
400006a0:	5b 9d 00 04 	sw (sp+4),ra
400006a4:	78 02 40 00 	mvhi r2,0x4000
400006a8:	38 42 10 98 	ori r2,r2,0x1098
400006ac:	b8 20 58 00 	mv r11,r1
400006b0:	28 41 00 00 	lw r1,(r2+0)
400006b4:	37 82 00 14 	addi r2,sp,20
400006b8:	5b 81 00 0c 	sw (sp+12),r1
400006bc:	37 81 00 0c 	addi r1,sp,12
400006c0:	fb ff ff 9d 	calli 40000534 <hex2int>
400006c4:	4c 01 00 2c 	bge r0,r1,40000774 <cmd_mem_write+0xdc>
400006c8:	2b 81 00 0c 	lw r1,(sp+12)
400006cc:	34 22 00 01 	addi r2,r1,1
400006d0:	5b 82 00 0c 	sw (sp+12),r2
400006d4:	10 22 00 00 	lb r2,(r1+0)
400006d8:	34 01 00 2c 	mvi r1,44
400006dc:	5c 41 00 26 	bne r2,r1,40000774 <cmd_mem_write+0xdc>
400006e0:	37 82 00 10 	addi r2,sp,16
400006e4:	37 81 00 0c 	addi r1,sp,12
400006e8:	fb ff ff 93 	calli 40000534 <hex2int>
400006ec:	4c 01 00 22 	bge r0,r1,40000774 <cmd_mem_write+0xdc>
400006f0:	2b 82 00 0c 	lw r2,(sp+12)
400006f4:	34 41 00 01 	addi r1,r2,1
400006f8:	5b 81 00 0c 	sw (sp+12),r1
400006fc:	10 43 00 00 	lb r3,(r2+0)
40000700:	34 02 00 3a 	mvi r2,58
40000704:	5c 62 00 1c 	bne r3,r2,40000774 <cmd_mem_write+0xdc>
40000708:	2b 82 00 14 	lw r2,(sp+20)
4000070c:	2b 83 00 10 	lw r3,(sp+16)
40000710:	5d 60 00 16 	bne r11,r0,40000768 <cmd_mem_write+0xd0>
40000714:	fb ff ff 65 	calli 400004a8 <hex2mem>
40000718:	e0 00 00 08 	bi 40000738 <cmd_mem_write+0xa0>
4000071c:	10 24 00 00 	lb r4,(r1+0)
40000720:	44 87 00 0e 	be r4,r7,40000758 <cmd_mem_write+0xc0>
40000724:	34 21 00 01 	addi r1,r1,1
40000728:	30 c4 00 00 	sb (r6+0),r4
4000072c:	34 a5 00 01 	addi r5,r5,1
40000730:	b4 a2 30 00 	add r6,r5,r2
40000734:	48 65 ff fa 	bg r3,r5,4000071c <cmd_mem_write+0x84>
40000738:	78 02 40 00 	mvhi r2,0x4000
4000073c:	38 42 10 9c 	ori r2,r2,0x109c
40000740:	28 41 00 00 	lw r1,(r2+0)
40000744:	fb ff ff c9 	calli 40000668 <strcpy.constprop.7>
40000748:	2b 9d 00 04 	lw ra,(sp+4)
4000074c:	2b 8b 00 08 	lw r11,(sp+8)
40000750:	37 9c 00 14 	addi sp,sp,20
40000754:	c3 a0 00 00 	ret
40000758:	10 24 00 01 	lb r4,(r1+1)
4000075c:	34 21 00 02 	addi r1,r1,2
40000760:	18 84 00 20 	xori r4,r4,0x20
40000764:	e3 ff ff f1 	bi 40000728 <cmd_mem_write+0x90>
40000768:	34 05 00 00 	mvi r5,0
4000076c:	34 07 00 7d 	mvi r7,125
40000770:	e3 ff ff f0 	bi 40000730 <cmd_mem_write+0x98>
40000774:	78 02 40 00 	mvhi r2,0x4000
40000778:	38 42 10 a0 	ori r2,r2,0x10a0
4000077c:	e3 ff ff f1 	bi 40000740 <cmd_mem_write+0xa8>

40000780 <handle_exception>:
40000780:	37 9c ff b8 	addi sp,sp,-72
40000784:	5b 8b 00 3c 	sw (sp+60),r11
40000788:	5b 8c 00 38 	sw (sp+56),r12
4000078c:	5b 8d 00 34 	sw (sp+52),r13
40000790:	5b 8e 00 30 	sw (sp+48),r14
40000794:	5b 8f 00 2c 	sw (sp+44),r15
40000798:	5b 90 00 28 	sw (sp+40),r16
4000079c:	5b 91 00 24 	sw (sp+36),r17
400007a0:	5b 92 00 20 	sw (sp+32),r18
400007a4:	5b 93 00 1c 	sw (sp+28),r19
400007a8:	5b 94 00 18 	sw (sp+24),r20
400007ac:	5b 95 00 14 	sw (sp+20),r21
400007b0:	5b 96 00 10 	sw (sp+16),r22
400007b4:	5b 97 00 0c 	sw (sp+12),r23
400007b8:	5b 98 00 08 	sw (sp+8),r24
400007bc:	5b 9d 00 04 	sw (sp+4),ra
400007c0:	b8 20 60 00 	mv r12,r1
400007c4:	38 01 00 10 	mvu r1,0x10
400007c8:	78 21 30 00 	orhi r1,r1,0x3000
400007cc:	58 20 00 00 	sw (r1+0),r0
400007d0:	28 22 10 40 	lw r2,(r1+4160)
400007d4:	5c 40 00 05 	bne r2,r0,400007e8 <handle_exception+0x68>
400007d8:	34 21 10 40 	addi r1,r1,4160
400007dc:	34 02 00 01 	mvi r2,1
400007e0:	58 22 00 00 	sw (r1+0),r2
400007e4:	fb ff fe b3 	calli 400002b0 <clear_bss>
400007e8:	38 01 10 54 	mvu r1,0x1054
400007ec:	78 21 30 00 	orhi r1,r1,0x3000
400007f0:	28 32 00 00 	lw r18,(r1+0)
400007f4:	38 02 00 08 	mvu r2,0x8
400007f8:	78 42 30 00 	orhi r2,r2,0x3000
400007fc:	58 20 00 00 	sw (r1+0),r0
40000800:	28 41 00 00 	lw r1,(r2+0)
40000804:	20 21 00 01 	andi r1,r1,0x1
40000808:	44 20 ff fe 	be r1,r0,40000800 <handle_exception+0x80>
4000080c:	28 4f 00 00 	lw r15,(r2+0)
40000810:	38 01 10 74 	mvu r1,0x1074
40000814:	78 21 30 00 	orhi r1,r1,0x3000
40000818:	38 02 00 04 	mvu r2,0x4
4000081c:	78 42 30 00 	orhi r2,r2,0x3000
40000820:	28 53 00 00 	lw r19,(r2+0)
40000824:	28 21 00 00 	lw r1,(r1+0)
40000828:	38 03 20 00 	mvu r3,0x2000
4000082c:	78 63 00 1c 	orhi r3,r3,0x1c
40000830:	8c 23 08 00 	divu r1,r1,r3
40000834:	58 41 00 00 	sw (r2+0),r1
40000838:	78 01 40 00 	mvhi r1,0x4000
4000083c:	38 21 10 a4 	ori r1,r1,0x10a4
40000840:	28 2d 00 00 	lw r13,(r1+0)
40000844:	11 a1 00 00 	lb r1,(r13+0)
40000848:	44 20 00 04 	be r1,r0,40000858 <handle_exception+0xd8>
4000084c:	b9 80 08 00 	mv r1,r12
40000850:	fb ff fe c9 	calli 40000374 <cmd_status>
40000854:	fb ff ff 58 	calli 400005b4 <put_packet.constprop.5>
40000858:	78 02 40 00 	mvhi r2,0x4000
4000085c:	78 03 40 00 	mvhi r3,0x4000
40000860:	78 04 40 00 	mvhi r4,0x4000
40000864:	38 42 10 a8 	ori r2,r2,0x10a8
40000868:	38 63 10 ac 	ori r3,r3,0x10ac
4000086c:	38 84 10 b0 	ori r4,r4,0x10b0
40000870:	28 4e 00 00 	lw r14,(r2+0)
40000874:	28 6b 00 00 	lw r11,(r3+0)
40000878:	28 91 00 00 	lw r17,(r4+0)
4000087c:	34 10 00 23 	mvi r16,35
40000880:	34 14 03 20 	mvi r20,800
40000884:	38 15 10 7c 	mvu r21,0x107c
40000888:	7a b5 30 00 	orhi r21,r21,0x3000
4000088c:	31 c0 00 00 	sb (r14+0),r0
40000890:	34 17 00 24 	mvi r23,36
40000894:	fb ff fe 90 	calli 400002d4 <get_debug_char>
40000898:	5c 37 ff ff 	bne r1,r23,40000894 <handle_exception+0x114>
4000089c:	34 16 00 00 	mvi r22,0
400008a0:	34 18 00 00 	mvi r24,0
400008a4:	fb ff fe 8c 	calli 400002d4 <get_debug_char>
400008a8:	44 37 ff fd 	be r1,r23,4000089c <handle_exception+0x11c>
400008ac:	44 30 00 07 	be r1,r16,400008c8 <handle_exception+0x148>
400008b0:	b5 76 10 00 	add r2,r11,r22
400008b4:	b7 01 c0 00 	add r24,r24,r1
400008b8:	30 41 00 00 	sb (r2+0),r1
400008bc:	36 d6 00 01 	addi r22,r22,1
400008c0:	23 18 00 ff 	andi r24,r24,0xff
400008c4:	5e d4 ff f8 	bne r22,r20,400008a4 <handle_exception+0x124>
400008c8:	b5 76 b0 00 	add r22,r11,r22
400008cc:	32 c0 00 00 	sb (r22+0),r0
400008d0:	5c 30 ff f1 	bne r1,r16,40000894 <handle_exception+0x114>
400008d4:	fb ff fe 80 	calli 400002d4 <get_debug_char>
400008d8:	20 21 00 ff 	andi r1,r1,0xff
400008dc:	fb ff fe e0 	calli 4000045c <hex>
400008e0:	3c 21 00 04 	sli r1,r1,4
400008e4:	20 36 00 ff 	andi r22,r1,0xff
400008e8:	fb ff fe 7b 	calli 400002d4 <get_debug_char>
400008ec:	20 21 00 ff 	andi r1,r1,0xff
400008f0:	fb ff fe db 	calli 4000045c <hex>
400008f4:	b6 c1 08 00 	add r1,r22,r1
400008f8:	20 21 00 ff 	andi r1,r1,0xff
400008fc:	44 38 00 04 	be r1,r24,4000090c <handle_exception+0x18c>
40000900:	34 01 00 2d 	mvi r1,45
40000904:	fb ff fe 7f 	calli 40000300 <put_debug_char>
40000908:	e3 ff ff e3 	bi 40000894 <handle_exception+0x114>
4000090c:	34 01 00 2b 	mvi r1,43
40000910:	fb ff fe 7c 	calli 40000300 <put_debug_char>
40000914:	11 62 00 02 	lb r2,(r11+2)
40000918:	34 01 00 3a 	mvi r1,58
4000091c:	5c 41 00 05 	bne r2,r1,40000930 <handle_exception+0x1b0>
40000920:	11 61 00 00 	lb r1,(r11+0)
40000924:	fb ff fe 77 	calli 40000300 <put_debug_char>
40000928:	11 61 00 01 	lb r1,(r11+1)
4000092c:	fb ff fe 75 	calli 40000300 <put_debug_char>
40000930:	34 01 00 01 	mvi r1,1
40000934:	31 a1 00 00 	sb (r13+0),r1
40000938:	11 61 00 00 	lb r1,(r11+0)
4000093c:	34 02 00 63 	mvi r2,99
40000940:	44 22 00 ed 	be r1,r2,40000cf4 <handle_exception+0x574>
40000944:	48 22 00 4a 	bg r1,r2,40000a6c <handle_exception+0x2ec>
40000948:	34 02 00 4d 	mvi r2,77
4000094c:	44 22 00 88 	be r1,r2,40000b6c <handle_exception+0x3ec>
40000950:	48 22 00 0a 	bg r1,r2,40000978 <handle_exception+0x1f8>
40000954:	34 02 00 44 	mvi r2,68
40000958:	44 22 00 b6 	be r1,r2,40000c30 <handle_exception+0x4b0>
4000095c:	34 02 00 47 	mvi r2,71
40000960:	44 22 00 58 	be r1,r2,40000ac0 <handle_exception+0x340>
40000964:	34 02 00 3f 	mvi r2,63
40000968:	5c 22 00 09 	bne r1,r2,4000098c <handle_exception+0x20c>
4000096c:	b9 80 08 00 	mv r1,r12
40000970:	fb ff fe 81 	calli 40000374 <cmd_status>
40000974:	e0 00 00 06 	bi 4000098c <handle_exception+0x20c>
40000978:	34 02 00 52 	mvi r2,82
4000097c:	44 22 01 aa 	be r1,r2,40001024 <handle_exception+0x8a4>
40000980:	48 22 00 05 	bg r1,r2,40000994 <handle_exception+0x214>
40000984:	34 02 00 50 	mvi r2,80
40000988:	44 22 00 90 	be r1,r2,40000bc8 <handle_exception+0x448>
4000098c:	fb ff ff 0a 	calli 400005b4 <put_packet.constprop.5>
40000990:	e3 ff ff bf 	bi 4000088c <handle_exception+0x10c>
40000994:	34 02 00 58 	mvi r2,88
40000998:	44 22 00 78 	be r1,r2,40000b78 <handle_exception+0x3f8>
4000099c:	34 02 00 5a 	mvi r2,90
400009a0:	5c 22 ff fb 	bne r1,r2,4000098c <handle_exception+0x20c>
400009a4:	78 02 40 00 	mvhi r2,0x4000
400009a8:	38 42 10 c8 	ori r2,r2,0x10c8
400009ac:	28 41 00 00 	lw r1,(r2+0)
400009b0:	11 76 00 02 	lb r22,(r11+2)
400009b4:	5b 81 00 40 	sw (sp+64),r1
400009b8:	34 01 00 2c 	mvi r1,44
400009bc:	5e c1 01 97 	bne r22,r1,40001018 <handle_exception+0x898>
400009c0:	37 82 00 44 	addi r2,sp,68
400009c4:	37 81 00 40 	addi r1,sp,64
400009c8:	fb ff fe db 	calli 40000534 <hex2int>
400009cc:	4c 01 01 93 	bge r0,r1,40001018 <handle_exception+0x898>
400009d0:	2b 81 00 40 	lw r1,(sp+64)
400009d4:	34 22 00 01 	addi r2,r1,1
400009d8:	5b 82 00 40 	sw (sp+64),r2
400009dc:	10 21 00 00 	lb r1,(r1+0)
400009e0:	5c 36 01 8e 	bne r1,r22,40001018 <handle_exception+0x898>
400009e4:	37 82 00 48 	addi r2,sp,72
400009e8:	37 81 00 40 	addi r1,sp,64
400009ec:	fb ff fe d2 	calli 40000534 <hex2int>
400009f0:	4c 01 01 8a 	bge r0,r1,40001018 <handle_exception+0x898>
400009f4:	11 62 00 01 	lb r2,(r11+1)
400009f8:	34 01 00 32 	mvi r1,50
400009fc:	44 41 01 5c 	be r2,r1,40000f6c <handle_exception+0x7ec>
40000a00:	48 41 00 d1 	bg r2,r1,40000d44 <handle_exception+0x5c4>
40000a04:	34 01 00 31 	mvi r1,49
40000a08:	5c 41 ff e1 	bne r2,r1,4000098c <handle_exception+0x20c>
40000a0c:	11 63 00 00 	lb r3,(r11+0)
40000a10:	34 02 00 5a 	mvi r2,90
40000a14:	2b 81 00 44 	lw r1,(sp+68)
40000a18:	5c 62 01 23 	bne r3,r2,40000ea4 <handle_exception+0x724>
40000a1c:	90 c0 10 00 	rcsr r2,CFG
40000a20:	14 42 00 12 	sri r2,r2,18
40000a24:	b0 40 10 00 	sextb r2,r2
40000a28:	20 44 00 0f 	andi r4,r2,0xf
40000a2c:	44 80 00 eb 	be r4,r0,40000dd8 <handle_exception+0x658>
40000a30:	78 03 40 00 	mvhi r3,0x4000
40000a34:	38 63 10 cc 	ori r3,r3,0x10cc
40000a38:	28 65 00 00 	lw r5,(r3+0)
40000a3c:	28 a3 00 00 	lw r3,(r5+0)
40000a40:	20 66 00 01 	andi r6,r3,0x1
40000a44:	5c c0 00 e5 	bne r6,r0,40000dd8 <handle_exception+0x658>
40000a48:	38 22 00 01 	ori r2,r1,0x1
40000a4c:	d2 02 00 00 	wcsr BP0,r2
40000a50:	78 04 40 00 	mvhi r4,0x4000
40000a54:	38 84 10 d0 	ori r4,r4,0x10d0
40000a58:	28 82 00 00 	lw r2,(r4+0)
40000a5c:	38 63 00 01 	ori r3,r3,0x1
40000a60:	58 a3 00 00 	sw (r5+0),r3
40000a64:	58 41 00 00 	sw (r2+0),r1
40000a68:	e0 00 00 1c 	bi 40000ad8 <handle_exception+0x358>
40000a6c:	34 02 00 70 	mvi r2,112
40000a70:	44 22 00 44 	be r1,r2,40000b80 <handle_exception+0x400>
40000a74:	48 22 00 0c 	bg r1,r2,40000aa4 <handle_exception+0x324>
40000a78:	34 02 00 6b 	mvi r2,107
40000a7c:	44 22 00 6d 	be r1,r2,40000c30 <handle_exception+0x4b0>
40000a80:	34 02 00 6d 	mvi r2,109
40000a84:	44 22 00 18 	be r1,r2,40000ae4 <handle_exception+0x364>
40000a88:	34 02 00 67 	mvi r2,103
40000a8c:	5c 22 ff c0 	bne r1,r2,4000098c <handle_exception+0x20c>
40000a90:	34 03 00 94 	mvi r3,148
40000a94:	b9 c0 10 00 	mv r2,r14
40000a98:	b9 80 08 00 	mv r1,r12
40000a9c:	fb ff fe 20 	calli 4000031c <mem2hex>
40000aa0:	e3 ff ff bb 	bi 4000098c <handle_exception+0x20c>
40000aa4:	34 02 00 72 	mvi r2,114
40000aa8:	44 22 01 5f 	be r1,r2,40001024 <handle_exception+0x8a4>
40000aac:	48 41 01 61 	bg r2,r1,40001030 <handle_exception+0x8b0>
40000ab0:	34 02 00 73 	mvi r2,115
40000ab4:	44 22 00 90 	be r1,r2,40000cf4 <handle_exception+0x574>
40000ab8:	34 02 00 7a 	mvi r2,122
40000abc:	e3 ff ff b9 	bi 400009a0 <handle_exception+0x220>
40000ac0:	78 05 40 00 	mvhi r5,0x4000
40000ac4:	38 a5 10 b4 	ori r5,r5,0x10b4
40000ac8:	28 a1 00 00 	lw r1,(r5+0)
40000acc:	34 03 00 94 	mvi r3,148
40000ad0:	b9 80 10 00 	mv r2,r12
40000ad4:	fb ff fe 75 	calli 400004a8 <hex2mem>
40000ad8:	78 02 40 00 	mvhi r2,0x4000
40000adc:	38 42 10 b8 	ori r2,r2,0x10b8
40000ae0:	e0 00 00 52 	bi 40000c28 <handle_exception+0x4a8>
40000ae4:	78 03 40 00 	mvhi r3,0x4000
40000ae8:	38 63 10 b4 	ori r3,r3,0x10b4
40000aec:	28 61 00 00 	lw r1,(r3+0)
40000af0:	37 82 00 48 	addi r2,sp,72
40000af4:	5b 81 00 40 	sw (sp+64),r1
40000af8:	37 81 00 40 	addi r1,sp,64
40000afc:	fb ff fe 8e 	calli 40000534 <hex2int>
40000b00:	4c 01 00 16 	bge r0,r1,40000b58 <handle_exception+0x3d8>
40000b04:	2b 81 00 40 	lw r1,(sp+64)
40000b08:	34 22 00 01 	addi r2,r1,1
40000b0c:	5b 82 00 40 	sw (sp+64),r2
40000b10:	10 22 00 00 	lb r2,(r1+0)
40000b14:	34 01 00 2c 	mvi r1,44
40000b18:	5c 41 00 10 	bne r2,r1,40000b58 <handle_exception+0x3d8>
40000b1c:	37 82 00 44 	addi r2,sp,68
40000b20:	37 81 00 40 	addi r1,sp,64
40000b24:	fb ff fe 84 	calli 40000534 <hex2int>
40000b28:	4c 01 00 0c 	bge r0,r1,40000b58 <handle_exception+0x3d8>
40000b2c:	2b 83 00 44 	lw r3,(sp+68)
40000b30:	34 01 01 90 	mvi r1,400
40000b34:	54 61 00 09 	bgu r3,r1,40000b58 <handle_exception+0x3d8>
40000b38:	2b 81 00 48 	lw r1,(sp+72)
40000b3c:	b9 c0 10 00 	mv r2,r14
40000b40:	fb ff fd f7 	calli 4000031c <mem2hex>
40000b44:	78 04 40 00 	mvhi r4,0x4000
40000b48:	38 84 10 bc 	ori r4,r4,0x10bc
40000b4c:	5c 20 ff 90 	bne r1,r0,4000098c <handle_exception+0x20c>
40000b50:	28 81 00 00 	lw r1,(r4+0)
40000b54:	e0 00 00 04 	bi 40000b64 <handle_exception+0x3e4>
40000b58:	78 05 40 00 	mvhi r5,0x4000
40000b5c:	38 a5 10 c0 	ori r5,r5,0x10c0
40000b60:	28 a1 00 00 	lw r1,(r5+0)
40000b64:	fb ff fe c1 	calli 40000668 <strcpy.constprop.7>
40000b68:	e3 ff ff 89 	bi 4000098c <handle_exception+0x20c>
40000b6c:	34 01 00 00 	mvi r1,0
40000b70:	fb ff fe ca 	calli 40000698 <cmd_mem_write>
40000b74:	e3 ff ff 86 	bi 4000098c <handle_exception+0x20c>
40000b78:	34 01 00 01 	mvi r1,1
40000b7c:	e3 ff ff fd 	bi 40000b70 <handle_exception+0x3f0>
40000b80:	78 02 40 00 	mvhi r2,0x4000
40000b84:	38 42 10 b4 	ori r2,r2,0x10b4
40000b88:	28 41 00 00 	lw r1,(r2+0)
40000b8c:	37 82 00 44 	addi r2,sp,68
40000b90:	5b 81 00 48 	sw (sp+72),r1
40000b94:	37 81 00 48 	addi r1,sp,72
40000b98:	fb ff fe 67 	calli 40000534 <hex2int>
40000b9c:	4c 01 00 07 	bge r0,r1,40000bb8 <handle_exception+0x438>
40000ba0:	2b 81 00 44 	lw r1,(sp+68)
40000ba4:	34 03 00 04 	mvi r3,4
40000ba8:	b9 c0 10 00 	mv r2,r14
40000bac:	3c 21 00 02 	sli r1,r1,2
40000bb0:	b5 81 08 00 	add r1,r12,r1
40000bb4:	e3 ff ff ba 	bi 40000a9c <handle_exception+0x31c>
40000bb8:	78 03 40 00 	mvhi r3,0x4000
40000bbc:	38 63 10 c0 	ori r3,r3,0x10c0
40000bc0:	28 61 00 00 	lw r1,(r3+0)
40000bc4:	e3 ff ff e8 	bi 40000b64 <handle_exception+0x3e4>
40000bc8:	78 04 40 00 	mvhi r4,0x4000
40000bcc:	38 84 10 b4 	ori r4,r4,0x10b4
40000bd0:	28 81 00 00 	lw r1,(r4+0)
40000bd4:	37 82 00 44 	addi r2,sp,68
40000bd8:	5b 81 00 48 	sw (sp+72),r1
40000bdc:	37 81 00 48 	addi r1,sp,72
40000be0:	fb ff fe 55 	calli 40000534 <hex2int>
40000be4:	4c 01 00 0f 	bge r0,r1,40000c20 <handle_exception+0x4a0>
40000be8:	2b 82 00 48 	lw r2,(sp+72)
40000bec:	34 41 00 01 	addi r1,r2,1
40000bf0:	5b 81 00 48 	sw (sp+72),r1
40000bf4:	10 43 00 00 	lb r3,(r2+0)
40000bf8:	34 02 00 3d 	mvi r2,61
40000bfc:	5c 62 00 09 	bne r3,r2,40000c20 <handle_exception+0x4a0>
40000c00:	2b 82 00 44 	lw r2,(sp+68)
40000c04:	34 03 00 04 	mvi r3,4
40000c08:	3c 42 00 02 	sli r2,r2,2
40000c0c:	b5 82 10 00 	add r2,r12,r2
40000c10:	fb ff fe 26 	calli 400004a8 <hex2mem>
40000c14:	78 05 40 00 	mvhi r5,0x4000
40000c18:	38 a5 10 b8 	ori r5,r5,0x10b8
40000c1c:	e3 ff ff d1 	bi 40000b60 <handle_exception+0x3e0>
40000c20:	78 02 40 00 	mvhi r2,0x4000
40000c24:	38 42 10 c0 	ori r2,r2,0x10c0
40000c28:	28 41 00 00 	lw r1,(r2+0)
40000c2c:	e3 ff ff ce 	bi 40000b64 <handle_exception+0x3e4>
40000c30:	d1 00 00 00 	wcsr DC,r0
40000c34:	d2 00 00 00 	wcsr BP0,r0
40000c38:	d2 20 00 00 	wcsr BP1,r0
40000c3c:	d2 40 00 00 	wcsr BP2,r0
40000c40:	d2 60 00 00 	wcsr BP3,r0
40000c44:	11 62 00 00 	lb r2,(r11+0)
40000c48:	31 a0 00 00 	sb (r13+0),r0
40000c4c:	34 01 00 44 	mvi r1,68
40000c50:	5c 41 00 06 	bne r2,r1,40000c68 <handle_exception+0x4e8>
40000c54:	78 03 40 00 	mvhi r3,0x4000
40000c58:	38 63 10 b8 	ori r3,r3,0x10b8
40000c5c:	28 61 00 00 	lw r1,(r3+0)
40000c60:	fb ff fe 82 	calli 40000668 <strcpy.constprop.7>
40000c64:	fb ff fe 54 	calli 400005b4 <put_packet.constprop.5>
40000c68:	d0 60 00 00 	wcsr ICC,r0
40000c6c:	34 00 00 00 	nop
40000c70:	34 00 00 00 	nop
40000c74:	34 00 00 00 	nop
40000c78:	34 00 00 00 	nop
40000c7c:	d0 80 00 00 	wcsr DCC,r0
40000c80:	34 00 00 00 	nop
40000c84:	34 00 00 00 	nop
40000c88:	34 00 00 00 	nop
40000c8c:	34 00 00 00 	nop
40000c90:	38 01 00 08 	mvu r1,0x8
40000c94:	78 21 30 00 	orhi r1,r1,0x3000
40000c98:	21 ef 00 04 	andi r15,r15,0x4
40000c9c:	58 2f 00 00 	sw (r1+0),r15
40000ca0:	58 33 ff fc 	sw (r1+-4),r19
40000ca4:	58 32 10 4c 	sw (r1+4172),r18
40000ca8:	34 02 00 01 	mvi r2,1
40000cac:	58 22 00 08 	sw (r1+8),r2
40000cb0:	2b 9d 00 04 	lw ra,(sp+4)
40000cb4:	2b 8b 00 3c 	lw r11,(sp+60)
40000cb8:	2b 8c 00 38 	lw r12,(sp+56)
40000cbc:	2b 8d 00 34 	lw r13,(sp+52)
40000cc0:	2b 8e 00 30 	lw r14,(sp+48)
40000cc4:	2b 8f 00 2c 	lw r15,(sp+44)
40000cc8:	2b 90 00 28 	lw r16,(sp+40)
40000ccc:	2b 91 00 24 	lw r17,(sp+36)
40000cd0:	2b 92 00 20 	lw r18,(sp+32)
40000cd4:	2b 93 00 1c 	lw r19,(sp+28)
40000cd8:	2b 94 00 18 	lw r20,(sp+24)
40000cdc:	2b 95 00 14 	lw r21,(sp+20)
40000ce0:	2b 96 00 10 	lw r22,(sp+16)
40000ce4:	2b 97 00 0c 	lw r23,(sp+12)
40000ce8:	2b 98 00 08 	lw r24,(sp+8)
40000cec:	37 9c 00 48 	addi sp,sp,72
40000cf0:	c3 a0 00 00 	ret
40000cf4:	78 04 40 00 	mvhi r4,0x4000
40000cf8:	38 84 10 b4 	ori r4,r4,0x10b4
40000cfc:	28 81 00 00 	lw r1,(r4+0)
40000d00:	37 82 00 48 	addi r2,sp,72
40000d04:	5b 81 00 44 	sw (sp+68),r1
40000d08:	37 81 00 44 	addi r1,sp,68
40000d0c:	fb ff fe 0a 	calli 40000534 <hex2int>
40000d10:	4c 01 00 03 	bge r0,r1,40000d1c <handle_exception+0x59c>
40000d14:	2b 81 00 48 	lw r1,(sp+72)
40000d18:	59 81 00 80 	sw (r12+128),r1
40000d1c:	11 62 00 00 	lb r2,(r11+0)
40000d20:	34 01 00 73 	mvi r1,115
40000d24:	5c 41 ff d1 	bne r2,r1,40000c68 <handle_exception+0x4e8>
40000d28:	78 05 40 00 	mvhi r5,0x4000
40000d2c:	38 a5 10 c4 	ori r5,r5,0x10c4
40000d30:	28 a1 00 00 	lw r1,(r5+0)
40000d34:	28 21 00 00 	lw r1,(r1+0)
40000d38:	38 21 00 01 	ori r1,r1,0x1
40000d3c:	d1 01 00 00 	wcsr DC,r1
40000d40:	e3 ff ff ca 	bi 40000c68 <handle_exception+0x4e8>
40000d44:	34 01 00 33 	mvi r1,51
40000d48:	44 41 00 8b 	be r2,r1,40000f74 <handle_exception+0x7f4>
40000d4c:	34 03 00 34 	mvi r3,52
40000d50:	34 01 00 0c 	mvi r1,12
40000d54:	5c 43 ff 0e 	bne r2,r3,4000098c <handle_exception+0x20c>
40000d58:	78 05 40 00 	mvhi r5,0x4000
40000d5c:	38 a5 10 cc 	ori r5,r5,0x10cc
40000d60:	28 a8 00 00 	lw r8,(r5+0)
40000d64:	11 63 00 00 	lb r3,(r11+0)
40000d68:	34 02 00 5a 	mvi r2,90
40000d6c:	2b 86 00 44 	lw r6,(sp+68)
40000d70:	29 07 00 00 	lw r7,(r8+0)
40000d74:	5c 62 00 89 	bne r3,r2,40000f98 <handle_exception+0x818>
40000d78:	90 c0 28 00 	rcsr r5,CFG
40000d7c:	14 a5 00 16 	sri r5,r5,22
40000d80:	34 02 00 0c 	mvi r2,12
40000d84:	20 a5 00 0f 	andi r5,r5,0xf
40000d88:	34 04 00 10 	mvi r4,16
40000d8c:	34 03 00 00 	mvi r3,0
40000d90:	48 a3 00 7b 	bg r5,r3,40000f7c <handle_exception+0x7fc>
40000d94:	44 65 00 9e 	be r3,r5,4000100c <handle_exception+0x88c>
40000d98:	b8 87 20 00 	or r4,r4,r7
40000d9c:	3c 63 00 02 	sli r3,r3,2
40000da0:	59 04 00 00 	sw (r8+0),r4
40000da4:	78 04 40 00 	mvhi r4,0x4000
40000da8:	b6 23 18 00 	add r3,r17,r3
40000dac:	38 84 10 c4 	ori r4,r4,0x10c4
40000db0:	58 66 00 00 	sw (r3+0),r6
40000db4:	28 83 00 00 	lw r3,(r4+0)
40000db8:	a4 40 10 00 	not r2,r2
40000dbc:	28 64 00 00 	lw r4,(r3+0)
40000dc0:	a0 44 10 00 	and r2,r2,r4
40000dc4:	b8 41 08 00 	or r1,r2,r1
40000dc8:	58 61 00 00 	sw (r3+0),r1
40000dcc:	d3 06 00 00 	wcsr WP0,r6
40000dd0:	d1 01 00 00 	wcsr DC,r1
40000dd4:	e3 ff ff 41 	bi 40000ad8 <handle_exception+0x358>
40000dd8:	20 43 00 0e 	andi r3,r2,0xe
40000ddc:	44 60 00 10 	be r3,r0,40000e1c <handle_exception+0x69c>
40000de0:	78 03 40 00 	mvhi r3,0x4000
40000de4:	38 63 10 cc 	ori r3,r3,0x10cc
40000de8:	28 65 00 00 	lw r5,(r3+0)
40000dec:	28 a3 00 00 	lw r3,(r5+0)
40000df0:	20 66 00 02 	andi r6,r3,0x2
40000df4:	5c c0 00 0a 	bne r6,r0,40000e1c <handle_exception+0x69c>
40000df8:	38 22 00 01 	ori r2,r1,0x1
40000dfc:	d2 22 00 00 	wcsr BP1,r2
40000e00:	78 04 40 00 	mvhi r4,0x4000
40000e04:	38 84 10 d0 	ori r4,r4,0x10d0
40000e08:	28 82 00 00 	lw r2,(r4+0)
40000e0c:	38 63 00 02 	ori r3,r3,0x2
40000e10:	58 a3 00 00 	sw (r5+0),r3
40000e14:	58 41 00 04 	sw (r2+4),r1
40000e18:	e3 ff ff 30 	bi 40000ad8 <handle_exception+0x358>
40000e1c:	34 03 00 02 	mvi r3,2
40000e20:	4c 64 00 10 	bge r3,r4,40000e60 <handle_exception+0x6e0>
40000e24:	78 05 40 00 	mvhi r5,0x4000
40000e28:	38 a5 10 cc 	ori r5,r5,0x10cc
40000e2c:	28 a4 00 00 	lw r4,(r5+0)
40000e30:	28 83 00 00 	lw r3,(r4+0)
40000e34:	20 65 00 04 	andi r5,r3,0x4
40000e38:	5c a0 00 0a 	bne r5,r0,40000e60 <handle_exception+0x6e0>
40000e3c:	38 22 00 01 	ori r2,r1,0x1
40000e40:	d2 42 00 00 	wcsr BP2,r2
40000e44:	38 63 00 04 	ori r3,r3,0x4
40000e48:	58 83 00 00 	sw (r4+0),r3
40000e4c:	78 03 40 00 	mvhi r3,0x4000
40000e50:	38 63 10 d0 	ori r3,r3,0x10d0
40000e54:	28 62 00 00 	lw r2,(r3+0)
40000e58:	58 41 00 08 	sw (r2+8),r1
40000e5c:	e3 ff ff 1f 	bi 40000ad8 <handle_exception+0x358>
40000e60:	20 42 00 0c 	andi r2,r2,0xc
40000e64:	44 40 00 6a 	be r2,r0,4000100c <handle_exception+0x88c>
40000e68:	78 04 40 00 	mvhi r4,0x4000
40000e6c:	38 84 10 cc 	ori r4,r4,0x10cc
40000e70:	28 83 00 00 	lw r3,(r4+0)
40000e74:	28 62 00 00 	lw r2,(r3+0)
40000e78:	20 44 00 08 	andi r4,r2,0x8
40000e7c:	5c 80 00 64 	bne r4,r0,4000100c <handle_exception+0x88c>
40000e80:	38 24 00 01 	ori r4,r1,0x1
40000e84:	d2 64 00 00 	wcsr BP3,r4
40000e88:	78 05 40 00 	mvhi r5,0x4000
40000e8c:	38 42 00 08 	ori r2,r2,0x8
40000e90:	38 a5 10 d0 	ori r5,r5,0x10d0
40000e94:	58 62 00 00 	sw (r3+0),r2
40000e98:	28 a2 00 00 	lw r2,(r5+0)
40000e9c:	58 41 00 0c 	sw (r2+12),r1
40000ea0:	e3 ff ff 0e 	bi 40000ad8 <handle_exception+0x358>
40000ea4:	90 c0 10 00 	rcsr r2,CFG
40000ea8:	78 03 40 00 	mvhi r3,0x4000
40000eac:	38 63 10 cc 	ori r3,r3,0x10cc
40000eb0:	28 62 00 00 	lw r2,(r3+0)
40000eb4:	28 43 00 00 	lw r3,(r2+0)
40000eb8:	20 64 00 01 	andi r4,r3,0x1
40000ebc:	44 80 00 0b 	be r4,r0,40000ee8 <handle_exception+0x768>
40000ec0:	78 05 40 00 	mvhi r5,0x4000
40000ec4:	38 a5 10 d0 	ori r5,r5,0x10d0
40000ec8:	28 a4 00 00 	lw r4,(r5+0)
40000ecc:	28 84 00 00 	lw r4,(r4+0)
40000ed0:	5c 81 00 06 	bne r4,r1,40000ee8 <handle_exception+0x768>
40000ed4:	d2 00 00 00 	wcsr BP0,r0
40000ed8:	28 41 00 00 	lw r1,(r2+0)
40000edc:	34 03 ff fe 	mvi r3,-2
40000ee0:	a0 23 08 00 	and r1,r1,r3
40000ee4:	e3 ff fe e0 	bi 40000a64 <handle_exception+0x2e4>
40000ee8:	20 64 00 02 	andi r4,r3,0x2
40000eec:	44 80 00 0a 	be r4,r0,40000f14 <handle_exception+0x794>
40000ef0:	78 05 40 00 	mvhi r5,0x4000
40000ef4:	38 a5 10 d0 	ori r5,r5,0x10d0
40000ef8:	28 a4 00 00 	lw r4,(r5+0)
40000efc:	28 84 00 04 	lw r4,(r4+4)
40000f00:	5c 81 00 05 	bne r4,r1,40000f14 <handle_exception+0x794>
40000f04:	d2 20 00 00 	wcsr BP1,r0
40000f08:	34 03 ff fd 	mvi r3,-3
40000f0c:	28 41 00 00 	lw r1,(r2+0)
40000f10:	e3 ff ff f4 	bi 40000ee0 <handle_exception+0x760>
40000f14:	20 64 00 04 	andi r4,r3,0x4
40000f18:	44 80 00 0a 	be r4,r0,40000f40 <handle_exception+0x7c0>
40000f1c:	78 05 40 00 	mvhi r5,0x4000
40000f20:	38 a5 10 d0 	ori r5,r5,0x10d0
40000f24:	28 a4 00 00 	lw r4,(r5+0)
40000f28:	28 84 00 08 	lw r4,(r4+8)
40000f2c:	5c 81 00 05 	bne r4,r1,40000f40 <handle_exception+0x7c0>
40000f30:	d2 40 00 00 	wcsr BP2,r0
40000f34:	34 03 ff fb 	mvi r3,-5
40000f38:	28 41 00 00 	lw r1,(r2+0)
40000f3c:	e3 ff ff e9 	bi 40000ee0 <handle_exception+0x760>
40000f40:	20 63 00 08 	andi r3,r3,0x8
40000f44:	44 60 00 32 	be r3,r0,4000100c <handle_exception+0x88c>
40000f48:	78 04 40 00 	mvhi r4,0x4000
40000f4c:	38 84 10 d0 	ori r4,r4,0x10d0
40000f50:	28 83 00 00 	lw r3,(r4+0)
40000f54:	28 63 00 0c 	lw r3,(r3+12)
40000f58:	5c 61 00 2d 	bne r3,r1,4000100c <handle_exception+0x88c>
40000f5c:	d2 60 00 00 	wcsr BP3,r0
40000f60:	34 03 ff f7 	mvi r3,-9
40000f64:	28 41 00 00 	lw r1,(r2+0)
40000f68:	e3 ff ff de 	bi 40000ee0 <handle_exception+0x760>
40000f6c:	34 01 00 08 	mvi r1,8
40000f70:	e3 ff ff 7a 	bi 40000d58 <handle_exception+0x5d8>
40000f74:	34 01 00 04 	mvi r1,4
40000f78:	e3 ff ff 78 	bi 40000d58 <handle_exception+0x5d8>
40000f7c:	a0 87 48 00 	and r9,r4,r7
40000f80:	45 20 ff 86 	be r9,r0,40000d98 <handle_exception+0x618>
40000f84:	3c 84 00 01 	sli r4,r4,1
40000f88:	3c 21 00 02 	sli r1,r1,2
40000f8c:	3c 42 00 02 	sli r2,r2,2
40000f90:	34 63 00 01 	addi r3,r3,1
40000f94:	e3 ff ff 7f 	bi 40000d90 <handle_exception+0x610>
40000f98:	78 05 40 00 	mvhi r5,0x4000
40000f9c:	38 a5 10 c4 	ori r5,r5,0x10c4
40000fa0:	28 aa 00 00 	lw r10,(r5+0)
40000fa4:	34 02 00 0c 	mvi r2,12
40000fa8:	34 05 00 00 	mvi r5,0
40000fac:	29 49 00 00 	lw r9,(r10+0)
40000fb0:	34 03 00 10 	mvi r3,16
40000fb4:	34 16 00 04 	mvi r22,4
40000fb8:	a0 67 20 00 	and r4,r3,r7
40000fbc:	44 80 00 0f 	be r4,r0,40000ff8 <handle_exception+0x878>
40000fc0:	3c a4 00 02 	sli r4,r5,2
40000fc4:	b4 91 20 00 	add r4,r4,r17
40000fc8:	28 84 00 00 	lw r4,(r4+0)
40000fcc:	5c c4 00 0b 	bne r6,r4,40000ff8 <handle_exception+0x878>
40000fd0:	a0 49 20 00 	and r4,r2,r9
40000fd4:	5c 81 00 09 	bne r4,r1,40000ff8 <handle_exception+0x878>
40000fd8:	a4 60 18 00 	not r3,r3
40000fdc:	a4 40 10 00 	not r2,r2
40000fe0:	a0 67 18 00 	and r3,r3,r7
40000fe4:	a0 49 10 00 	and r2,r2,r9
40000fe8:	59 03 00 00 	sw (r8+0),r3
40000fec:	59 42 00 00 	sw (r10+0),r2
40000ff0:	d1 02 00 00 	wcsr DC,r2
40000ff4:	e3 ff fe b9 	bi 40000ad8 <handle_exception+0x358>
40000ff8:	34 a5 00 01 	addi r5,r5,1
40000ffc:	3c 63 00 01 	sli r3,r3,1
40001000:	3c 21 00 02 	sli r1,r1,2
40001004:	3c 42 00 02 	sli r2,r2,2
40001008:	5c b6 ff ec 	bne r5,r22,40000fb8 <handle_exception+0x838>
4000100c:	78 03 40 00 	mvhi r3,0x4000
40001010:	38 63 10 d4 	ori r3,r3,0x10d4
40001014:	e3 ff fe eb 	bi 40000bc0 <handle_exception+0x440>
40001018:	78 04 40 00 	mvhi r4,0x4000
4000101c:	38 84 10 c0 	ori r4,r4,0x10c0
40001020:	e3 ff fe cc 	bi 40000b50 <handle_exception+0x3d0>
40001024:	34 01 00 01 	mvi r1,1
40001028:	5a a1 00 00 	sw (r21+0),r1
4000102c:	e3 ff fe 58 	bi 4000098c <handle_exception+0x20c>
40001030:	78 05 40 00 	mvhi r5,0x4000
40001034:	78 03 40 00 	mvhi r3,0x4000
40001038:	38 a5 10 ac 	ori r5,r5,0x10ac
4000103c:	38 63 10 d8 	ori r3,r3,0x10d8
40001040:	28 a2 00 00 	lw r2,(r5+0)
40001044:	28 65 00 00 	lw r5,(r3+0)
40001048:	34 01 00 00 	mvi r1,0
4000104c:	34 04 00 09 	mvi r4,9
40001050:	b4 25 18 00 	add r3,r1,r5
40001054:	40 46 00 01 	lbu r6,(r2+1)
40001058:	40 63 00 00 	lbu r3,(r3+0)
4000105c:	5c c3 fe 4c 	bne r6,r3,4000098c <handle_exception+0x20c>
40001060:	34 21 00 01 	addi r1,r1,1
40001064:	34 42 00 01 	addi r2,r2,1
40001068:	5c 24 ff fa 	bne r1,r4,40001050 <handle_exception+0x8d0>
4000106c:	78 04 40 00 	mvhi r4,0x4000
40001070:	38 84 10 dc 	ori r4,r4,0x10dc
40001074:	e3 ff fe b7 	bi 40000b50 <handle_exception+0x3d0>
