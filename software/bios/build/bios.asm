
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
      c8:	f8 00 03 ba 	calli fb0 <isr>
      cc:	e0 00 00 25 	bi 160 <.restore_all_and_eret>
      d0:	34 00 00 00 	nop
      d4:	34 00 00 00 	nop
      d8:	34 00 00 00 	nop
      dc:	34 00 00 00 	nop

000000e0 <_crt0>:
      e0:	78 1c 20 6f 	mvhi sp,0x206f
      e4:	3b 9c ff fc 	ori sp,sp,0xfffc
      e8:	78 1a 00 00 	mvhi gp,0x0
      ec:	3b 5a 24 60 	ori gp,gp,0x2460
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
     11c:	e0 00 02 17 	bi 978 <main>

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
 *
 * Call this function if you are already dealing with a va_list.
 * You probably want snprintf() instead.
 */
int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
{
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
				/* 'z' changed to 'Z' --davidm 1/25/99 */
				/* 't' added for ptrdiff_t */

	/* Reject out-of-range values early.  Large positive sizes are
	   used for unknown buffer sizes. */
	if (unlikely((int) size < 0))
     1e8:	48 02 00 bd 	bg r0,r2,4dc <vsnprintf+0x340>
		return 0;

	str = buf;
	end = buf + size;
     1ec:	b4 22 60 00 	add r12,r1,r2
     1f0:	b8 40 90 00 	mv r18,r2
     1f4:	b8 20 88 00 	mv r17,r1
     1f8:	b8 80 78 00 	mv r15,r4

	/* Make sure end is always >= buf */
	if (end < buf) {
     1fc:	51 81 00 03 	bgeu r12,r1,208 <vsnprintf+0x6c>
		end = ((void *)-1);
		size = end - buf;
     200:	a4 20 90 00 	not r18,r1
		end = ((void *)-1);
     204:	34 0c ff ff 	mvi r12,-1
	}

	for (; *fmt ; ++fmt) {
     208:	2b 86 00 78 	lw r6,(sp+120)
     20c:	ba 20 58 00 	mv r11,r17
     210:	10 c2 00 00 	lb r2,(r6+0)
     214:	44 40 01 8a 	be r2,r0,83c <vsnprintf+0x6a0>

		/* process flags */
		flags = 0;
		repeat:
			++fmt;		/* this also skips first '%' */
			switch (*fmt) {
     218:	78 01 00 00 	mvhi r1,0x0
     21c:	38 21 1f 24 	ori r1,r1,0x1f24
     220:	28 2e 00 00 	lw r14,(r1+0)
		}

		/* default base */
		base = 10;

		switch (*fmt) {
     224:	78 01 00 00 	mvhi r1,0x0
     228:	38 21 1f 28 	ori r1,r1,0x1f28
     22c:	28 39 00 00 	lw r25,(r1+0)
     230:	78 01 00 00 	mvhi r1,0x0
     234:	38 21 1f 2c 	ori r1,r1,0x1f2c
     238:	28 37 00 00 	lw r23,(r1+0)
     23c:	78 01 00 00 	mvhi r1,0x0
     240:	38 21 1f 30 	ori r1,r1,0x1f30
     244:	28 38 00 00 	lw r24,(r1+0)
		if (*fmt != '%') {
     248:	34 10 00 25 	mvi r16,37
			switch (*fmt) {
     24c:	34 0d 00 10 	mvi r13,16
		if (isdigit(*fmt))
     250:	34 13 00 09 	mvi r19,9
		if (*fmt == '.') {
     254:	34 15 00 2e 	mvi r21,46
		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' ||
     258:	34 14 ff df 	mvi r20,-33
						*str = *s;
					++str; ++s;
				}
				while (len < field_width--) {
					if (str < end)
						*str = ' ';
     25c:	34 16 00 20 	mvi r22,32
		if (*fmt != '%') {
     260:	44 50 00 21 	be r2,r16,2e4 <vsnprintf+0x148>
			if (str < end)
     264:	b8 c0 08 00 	mv r1,r6
     268:	51 6c 00 03 	bgeu r11,r12,274 <vsnprintf+0xd8>
				*str = *fmt;
     26c:	31 62 00 00 	sb (r11+0),r2
     270:	2b 81 00 78 	lw r1,(sp+120)
				continue;

			case '%':
				if (str < end)
					*str = '%';
				++str;
     274:	35 6b 00 01 	addi r11,r11,1
				continue;
     278:	34 26 00 01 	addi r6,r1,1
	for (; *fmt ; ++fmt) {
     27c:	5b 86 00 78 	sw (sp+120),r6
     280:	10 22 00 01 	lb r2,(r1+1)
     284:	5c 40 ff f7 	bne r2,r0,260 <vsnprintf+0xc4>
     288:	c9 71 08 00 	sub r1,r11,r17
				num = (signed int) num;
		}
		str = number(str, end, num, base,
				field_width, precision, flags);
	}
	if (size > 0) {
     28c:	4c 12 00 03 	bge r0,r18,298 <vsnprintf+0xfc>
		if (str < end)
     290:	51 6c 00 9f 	bgeu r11,r12,50c <vsnprintf+0x370>
			*str = '\0';
     294:	31 60 00 00 	sb (r11+0),r0
		else
			end[-1] = '\0';
	}
	/* the trailing null byte doesn't count towards the total */
	return str-buf;
}
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
		flags = 0;
     2e4:	34 1b 00 00 	mvi fp,0
			++fmt;		/* this also skips first '%' */
     2e8:	34 c4 00 01 	addi r4,r6,1
     2ec:	5b 84 00 78 	sw (sp+120),r4
			switch (*fmt) {
     2f0:	10 c3 00 01 	lb r3,(r6+1)
     2f4:	34 61 ff e0 	addi r1,r3,-32
     2f8:	20 21 00 ff 	andi r1,r1,0xff
     2fc:	54 2d 00 14 	bgu r1,r13,34c <vsnprintf+0x1b0>
     300:	3c 21 00 02 	sli r1,r1,2
     304:	b5 c1 08 00 	add r1,r14,r1
     308:	28 21 00 00 	lw r1,(r1+0)
     30c:	c0 20 00 00 	b r1
				case '0': flags |= PRINTF_ZEROPAD; goto repeat;
     310:	3b 7b 00 01 	ori fp,fp,0x1
     314:	b8 80 30 00 	mv r6,r4
     318:	e3 ff ff f4 	bi 2e8 <vsnprintf+0x14c>
				case '-': flags |= PRINTF_LEFT; goto repeat;
     31c:	3b 7b 00 10 	ori fp,fp,0x10
     320:	b8 80 30 00 	mv r6,r4
     324:	e3 ff ff f1 	bi 2e8 <vsnprintf+0x14c>
				case '+': flags |= PRINTF_PLUS; goto repeat;
     328:	3b 7b 00 04 	ori fp,fp,0x4
     32c:	b8 80 30 00 	mv r6,r4
     330:	e3 ff ff ee 	bi 2e8 <vsnprintf+0x14c>
				case '#': flags |= PRINTF_SPECIAL; goto repeat;
     334:	3b 7b 00 20 	ori fp,fp,0x20
     338:	b8 80 30 00 	mv r6,r4
     33c:	e3 ff ff eb 	bi 2e8 <vsnprintf+0x14c>
				case ' ': flags |= PRINTF_SPACE; goto repeat;
     340:	3b 7b 00 08 	ori fp,fp,0x8
     344:	b8 80 30 00 	mv r6,r4
     348:	e3 ff ff e8 	bi 2e8 <vsnprintf+0x14c>
#ifndef __CTYPE_H
#define __CTYPE_H

static inline int isdigit(char c)
{
	return (c >= '0') && (c <= '9');
     34c:	34 61 ff d0 	addi r1,r3,-48
		if (isdigit(*fmt))
     350:	20 21 00 ff 	andi r1,r1,0xff
     354:	54 33 00 18 	bgu r1,r19,3b4 <vsnprintf+0x218>
			field_width = skip_atoi(&fmt);
     358:	37 81 00 78 	addi r1,sp,120
     35c:	f8 00 05 ba 	calli 1a44 <skip_atoi>
     360:	2b 84 00 78 	lw r4,(sp+120)
     364:	b8 20 28 00 	mv r5,r1
		precision = -1;
     368:	34 06 ff ff 	mvi r6,-1
     36c:	10 83 00 00 	lb r3,(r4+0)
		if (*fmt == '.') {
     370:	5c 75 00 16 	bne r3,r21,3c8 <vsnprintf+0x22c>
			++fmt;	
     374:	34 82 00 01 	addi r2,r4,1
     378:	5b 82 00 78 	sw (sp+120),r2
			if (isdigit(*fmt))
     37c:	10 83 00 01 	lb r3,(r4+1)
     380:	34 61 ff d0 	addi r1,r3,-48
     384:	20 21 00 ff 	andi r1,r1,0xff
     388:	54 33 00 31 	bgu r1,r19,44c <vsnprintf+0x2b0>
				precision = skip_atoi(&fmt);
     38c:	37 81 00 78 	addi r1,sp,120
     390:	5b 85 00 48 	sw (sp+72),r5
     394:	f8 00 05 ac 	calli 1a44 <skip_atoi>
     398:	2b 84 00 78 	lw r4,(sp+120)
     39c:	2b 85 00 48 	lw r5,(sp+72)
			if (precision < 0)
     3a0:	a4 20 10 00 	not r2,r1
     3a4:	14 42 00 1f 	sri r2,r2,31
     3a8:	10 83 00 00 	lb r3,(r4+0)
     3ac:	a0 22 30 00 	and r6,r1,r2
     3b0:	e0 00 00 06 	bi 3c8 <vsnprintf+0x22c>
		else if (*fmt == '*') {
     3b4:	34 01 00 2a 	mvi r1,42
		field_width = -1;
     3b8:	34 05 ff ff 	mvi r5,-1
		else if (*fmt == '*') {
     3bc:	44 61 00 41 	be r3,r1,4c0 <vsnprintf+0x324>
		precision = -1;
     3c0:	34 06 ff ff 	mvi r6,-1
		if (*fmt == '.') {
     3c4:	44 75 ff ec 	be r3,r21,374 <vsnprintf+0x1d8>
		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' ||
     3c8:	a0 74 40 00 	and r8,r3,r20
     3cc:	b1 00 40 00 	sextb r8,r8
     3d0:	64 67 00 68 	cmpei r7,r3,104
		    *fmt =='Z' || *fmt == 'z' || *fmt == 't') {
     3d4:	64 61 00 74 	cmpei r1,r3,116
		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' ||
     3d8:	65 09 00 4c 	cmpei r9,r8,76
		    *fmt =='Z' || *fmt == 'z' || *fmt == 't') {
     3dc:	b8 e1 08 00 	or r1,r7,r1
		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' ||
     3e0:	65 02 00 5a 	cmpei r2,r8,90
		    *fmt =='Z' || *fmt == 'z' || *fmt == 't') {
     3e4:	b9 21 08 00 	or r1,r9,r1
     3e8:	b8 41 08 00 	or r1,r2,r1
     3ec:	44 20 01 0d 	be r1,r0,820 <vsnprintf+0x684>
			++fmt;
     3f0:	34 81 00 01 	addi r1,r4,1
     3f4:	5b 81 00 78 	sw (sp+120),r1
			qualifier = *fmt;
     3f8:	b8 60 38 00 	mv r7,r3
			if (qualifier == 'l' && *fmt == 'l') {
     3fc:	34 02 00 6c 	mvi r2,108
     400:	10 83 00 01 	lb r3,(r4+1)
     404:	44 e2 00 09 	be r7,r2,428 <vsnprintf+0x28c>
		switch (*fmt) {
     408:	34 62 ff db 	addi r2,r3,-37
     40c:	34 09 00 53 	mvi r9,83
     410:	20 42 00 ff 	andi r2,r2,0xff
     414:	54 49 00 eb 	bgu r2,r9,7c0 <vsnprintf+0x624>
     418:	3c 42 00 02 	sli r2,r2,2
     41c:	b6 e2 10 00 	add r2,r23,r2
     420:	28 42 00 00 	lw r2,(r2+0)
     424:	c0 40 00 00 	b r2
			if (qualifier == 'l' && *fmt == 'l') {
     428:	44 67 00 3b 	be r3,r7,514 <vsnprintf+0x378>
		switch (*fmt) {
     42c:	34 62 ff db 	addi r2,r3,-37
     430:	20 42 00 ff 	andi r2,r2,0xff
     434:	34 07 00 53 	mvi r7,83
     438:	54 47 00 e2 	bgu r2,r7,7c0 <vsnprintf+0x624>
     43c:	3c 42 00 02 	sli r2,r2,2
     440:	b7 02 10 00 	add r2,r24,r2
     444:	28 42 00 00 	lw r2,(r2+0)
     448:	c0 40 00 00 	b r2
			else if (*fmt == '*') {
     44c:	34 01 00 2a 	mvi r1,42
     450:	44 61 00 f6 	be r3,r1,828 <vsnprintf+0x68c>
     454:	b8 40 20 00 	mv r4,r2
				precision = 0;
     458:	34 06 00 00 	mvi r6,0
     45c:	e3 ff ff db 	bi 3c8 <vsnprintf+0x22c>
				flags |= PRINTF_LARGE;
     460:	3b 7b 00 40 	ori fp,fp,0x40
				base = 16;
     464:	34 04 00 10 	mvi r4,16
		if (qualifier == 'L')
     468:	34 01 00 4c 	mvi r1,76
     46c:	44 e1 00 1e 	be r7,r1,4e4 <vsnprintf+0x348>
		else if (qualifier == 'l') {
     470:	34 01 00 6c 	mvi r1,108
     474:	35 e2 00 04 	addi r2,r15,4
     478:	44 e1 00 e1 	be r7,r1,7fc <vsnprintf+0x660>
		} else if (qualifier == 'Z' || qualifier == 'z') {
     47c:	34 01 ff df 	mvi r1,-33
     480:	a0 e1 08 00 	and r1,r7,r1
     484:	34 03 00 5a 	mvi r3,90
     488:	44 23 00 30 	be r1,r3,548 <vsnprintf+0x3ac>
		} else if (qualifier == 't') {
     48c:	34 01 00 74 	mvi r1,116
     490:	44 e1 00 f2 	be r7,r1,858 <vsnprintf+0x6bc>
		} else if (qualifier == 'h') {
     494:	34 03 00 68 	mvi r3,104
     498:	23 61 00 02 	andi r1,fp,0x2
     49c:	44 e3 01 2b 	be r7,r3,948 <vsnprintf+0x7ac>
     4a0:	29 e3 00 00 	lw r3,(r15+0)
			if (flags & PRINTF_SIGN)
     4a4:	b8 40 78 00 	mv r15,r2
     4a8:	44 20 00 11 	be r1,r0,4ec <vsnprintf+0x350>
				num = (signed int) num;
     4ac:	5b 83 00 6c 	sw (sp+108),r3
     4b0:	14 63 00 1f 	sri r3,r3,31
     4b4:	5b 83 00 68 	sw (sp+104),r3
     4b8:	2b 83 00 6c 	lw r3,(sp+108)
     4bc:	e0 00 00 0c 	bi 4ec <vsnprintf+0x350>
			field_width = va_arg(args, int);
     4c0:	29 e5 00 00 	lw r5,(r15+0)
			++fmt;
     4c4:	34 c4 00 02 	addi r4,r6,2
     4c8:	5b 84 00 78 	sw (sp+120),r4
			field_width = va_arg(args, int);
     4cc:	35 ef 00 04 	addi r15,r15,4
			if (field_width < 0) {
     4d0:	10 c3 00 02 	lb r3,(r6+2)
     4d4:	48 05 00 24 	bg r0,r5,564 <vsnprintf+0x3c8>
     4d8:	e3 ff ff ba 	bi 3c0 <vsnprintf+0x224>
		return 0;
     4dc:	34 01 00 00 	mvi r1,0
     4e0:	e3 ff ff 6e 	bi 298 <vsnprintf+0xfc>
			num = va_arg(args, long long);
     4e4:	29 e3 00 04 	lw r3,(r15+4)
     4e8:	35 ef 00 08 	addi r15,r15,8
		str = number(str, end, num, base,
     4ec:	b9 60 08 00 	mv r1,r11
     4f0:	bb 60 38 00 	mv r7,fp
     4f4:	b9 80 10 00 	mv r2,r12
     4f8:	f8 00 05 6a 	calli 1aa0 <number>
     4fc:	b8 20 58 00 	mv r11,r1
     500:	2b 81 00 78 	lw r1,(sp+120)
     504:	34 26 00 01 	addi r6,r1,1
     508:	e3 ff ff 5d 	bi 27c <vsnprintf+0xe0>
			end[-1] = '\0';
     50c:	31 80 ff ff 	sb (r12+-1),r0
	return str-buf;
     510:	e3 ff ff 62 	bi 298 <vsnprintf+0xfc>
				++fmt;
     514:	34 81 00 02 	addi r1,r4,2
     518:	5b 81 00 78 	sw (sp+120),r1
     51c:	10 83 00 02 	lb r3,(r4+2)
				qualifier = 'L';
     520:	34 07 00 4c 	mvi r7,76
				++fmt;
     524:	b8 20 20 00 	mv r4,r1
		switch (*fmt) {
     528:	34 61 ff db 	addi r1,r3,-37
     52c:	20 21 00 ff 	andi r1,r1,0xff
     530:	34 02 00 53 	mvi r2,83
     534:	54 22 00 a2 	bgu r1,r2,7bc <vsnprintf+0x620>
     538:	3c 21 00 02 	sli r1,r1,2
     53c:	b7 21 08 00 	add r1,r25,r1
     540:	28 21 00 00 	lw r1,(r1+0)
     544:	c0 20 00 00 	b r1
			num = va_arg(args, size_t);
     548:	29 e1 00 00 	lw r1,(r15+0)
     54c:	b8 40 78 00 	mv r15,r2
     550:	5b 81 00 54 	sw (sp+84),r1
     554:	14 21 00 1f 	sri r1,r1,31
     558:	2b 83 00 54 	lw r3,(sp+84)
     55c:	5b 81 00 50 	sw (sp+80),r1
     560:	e3 ff ff e3 	bi 4ec <vsnprintf+0x350>
				field_width = -field_width;
     564:	c8 05 28 00 	sub r5,r0,r5
				flags |= PRINTF_LEFT;
     568:	3b 7b 00 10 	ori fp,fp,0x10
     56c:	e3 ff ff 95 	bi 3c0 <vsnprintf+0x224>
		switch (*fmt) {
     570:	b8 80 08 00 	mv r1,r4
				if (str < end)
     574:	51 6c ff 40 	bgeu r11,r12,274 <vsnprintf+0xd8>
					*str = '%';
     578:	34 01 00 25 	mvi r1,37
     57c:	31 61 00 00 	sb (r11+0),r1
     580:	2b 81 00 78 	lw r1,(sp+120)
     584:	e3 ff ff 3c 	bi 274 <vsnprintf+0xd8>
				if (!(flags & PRINTF_LEFT)) {
     588:	23 7b 00 10 	andi fp,fp,0x10
     58c:	34 a2 ff ff 	addi r2,r5,-1
     590:	47 60 00 e1 	be fp,r0,914 <vsnprintf+0x778>
				c = (unsigned char) va_arg(args, int);
     594:	35 e4 00 04 	addi r4,r15,4
				if (str < end)
     598:	51 6c 00 03 	bgeu r11,r12,5a4 <vsnprintf+0x408>
				c = (unsigned char) va_arg(args, int);
     59c:	29 e1 00 00 	lw r1,(r15+0)
     5a0:	31 61 00 00 	sb (r11+0),r1
				++str;
     5a4:	35 63 00 01 	addi r3,r11,1
				while (--field_width > 0) {
     5a8:	34 41 00 01 	addi r1,r2,1
     5ac:	b5 61 58 00 	add r11,r11,r1
				++str;
     5b0:	b8 60 08 00 	mv r1,r3
				while (--field_width > 0) {
     5b4:	48 40 00 06 	bg r2,r0,5cc <vsnprintf+0x430>
     5b8:	2b 81 00 78 	lw r1,(sp+120)
     5bc:	b8 80 78 00 	mv r15,r4
     5c0:	b8 60 58 00 	mv r11,r3
     5c4:	34 26 00 01 	addi r6,r1,1
     5c8:	e3 ff ff 2d 	bi 27c <vsnprintf+0xe0>
					if (str < end)
     5cc:	50 2c 00 02 	bgeu r1,r12,5d4 <vsnprintf+0x438>
						*str = ' ';
     5d0:	30 36 00 00 	sb (r1+0),r22
					++str;
     5d4:	34 21 00 01 	addi r1,r1,1
				while (--field_width > 0) {
     5d8:	5c 2b ff fd 	bne r1,r11,5cc <vsnprintf+0x430>
     5dc:	2b 81 00 78 	lw r1,(sp+120)
     5e0:	b4 62 58 00 	add r11,r3,r2
     5e4:	b8 80 78 00 	mv r15,r4
     5e8:	34 26 00 01 	addi r6,r1,1
     5ec:	e3 ff ff 24 	bi 27c <vsnprintf+0xe0>
				if (field_width == -1) {
     5f0:	34 01 ff ff 	mvi r1,-1
     5f4:	5c a1 00 03 	bne r5,r1,600 <vsnprintf+0x464>
					flags |= PRINTF_ZEROPAD;
     5f8:	3b 7b 00 01 	ori fp,fp,0x1
					field_width = 2*sizeof(void *);
     5fc:	34 05 00 08 	mvi r5,8
				str = number(str, end,
     600:	29 e3 00 00 	lw r3,(r15+0)
     604:	b9 60 08 00 	mv r1,r11
     608:	bb 60 38 00 	mv r7,fp
     60c:	34 04 00 10 	mvi r4,16
     610:	b9 80 10 00 	mv r2,r12
     614:	f8 00 05 23 	calli 1aa0 <number>
     618:	b8 20 58 00 	mv r11,r1
     61c:	2b 81 00 78 	lw r1,(sp+120)
						(unsigned long) va_arg(args, void *),
     620:	35 ef 00 04 	addi r15,r15,4
				continue;
     624:	34 26 00 01 	addi r6,r1,1
     628:	e3 ff ff 15 	bi 27c <vsnprintf+0xe0>
				s = va_arg(args, char *);
     62c:	29 e3 00 00 	lw r3,(r15+0)
     630:	35 ef 00 04 	addi r15,r15,4
				if (s == NULL)
     634:	44 60 00 b4 	be r3,r0,904 <vsnprintf+0x768>
				len = strnlen(s, precision);
     638:	b8 60 08 00 	mv r1,r3
     63c:	b8 c0 10 00 	mv r2,r6
     640:	5b 83 00 4c 	sw (sp+76),r3
     644:	5b 85 00 48 	sw (sp+72),r5
     648:	f8 00 02 ce 	calli 1180 <strnlen>
				if (!(flags & PRINTF_LEFT)) {
     64c:	2b 85 00 48 	lw r5,(sp+72)
     650:	23 7b 00 10 	andi fp,fp,0x10
     654:	2b 83 00 4c 	lw r3,(sp+76)
     658:	34 a4 ff ff 	addi r4,r5,-1
     65c:	47 60 00 86 	be fp,r0,874 <vsnprintf+0x6d8>
				for (i = 0; i < len; ++i) {
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
						*str = *s;
     6dc:	28 db 00 00 	lw fp,(r6+0)
     6e0:	34 42 00 04 	addi r2,r2,4
     6e4:	34 c6 00 04 	addi r6,r6,4
     6e8:	58 5b ff fc 	sw (r2+-4),fp
					++str; ++s;
     6ec:	5c e2 ff fc 	bne r7,r2,6dc <vsnprintf+0x540>
     6f0:	34 02 ff fc 	mvi r2,-4
     6f4:	a1 42 10 00 	and r2,r10,r2
     6f8:	b5 62 58 00 	add r11,r11,r2
     6fc:	b4 62 18 00 	add r3,r3,r2
     700:	44 4a 00 0b 	be r2,r10,72c <vsnprintf+0x590>
						*str = *s;
     704:	10 66 00 00 	lb r6,(r3+0)
					++str; ++s;
     708:	35 62 00 01 	addi r2,r11,1
						*str = *s;
     70c:	31 66 00 00 	sb (r11+0),r6
				for (i = 0; i < len; ++i) {
     710:	50 48 00 07 	bgeu r2,r8,72c <vsnprintf+0x590>
						*str = *s;
     714:	10 66 00 01 	lb r6,(r3+1)
					++str; ++s;
     718:	35 62 00 02 	addi r2,r11,2
						*str = *s;
     71c:	31 66 00 01 	sb (r11+1),r6
				for (i = 0; i < len; ++i) {
     720:	50 48 00 03 	bgeu r2,r8,72c <vsnprintf+0x590>
						*str = *s;
     724:	10 62 00 02 	lb r2,(r3+2)
     728:	31 62 00 02 	sb (r11+2),r2
					++str; ++s;
     72c:	b9 20 58 00 	mv r11,r9
     730:	34 83 00 01 	addi r3,r4,1
				while (len < field_width--) {
     734:	b5 63 18 00 	add r3,r11,r3
     738:	48 a1 00 15 	bg r5,r1,78c <vsnprintf+0x5f0>
     73c:	e3 ff ff 71 	bi 500 <vsnprintf+0x364>
						*str = *s;
     740:	10 62 00 00 	lb r2,(r3+0)
					++str; ++s;
     744:	35 6b 00 01 	addi r11,r11,1
     748:	34 63 00 01 	addi r3,r3,1
						*str = *s;
     74c:	31 62 ff ff 	sb (r11+-1),r2
				for (i = 0; i < len; ++i) {
     750:	55 0b ff fc 	bgu r8,r11,740 <vsnprintf+0x5a4>
     754:	e3 ff ff f6 	bi 72c <vsnprintf+0x590>
		base = 10;
     758:	34 04 00 0a 	mvi r4,10
     75c:	e3 ff ff 43 	bi 468 <vsnprintf+0x2cc>
				base = 8;
     760:	34 04 00 08 	mvi r4,8
     764:	e3 ff ff 41 	bi 468 <vsnprintf+0x2cc>
				flags |= PRINTF_SIGN;
     768:	3b 7b 00 02 	ori fp,fp,0x2
		base = 10;
     76c:	34 04 00 0a 	mvi r4,10
     770:	e3 ff ff 3e 	bi 468 <vsnprintf+0x2cc>
				} else if (qualifier == 'Z' || qualifier == 'z') {
     774:	29 e3 00 00 	lw r3,(r15+0)
     778:	c9 71 10 00 	sub r2,r11,r17
     77c:	35 ef 00 04 	addi r15,r15,4
     780:	34 86 00 02 	addi r6,r4,2
					*ip = (str - buf);
     784:	58 62 00 00 	sw (r3+0),r2
     788:	e3 ff fe bd 	bi 27c <vsnprintf+0xe0>
					if (str < end)
     78c:	51 6c 00 02 	bgeu r11,r12,794 <vsnprintf+0x5f8>
						*str = ' ';
     790:	31 76 00 00 	sb (r11+0),r22
					++str;
     794:	35 6b 00 01 	addi r11,r11,1
				while (len < field_width--) {
     798:	c8 6b 10 00 	sub r2,r3,r11
     79c:	48 41 ff fc 	bg r2,r1,78c <vsnprintf+0x5f0>
     7a0:	e3 ff ff 58 	bi 500 <vsnprintf+0x364>
					*ip = (str - buf);
     7a4:	29 e2 00 00 	lw r2,(r15+0)
     7a8:	c9 71 18 00 	sub r3,r11,r17
     7ac:	34 86 00 02 	addi r6,r4,2
     7b0:	58 43 00 00 	sw (r2+0),r3
					long * ip = va_arg(args, long *);
     7b4:	35 ef 00 04 	addi r15,r15,4
     7b8:	e3 ff fe b1 	bi 27c <vsnprintf+0xe0>
		switch (*fmt) {
     7bc:	b8 80 08 00 	mv r1,r4
				if (str < end)
     7c0:	51 6c 00 05 	bgeu r11,r12,7d4 <vsnprintf+0x638>
					*str = '%';
     7c4:	34 01 00 25 	mvi r1,37
     7c8:	31 61 00 00 	sb (r11+0),r1
     7cc:	2b 81 00 78 	lw r1,(sp+120)
     7d0:	10 23 00 00 	lb r3,(r1+0)
				++str;
     7d4:	35 62 00 01 	addi r2,r11,1
				if (*fmt) {
     7d8:	44 60 00 1c 	be r3,r0,848 <vsnprintf+0x6ac>
					if (str < end)
     7dc:	50 4c 00 03 	bgeu r2,r12,7e8 <vsnprintf+0x64c>
						*str = *fmt;
     7e0:	31 63 00 01 	sb (r11+1),r3
     7e4:	2b 81 00 78 	lw r1,(sp+120)
					++str;
     7e8:	35 6b 00 02 	addi r11,r11,2
     7ec:	34 26 00 01 	addi r6,r1,1
     7f0:	e3 ff fe a3 	bi 27c <vsnprintf+0xe0>
     7f4:	35 e2 00 04 	addi r2,r15,4
		base = 10;
     7f8:	34 04 00 0a 	mvi r4,10
			if (flags & PRINTF_SIGN)
     7fc:	23 61 00 02 	andi r1,fp,0x2
			num = va_arg(args, unsigned long);
     800:	29 e3 00 00 	lw r3,(r15+0)
     804:	b8 40 78 00 	mv r15,r2
			if (flags & PRINTF_SIGN)
     808:	44 20 ff 39 	be r1,r0,4ec <vsnprintf+0x350>
				num = (signed long) num;
     80c:	5b 83 00 5c 	sw (sp+92),r3
     810:	14 63 00 1f 	sri r3,r3,31
     814:	5b 83 00 58 	sw (sp+88),r3
     818:	2b 83 00 5c 	lw r3,(sp+92)
     81c:	e3 ff ff 34 	bi 4ec <vsnprintf+0x350>
		qualifier = -1;
     820:	34 07 ff ff 	mvi r7,-1
     824:	e3 ff ff 41 	bi 528 <vsnprintf+0x38c>
				++fmt;
     828:	34 84 00 02 	addi r4,r4,2
				precision = va_arg(args, int);
     82c:	29 e1 00 00 	lw r1,(r15+0)
				++fmt;
     830:	5b 84 00 78 	sw (sp+120),r4
				precision = va_arg(args, int);
     834:	35 ef 00 04 	addi r15,r15,4
     838:	e3 ff fe da 	bi 3a0 <vsnprintf+0x204>
	for (; *fmt ; ++fmt) {
     83c:	34 01 00 00 	mvi r1,0
	if (size > 0) {
     840:	4c 12 fe 96 	bge r0,r18,298 <vsnprintf+0xfc>
     844:	e3 ff fe 93 	bi 290 <vsnprintf+0xf4>
					--fmt;
     848:	b8 20 30 00 	mv r6,r1
				++str;
     84c:	b8 40 58 00 	mv r11,r2
					--fmt;
     850:	34 21 ff ff 	addi r1,r1,-1
     854:	e3 ff fe 8a 	bi 27c <vsnprintf+0xe0>
			num = va_arg(args, ptrdiff_t);
     858:	29 e1 00 00 	lw r1,(r15+0)
     85c:	b8 40 78 00 	mv r15,r2
     860:	5b 81 00 64 	sw (sp+100),r1
     864:	14 21 00 1f 	sri r1,r1,31
     868:	2b 83 00 64 	lw r3,(sp+100)
     86c:	5b 81 00 60 	sw (sp+96),r1
     870:	e3 ff ff 1f 	bi 4ec <vsnprintf+0x350>
     874:	c8 a1 10 00 	sub r2,r5,r1
     878:	b5 62 10 00 	add r2,r11,r2
					while (len < field_width--) {
     87c:	48 a1 00 05 	bg r5,r1,890 <vsnprintf+0x6f4>
     880:	34 a2 ff fe 	addi r2,r5,-2
     884:	b8 80 28 00 	mv r5,r4
     888:	b8 40 20 00 	mv r4,r2
     88c:	e3 ff ff 75 	bi 660 <vsnprintf+0x4c4>
						if (str < end)
     890:	51 6c 00 02 	bgeu r11,r12,898 <vsnprintf+0x6fc>
							*str = ' ';
     894:	31 76 00 00 	sb (r11+0),r22
						++str;
     898:	35 6b 00 01 	addi r11,r11,1
					while (len < field_width--) {
     89c:	5c 4b ff fd 	bne r2,r11,890 <vsnprintf+0x6f4>
     8a0:	c8 25 28 00 	sub r5,r1,r5
     8a4:	b4 a4 28 00 	add r5,r5,r4
     8a8:	34 a4 ff ff 	addi r4,r5,-1
     8ac:	e3 ff ff 6d 	bi 660 <vsnprintf+0x4c4>
				flags |= PRINTF_LARGE;
     8b0:	3b 7b 00 40 	ori fp,fp,0x40
		else if (qualifier == 'l') {
     8b4:	35 e2 00 04 	addi r2,r15,4
				base = 16;
     8b8:	34 04 00 10 	mvi r4,16
     8bc:	e3 ff ff d0 	bi 7fc <vsnprintf+0x660>
				flags |= PRINTF_SIGN;
     8c0:	3b 7b 00 02 	ori fp,fp,0x2
		else if (qualifier == 'l') {
     8c4:	35 e2 00 04 	addi r2,r15,4
		base = 10;
     8c8:	34 04 00 0a 	mvi r4,10
     8cc:	e3 ff ff cc 	bi 7fc <vsnprintf+0x660>
		else if (qualifier == 'l') {
     8d0:	35 e2 00 04 	addi r2,r15,4
				base = 8;
     8d4:	34 04 00 08 	mvi r4,8
     8d8:	e3 ff ff c9 	bi 7fc <vsnprintf+0x660>
		if (qualifier == 'L')
     8dc:	35 e2 00 04 	addi r2,r15,4
				base = 16;
     8e0:	34 04 00 10 	mvi r4,16
     8e4:	e3 ff ff c6 	bi 7fc <vsnprintf+0x660>
     8e8:	29 e3 00 00 	lw r3,(r15+0)
     8ec:	c9 71 10 00 	sub r2,r11,r17
     8f0:	35 ef 00 04 	addi r15,r15,4
     8f4:	34 86 00 01 	addi r6,r4,1
		switch (*fmt) {
     8f8:	b8 80 08 00 	mv r1,r4
					*ip = (str - buf);
     8fc:	58 62 00 00 	sw (r3+0),r2
     900:	e3 ff fe 5f 	bi 27c <vsnprintf+0xe0>
					s = "<NULL>";
     904:	78 01 00 00 	mvhi r1,0x0
     908:	38 21 1f 20 	ori r1,r1,0x1f20
     90c:	28 23 00 00 	lw r3,(r1+0)
     910:	e3 ff ff 4a 	bi 638 <vsnprintf+0x49c>
     914:	b5 62 08 00 	add r1,r11,r2
					while (--field_width > 0) {
     918:	48 40 00 06 	bg r2,r0,930 <vsnprintf+0x794>
     91c:	34 a2 ff fe 	addi r2,r5,-2
				c = (unsigned char) va_arg(args, int);
     920:	35 e4 00 04 	addi r4,r15,4
				if (str < end)
     924:	55 8b ff 1e 	bgu r12,r11,59c <vsnprintf+0x400>
				++str;
     928:	35 63 00 01 	addi r3,r11,1
				while (--field_width > 0) {
     92c:	e3 ff ff 23 	bi 5b8 <vsnprintf+0x41c>
						if (str < end)
     930:	51 6c 00 02 	bgeu r11,r12,938 <vsnprintf+0x79c>
							*str = ' ';
     934:	31 76 00 00 	sb (r11+0),r22
						++str;
     938:	35 6b 00 01 	addi r11,r11,1
					while (--field_width > 0) {
     93c:	5d 61 ff fd 	bne r11,r1,930 <vsnprintf+0x794>
     940:	34 02 ff ff 	mvi r2,-1
     944:	e3 ff ff 14 	bi 594 <vsnprintf+0x3f8>
			num = (unsigned short) va_arg(args, int);
     948:	29 e3 00 00 	lw r3,(r15+0)
			if (flags & PRINTF_SIGN)
     94c:	5c 20 00 04 	bne r1,r0,95c <vsnprintf+0x7c0>
     950:	20 63 ff ff 	andi r3,r3,0xffff
     954:	b8 40 78 00 	mv r15,r2
     958:	e3 ff fe e5 	bi 4ec <vsnprintf+0x350>
				num = (signed short) num;
     95c:	dc 60 18 00 	sexth r3,r3
     960:	5b 83 00 74 	sw (sp+116),r3
     964:	14 63 00 1f 	sri r3,r3,31
     968:	b8 40 78 00 	mv r15,r2
     96c:	5b 83 00 70 	sw (sp+112),r3
     970:	2b 83 00 74 	lw r3,(sp+116)
     974:	e3 ff fe de 	bi 4ec <vsnprintf+0x350>

00000978 <main>:
}

#include "delay.h"
	
int main (void)
{	
     978:	37 9c ff fc 	addi sp,sp,-4
     97c:	5b 9d 00 04 	sw (sp+4),ra
       return mask;
}

static inline void irq_setmask(unsigned int mask)
{
       __asm__ __volatile__("wcsr IM, %0" : : "r" (mask));
     980:	34 01 00 00 	mvi r1,0
     984:	d0 21 00 00 	wcsr IM,r1
       __asm__ __volatile__("wcsr IE, %0" : : "r" (en));
     988:	34 01 00 01 	mvi r1,1
     98c:	d0 01 00 00 	wcsr IE,r1
	/* Mask all interrupts */
	irq_setmask (0);
	/* Global interrupt enable */
	irq_enable (1);	
	/* UART initialization */
	uart_init ();
     990:	f8 00 00 9a 	calli bf8 <uart_init>
	
	printf ("hELLO!\n");
     994:	78 02 00 00 	mvhi r2,0x0
     998:	38 42 23 70 	ori r2,r2,0x2370
     99c:	28 41 00 00 	lw r1,(r2+0)
     9a0:	f8 00 01 4d 	calli ed4 <printf>
	
	for (;;) {
		CSR_GPIO_OUT = 0;
     9a4:	38 04 10 04 	mvu r4,0x1004
     9a8:	78 84 30 00 	orhi r4,r4,0x3000
		CSR_GPIO_OUT = LED0;
     9ac:	34 07 00 01 	mvi r7,1

#include "hw/sysctl.h"

static void delay_us (uint32_t us)
{	
	register uint32_t dtime = SIMPLE_COUNTER + us;
     9b0:	38 01 10 40 	mvu r1,0x1040
     9b4:	78 21 30 00 	orhi r1,r1,0x3000
     9b8:	38 05 42 40 	mvu r5,0x4240
     9bc:	78 a5 00 0f 	orhi r5,r5,0xf
		delay_ms (1000);
		CSR_GPIO_OUT = 0;
		CSR_GPIO_OUT = LED1;
     9c0:	34 06 00 02 	mvi r6,2
		CSR_GPIO_OUT = 0;
     9c4:	58 80 00 00 	sw (r4+0),r0
		CSR_GPIO_OUT = LED0;
     9c8:	58 87 00 00 	sw (r4+0),r7
     9cc:	28 23 00 00 	lw r3,(r1+0)
     9d0:	b4 65 18 00 	add r3,r3,r5
	while (SIMPLE_COUNTER < dtime);
     9d4:	28 22 00 00 	lw r2,(r1+0)
     9d8:	54 62 ff ff 	bgu r3,r2,9d4 <main+0x5c>
		CSR_GPIO_OUT = 0;
     9dc:	58 80 00 00 	sw (r4+0),r0
		CSR_GPIO_OUT = LED1;
     9e0:	58 86 00 00 	sw (r4+0),r6
	register uint32_t dtime = SIMPLE_COUNTER + us;
     9e4:	28 23 00 00 	lw r3,(r1+0)
     9e8:	b4 65 18 00 	add r3,r3,r5
	while (SIMPLE_COUNTER < dtime);
     9ec:	28 22 00 00 	lw r2,(r1+0)
     9f0:	54 62 ff ff 	bgu r3,r2,9ec <main+0x74>
     9f4:	e3 ff ff f4 	bi 9c4 <main+0x4c>

000009f8 <uart_isr>:
static int force_sync;


void uart_isr(void)
{
	unsigned int stat = CSR_UART_STAT;
     9f8:	38 02 00 08 	mvu r2,0x8
     9fc:	78 42 30 00 	orhi r2,r2,0x3000
     a00:	28 41 00 00 	lw r1,(r2+0)
	CSR_UART_STAT = stat;
     a04:	58 41 00 00 	sw (r2+0),r1

	if(stat & UART_STAT_RX_EVT) {
     a08:	20 22 00 02 	andi r2,r1,0x2
     a0c:	44 40 00 10 	be r2,r0,a4c <uart_isr+0x54>
		rx_buf[rx_produce] = CSR_UART_RXTX;
     a10:	78 02 00 00 	mvhi r2,0x0
     a14:	38 42 23 74 	ori r2,r2,0x2374
     a18:	28 43 00 00 	lw r3,(r2+0)
     a1c:	78 07 00 00 	mvhi r7,0x0
     a20:	78 02 30 00 	mvhi r2,0x3000
     a24:	28 45 00 00 	lw r5,(r2+0)
     a28:	38 e7 23 78 	ori r7,r7,0x2378
     a2c:	28 66 00 00 	lw r6,(r3+0)
		rx_produce = (rx_produce + 1) & UART_RINGBUFFER_MASK_RX;
     a30:	28 62 00 00 	lw r2,(r3+0)
		rx_buf[rx_produce] = CSR_UART_RXTX;
     a34:	28 e4 00 00 	lw r4,(r7+0)
		rx_produce = (rx_produce + 1) & UART_RINGBUFFER_MASK_RX;
     a38:	34 42 00 01 	addi r2,r2,1
		rx_buf[rx_produce] = CSR_UART_RXTX;
     a3c:	b4 86 20 00 	add r4,r4,r6
		rx_produce = (rx_produce + 1) & UART_RINGBUFFER_MASK_RX;
     a40:	20 42 0f ff 	andi r2,r2,0xfff
		rx_buf[rx_produce] = CSR_UART_RXTX;
     a44:	30 85 00 00 	sb (r4+0),r5
		rx_produce = (rx_produce + 1) & UART_RINGBUFFER_MASK_RX;
     a48:	58 62 00 00 	sw (r3+0),r2
	}

	if(stat & UART_STAT_TX_EVT) {
     a4c:	20 21 00 04 	andi r1,r1,0x4
     a50:	44 20 00 16 	be r1,r0,aa8 <uart_isr+0xb0>
		if(tx_produce != tx_consume) {
     a54:	78 01 00 00 	mvhi r1,0x0
     a58:	78 04 00 00 	mvhi r4,0x0
     a5c:	38 21 23 7c 	ori r1,r1,0x237c
     a60:	38 84 23 80 	ori r4,r4,0x2380
     a64:	28 22 00 00 	lw r2,(r1+0)
     a68:	28 83 00 00 	lw r3,(r4+0)
     a6c:	28 41 00 00 	lw r1,(r2+0)
     a70:	28 63 00 00 	lw r3,(r3+0)
     a74:	44 61 00 10 	be r3,r1,ab4 <uart_isr+0xbc>
			CSR_UART_RXTX = tx_buf[tx_consume];
     a78:	78 05 00 00 	mvhi r5,0x0
     a7c:	38 a5 23 84 	ori r5,r5,0x2384
     a80:	28 a4 00 00 	lw r4,(r5+0)
			tx_consume = (tx_consume + 1) & UART_RINGBUFFER_MASK_TX;
     a84:	34 23 00 01 	addi r3,r1,1
			CSR_UART_RXTX = tx_buf[tx_consume];
     a88:	b4 81 08 00 	add r1,r4,r1
     a8c:	10 24 00 00 	lb r4,(r1+0)
			tx_consume = (tx_consume + 1) & UART_RINGBUFFER_MASK_TX;
     a90:	38 01 ff ff 	mvu r1,0xffff
     a94:	78 21 00 01 	orhi r1,r1,0x1
     a98:	a0 61 08 00 	and r1,r3,r1
			CSR_UART_RXTX = tx_buf[tx_consume];
     a9c:	78 03 30 00 	mvhi r3,0x3000
     aa0:	58 64 00 00 	sw (r3+0),r4
			tx_consume = (tx_consume + 1) & UART_RINGBUFFER_MASK_TX;
     aa4:	58 41 00 00 	sw (r2+0),r1
       return pending;
}

static inline void irq_ack(unsigned int mask)
{
       __asm__ __volatile__("wcsr IP, %0" : : "r" (mask));
     aa8:	34 01 00 01 	mvi r1,1
     aac:	d0 41 00 00 	wcsr IP,r1
		} else
			tx_cts = 1;
	}

	irq_ack(IRQ_UART);
}
     ab0:	c3 a0 00 00 	ret
			tx_cts = 1;
     ab4:	78 07 00 00 	mvhi r7,0x0
     ab8:	38 e7 23 88 	ori r7,r7,0x2388
     abc:	28 e1 00 00 	lw r1,(r7+0)
     ac0:	34 02 00 01 	mvi r2,1
     ac4:	58 22 00 00 	sw (r1+0),r2
     ac8:	34 01 00 01 	mvi r1,1
     acc:	d0 41 00 00 	wcsr IP,r1
}
     ad0:	c3 a0 00 00 	ret

00000ad4 <uart_read>:
/* Do not use in interrupt handlers! */
char uart_read(void)
{
	char c;
	
	while(rx_consume == rx_produce);
     ad4:	78 01 00 00 	mvhi r1,0x0
     ad8:	78 05 00 00 	mvhi r5,0x0
     adc:	38 21 23 8c 	ori r1,r1,0x238c
     ae0:	38 a5 23 90 	ori r5,r5,0x2390
     ae4:	28 23 00 00 	lw r3,(r1+0)
     ae8:	28 a4 00 00 	lw r4,(r5+0)
     aec:	28 62 00 00 	lw r2,(r3+0)
     af0:	28 81 00 00 	lw r1,(r4+0)
     af4:	44 41 ff fe 	be r2,r1,aec <uart_read+0x18>
	c = rx_buf[rx_consume];
     af8:	78 05 00 00 	mvhi r5,0x0
     afc:	28 64 00 00 	lw r4,(r3+0)
     b00:	38 a5 23 94 	ori r5,r5,0x2394
	rx_consume = (rx_consume + 1) & UART_RINGBUFFER_MASK_RX;
     b04:	28 61 00 00 	lw r1,(r3+0)
	c = rx_buf[rx_consume];
     b08:	28 a2 00 00 	lw r2,(r5+0)
	rx_consume = (rx_consume + 1) & UART_RINGBUFFER_MASK_RX;
     b0c:	34 21 00 01 	addi r1,r1,1
	c = rx_buf[rx_consume];
     b10:	b4 44 10 00 	add r2,r2,r4
	rx_consume = (rx_consume + 1) & UART_RINGBUFFER_MASK_RX;
     b14:	20 21 0f ff 	andi r1,r1,0xfff
     b18:	58 61 00 00 	sw (r3+0),r1
	return c;
}
     b1c:	10 41 00 00 	lb r1,(r2+0)
     b20:	c3 a0 00 00 	ret

00000b24 <uart_read_nonblock>:

int uart_read_nonblock(void)
{
	return (rx_consume != rx_produce);
     b24:	78 02 00 00 	mvhi r2,0x0
     b28:	38 42 23 98 	ori r2,r2,0x2398
     b2c:	28 41 00 00 	lw r1,(r2+0)
     b30:	78 03 00 00 	mvhi r3,0x0
     b34:	38 63 23 9c 	ori r3,r3,0x239c
     b38:	28 22 00 00 	lw r2,(r1+0)
     b3c:	28 61 00 00 	lw r1,(r3+0)
     b40:	28 21 00 00 	lw r1,(r1+0)
}
     b44:	fc 41 08 00 	cmpne r1,r2,r1
     b48:	c3 a0 00 00 	ret

00000b4c <uart_write>:

void uart_write(char c)
{
     b4c:	b0 20 08 00 	sextb r1,r1
       __asm__ __volatile__("rcsr %0, IM" : "=r" (mask));
     b50:	90 20 18 00 	rcsr r3,IM
       __asm__ __volatile__("wcsr IM, %0" : : "r" (mask));
     b54:	34 02 00 00 	mvi r2,0
     b58:	d0 22 00 00 	wcsr IM,r2
	unsigned int oldmask;
	
	oldmask = irq_getmask();
	irq_setmask(0);

	if(force_sync) {
     b5c:	78 04 00 00 	mvhi r4,0x0
     b60:	38 84 23 a0 	ori r4,r4,0x23a0
     b64:	28 82 00 00 	lw r2,(r4+0)
     b68:	28 42 00 00 	lw r2,(r2+0)
     b6c:	44 40 00 09 	be r2,r0,b90 <uart_write+0x44>
		CSR_UART_RXTX = c;
     b70:	78 02 30 00 	mvhi r2,0x3000
     b74:	58 41 00 00 	sw (r2+0),r1
		while(!(CSR_UART_STAT & UART_STAT_THRE));
     b78:	34 42 00 08 	addi r2,r2,8
     b7c:	28 41 00 00 	lw r1,(r2+0)
     b80:	20 21 00 01 	andi r1,r1,0x1
     b84:	44 20 ff fe 	be r1,r0,b7c <uart_write+0x30>
     b88:	d0 23 00 00 	wcsr IM,r3
			tx_buf[tx_produce] = c;
			tx_produce = (tx_produce + 1) & UART_RINGBUFFER_MASK_TX;
		}
	}
	irq_setmask(oldmask);
}
     b8c:	c3 a0 00 00 	ret
		if(tx_cts) {
     b90:	78 07 00 00 	mvhi r7,0x0
     b94:	38 e7 23 a4 	ori r7,r7,0x23a4
     b98:	28 e2 00 00 	lw r2,(r7+0)
     b9c:	28 44 00 00 	lw r4,(r2+0)
     ba0:	44 80 00 06 	be r4,r0,bb8 <uart_write+0x6c>
			tx_cts = 0;
     ba4:	58 40 00 00 	sw (r2+0),r0
			CSR_UART_RXTX = c;
     ba8:	78 02 30 00 	mvhi r2,0x3000
     bac:	58 41 00 00 	sw (r2+0),r1
     bb0:	d0 23 00 00 	wcsr IM,r3
}
     bb4:	c3 a0 00 00 	ret
			tx_buf[tx_produce] = c;
     bb8:	78 02 00 00 	mvhi r2,0x0
     bbc:	38 42 23 a8 	ori r2,r2,0x23a8
     bc0:	28 45 00 00 	lw r5,(r2+0)
     bc4:	78 07 00 00 	mvhi r7,0x0
     bc8:	38 e7 23 ac 	ori r7,r7,0x23ac
     bcc:	28 a6 00 00 	lw r6,(r5+0)
     bd0:	28 e4 00 00 	lw r4,(r7+0)
			tx_produce = (tx_produce + 1) & UART_RINGBUFFER_MASK_TX;
     bd4:	34 c2 00 01 	addi r2,r6,1
			tx_buf[tx_produce] = c;
     bd8:	b4 86 20 00 	add r4,r4,r6
			tx_produce = (tx_produce + 1) & UART_RINGBUFFER_MASK_TX;
     bdc:	38 06 ff ff 	mvu r6,0xffff
     be0:	78 c6 00 01 	orhi r6,r6,0x1
     be4:	a0 46 10 00 	and r2,r2,r6
			tx_buf[tx_produce] = c;
     be8:	30 81 00 00 	sb (r4+0),r1
			tx_produce = (tx_produce + 1) & UART_RINGBUFFER_MASK_TX;
     bec:	58 a2 00 00 	sw (r5+0),r2
     bf0:	d0 23 00 00 	wcsr IM,r3
}
     bf4:	c3 a0 00 00 	ret

00000bf8 <uart_init>:

void uart_init (void)
{
	unsigned int mask;
	
	rx_produce = 0;
     bf8:	78 02 00 00 	mvhi r2,0x0
     bfc:	38 42 23 b0 	ori r2,r2,0x23b0
     c00:	28 41 00 00 	lw r1,(r2+0)
	rx_consume = 0;
     c04:	78 03 00 00 	mvhi r3,0x0
     c08:	38 63 23 b4 	ori r3,r3,0x23b4
	rx_produce = 0;
     c0c:	58 20 00 00 	sw (r1+0),r0
	rx_consume = 0;
     c10:	28 61 00 00 	lw r1,(r3+0)
	tx_produce = 0;
     c14:	78 03 00 00 	mvhi r3,0x0
     c18:	38 63 23 b8 	ori r3,r3,0x23b8
     c1c:	28 62 00 00 	lw r2,(r3+0)
	tx_consume = 0;
     c20:	78 03 00 00 	mvhi r3,0x0
     c24:	38 63 23 bc 	ori r3,r3,0x23bc
	tx_produce = 0;
     c28:	58 40 00 00 	sw (r2+0),r0
	tx_consume = 0;
     c2c:	28 62 00 00 	lw r2,(r3+0)
	tx_cts = 1;
     c30:	78 03 00 00 	mvhi r3,0x0
     c34:	38 63 23 c0 	ori r3,r3,0x23c0
	tx_consume = 0;
     c38:	58 40 00 00 	sw (r2+0),r0
	tx_cts = 1;
     c3c:	28 62 00 00 	lw r2,(r3+0)
	rx_consume = 0;
     c40:	58 20 00 00 	sw (r1+0),r0
	tx_cts = 1;
     c44:	34 01 00 01 	mvi r1,1
     c48:	58 41 00 00 	sw (r2+0),r1
       __asm__ __volatile__("wcsr IP, %0" : : "r" (mask));
     c4c:	d0 41 00 00 	wcsr IP,r1

	irq_ack(IRQ_UART);

	/* ack any events */
	CSR_UART_STAT = CSR_UART_STAT;
     c50:	38 01 00 08 	mvu r1,0x8
     c54:	78 21 30 00 	orhi r1,r1,0x3000
     c58:	28 22 00 00 	lw r2,(r1+0)
     c5c:	58 22 00 00 	sw (r1+0),r2

	/* enable interrupts */
	CSR_UART_CTRL = UART_CTRL_TX_INT | UART_CTRL_RX_INT;
     c60:	34 02 00 03 	mvi r2,3
     c64:	58 22 00 04 	sw (r1+4),r2
       __asm__ __volatile__("rcsr %0, IM" : "=r" (mask));
     c68:	90 20 08 00 	rcsr r1,IM

	mask = irq_getmask();
	mask |= IRQ_UART;
     c6c:	38 21 00 01 	ori r1,r1,0x1
       __asm__ __volatile__("wcsr IM, %0" : : "r" (mask));
     c70:	d0 21 00 00 	wcsr IM,r1
	irq_setmask(mask);
}
     c74:	c3 a0 00 00 	ret

00000c78 <uart_force_sync>:

void uart_force_sync(int f)
{
	if(f) while(!tx_cts);
     c78:	44 20 00 06 	be r1,r0,c90 <uart_force_sync+0x18>
     c7c:	78 02 00 00 	mvhi r2,0x0
     c80:	38 42 23 c4 	ori r2,r2,0x23c4
     c84:	28 43 00 00 	lw r3,(r2+0)
     c88:	28 62 00 00 	lw r2,(r3+0)
     c8c:	44 40 ff ff 	be r2,r0,c88 <uart_force_sync+0x10>
	force_sync = f;
     c90:	78 03 00 00 	mvhi r3,0x0
     c94:	38 63 23 c8 	ori r3,r3,0x23c8
     c98:	28 62 00 00 	lw r2,(r3+0)
     c9c:	58 41 00 00 	sw (r2+0),r1
}
     ca0:	c3 a0 00 00 	ret

00000ca4 <console_set_write_hook>:
static console_read_hook read_hook;
static console_read_nonblock_hook read_nonblock_hook;

void console_set_write_hook(console_write_hook h)
{
	write_hook = h;
     ca4:	78 03 00 00 	mvhi r3,0x0
     ca8:	38 63 23 cc 	ori r3,r3,0x23cc
     cac:	28 62 00 00 	lw r2,(r3+0)
     cb0:	58 41 00 00 	sw (r2+0),r1
}
     cb4:	c3 a0 00 00 	ret

00000cb8 <console_set_read_hook>:

void console_set_read_hook(console_read_hook r, console_read_nonblock_hook rn)
{
	read_hook = r;
     cb8:	78 04 00 00 	mvhi r4,0x0
     cbc:	38 84 23 d0 	ori r4,r4,0x23d0
     cc0:	28 83 00 00 	lw r3,(r4+0)
     cc4:	58 61 00 00 	sw (r3+0),r1
	read_nonblock_hook = rn;
     cc8:	78 03 00 00 	mvhi r3,0x0
     ccc:	38 63 23 d4 	ori r3,r3,0x23d4
     cd0:	28 61 00 00 	lw r1,(r3+0)
     cd4:	58 22 00 00 	sw (r1+0),r2
}
     cd8:	c3 a0 00 00 	ret

00000cdc <readchar>:
	if(write_hook != NULL)
		write_hook(c);
}

char readchar(void)
{
     cdc:	37 9c ff f8 	addi sp,sp,-8
     ce0:	5b 8b 00 08 	sw (sp+8),r11
     ce4:	5b 9d 00 04 	sw (sp+4),ra
	while(1) {
		if(uart_read_nonblock())
			return uart_read();
		if((read_nonblock_hook != NULL) && read_nonblock_hook())
     ce8:	78 01 00 00 	mvhi r1,0x0
     cec:	38 21 23 d8 	ori r1,r1,0x23d8
     cf0:	28 2b 00 00 	lw r11,(r1+0)
     cf4:	e0 00 00 03 	bi d00 <readchar+0x24>
     cf8:	29 61 00 00 	lw r1,(r11+0)
     cfc:	5c 20 00 08 	bne r1,r0,d1c <readchar+0x40>
		if(uart_read_nonblock())
     d00:	fb ff ff 89 	calli b24 <uart_read_nonblock>
     d04:	44 20 ff fd 	be r1,r0,cf8 <readchar+0x1c>
			return uart_read();
     d08:	fb ff ff 73 	calli ad4 <uart_read>
			return read_hook();
	}
}
     d0c:	2b 9d 00 04 	lw ra,(sp+4)
     d10:	2b 8b 00 08 	lw r11,(sp+8)
     d14:	37 9c 00 08 	addi sp,sp,8
     d18:	c3 a0 00 00 	ret
		if((read_nonblock_hook != NULL) && read_nonblock_hook())
     d1c:	d8 20 00 00 	call r1
     d20:	44 20 ff f8 	be r1,r0,d00 <readchar+0x24>
			return read_hook();
     d24:	78 02 00 00 	mvhi r2,0x0
     d28:	38 42 23 dc 	ori r2,r2,0x23dc
     d2c:	28 41 00 00 	lw r1,(r2+0)
     d30:	28 21 00 00 	lw r1,(r1+0)
     d34:	d8 20 00 00 	call r1
     d38:	e3 ff ff f5 	bi d0c <readchar+0x30>

00000d3c <readchar_nonblock>:

int readchar_nonblock(void)
{
     d3c:	37 9c ff fc 	addi sp,sp,-4
     d40:	5b 9d 00 04 	sw (sp+4),ra
	return (uart_read_nonblock()
     d44:	fb ff ff 78 	calli b24 <uart_read_nonblock>
		|| ((read_nonblock_hook != NULL) && read_nonblock_hook()));
     d48:	5c 20 00 0b 	bne r1,r0,d74 <readchar_nonblock+0x38>
     d4c:	78 03 00 00 	mvhi r3,0x0
     d50:	38 63 23 e0 	ori r3,r3,0x23e0
     d54:	28 62 00 00 	lw r2,(r3+0)
     d58:	28 42 00 00 	lw r2,(r2+0)
     d5c:	44 40 00 03 	be r2,r0,d68 <readchar_nonblock+0x2c>
     d60:	d8 40 00 00 	call r2
     d64:	fc 01 08 00 	cmpne r1,r0,r1
}
     d68:	2b 9d 00 04 	lw ra,(sp+4)
     d6c:	37 9c 00 04 	addi sp,sp,4
     d70:	c3 a0 00 00 	ret
		|| ((read_nonblock_hook != NULL) && read_nonblock_hook()));
     d74:	34 01 00 01 	mvi r1,1
}
     d78:	2b 9d 00 04 	lw ra,(sp+4)
     d7c:	37 9c 00 04 	addi sp,sp,4
     d80:	c3 a0 00 00 	ret

00000d84 <puts>:

int puts(const char *s)
{
     d84:	37 9c ff ec 	addi sp,sp,-20
     d88:	5b 8b 00 14 	sw (sp+20),r11
     d8c:	5b 8c 00 10 	sw (sp+16),r12
     d90:	5b 8d 00 0c 	sw (sp+12),r13
     d94:	5b 8e 00 08 	sw (sp+8),r14
     d98:	5b 9d 00 04 	sw (sp+4),ra
     d9c:	b8 20 60 00 	mv r12,r1
       __asm__ __volatile__("rcsr %0, IM" : "=r" (mask));
     da0:	90 20 70 00 	rcsr r14,IM
       __asm__ __volatile__("wcsr IM, %0" : : "r" (mask));
     da4:	34 01 00 01 	mvi r1,1
     da8:	d0 21 00 00 	wcsr IM,r1
	unsigned int oldmask;

	oldmask = irq_getmask();
	irq_setmask(IRQ_UART); // HACK: prevent UART data loss

	while(*s) {
     dac:	11 8b 00 00 	lb r11,(r12+0)
     db0:	78 01 00 00 	mvhi r1,0x0
     db4:	38 21 23 e4 	ori r1,r1,0x23e4
     db8:	28 2d 00 00 	lw r13,(r1+0)
     dbc:	45 60 00 0a 	be r11,r0,de4 <puts+0x60>
	uart_write(c);
     dc0:	b9 60 08 00 	mv r1,r11
     dc4:	fb ff ff 62 	calli b4c <uart_write>
	if(write_hook != NULL)
     dc8:	29 a2 00 00 	lw r2,(r13+0)
		write_hook(c);
     dcc:	b9 60 08 00 	mv r1,r11
		writechar(*s);
		s++;
     dd0:	35 8c 00 01 	addi r12,r12,1
	if(write_hook != NULL)
     dd4:	44 40 00 13 	be r2,r0,e20 <puts+0x9c>
		write_hook(c);
     dd8:	d8 40 00 00 	call r2
	while(*s) {
     ddc:	11 8b 00 00 	lb r11,(r12+0)
     de0:	5d 60 ff f8 	bne r11,r0,dc0 <puts+0x3c>
	uart_write(c);
     de4:	34 01 00 0a 	mvi r1,10
     de8:	fb ff ff 59 	calli b4c <uart_write>
	if(write_hook != NULL)
     dec:	29 a2 00 00 	lw r2,(r13+0)
     df0:	44 40 00 03 	be r2,r0,dfc <puts+0x78>
		write_hook(c);
     df4:	34 01 00 0a 	mvi r1,10
     df8:	d8 40 00 00 	call r2
     dfc:	d0 2e 00 00 	wcsr IM,r14
	}
	writechar('\n');
	
	irq_setmask(oldmask);
	return 1;
}
     e00:	34 01 00 01 	mvi r1,1
     e04:	2b 9d 00 04 	lw ra,(sp+4)
     e08:	2b 8b 00 14 	lw r11,(sp+20)
     e0c:	2b 8c 00 10 	lw r12,(sp+16)
     e10:	2b 8d 00 0c 	lw r13,(sp+12)
     e14:	2b 8e 00 08 	lw r14,(sp+8)
     e18:	37 9c 00 14 	addi sp,sp,20
     e1c:	c3 a0 00 00 	ret
	while(*s) {
     e20:	11 8b 00 00 	lb r11,(r12+0)
     e24:	5d 60 ff e7 	bne r11,r0,dc0 <puts+0x3c>
     e28:	e3 ff ff ef 	bi de4 <puts+0x60>

00000e2c <putsnonl>:

void putsnonl(const char *s)
{
     e2c:	37 9c ff ec 	addi sp,sp,-20
     e30:	5b 8b 00 14 	sw (sp+20),r11
     e34:	5b 8c 00 10 	sw (sp+16),r12
     e38:	5b 8d 00 0c 	sw (sp+12),r13
     e3c:	5b 8e 00 08 	sw (sp+8),r14
     e40:	5b 9d 00 04 	sw (sp+4),ra
     e44:	b8 20 60 00 	mv r12,r1
       __asm__ __volatile__("rcsr %0, IM" : "=r" (mask));
     e48:	90 20 70 00 	rcsr r14,IM
       __asm__ __volatile__("wcsr IM, %0" : : "r" (mask));
     e4c:	34 01 00 01 	mvi r1,1
     e50:	d0 21 00 00 	wcsr IM,r1
	unsigned int oldmask;

	oldmask = irq_getmask();
	irq_setmask(IRQ_UART); // HACK: prevent UART data loss
	
	while(*s) {
     e54:	11 8b 00 00 	lb r11,(r12+0)
     e58:	78 01 00 00 	mvhi r1,0x0
     e5c:	38 21 23 e8 	ori r1,r1,0x23e8
     e60:	28 2d 00 00 	lw r13,(r1+0)
     e64:	45 60 00 0a 	be r11,r0,e8c <putsnonl+0x60>
	uart_write(c);
     e68:	b9 60 08 00 	mv r1,r11
     e6c:	fb ff ff 38 	calli b4c <uart_write>
	if(write_hook != NULL)
     e70:	29 a2 00 00 	lw r2,(r13+0)
		write_hook(c);
     e74:	b9 60 08 00 	mv r1,r11
		writechar(*s);
		s++;
     e78:	35 8c 00 01 	addi r12,r12,1
	if(write_hook != NULL)
     e7c:	44 40 00 0c 	be r2,r0,eac <putsnonl+0x80>
		write_hook(c);
     e80:	d8 40 00 00 	call r2
	while(*s) {
     e84:	11 8b 00 00 	lb r11,(r12+0)
     e88:	5d 60 ff f8 	bne r11,r0,e68 <putsnonl+0x3c>
     e8c:	d0 2e 00 00 	wcsr IM,r14
	}
	
	irq_setmask(oldmask);
}
     e90:	2b 9d 00 04 	lw ra,(sp+4)
     e94:	2b 8b 00 14 	lw r11,(sp+20)
     e98:	2b 8c 00 10 	lw r12,(sp+16)
     e9c:	2b 8d 00 0c 	lw r13,(sp+12)
     ea0:	2b 8e 00 08 	lw r14,(sp+8)
     ea4:	37 9c 00 14 	addi sp,sp,20
     ea8:	c3 a0 00 00 	ret
	while(*s) {
     eac:	11 8b 00 00 	lb r11,(r12+0)
     eb0:	5d 60 ff ee 	bne r11,r0,e68 <putsnonl+0x3c>
     eb4:	d0 2e 00 00 	wcsr IM,r14
}
     eb8:	2b 9d 00 04 	lw ra,(sp+4)
     ebc:	2b 8b 00 14 	lw r11,(sp+20)
     ec0:	2b 8c 00 10 	lw r12,(sp+16)
     ec4:	2b 8d 00 0c 	lw r13,(sp+12)
     ec8:	2b 8e 00 08 	lw r14,(sp+8)
     ecc:	37 9c 00 14 	addi sp,sp,20
     ed0:	c3 a0 00 00 	ret

00000ed4 <printf>:

int printf(const char *fmt, ...)
{
     ed4:	37 9c fe c8 	addi sp,sp,-312
     ed8:	5b 8b 00 18 	sw (sp+24),r11
     edc:	5b 8c 00 14 	sw (sp+20),r12
     ee0:	5b 8d 00 10 	sw (sp+16),r13
     ee4:	5b 8e 00 0c 	sw (sp+12),r14
     ee8:	5b 8f 00 08 	sw (sp+8),r15
     eec:	5b 9d 00 04 	sw (sp+4),ra
     ef0:	5b 81 01 1c 	sw (sp+284),r1
     ef4:	5b 83 01 24 	sw (sp+292),r3
     ef8:	5b 82 01 20 	sw (sp+288),r2
	va_list args;
	int len;
	char outbuf[256];

	va_start(args, fmt);
	len = vscnprintf(outbuf, sizeof(outbuf), fmt, args);
     efc:	b8 20 18 00 	mv r3,r1
{
     f00:	5b 84 01 28 	sw (sp+296),r4
	len = vscnprintf(outbuf, sizeof(outbuf), fmt, args);
     f04:	34 02 01 00 	mvi r2,256
     f08:	37 84 01 20 	addi r4,sp,288
     f0c:	37 81 00 1c 	addi r1,sp,28
{
     f10:	5b 85 01 2c 	sw (sp+300),r5
     f14:	5b 86 01 30 	sw (sp+304),r6
     f18:	5b 87 01 34 	sw (sp+308),r7
     f1c:	5b 88 01 38 	sw (sp+312),r8
	len = vscnprintf(outbuf, sizeof(outbuf), fmt, args);
     f20:	f8 00 03 a7 	calli 1dbc <vscnprintf>
	va_end(args);
	outbuf[len] = 0;
     f24:	37 82 00 1c 	addi r2,sp,28
	len = vscnprintf(outbuf, sizeof(outbuf), fmt, args);
     f28:	b8 20 68 00 	mv r13,r1
	outbuf[len] = 0;
     f2c:	b4 41 08 00 	add r1,r2,r1
     f30:	30 20 00 00 	sb (r1+0),r0
       __asm__ __volatile__("rcsr %0, IM" : "=r" (mask));
     f34:	90 20 70 00 	rcsr r14,IM
       __asm__ __volatile__("wcsr IM, %0" : : "r" (mask));
     f38:	34 01 00 01 	mvi r1,1
     f3c:	d0 21 00 00 	wcsr IM,r1
	while(*s) {
     f40:	13 8c 00 1c 	lb r12,(sp+28)
     f44:	78 01 00 00 	mvhi r1,0x0
     f48:	38 21 23 ec 	ori r1,r1,0x23ec
     f4c:	b8 40 58 00 	mv r11,r2
     f50:	28 2f 00 00 	lw r15,(r1+0)
     f54:	45 80 00 0a 	be r12,r0,f7c <printf+0xa8>
	uart_write(c);
     f58:	b9 80 08 00 	mv r1,r12
     f5c:	fb ff fe fc 	calli b4c <uart_write>
	if(write_hook != NULL)
     f60:	29 e2 00 00 	lw r2,(r15+0)
		write_hook(c);
     f64:	b9 80 08 00 	mv r1,r12
		s++;
     f68:	35 6b 00 01 	addi r11,r11,1
	if(write_hook != NULL)
     f6c:	44 40 00 0e 	be r2,r0,fa4 <printf+0xd0>
		write_hook(c);
     f70:	d8 40 00 00 	call r2
	while(*s) {
     f74:	11 6c 00 00 	lb r12,(r11+0)
     f78:	5d 80 ff f8 	bne r12,r0,f58 <printf+0x84>
     f7c:	d0 2e 00 00 	wcsr IM,r14
	putsnonl(outbuf);

	return len;
}
     f80:	b9 a0 08 00 	mv r1,r13
     f84:	2b 9d 00 04 	lw ra,(sp+4)
     f88:	2b 8b 00 18 	lw r11,(sp+24)
     f8c:	2b 8c 00 14 	lw r12,(sp+20)
     f90:	2b 8d 00 10 	lw r13,(sp+16)
     f94:	2b 8e 00 0c 	lw r14,(sp+12)
     f98:	2b 8f 00 08 	lw r15,(sp+8)
     f9c:	37 9c 01 38 	addi sp,sp,312
     fa0:	c3 a0 00 00 	ret
	while(*s) {
     fa4:	11 6c 00 00 	lb r12,(r11+0)
     fa8:	5d 80 ff ec 	bne r12,r0,f58 <printf+0x84>
     fac:	e3 ff ff f4 	bi f7c <printf+0xa8>

00000fb0 <isr>:
       __asm__ __volatile__("rcsr %0, IP" : "=r" (pending));
     fb0:	90 40 10 00 	rcsr r2,IP
       __asm__ __volatile__("rcsr %0, IM" : "=r" (mask));
     fb4:	90 20 08 00 	rcsr r1,IM

void isr (void)
{
	unsigned int irqs;	

	irqs = irq_pending() & irq_getmask();
     fb8:	a0 22 08 00 	and r1,r1,r2

	if(irqs & IRQ_UART)
     fbc:	20 21 00 01 	andi r1,r1,0x1
     fc0:	5c 20 00 02 	bne r1,r0,fc8 <isr+0x18>
     fc4:	c3 a0 00 00 	ret
{
     fc8:	37 9c ff fc 	addi sp,sp,-4
     fcc:	5b 9d 00 04 	sw (sp+4),ra
		uart_isr();
     fd0:	fb ff fe 8a 	calli 9f8 <uart_isr>
}
     fd4:	2b 9d 00 04 	lw ra,(sp+4)
     fd8:	37 9c 00 04 	addi sp,sp,4
     fdc:	c3 a0 00 00 	ret

00000fe0 <strchr>:
 * @s: The string to be searched
 * @c: The character to search for
 */
char *strchr(const char *s, int c)
{
	for (; *s != (char)c; ++s)
     fe0:	10 23 00 00 	lb r3,(r1+0)
     fe4:	b0 40 10 00 	sextb r2,r2
     fe8:	44 62 00 05 	be r3,r2,ffc <strchr+0x1c>
		if (*s == '\0')
     fec:	44 60 00 05 	be r3,r0,1000 <strchr+0x20>
	for (; *s != (char)c; ++s)
     ff0:	34 21 00 01 	addi r1,r1,1
     ff4:	10 23 00 00 	lb r3,(r1+0)
     ff8:	5c 62 ff fd 	bne r3,r2,fec <strchr+0xc>
			return NULL;
	return (char *)s;
}
     ffc:	c3 a0 00 00 	ret
			return NULL;
    1000:	34 01 00 00 	mvi r1,0
}
    1004:	c3 a0 00 00 	ret

00001008 <strrchr>:
 * strrchr - Find the last occurrence of a character in a string
 * @s: The string to be searched
 * @c: The character to search for
 */
char *strrchr(const char *s, int c)
{
    1008:	b8 20 20 00 	mv r4,r1
 */
size_t strlen(const char *s)
{
	const char *sc;

	for (sc = s; *sc != '\0'; ++sc)
    100c:	10 21 00 00 	lb r1,(r1+0)
    1010:	44 20 00 0c 	be r1,r0,1040 <strrchr+0x38>
    1014:	b8 80 08 00 	mv r1,r4
    1018:	34 21 00 01 	addi r1,r1,1
    101c:	10 23 00 00 	lb r3,(r1+0)
    1020:	5c 60 ff fe 	bne r3,r0,1018 <strrchr+0x10>
    1024:	b0 40 10 00 	sextb r2,r2
           if (*p == (char)c)
    1028:	10 23 00 00 	lb r3,(r1+0)
    102c:	44 62 00 04 	be r3,r2,103c <strrchr+0x34>
       } while (--p >= s);
    1030:	34 21 ff ff 	addi r1,r1,-1
    1034:	50 24 ff fd 	bgeu r1,r4,1028 <strrchr+0x20>
       return NULL;
    1038:	34 01 00 00 	mvi r1,0
}
    103c:	c3 a0 00 00 	ret
	for (sc = s; *sc != '\0'; ++sc)
    1040:	b8 80 08 00 	mv r1,r4
    1044:	e3 ff ff f8 	bi 1024 <strrchr+0x1c>

00001048 <strnchr>:
	for (; count-- && *s != '\0'; ++s)
    1048:	44 40 00 0e 	be r2,r0,1080 <strnchr+0x38>
    104c:	10 24 00 00 	lb r4,(r1+0)
    1050:	44 80 00 0c 	be r4,r0,1080 <strnchr+0x38>
		if (*s == (char)c)
    1054:	b0 60 18 00 	sextb r3,r3
    1058:	44 83 00 0b 	be r4,r3,1084 <strnchr+0x3c>
    105c:	34 24 00 01 	addi r4,r1,1
    1060:	b4 22 10 00 	add r2,r1,r2
    1064:	e0 00 00 05 	bi 1078 <strnchr+0x30>
	for (; count-- && *s != '\0'; ++s)
    1068:	10 85 00 00 	lb r5,(r4+0)
    106c:	34 84 00 01 	addi r4,r4,1
    1070:	44 a0 00 04 	be r5,r0,1080 <strnchr+0x38>
		if (*s == (char)c)
    1074:	44 a3 00 04 	be r5,r3,1084 <strnchr+0x3c>
	for (; count-- && *s != '\0'; ++s)
    1078:	b8 80 08 00 	mv r1,r4
    107c:	5c 82 ff fb 	bne r4,r2,1068 <strnchr+0x20>
	return NULL;
    1080:	34 01 00 00 	mvi r1,0
}
    1084:	c3 a0 00 00 	ret

00001088 <strcpy>:
	while ((*dest++ = *src++) != '\0')
    1088:	b8 20 18 00 	mv r3,r1
    108c:	34 42 00 01 	addi r2,r2,1
    1090:	10 44 ff ff 	lb r4,(r2+-1)
    1094:	34 63 00 01 	addi r3,r3,1
    1098:	30 64 ff ff 	sb (r3+-1),r4
    109c:	5c 80 ff fc 	bne r4,r0,108c <strcpy+0x4>
}
    10a0:	c3 a0 00 00 	ret

000010a4 <strncpy>:
	while (count) {
    10a4:	44 60 00 09 	be r3,r0,10c8 <strncpy+0x24>
    10a8:	b4 23 18 00 	add r3,r1,r3
	char *tmp = dest;
    10ac:	b8 20 20 00 	mv r4,r1
		if ((*tmp = *src) != 0)
    10b0:	10 45 00 00 	lb r5,(r2+0)
		tmp++;
    10b4:	34 84 00 01 	addi r4,r4,1
			src++;
    10b8:	fc 05 30 00 	cmpne r6,r0,r5
		if ((*tmp = *src) != 0)
    10bc:	30 85 ff ff 	sb (r4+-1),r5
			src++;
    10c0:	b4 46 10 00 	add r2,r2,r6
	while (count) {
    10c4:	5c 64 ff fb 	bne r3,r4,10b0 <strncpy+0xc>
}
    10c8:	c3 a0 00 00 	ret

000010cc <strcmp>:
		if ((__res = *cs - *ct++) != 0 || !*cs++)
    10cc:	34 42 00 01 	addi r2,r2,1
    10d0:	10 24 00 00 	lb r4,(r1+0)
    10d4:	40 43 ff ff 	lbu r3,(r2+-1)
    10d8:	34 21 00 01 	addi r1,r1,1
    10dc:	c8 83 18 00 	sub r3,r4,r3
    10e0:	b0 60 18 00 	sextb r3,r3
    10e4:	5c 60 00 04 	bne r3,r0,10f4 <strcmp+0x28>
    10e8:	5c 80 ff f9 	bne r4,r0,10cc <strcmp>
    10ec:	34 01 00 00 	mvi r1,0
}
    10f0:	c3 a0 00 00 	ret
    10f4:	b8 60 08 00 	mv r1,r3
    10f8:	c3 a0 00 00 	ret

000010fc <strncmp>:
	while (n < count) {
    10fc:	4c 03 00 13 	bge r0,r3,1148 <strncmp+0x4c>
		if ((__res = *cs - *ct++) != 0 || !*cs++)
    1100:	10 26 00 00 	lb r6,(r1+0)
    1104:	40 44 00 00 	lbu r4,(r2+0)
    1108:	34 45 00 01 	addi r5,r2,1
    110c:	c8 c4 20 00 	sub r4,r6,r4
    1110:	b0 80 20 00 	sextb r4,r4
    1114:	5c 80 00 0f 	bne r4,r0,1150 <strncmp+0x54>
    1118:	34 24 00 01 	addi r4,r1,1
    111c:	44 c0 00 0b 	be r6,r0,1148 <strncmp+0x4c>
    1120:	b4 43 18 00 	add r3,r2,r3
	while (n < count) {
    1124:	44 65 00 09 	be r3,r5,1148 <strncmp+0x4c>
		if ((__res = *cs - *ct++) != 0 || !*cs++)
    1128:	34 a5 00 01 	addi r5,r5,1
    112c:	10 86 00 00 	lb r6,(r4+0)
    1130:	40 a1 ff ff 	lbu r1,(r5+-1)
    1134:	34 84 00 01 	addi r4,r4,1
    1138:	c8 c1 08 00 	sub r1,r6,r1
    113c:	b0 20 08 00 	sextb r1,r1
    1140:	5c 20 00 03 	bne r1,r0,114c <strncmp+0x50>
    1144:	5c c0 ff f8 	bne r6,r0,1124 <strncmp+0x28>
    1148:	34 01 00 00 	mvi r1,0
}
    114c:	c3 a0 00 00 	ret
    1150:	b8 80 08 00 	mv r1,r4
    1154:	c3 a0 00 00 	ret

00001158 <strlen>:
	for (sc = s; *sc != '\0'; ++sc)
    1158:	10 22 00 00 	lb r2,(r1+0)
    115c:	44 40 00 07 	be r2,r0,1178 <strlen+0x20>
    1160:	b8 20 10 00 	mv r2,r1
    1164:	34 42 00 01 	addi r2,r2,1
    1168:	10 43 00 00 	lb r3,(r2+0)
    116c:	5c 60 ff fe 	bne r3,r0,1164 <strlen+0xc>
    1170:	c8 41 08 00 	sub r1,r2,r1
		/* nothing */;
	return sc - s;
}
    1174:	c3 a0 00 00 	ret
	for (sc = s; *sc != '\0'; ++sc)
    1178:	34 01 00 00 	mvi r1,0
}
    117c:	c3 a0 00 00 	ret

00001180 <strnlen>:
 */
size_t strnlen(const char *s, size_t count)
{
	const char *sc;

	for (sc = s; count-- && *sc != '\0'; ++sc)
    1180:	44 40 00 0f 	be r2,r0,11bc <strnlen+0x3c>
    1184:	10 23 00 00 	lb r3,(r1+0)
    1188:	44 60 00 0d 	be r3,r0,11bc <strnlen+0x3c>
    118c:	34 23 00 01 	addi r3,r1,1
    1190:	b4 22 10 00 	add r2,r1,r2
    1194:	e0 00 00 04 	bi 11a4 <strnlen+0x24>
    1198:	34 63 00 01 	addi r3,r3,1
    119c:	10 64 ff ff 	lb r4,(r3+-1)
    11a0:	44 80 00 05 	be r4,r0,11b4 <strnlen+0x34>
    11a4:	b8 60 28 00 	mv r5,r3
    11a8:	5c 62 ff fc 	bne r3,r2,1198 <strnlen+0x18>
    11ac:	c8 61 08 00 	sub r1,r3,r1
		/* nothing */;
	return sc - s;
}
    11b0:	c3 a0 00 00 	ret
    11b4:	c8 a1 08 00 	sub r1,r5,r1
    11b8:	c3 a0 00 00 	ret
	for (sc = s; count-- && *sc != '\0'; ++sc)
    11bc:	34 01 00 00 	mvi r1,0
}
    11c0:	c3 a0 00 00 	ret

000011c4 <memcmp>:
 * @cs: One area of memory
 * @ct: Another area of memory
 * @count: The size of the area.
 */
int memcmp(const void *cs, const void *ct, size_t count)
{
    11c4:	b8 20 20 00 	mv r4,r1
	const unsigned char *su1, *su2;
	int res = 0;

	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
    11c8:	4c 03 00 11 	bge r0,r3,120c <memcmp+0x48>
		if ((res = *su1 - *su2) != 0)
    11cc:	40 21 00 00 	lbu r1,(r1+0)
    11d0:	40 45 00 00 	lbu r5,(r2+0)
    11d4:	c8 25 08 00 	sub r1,r1,r5
    11d8:	5c 20 00 0a 	bne r1,r0,1200 <memcmp+0x3c>
    11dc:	b4 83 18 00 	add r3,r4,r3
    11e0:	e0 00 00 05 	bi 11f4 <memcmp+0x30>
    11e4:	40 85 00 00 	lbu r5,(r4+0)
    11e8:	40 46 00 00 	lbu r6,(r2+0)
    11ec:	c8 a6 28 00 	sub r5,r5,r6
    11f0:	5c a0 00 05 	bne r5,r0,1204 <memcmp+0x40>
	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
    11f4:	34 84 00 01 	addi r4,r4,1
    11f8:	34 42 00 01 	addi r2,r2,1
    11fc:	5c 64 ff fa 	bne r3,r4,11e4 <memcmp+0x20>
			break;
	return res;
}
    1200:	c3 a0 00 00 	ret
		if ((res = *su1 - *su2) != 0)
    1204:	b8 a0 08 00 	mv r1,r5
}
    1208:	c3 a0 00 00 	ret
	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
    120c:	34 01 00 00 	mvi r1,0
}
    1210:	c3 a0 00 00 	ret

00001214 <memset>:
 */
void *memset(void *s, int c, size_t count)
{
	char *xs = s;

	while (count--)
    1214:	44 60 00 47 	be r3,r0,1330 <memset+0x11c>
    1218:	c8 01 20 00 	sub r4,r0,r1
    121c:	34 69 ff ff 	addi r9,r3,-1
    1220:	34 05 00 05 	mvi r5,5
    1224:	b0 40 10 00 	sextb r2,r2
    1228:	20 84 00 03 	andi r4,r4,0x3
    122c:	50 a9 00 39 	bgeu r5,r9,1310 <memset+0xfc>
{
    1230:	37 9c ff fc 	addi sp,sp,-4
    1234:	5b 8b 00 04 	sw (sp+4),r11
	while (count--)
    1238:	b8 20 38 00 	mv r7,r1
    123c:	44 80 00 0e 	be r4,r0,1274 <memset+0x60>
		*xs++ = c;
    1240:	30 22 00 00 	sb (r1+0),r2
    1244:	34 05 00 01 	mvi r5,1
    1248:	34 27 00 01 	addi r7,r1,1
	while (count--)
    124c:	34 69 ff fe 	addi r9,r3,-2
    1250:	44 85 00 09 	be r4,r5,1274 <memset+0x60>
		*xs++ = c;
    1254:	30 22 00 01 	sb (r1+1),r2
    1258:	34 05 00 03 	mvi r5,3
    125c:	34 27 00 02 	addi r7,r1,2
	while (count--)
    1260:	34 69 ff fd 	addi r9,r3,-3
    1264:	5c 85 00 04 	bne r4,r5,1274 <memset+0x60>
		*xs++ = c;
    1268:	34 27 00 03 	addi r7,r1,3
    126c:	30 22 00 02 	sb (r1+2),r2
	while (count--)
    1270:	34 69 ff fc 	addi r9,r3,-4
    1274:	20 45 00 ff 	andi r5,r2,0xff
    1278:	c8 64 18 00 	sub r3,r3,r4
    127c:	b8 a0 40 00 	mv r8,r5
    1280:	3c ab 00 10 	sli r11,r5,16
    1284:	00 66 00 02 	srui r6,r3,2
    1288:	3c a5 00 18 	sli r5,r5,24
    128c:	3d 0a 00 08 	sli r10,r8,8
    1290:	b8 ab 28 00 	or r5,r5,r11
    1294:	3c c6 00 02 	sli r6,r6,2
    1298:	b8 aa 28 00 	or r5,r5,r10
    129c:	b4 24 20 00 	add r4,r1,r4
    12a0:	b8 a8 28 00 	or r5,r5,r8
    12a4:	b4 c4 30 00 	add r6,r6,r4
		*xs++ = c;
    12a8:	58 85 00 00 	sw (r4+0),r5
    12ac:	34 84 00 04 	addi r4,r4,4
    12b0:	5c 86 ff fe 	bne r4,r6,12a8 <memset+0x94>
    12b4:	34 05 ff fc 	mvi r5,-4
    12b8:	a0 65 28 00 	and r5,r3,r5
    12bc:	b4 e5 20 00 	add r4,r7,r5
    12c0:	c9 25 48 00 	sub r9,r9,r5
    12c4:	44 65 00 10 	be r3,r5,1304 <memset+0xf0>
    12c8:	30 82 00 00 	sb (r4+0),r2
	while (count--)
    12cc:	45 20 00 0e 	be r9,r0,1304 <memset+0xf0>
		*xs++ = c;
    12d0:	30 82 00 01 	sb (r4+1),r2
	while (count--)
    12d4:	34 03 00 01 	mvi r3,1
    12d8:	45 23 00 0b 	be r9,r3,1304 <memset+0xf0>
		*xs++ = c;
    12dc:	30 82 00 02 	sb (r4+2),r2
	while (count--)
    12e0:	34 03 00 02 	mvi r3,2
    12e4:	45 23 00 08 	be r9,r3,1304 <memset+0xf0>
		*xs++ = c;
    12e8:	30 82 00 03 	sb (r4+3),r2
	while (count--)
    12ec:	34 03 00 03 	mvi r3,3
    12f0:	45 23 00 05 	be r9,r3,1304 <memset+0xf0>
		*xs++ = c;
    12f4:	30 82 00 04 	sb (r4+4),r2
	while (count--)
    12f8:	34 03 00 04 	mvi r3,4
    12fc:	45 23 00 02 	be r9,r3,1304 <memset+0xf0>
		*xs++ = c;
    1300:	30 82 00 05 	sb (r4+5),r2
	return s;
}
    1304:	2b 8b 00 04 	lw r11,(sp+4)
    1308:	37 9c 00 04 	addi sp,sp,4
    130c:	c3 a0 00 00 	ret
		*xs++ = c;
    1310:	30 22 00 00 	sb (r1+0),r2
	while (count--)
    1314:	45 20 00 07 	be r9,r0,1330 <memset+0x11c>
		*xs++ = c;
    1318:	30 22 00 01 	sb (r1+1),r2
	while (count--)
    131c:	34 03 00 01 	mvi r3,1
    1320:	45 23 00 04 	be r9,r3,1330 <memset+0x11c>
		*xs++ = c;
    1324:	30 22 00 02 	sb (r1+2),r2
	while (count--)
    1328:	34 03 00 02 	mvi r3,2
    132c:	5d 23 00 02 	bne r9,r3,1334 <memset+0x120>
}
    1330:	c3 a0 00 00 	ret
		*xs++ = c;
    1334:	30 22 00 03 	sb (r1+3),r2
	while (count--)
    1338:	34 03 00 03 	mvi r3,3
    133c:	45 23 ff fd 	be r9,r3,1330 <memset+0x11c>
		*xs++ = c;
    1340:	30 22 00 04 	sb (r1+4),r2
	while (count--)
    1344:	34 03 00 04 	mvi r3,4
    1348:	45 23 ff fa 	be r9,r3,1330 <memset+0x11c>
		*xs++ = c;
    134c:	30 22 00 05 	sb (r1+5),r2
	return s;
    1350:	c3 a0 00 00 	ret

00001354 <memcpy>:
void *memcpy(void *to, const void *from, size_t n)
{
	void *xto = to;
	size_t temp;

	if(!n)
    1354:	44 60 00 24 	be r3,r0,13e4 <memcpy+0x90>
		return xto;
	if((long)to & 1) {
    1358:	20 24 00 01 	andi r4,r1,0x1
    135c:	5c 80 00 23 	bne r4,r0,13e8 <memcpy+0x94>
		*cto++ = *cfrom++;
		to = cto;
		from = cfrom;
		n--;
	}
	if((long)from & 1) {
    1360:	20 44 00 01 	andi r4,r2,0x1
    1364:	b8 40 28 00 	mv r5,r2
    1368:	5c 80 00 5a 	bne r4,r0,14d0 <memcpy+0x17c>
    136c:	b8 20 20 00 	mv r4,r1
		const char *cfrom = from;
		for (; n; n--)
			*cto++ = *cfrom++;
		return xto;
	}
	if(n > 2 && (long)to & 2) {
    1370:	34 06 00 02 	mvi r6,2
    1374:	4c c3 00 09 	bge r6,r3,1398 <memcpy+0x44>
    1378:	20 86 00 02 	andi r6,r4,0x2
    137c:	44 c0 00 51 	be r6,r0,14c0 <memcpy+0x16c>
		short *sto = to;
		const short *sfrom = from;
		*sto++ = *sfrom++;
    1380:	1c 45 00 00 	lh r5,(r2+0)
    1384:	34 42 00 02 	addi r2,r2,2
		to = sto;
		from = sfrom;
		n -= 2;
    1388:	34 63 ff fe 	addi r3,r3,-2
		*sto++ = *sfrom++;
    138c:	0c 85 00 00 	sh (r4+0),r5
		from = sfrom;
    1390:	b8 40 28 00 	mv r5,r2
		to = sto;
    1394:	34 84 00 02 	addi r4,r4,2
	}
	if((long)from & 2) {
    1398:	20 a5 00 02 	andi r5,r5,0x2
    139c:	5c a0 00 4f 	bne r5,r0,14d8 <memcpy+0x184>
			const char *cfrom = from;
			*cto = *cfrom;
		}
		return xto;
	}
	temp = n >> 2;
    13a0:	14 65 00 02 	sri r5,r3,2
	if(temp) {
    13a4:	44 a0 00 0a 	be r5,r0,13cc <memcpy+0x78>
    13a8:	3c a8 00 02 	sli r8,r5,2
    13ac:	b8 40 28 00 	mv r5,r2
    13b0:	b4 88 38 00 	add r7,r4,r8
		long *lto = to;
		const long *lfrom = from;
		for(; temp; temp--)
			*lto++ = *lfrom++;
    13b4:	34 a5 00 04 	addi r5,r5,4
    13b8:	28 a6 ff fc 	lw r6,(r5+-4)
    13bc:	34 84 00 04 	addi r4,r4,4
    13c0:	58 86 ff fc 	sw (r4+-4),r6
		for(; temp; temp--)
    13c4:	5c 87 ff fc 	bne r4,r7,13b4 <memcpy+0x60>
    13c8:	b4 48 10 00 	add r2,r2,r8
		to = lto;
		from = lfrom;
	}
	if(n & 2) {
    13cc:	20 65 00 02 	andi r5,r3,0x2
    13d0:	5c a0 00 37 	bne r5,r0,14ac <memcpy+0x158>
		const short *sfrom = from;
		*sto++ = *sfrom++;
		to = sto;
		from = sfrom;
	}
	if(n & 1) {
    13d4:	20 63 00 01 	andi r3,r3,0x1
    13d8:	44 60 00 03 	be r3,r0,13e4 <memcpy+0x90>
		char *cto = to;
		const char *cfrom = from;
		*cto = *cfrom;
    13dc:	10 42 00 00 	lb r2,(r2+0)
    13e0:	30 82 00 00 	sb (r4+0),r2
	}
	return xto;
}
    13e4:	c3 a0 00 00 	ret
		*cto++ = *cfrom++;
    13e8:	10 44 00 00 	lb r4,(r2+0)
    13ec:	34 42 00 01 	addi r2,r2,1
	if((long)from & 1) {
    13f0:	20 46 00 01 	andi r6,r2,0x1
		*cto++ = *cfrom++;
    13f4:	30 24 00 00 	sb (r1+0),r4
		n--;
    13f8:	34 63 ff ff 	addi r3,r3,-1
		*cto++ = *cfrom++;
    13fc:	34 24 00 01 	addi r4,r1,1
	if((long)from & 1) {
    1400:	b8 40 28 00 	mv r5,r2
    1404:	44 c0 ff db 	be r6,r0,1370 <memcpy+0x1c>
		for (; n; n--)
    1408:	44 60 ff f7 	be r3,r0,13e4 <memcpy+0x90>
    140c:	34 88 00 04 	addi r8,r4,4
    1410:	34 47 00 04 	addi r7,r2,4
    1414:	f0 48 40 00 	cmpgeu r8,r2,r8
    1418:	f0 87 38 00 	cmpgeu r7,r4,r7
    141c:	34 66 ff ff 	addi r6,r3,-1
    1420:	b8 82 28 00 	or r5,r4,r2
    1424:	74 c6 00 08 	cmpgui r6,r6,0x8
    1428:	20 a5 00 03 	andi r5,r5,0x3
    142c:	b9 07 38 00 	or r7,r8,r7
    1430:	e4 05 28 00 	cmpe r5,r0,r5
    1434:	a0 c7 30 00 	and r6,r6,r7
    1438:	a0 a6 28 00 	and r5,r5,r6
    143c:	44 a0 00 4c 	be r5,r0,156c <memcpy+0x218>
    1440:	00 67 00 02 	srui r7,r3,2
    1444:	b8 40 28 00 	mv r5,r2
    1448:	3c e7 00 02 	sli r7,r7,2
    144c:	b8 80 30 00 	mv r6,r4
    1450:	b4 e2 38 00 	add r7,r7,r2
			*cto++ = *cfrom++;
    1454:	28 a8 00 00 	lw r8,(r5+0)
    1458:	34 c6 00 04 	addi r6,r6,4
    145c:	34 a5 00 04 	addi r5,r5,4
    1460:	58 c8 ff fc 	sw (r6+-4),r8
    1464:	5c a7 ff fc 	bne r5,r7,1454 <memcpy+0x100>
    1468:	34 05 ff fc 	mvi r5,-4
    146c:	a0 65 28 00 	and r5,r3,r5
    1470:	c8 65 30 00 	sub r6,r3,r5
    1474:	b4 85 20 00 	add r4,r4,r5
    1478:	b4 45 10 00 	add r2,r2,r5
    147c:	44 65 ff da 	be r3,r5,13e4 <memcpy+0x90>
    1480:	10 45 00 00 	lb r5,(r2+0)
		for (; n; n--)
    1484:	34 c3 ff ff 	addi r3,r6,-1
			*cto++ = *cfrom++;
    1488:	30 85 00 00 	sb (r4+0),r5
		for (; n; n--)
    148c:	44 60 ff d6 	be r3,r0,13e4 <memcpy+0x90>
			*cto++ = *cfrom++;
    1490:	10 45 00 01 	lb r5,(r2+1)
		for (; n; n--)
    1494:	34 03 00 02 	mvi r3,2
			*cto++ = *cfrom++;
    1498:	30 85 00 01 	sb (r4+1),r5
		for (; n; n--)
    149c:	44 c3 ff d2 	be r6,r3,13e4 <memcpy+0x90>
			*cto++ = *cfrom++;
    14a0:	10 42 00 02 	lb r2,(r2+2)
    14a4:	30 82 00 02 	sb (r4+2),r2
}
    14a8:	c3 a0 00 00 	ret
		*sto++ = *sfrom++;
    14ac:	1c 45 00 00 	lh r5,(r2+0)
		to = sto;
    14b0:	34 84 00 02 	addi r4,r4,2
		from = sfrom;
    14b4:	34 42 00 02 	addi r2,r2,2
		*sto++ = *sfrom++;
    14b8:	0c 85 ff fe 	sh (r4+-2),r5
		from = sfrom;
    14bc:	e3 ff ff c6 	bi 13d4 <memcpy+0x80>
	if((long)from & 2) {
    14c0:	20 a5 00 02 	andi r5,r5,0x2
    14c4:	44 a0 ff b7 	be r5,r0,13a0 <memcpy+0x4c>
		temp = n >> 1;
    14c8:	14 69 00 01 	sri r9,r3,1
		for (; temp; temp--)
    14cc:	e0 00 00 05 	bi 14e0 <memcpy+0x18c>
	if((long)from & 1) {
    14d0:	b8 20 20 00 	mv r4,r1
    14d4:	e3 ff ff ce 	bi 140c <memcpy+0xb8>
		temp = n >> 1;
    14d8:	14 69 00 01 	sri r9,r3,1
		for (; temp; temp--)
    14dc:	45 20 ff be 	be r9,r0,13d4 <memcpy+0x80>
    14e0:	34 88 00 04 	addi r8,r4,4
    14e4:	34 47 00 04 	addi r7,r2,4
    14e8:	f0 48 40 00 	cmpgeu r8,r2,r8
    14ec:	f0 87 38 00 	cmpgeu r7,r4,r7
    14f0:	35 26 ff ff 	addi r6,r9,-1
    14f4:	b8 44 28 00 	or r5,r2,r4
    14f8:	74 c6 00 0b 	cmpgui r6,r6,0xb
    14fc:	20 a5 00 03 	andi r5,r5,0x3
    1500:	b9 07 38 00 	or r7,r8,r7
    1504:	e4 05 28 00 	cmpe r5,r0,r5
    1508:	a0 c7 30 00 	and r6,r6,r7
    150c:	a0 a6 28 00 	and r5,r5,r6
    1510:	44 a0 00 1e 	be r5,r0,1588 <memcpy+0x234>
    1514:	01 27 00 01 	srui r7,r9,1
    1518:	b8 40 28 00 	mv r5,r2
    151c:	3c e7 00 02 	sli r7,r7,2
    1520:	b8 80 30 00 	mv r6,r4
    1524:	b4 e2 38 00 	add r7,r7,r2
			*sto++ = *sfrom++;
    1528:	28 a8 00 00 	lw r8,(r5+0)
    152c:	34 c6 00 04 	addi r6,r6,4
    1530:	34 a5 00 04 	addi r5,r5,4
    1534:	58 c8 ff fc 	sw (r6+-4),r8
    1538:	5c a7 ff fc 	bne r5,r7,1528 <memcpy+0x1d4>
    153c:	34 07 ff fe 	mvi r7,-2
    1540:	a1 27 38 00 	and r7,r9,r7
    1544:	3c e5 00 01 	sli r5,r7,1
    1548:	3d 28 00 01 	sli r8,r9,1
    154c:	b4 85 30 00 	add r6,r4,r5
    1550:	b4 45 28 00 	add r5,r2,r5
    1554:	45 27 00 03 	be r9,r7,1560 <memcpy+0x20c>
    1558:	1c a5 00 00 	lh r5,(r5+0)
    155c:	0c c5 00 00 	sh (r6+0),r5
    1560:	b4 48 10 00 	add r2,r2,r8
    1564:	b4 88 20 00 	add r4,r4,r8
    1568:	e3 ff ff 9b 	bi 13d4 <memcpy+0x80>
    156c:	b4 83 18 00 	add r3,r4,r3
			*cto++ = *cfrom++;
    1570:	34 42 00 01 	addi r2,r2,1
    1574:	10 45 ff ff 	lb r5,(r2+-1)
    1578:	34 84 00 01 	addi r4,r4,1
    157c:	30 85 ff ff 	sb (r4+-1),r5
		for (; n; n--)
    1580:	5c 64 ff fc 	bne r3,r4,1570 <memcpy+0x21c>
}
    1584:	c3 a0 00 00 	ret
    1588:	3d 28 00 01 	sli r8,r9,1
		to = sto;
    158c:	b8 40 30 00 	mv r6,r2
    1590:	b4 88 48 00 	add r9,r4,r8
    1594:	b8 80 28 00 	mv r5,r4
			*sto++ = *sfrom++;
    1598:	34 c6 00 02 	addi r6,r6,2
    159c:	1c c7 ff fe 	lh r7,(r6+-2)
    15a0:	34 a5 00 02 	addi r5,r5,2
    15a4:	0c a7 ff fe 	sh (r5+-2),r7
		for (; temp; temp--)
    15a8:	5c a9 ff fc 	bne r5,r9,1598 <memcpy+0x244>
    15ac:	e3 ff ff ed 	bi 1560 <memcpy+0x20c>

000015b0 <memmove>:
 */
void *memmove(void *dest, const void *src, size_t count)
{
	char *tmp, *s;

	if(dest <= src) {
    15b0:	34 68 ff ff 	addi r8,r3,-1
    15b4:	54 22 00 28 	bgu r1,r2,1654 <memmove+0xa4>
		tmp = (char *) dest;
		s = (char *) src;
		while(count--)
    15b8:	44 60 00 26 	be r3,r0,1650 <memmove+0xa0>
    15bc:	34 47 00 04 	addi r7,r2,4
    15c0:	34 26 00 04 	addi r6,r1,4
    15c4:	f0 27 38 00 	cmpgeu r7,r1,r7
    15c8:	f0 46 30 00 	cmpgeu r6,r2,r6
    15cc:	b8 22 28 00 	or r5,r1,r2
    15d0:	75 04 00 08 	cmpgui r4,r8,0x8
    15d4:	20 a5 00 03 	andi r5,r5,0x3
    15d8:	b8 e6 30 00 	or r6,r7,r6
    15dc:	e4 05 28 00 	cmpe r5,r0,r5
    15e0:	a0 86 20 00 	and r4,r4,r6
    15e4:	a0 a4 20 00 	and r4,r5,r4
    15e8:	44 80 00 29 	be r4,r0,168c <memmove+0xdc>
    15ec:	00 66 00 02 	srui r6,r3,2
    15f0:	b8 40 20 00 	mv r4,r2
    15f4:	3c c6 00 02 	sli r6,r6,2
    15f8:	b8 20 28 00 	mv r5,r1
    15fc:	b4 c2 30 00 	add r6,r6,r2
			*tmp++ = *s++;
    1600:	28 87 00 00 	lw r7,(r4+0)
    1604:	34 a5 00 04 	addi r5,r5,4
    1608:	34 84 00 04 	addi r4,r4,4
    160c:	58 a7 ff fc 	sw (r5+-4),r7
    1610:	5c 86 ff fc 	bne r4,r6,1600 <memmove+0x50>
    1614:	34 04 ff fc 	mvi r4,-4
    1618:	a0 64 20 00 	and r4,r3,r4
    161c:	b4 24 28 00 	add r5,r1,r4
    1620:	b4 44 10 00 	add r2,r2,r4
    1624:	c9 04 40 00 	sub r8,r8,r4
    1628:	44 64 00 0a 	be r3,r4,1650 <memmove+0xa0>
    162c:	10 43 00 00 	lb r3,(r2+0)
    1630:	30 a3 00 00 	sb (r5+0),r3
		while(count--)
    1634:	45 00 00 07 	be r8,r0,1650 <memmove+0xa0>
			*tmp++ = *s++;
    1638:	10 44 00 01 	lb r4,(r2+1)
		while(count--)
    163c:	34 03 00 01 	mvi r3,1
			*tmp++ = *s++;
    1640:	30 a4 00 01 	sb (r5+1),r4
		while(count--)
    1644:	45 03 00 03 	be r8,r3,1650 <memmove+0xa0>
			*tmp++ = *s++;
    1648:	10 42 00 02 	lb r2,(r2+2)
    164c:	30 a2 00 02 	sb (r5+2),r2
		while(count--)
			*--tmp = *--s;
	}

	return dest;
}
    1650:	c3 a0 00 00 	ret
		tmp = (char *)dest + count;
    1654:	b4 23 20 00 	add r4,r1,r3
		s = (char *)src + count;
    1658:	b4 43 10 00 	add r2,r2,r3
		while(count--)
    165c:	44 60 ff fd 	be r3,r0,1650 <memmove+0xa0>
			*--tmp = *--s;
    1660:	34 42 ff ff 	addi r2,r2,-1
    1664:	10 43 00 00 	lb r3,(r2+0)
    1668:	34 84 ff ff 	addi r4,r4,-1
    166c:	30 83 00 00 	sb (r4+0),r3
		while(count--)
    1670:	44 24 ff f8 	be r1,r4,1650 <memmove+0xa0>
			*--tmp = *--s;
    1674:	34 42 ff ff 	addi r2,r2,-1
    1678:	10 43 00 00 	lb r3,(r2+0)
    167c:	34 84 ff ff 	addi r4,r4,-1
    1680:	30 83 00 00 	sb (r4+0),r3
		while(count--)
    1684:	5c 24 ff f7 	bne r1,r4,1660 <memmove+0xb0>
    1688:	e3 ff ff f2 	bi 1650 <memmove+0xa0>
    168c:	b4 23 18 00 	add r3,r1,r3
		while(count--)
    1690:	b8 20 20 00 	mv r4,r1
			*tmp++ = *s++;
    1694:	34 42 00 01 	addi r2,r2,1
    1698:	10 45 ff ff 	lb r5,(r2+-1)
    169c:	34 84 00 01 	addi r4,r4,1
    16a0:	30 85 ff ff 	sb (r4+-1),r5
		while(count--)
    16a4:	5c 83 ff fc 	bne r4,r3,1694 <memmove+0xe4>
}
    16a8:	c3 a0 00 00 	ret

000016ac <strstr>:
	for (sc = s; *sc != '\0'; ++sc)
    16ac:	10 4a 00 00 	lb r10,(r2+0)
 * strstr - Find the first substring in a %NUL terminated string
 * @s1: The string to be searched
 * @s2: The string to search for
 */
char *strstr(const char *s1, const char *s2)
{
    16b0:	b8 20 38 00 	mv r7,r1
	for (sc = s; *sc != '\0'; ++sc)
    16b4:	45 40 00 20 	be r10,r0,1734 <strstr+0x88>
    16b8:	b8 40 08 00 	mv r1,r2
    16bc:	34 21 00 01 	addi r1,r1,1
    16c0:	10 23 00 00 	lb r3,(r1+0)
    16c4:	5c 60 ff fe 	bne r3,r0,16bc <strstr+0x10>
	return sc - s;
    16c8:	c8 22 40 00 	sub r8,r1,r2
	size_t l1, l2;

	l2 = strlen(s2);
	if (!l2)
    16cc:	b8 e0 08 00 	mv r1,r7
    16d0:	45 00 00 19 	be r8,r0,1734 <strstr+0x88>
	for (sc = s; *sc != '\0'; ++sc)
    16d4:	10 e1 00 00 	lb r1,(r7+0)
    16d8:	44 20 00 1e 	be r1,r0,1750 <strstr+0xa4>
    16dc:	b8 e0 08 00 	mv r1,r7
    16e0:	34 21 00 01 	addi r1,r1,1
    16e4:	10 23 00 00 	lb r3,(r1+0)
    16e8:	5c 60 ff fe 	bne r3,r0,16e0 <strstr+0x34>
    16ec:	c8 27 48 00 	sub r9,r1,r7
		return (char *)s1;
	l1 = strlen(s1);
	while (l1 >= l2) {
    16f0:	49 09 00 16 	bg r8,r9,1748 <strstr+0x9c>
    16f4:	b8 e0 08 00 	mv r1,r7
		if ((res = *su1 - *su2) != 0)
    16f8:	21 4a 00 ff 	andi r10,r10,0xff
    16fc:	b4 e8 38 00 	add r7,r7,r8
	while (l1 >= l2) {
    1700:	b4 29 48 00 	add r9,r1,r9
	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
    1704:	4c 08 00 0c 	bge r0,r8,1734 <strstr+0x88>
		if ((res = *su1 - *su2) != 0)
    1708:	40 23 00 00 	lbu r3,(r1+0)
    170c:	5c 6a 00 0b 	bne r3,r10,1738 <strstr+0x8c>
    1710:	b8 40 20 00 	mv r4,r2
    1714:	b8 20 18 00 	mv r3,r1
    1718:	e0 00 00 04 	bi 1728 <strstr+0x7c>
    171c:	40 66 00 00 	lbu r6,(r3+0)
    1720:	40 85 00 00 	lbu r5,(r4+0)
    1724:	5c c5 00 05 	bne r6,r5,1738 <strstr+0x8c>
	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
    1728:	34 63 00 01 	addi r3,r3,1
    172c:	34 84 00 01 	addi r4,r4,1
    1730:	5c 67 ff fb 	bne r3,r7,171c <strstr+0x70>
		if (!memcmp(s1, s2, l2))
			return (char *)s1;
		s1++;
	}
	return NULL;
}
    1734:	c3 a0 00 00 	ret
		s1++;
    1738:	34 21 00 01 	addi r1,r1,1
	while (l1 >= l2) {
    173c:	c9 21 18 00 	sub r3,r9,r1
    1740:	34 e7 00 01 	addi r7,r7,1
    1744:	4c 68 ff f0 	bge r3,r8,1704 <strstr+0x58>
	return NULL;
    1748:	34 01 00 00 	mvi r1,0
}
    174c:	c3 a0 00 00 	ret
	for (sc = s; *sc != '\0'; ++sc)
    1750:	34 09 00 00 	mvi r9,0
    1754:	e3 ff ff e7 	bi 16f0 <strstr+0x44>

00001758 <strtoul>:
 * @nptr: The start of the string
 * @endptr: A pointer to the end of the parsed string will be placed here
 * @base: The number base to use
 */
unsigned long strtoul(const char *nptr, char **endptr, int base)
{
    1758:	37 9c ff f4 	addi sp,sp,-12
    175c:	5b 8b 00 0c 	sw (sp+12),r11
    1760:	5b 8c 00 08 	sw (sp+8),r12
    1764:	5b 8d 00 04 	sw (sp+4),r13
	unsigned long result = 0,value;

	if (!base) {
    1768:	10 24 00 00 	lb r4,(r1+0)
    176c:	5c 60 00 28 	bne r3,r0,180c <strtoul+0xb4>
		base = 10;
		if (*nptr == '0') {
    1770:	34 05 00 30 	mvi r5,48
		base = 10;
    1774:	34 03 00 0a 	mvi r3,10
		if (*nptr == '0') {
    1778:	44 85 00 34 	be r4,r5,1848 <strtoul+0xf0>
			base = 8;
    177c:	34 09 00 00 	mvi r9,0
}

static inline int isxdigit(char c)
{
	return isdigit(c) || ((c >= 'a') && (c <= 'f')) || ((c >= 'A') && (c <= 'F'));
    1780:	34 0b 00 09 	mvi r11,9
    1784:	34 0a ff df 	mvi r10,-33
    1788:	34 0c 00 05 	mvi r12,5
	return c;
}

static inline unsigned char toupper(unsigned char c)
{
	if (islower(c))
    178c:	34 0d 00 19 	mvi r13,25
		}
	} else if (base == 16) {
		if (nptr[0] == '0' && toupper(nptr[1]) == 'X')
			nptr += 2;
	}
	while (isxdigit(*nptr) &&
    1790:	10 28 00 00 	lb r8,(r1+0)
	return (c >= '0') && (c <= '9');
    1794:	21 04 00 ff 	andi r4,r8,0xff
	return isdigit(c) || ((c >= 'a') && (c <= 'f')) || ((c >= 'A') && (c <= 'F'));
    1798:	a0 8a 28 00 	and r5,r4,r10
	return (c >= '0') && (c <= '9');
    179c:	34 86 ff d0 	addi r6,r4,-48
	return isdigit(c) || ((c >= 'a') && (c <= 'f')) || ((c >= 'A') && (c <= 'F'));
    17a0:	34 a5 ff bf 	addi r5,r5,-65
    17a4:	20 c6 00 ff 	andi r6,r6,0xff
    17a8:	34 87 ff 9f 	addi r7,r4,-97
    17ac:	20 a5 00 ff 	andi r5,r5,0xff
    17b0:	51 66 00 15 	bgeu r11,r6,1804 <strtoul+0xac>
    17b4:	20 e7 00 ff 	andi r7,r7,0xff
    17b8:	51 85 00 09 	bgeu r12,r5,17dc <strtoul+0x84>
	       (value = isdigit(*nptr) ? *nptr-'0' : toupper(*nptr)-'A'+10) < (unsigned int) base) {
		result = result*base + value;
		nptr++;
	}
	if (endptr)
    17bc:	44 40 00 02 	be r2,r0,17c4 <strtoul+0x6c>
		*endptr = (char *)nptr;
    17c0:	58 41 00 00 	sw (r2+0),r1
	return result;
}
    17c4:	b9 20 08 00 	mv r1,r9
    17c8:	2b 8b 00 0c 	lw r11,(sp+12)
    17cc:	2b 8c 00 08 	lw r12,(sp+8)
    17d0:	2b 8d 00 04 	lw r13,(sp+4)
    17d4:	37 9c 00 0c 	addi sp,sp,12
    17d8:	c3 a0 00 00 	ret
		c -= 'a'-'A';
    17dc:	34 85 ff e0 	addi r5,r4,-32
	if (islower(c))
    17e0:	54 ed 00 02 	bgu r7,r13,17e8 <strtoul+0x90>
		c -= 'a'-'A';
    17e4:	20 a4 00 ff 	andi r4,r5,0xff
	       (value = isdigit(*nptr) ? *nptr-'0' : toupper(*nptr)-'A'+10) < (unsigned int) base) {
    17e8:	34 84 ff c9 	addi r4,r4,-55
		result = result*base + value;
    17ec:	88 69 28 00 	mul r5,r3,r9
	while (isxdigit(*nptr) &&
    17f0:	54 64 00 02 	bgu r3,r4,17f8 <strtoul+0xa0>
    17f4:	e3 ff ff f2 	bi 17bc <strtoul+0x64>
		nptr++;
    17f8:	34 21 00 01 	addi r1,r1,1
		result = result*base + value;
    17fc:	b4 a4 48 00 	add r9,r5,r4
		nptr++;
    1800:	e3 ff ff e4 	bi 1790 <strtoul+0x38>
	       (value = isdigit(*nptr) ? *nptr-'0' : toupper(*nptr)-'A'+10) < (unsigned int) base) {
    1804:	35 04 ff d0 	addi r4,r8,-48
    1808:	e3 ff ff f9 	bi 17ec <strtoul+0x94>
	} else if (base == 16) {
    180c:	34 05 00 10 	mvi r5,16
    1810:	5c 65 ff db 	bne r3,r5,177c <strtoul+0x24>
		if (nptr[0] == '0' && toupper(nptr[1]) == 'X')
    1814:	34 05 00 30 	mvi r5,48
    1818:	5c 85 ff d9 	bne r4,r5,177c <strtoul+0x24>
    181c:	40 24 00 01 	lbu r4,(r1+1)
	if (islower(c))
    1820:	34 06 00 19 	mvi r6,25
	return (c >= 'a') && (c <= 'z');
    1824:	34 85 ff 9f 	addi r5,r4,-97
	if (islower(c))
    1828:	20 a5 00 ff 	andi r5,r5,0xff
    182c:	54 a6 00 03 	bgu r5,r6,1838 <strtoul+0xe0>
		c -= 'a'-'A';
    1830:	34 84 ff e0 	addi r4,r4,-32
    1834:	20 84 00 ff 	andi r4,r4,0xff
    1838:	34 05 00 58 	mvi r5,88
    183c:	5c 85 ff d0 	bne r4,r5,177c <strtoul+0x24>
			nptr += 2;
    1840:	34 21 00 02 	addi r1,r1,2
    1844:	e3 ff ff ce 	bi 177c <strtoul+0x24>
			if ((toupper(*nptr) == 'X') && isxdigit(nptr[1])) {
    1848:	40 23 00 01 	lbu r3,(r1+1)
	if (islower(c))
    184c:	34 05 00 19 	mvi r5,25
			nptr++;
    1850:	34 26 00 01 	addi r6,r1,1
	return (c >= 'a') && (c <= 'z');
    1854:	34 64 ff 9f 	addi r4,r3,-97
	if (islower(c))
    1858:	20 84 00 ff 	andi r4,r4,0xff
    185c:	54 85 00 03 	bgu r4,r5,1868 <strtoul+0x110>
		c -= 'a'-'A';
    1860:	34 63 ff e0 	addi r3,r3,-32
    1864:	20 63 00 ff 	andi r3,r3,0xff
			if ((toupper(*nptr) == 'X') && isxdigit(nptr[1])) {
    1868:	34 04 00 58 	mvi r4,88
    186c:	44 64 00 04 	be r3,r4,187c <strtoul+0x124>
			nptr++;
    1870:	b8 c0 08 00 	mv r1,r6
			base = 8;
    1874:	34 03 00 08 	mvi r3,8
    1878:	e3 ff ff c1 	bi 177c <strtoul+0x24>
	return (c >= '0') && (c <= '9');
    187c:	40 23 00 02 	lbu r3,(r1+2)
	return isdigit(c) || ((c >= 'a') && (c <= 'f')) || ((c >= 'A') && (c <= 'F'));
    1880:	34 05 00 09 	mvi r5,9
	return (c >= '0') && (c <= '9');
    1884:	34 64 ff d0 	addi r4,r3,-48
	return isdigit(c) || ((c >= 'a') && (c <= 'f')) || ((c >= 'A') && (c <= 'F'));
    1888:	20 84 00 ff 	andi r4,r4,0xff
    188c:	50 a4 00 06 	bgeu r5,r4,18a4 <strtoul+0x14c>
    1890:	20 63 00 df 	andi r3,r3,0xdf
    1894:	34 63 ff bf 	addi r3,r3,-65
    1898:	20 63 00 ff 	andi r3,r3,0xff
    189c:	34 04 00 05 	mvi r4,5
    18a0:	54 64 ff f4 	bgu r3,r4,1870 <strtoul+0x118>
				nptr++;
    18a4:	34 21 00 02 	addi r1,r1,2
				base = 16;
    18a8:	34 03 00 10 	mvi r3,16
    18ac:	e3 ff ff b4 	bi 177c <strtoul+0x24>

000018b0 <strtol>:
 * @nptr: The start of the string
 * @endptr: A pointer to the end of the parsed string will be placed here
 * @base: The number base to use
 */
long strtol(const char *nptr, char **endptr, int base)
{
    18b0:	37 9c ff f0 	addi sp,sp,-16
    18b4:	5b 8b 00 10 	sw (sp+16),r11
    18b8:	5b 8c 00 0c 	sw (sp+12),r12
    18bc:	5b 8d 00 08 	sw (sp+8),r13
    18c0:	5b 9d 00 04 	sw (sp+4),ra
	if(*nptr=='-')
    18c4:	10 24 00 00 	lb r4,(r1+0)
    18c8:	34 06 00 2d 	mvi r6,45
    18cc:	44 86 00 3b 	be r4,r6,19b8 <strtol+0x108>
    18d0:	b8 40 48 00 	mv r9,r2
    18d4:	b8 60 28 00 	mv r5,r3
	if (!base) {
    18d8:	44 60 00 26 	be r3,r0,1970 <strtol+0xc0>
	} else if (base == 16) {
    18dc:	34 02 00 10 	mvi r2,16
    18e0:	44 62 00 3f 	be r3,r2,19dc <strtol+0x12c>
			base = 8;
    18e4:	34 04 00 00 	mvi r4,0
    18e8:	34 0d 00 09 	mvi r13,9
    18ec:	34 0c ff df 	mvi r12,-33
    18f0:	34 0b 00 05 	mvi r11,5
	if (islower(c))
    18f4:	34 0a 00 19 	mvi r10,25
	while (isxdigit(*nptr) &&
    18f8:	10 28 00 00 	lb r8,(r1+0)
	return (c >= '0') && (c <= '9');
    18fc:	21 02 00 ff 	andi r2,r8,0xff
	return isdigit(c) || ((c >= 'a') && (c <= 'f')) || ((c >= 'A') && (c <= 'F'));
    1900:	a0 4c 18 00 	and r3,r2,r12
	return (c >= '0') && (c <= '9');
    1904:	34 47 ff d0 	addi r7,r2,-48
	return isdigit(c) || ((c >= 'a') && (c <= 'f')) || ((c >= 'A') && (c <= 'F'));
    1908:	34 63 ff bf 	addi r3,r3,-65
    190c:	20 e7 00 ff 	andi r7,r7,0xff
    1910:	34 46 ff 9f 	addi r6,r2,-97
    1914:	20 63 00 ff 	andi r3,r3,0xff
    1918:	51 a7 00 26 	bgeu r13,r7,19b0 <strtol+0x100>
    191c:	20 c6 00 ff 	andi r6,r6,0xff
    1920:	51 63 00 0a 	bgeu r11,r3,1948 <strtol+0x98>
	if (endptr)
    1924:	45 20 00 02 	be r9,r0,192c <strtol+0x7c>
		*endptr = (char *)nptr;
    1928:	59 21 00 00 	sw (r9+0),r1
		return -strtoul(nptr+1,endptr,base);
	return strtoul(nptr,endptr,base);
    192c:	b8 80 08 00 	mv r1,r4
}
    1930:	2b 9d 00 04 	lw ra,(sp+4)
    1934:	2b 8b 00 10 	lw r11,(sp+16)
    1938:	2b 8c 00 0c 	lw r12,(sp+12)
    193c:	2b 8d 00 08 	lw r13,(sp+8)
    1940:	37 9c 00 10 	addi sp,sp,16
    1944:	c3 a0 00 00 	ret
		c -= 'a'-'A';
    1948:	34 43 ff e0 	addi r3,r2,-32
	if (islower(c))
    194c:	54 ca 00 02 	bgu r6,r10,1954 <strtol+0xa4>
		c -= 'a'-'A';
    1950:	20 62 00 ff 	andi r2,r3,0xff
	       (value = isdigit(*nptr) ? *nptr-'0' : toupper(*nptr)-'A'+10) < (unsigned int) base) {
    1954:	34 42 ff c9 	addi r2,r2,-55
		result = result*base + value;
    1958:	88 a4 18 00 	mul r3,r5,r4
	while (isxdigit(*nptr) &&
    195c:	54 a2 00 02 	bgu r5,r2,1964 <strtol+0xb4>
    1960:	e3 ff ff f1 	bi 1924 <strtol+0x74>
		nptr++;
    1964:	34 21 00 01 	addi r1,r1,1
		result = result*base + value;
    1968:	b4 62 20 00 	add r4,r3,r2
		nptr++;
    196c:	e3 ff ff e3 	bi 18f8 <strtol+0x48>
		if (*nptr == '0') {
    1970:	34 02 00 30 	mvi r2,48
		base = 10;
    1974:	34 05 00 0a 	mvi r5,10
		if (*nptr == '0') {
    1978:	5c 82 ff db 	bne r4,r2,18e4 <strtol+0x34>
			if ((toupper(*nptr) == 'X') && isxdigit(nptr[1])) {
    197c:	40 22 00 01 	lbu r2,(r1+1)
	if (islower(c))
    1980:	34 04 00 19 	mvi r4,25
			nptr++;
    1984:	34 25 00 01 	addi r5,r1,1
	return (c >= 'a') && (c <= 'z');
    1988:	34 43 ff 9f 	addi r3,r2,-97
	if (islower(c))
    198c:	20 63 00 ff 	andi r3,r3,0xff
    1990:	54 64 00 03 	bgu r3,r4,199c <strtol+0xec>
		c -= 'a'-'A';
    1994:	34 42 ff e0 	addi r2,r2,-32
    1998:	20 42 00 ff 	andi r2,r2,0xff
			if ((toupper(*nptr) == 'X') && isxdigit(nptr[1])) {
    199c:	34 03 00 58 	mvi r3,88
    19a0:	44 43 00 1c 	be r2,r3,1a10 <strtol+0x160>
			nptr++;
    19a4:	b8 a0 08 00 	mv r1,r5
			base = 8;
    19a8:	34 05 00 08 	mvi r5,8
    19ac:	e3 ff ff ce 	bi 18e4 <strtol+0x34>
	       (value = isdigit(*nptr) ? *nptr-'0' : toupper(*nptr)-'A'+10) < (unsigned int) base) {
    19b0:	35 02 ff d0 	addi r2,r8,-48
    19b4:	e3 ff ff e9 	bi 1958 <strtol+0xa8>
		return -strtoul(nptr+1,endptr,base);
    19b8:	34 21 00 01 	addi r1,r1,1
    19bc:	fb ff ff 67 	calli 1758 <strtoul>
    19c0:	c8 01 08 00 	sub r1,r0,r1
}
    19c4:	2b 9d 00 04 	lw ra,(sp+4)
    19c8:	2b 8b 00 10 	lw r11,(sp+16)
    19cc:	2b 8c 00 0c 	lw r12,(sp+12)
    19d0:	2b 8d 00 08 	lw r13,(sp+8)
    19d4:	37 9c 00 10 	addi sp,sp,16
    19d8:	c3 a0 00 00 	ret
		if (nptr[0] == '0' && toupper(nptr[1]) == 'X')
    19dc:	34 02 00 30 	mvi r2,48
    19e0:	5c 82 ff c1 	bne r4,r2,18e4 <strtol+0x34>
    19e4:	40 22 00 01 	lbu r2,(r1+1)
	if (islower(c))
    19e8:	34 04 00 19 	mvi r4,25
	return (c >= 'a') && (c <= 'z');
    19ec:	34 43 ff 9f 	addi r3,r2,-97
	if (islower(c))
    19f0:	20 63 00 ff 	andi r3,r3,0xff
    19f4:	54 64 00 03 	bgu r3,r4,1a00 <strtol+0x150>
		c -= 'a'-'A';
    19f8:	34 42 ff e0 	addi r2,r2,-32
    19fc:	20 42 00 ff 	andi r2,r2,0xff
    1a00:	34 03 00 58 	mvi r3,88
    1a04:	5c 43 ff b8 	bne r2,r3,18e4 <strtol+0x34>
			nptr += 2;
    1a08:	34 21 00 02 	addi r1,r1,2
    1a0c:	e3 ff ff b6 	bi 18e4 <strtol+0x34>
	return (c >= '0') && (c <= '9');
    1a10:	40 22 00 02 	lbu r2,(r1+2)
	return isdigit(c) || ((c >= 'a') && (c <= 'f')) || ((c >= 'A') && (c <= 'F'));
    1a14:	34 04 00 09 	mvi r4,9
	return (c >= '0') && (c <= '9');
    1a18:	34 43 ff d0 	addi r3,r2,-48
	return isdigit(c) || ((c >= 'a') && (c <= 'f')) || ((c >= 'A') && (c <= 'F'));
    1a1c:	20 63 00 ff 	andi r3,r3,0xff
    1a20:	50 83 00 06 	bgeu r4,r3,1a38 <strtol+0x188>
    1a24:	20 42 00 df 	andi r2,r2,0xdf
    1a28:	34 42 ff bf 	addi r2,r2,-65
    1a2c:	20 42 00 ff 	andi r2,r2,0xff
    1a30:	34 03 00 05 	mvi r3,5
    1a34:	54 43 ff dc 	bgu r2,r3,19a4 <strtol+0xf4>
				nptr++;
    1a38:	34 21 00 02 	addi r1,r1,2
				base = 16;
    1a3c:	34 05 00 10 	mvi r5,16
    1a40:	e3 ff ff a9 	bi 18e4 <strtol+0x34>

00001a44 <skip_atoi>:

int skip_atoi(const char **s)
{
	int i=0;

	while (isdigit(**s))
    1a44:	28 24 00 00 	lw r4,(r1+0)
{
    1a48:	b8 20 30 00 	mv r6,r1
	while (isdigit(**s))
    1a4c:	34 02 00 09 	mvi r2,9
	return (c >= '0') && (c <= '9');
    1a50:	40 81 00 00 	lbu r1,(r4+0)
    1a54:	34 21 ff d0 	addi r1,r1,-48
    1a58:	20 21 00 ff 	andi r1,r1,0xff
    1a5c:	54 22 00 0f 	bgu r1,r2,1a98 <skip_atoi+0x54>
    1a60:	34 84 00 01 	addi r4,r4,1
	int i=0;
    1a64:	34 01 00 00 	mvi r1,0
	while (isdigit(**s))
    1a68:	34 07 00 09 	mvi r7,9
		i = i*10 + *((*s)++) - '0';
    1a6c:	58 c4 00 00 	sw (r6+0),r4
    1a70:	40 83 00 00 	lbu r3,(r4+0)
    1a74:	08 22 00 0a 	muli r2,r1,10
    1a78:	10 85 ff ff 	lb r5,(r4+-1)
    1a7c:	34 63 ff d0 	addi r3,r3,-48
	while (isdigit(**s))
    1a80:	20 63 00 ff 	andi r3,r3,0xff
		i = i*10 + *((*s)++) - '0';
    1a84:	b4 45 10 00 	add r2,r2,r5
    1a88:	34 41 ff d0 	addi r1,r2,-48
    1a8c:	34 84 00 01 	addi r4,r4,1
	while (isdigit(**s))
    1a90:	50 e3 ff f7 	bgeu r7,r3,1a6c <skip_atoi+0x28>
	return i;
}
    1a94:	c3 a0 00 00 	ret
	int i=0;
    1a98:	34 01 00 00 	mvi r1,0
}
    1a9c:	c3 a0 00 00 	ret

00001aa0 <number>:

char *number(char *buf, char *end, unsigned long num, int base, int size, int precision, int type)
{
    1aa0:	37 9c ff 98 	addi sp,sp,-104
    1aa4:	5b 8b 00 24 	sw (sp+36),r11
    1aa8:	5b 8c 00 20 	sw (sp+32),r12
    1aac:	5b 8d 00 1c 	sw (sp+28),r13
    1ab0:	5b 8e 00 18 	sw (sp+24),r14
    1ab4:	5b 8f 00 14 	sw (sp+20),r15
    1ab8:	5b 90 00 10 	sw (sp+16),r16
    1abc:	5b 91 00 0c 	sw (sp+12),r17
    1ac0:	5b 92 00 08 	sw (sp+8),r18
    1ac4:	5b 93 00 04 	sw (sp+4),r19
    1ac8:	b8 20 40 00 	mv r8,r1
	const char *digits;
	static const char small_digits[] = "0123456789abcdefghijklmnopqrstuvwxyz";
	static const char large_digits[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	int i;

	digits = (type & PRINTF_LARGE) ? large_digits : small_digits;
    1acc:	78 01 00 00 	mvhi r1,0x0
    1ad0:	38 21 23 f0 	ori r1,r1,0x23f0
    1ad4:	20 e9 00 40 	andi r9,r7,0x40
    1ad8:	28 2c 00 00 	lw r12,(r1+0)
    1adc:	5d 20 00 04 	bne r9,r0,1aec <number+0x4c>
    1ae0:	78 01 00 00 	mvhi r1,0x0
    1ae4:	38 21 23 f4 	ori r1,r1,0x23f4
    1ae8:	28 2c 00 00 	lw r12,(r1+0)
	if (type & PRINTF_LEFT)
    1aec:	20 f0 00 10 	andi r16,r7,0x10
    1af0:	34 89 ff fe 	addi r9,r4,-2
		type &= ~PRINTF_ZEROPAD;
	if (base < 2 || base > 36)
    1af4:	34 0a 00 22 	mvi r10,34
	if (type & PRINTF_LEFT)
    1af8:	46 00 00 82 	be r16,r0,1d00 <number+0x260>
		type &= ~PRINTF_ZEROPAD;
    1afc:	34 01 ff fe 	mvi r1,-2
    1b00:	a0 e1 38 00 	and r7,r7,r1
		return NULL;
    1b04:	34 01 00 00 	mvi r1,0
	if (base < 2 || base > 36)
    1b08:	55 2a 00 43 	bgu r9,r10,1c14 <number+0x174>
    1b0c:	ba 00 90 00 	mv r18,r16
	c = (type & PRINTF_ZEROPAD) ? '0' : ' ';
    1b10:	34 0f 00 20 	mvi r15,32
	sign = 0;
	if (type & PRINTF_SIGN) {
    1b14:	20 e1 00 02 	andi r1,r7,0x2
    1b18:	20 f1 00 20 	andi r17,r7,0x20
    1b1c:	44 20 00 81 	be r1,r0,1d20 <number+0x280>
		if ((signed long) num < 0) {
    1b20:	4c 60 00 48 	bge r3,r0,1c40 <number+0x1a0>
			sign = '-';
			num = - (signed long) num;
    1b24:	c8 03 18 00 	sub r3,r0,r3
			size--;
    1b28:	34 a5 ff ff 	addi r5,r5,-1
			sign = '-';
    1b2c:	34 13 00 2d 	mvi r19,45
		} else if (type & PRINTF_SPACE) {
			sign = ' ';
			size--;
		}
	}
	if (type & PRINTF_SPECIAL) {
    1b30:	5e 20 00 4c 	bne r17,r0,1c60 <number+0x1c0>
			sign = '-';
    1b34:	34 0d 00 00 	mvi r13,0
    1b38:	37 87 00 28 	addi r7,sp,40
	}
	i = 0;
	if (num == 0)
		tmp[i++]='0';
	else while (num != 0) {
		tmp[i++] = digits[num % base];
    1b3c:	c4 64 08 00 	modu r1,r3,r4
    1b40:	35 a9 00 01 	addi r9,r13,1
    1b44:	b5 81 08 00 	add r1,r12,r1
    1b48:	40 2a 00 00 	lbu r10,(r1+0)
    1b4c:	b4 e9 08 00 	add r1,r7,r9
		num = num / base;
    1b50:	8c 64 58 00 	divu r11,r3,r4
		tmp[i++] = digits[num % base];
    1b54:	30 2a ff ff 	sb (r1+-1),r10
    1b58:	b9 20 70 00 	mv r14,r9
	else while (num != 0) {
    1b5c:	50 64 00 82 	bgeu r3,r4,1d64 <number+0x2c4>
    1b60:	e0 00 00 4b 	bi 1c8c <number+0x1ec>
			++buf;
		}
	}
	if (!(type & PRINTF_LEFT)) {
		while (size-- > 0) {
			if (buf < end)
    1b64:	50 62 00 02 	bgeu r3,r2,1b6c <number+0xcc>
				*buf = c;
    1b68:	30 6f 00 00 	sb (r3+0),r15
			++buf;
    1b6c:	34 63 00 01 	addi r3,r3,1
		while (size-- > 0) {
    1b70:	c8 23 28 00 	sub r5,r1,r3
    1b74:	48 a0 ff fc 	bg r5,r0,1b64 <number+0xc4>
    1b78:	a5 60 08 00 	not r1,r11
    1b7c:	14 21 00 1f 	sri r1,r1,31
    1b80:	35 65 ff ff 	addi r5,r11,-1
    1b84:	a1 61 58 00 	and r11,r11,r1
    1b88:	c8 ab 28 00 	sub r5,r5,r11
    1b8c:	35 6b 00 01 	addi r11,r11,1
    1b90:	b5 0b 40 00 	add r8,r8,r11
    1b94:	34 ab ff ff 	addi r11,r5,-1
    1b98:	c9 4e 08 00 	sub r1,r10,r14
    1b9c:	b5 01 08 00 	add r1,r8,r1
		}
	}
	while (i < precision--) {
		if (buf < end)
			*buf = '0';
    1ba0:	34 03 00 30 	mvi r3,48
	while (i < precision--) {
    1ba4:	49 4e 00 68 	bg r10,r14,1d44 <number+0x2a4>
    1ba8:	b9 00 08 00 	mv r1,r8
    1bac:	b4 ed 20 00 	add r4,r7,r13
    1bb0:	b8 20 18 00 	mv r3,r1
		++buf;
	}
	while (i-- > 0) {
    1bb4:	b4 29 38 00 	add r7,r1,r9
		if (buf < end)
    1bb8:	50 62 00 03 	bgeu r3,r2,1bc4 <number+0x124>
			*buf = tmp[i];
    1bbc:	40 86 00 00 	lbu r6,(r4+0)
    1bc0:	30 66 00 00 	sb (r3+0),r6
		++buf;
    1bc4:	34 63 00 01 	addi r3,r3,1
	while (i-- > 0) {
    1bc8:	c8 e3 30 00 	sub r6,r7,r3
    1bcc:	34 84 ff ff 	addi r4,r4,-1
    1bd0:	48 c0 ff fa 	bg r6,r0,1bb8 <number+0x118>
    1bd4:	b4 29 08 00 	add r1,r1,r9
	}
	while (size-- > 0) {
    1bd8:	4c 05 00 0f 	bge r0,r5,1c14 <number+0x174>
    1bdc:	35 64 00 01 	addi r4,r11,1
		++buf;
    1be0:	b8 20 18 00 	mv r3,r1
		if (buf < end)
			*buf = ' ';
    1be4:	34 06 00 20 	mvi r6,32
	while (size-- > 0) {
    1be8:	b4 24 20 00 	add r4,r1,r4
		if (buf < end)
    1bec:	50 62 00 02 	bgeu r3,r2,1bf4 <number+0x154>
			*buf = ' ';
    1bf0:	30 66 00 00 	sb (r3+0),r6
		++buf;
    1bf4:	34 63 00 01 	addi r3,r3,1
	while (size-- > 0) {
    1bf8:	c8 83 28 00 	sub r5,r4,r3
    1bfc:	48 a0 ff fc 	bg r5,r0,1bec <number+0x14c>
    1c00:	a5 60 10 00 	not r2,r11
    1c04:	14 42 00 1f 	sri r2,r2,31
    1c08:	a1 62 10 00 	and r2,r11,r2
    1c0c:	34 42 00 01 	addi r2,r2,1
    1c10:	b4 22 08 00 	add r1,r1,r2
	}
	return buf;
}
    1c14:	2b 8b 00 24 	lw r11,(sp+36)
    1c18:	2b 8c 00 20 	lw r12,(sp+32)
    1c1c:	2b 8d 00 1c 	lw r13,(sp+28)
    1c20:	2b 8e 00 18 	lw r14,(sp+24)
    1c24:	2b 8f 00 14 	lw r15,(sp+20)
    1c28:	2b 90 00 10 	lw r16,(sp+16)
    1c2c:	2b 91 00 0c 	lw r17,(sp+12)
    1c30:	2b 92 00 08 	lw r18,(sp+8)
    1c34:	2b 93 00 04 	lw r19,(sp+4)
    1c38:	37 9c 00 68 	addi sp,sp,104
    1c3c:	c3 a0 00 00 	ret
		} else if (type & PRINTF_PLUS) {
    1c40:	20 e1 00 04 	andi r1,r7,0x4
    1c44:	5c 20 00 4b 	bne r1,r0,1d70 <number+0x2d0>
		} else if (type & PRINTF_SPACE) {
    1c48:	20 e7 00 08 	andi r7,r7,0x8
	sign = 0;
    1c4c:	34 13 00 00 	mvi r19,0
		} else if (type & PRINTF_SPACE) {
    1c50:	44 e0 00 03 	be r7,r0,1c5c <number+0x1bc>
			size--;
    1c54:	34 a5 ff ff 	addi r5,r5,-1
			sign = ' ';
    1c58:	34 13 00 20 	mvi r19,32
	if (type & PRINTF_SPECIAL) {
    1c5c:	46 20 00 05 	be r17,r0,1c70 <number+0x1d0>
		if (base == 16)
    1c60:	34 01 00 10 	mvi r1,16
    1c64:	44 81 00 54 	be r4,r1,1db4 <number+0x314>
			size--;
    1c68:	64 81 00 08 	cmpei r1,r4,8
    1c6c:	c8 a1 28 00 	sub r5,r5,r1
	if (num == 0)
    1c70:	5c 60 ff b1 	bne r3,r0,1b34 <number+0x94>
		tmp[i++]='0';
    1c74:	34 01 00 30 	mvi r1,48
    1c78:	33 81 00 28 	sb (sp+40),r1
    1c7c:	34 0d 00 00 	mvi r13,0
    1c80:	34 0e 00 01 	mvi r14,1
    1c84:	34 09 00 01 	mvi r9,1
    1c88:	37 87 00 28 	addi r7,sp,40
	if (i > precision)
    1c8c:	b9 c0 50 00 	mv r10,r14
    1c90:	4d c6 00 02 	bge r14,r6,1c98 <number+0x1f8>
    1c94:	b8 c0 50 00 	mv r10,r6
	size -= precision;
    1c98:	c8 aa 28 00 	sub r5,r5,r10
	if (!(type&(PRINTF_ZEROPAD+PRINTF_LEFT))) {
    1c9c:	34 ab ff ff 	addi r11,r5,-1
    1ca0:	5e 40 00 07 	bne r18,r0,1cbc <number+0x21c>
    1ca4:	b5 05 08 00 	add r1,r8,r5
				*buf = ' ';
    1ca8:	34 03 00 20 	mvi r3,32
		while(size-->0) {
    1cac:	48 a0 00 1f 	bg r5,r0,1d28 <number+0x288>
    1cb0:	34 a1 ff fe 	addi r1,r5,-2
    1cb4:	b9 60 28 00 	mv r5,r11
    1cb8:	b8 20 58 00 	mv r11,r1
	if (sign) {
    1cbc:	46 60 00 04 	be r19,r0,1ccc <number+0x22c>
		if (buf < end)
    1cc0:	51 02 00 02 	bgeu r8,r2,1cc8 <number+0x228>
			*buf = sign;
    1cc4:	31 13 00 00 	sb (r8+0),r19
		++buf;
    1cc8:	35 08 00 01 	addi r8,r8,1
	if (type & PRINTF_SPECIAL) {
    1ccc:	46 20 00 05 	be r17,r0,1ce0 <number+0x240>
		if (base==8) {
    1cd0:	34 01 00 08 	mvi r1,8
    1cd4:	44 81 00 33 	be r4,r1,1da0 <number+0x300>
		} else if (base==16) {
    1cd8:	34 01 00 10 	mvi r1,16
    1cdc:	44 81 00 28 	be r4,r1,1d7c <number+0x2dc>
	if (!(type & PRINTF_LEFT)) {
    1ce0:	5e 00 ff ae 	bne r16,r0,1b98 <number+0xf8>
    1ce4:	35 64 00 01 	addi r4,r11,1
		while (size-- > 0) {
    1ce8:	b9 00 18 00 	mv r3,r8
    1cec:	b5 04 08 00 	add r1,r8,r4
    1cf0:	48 a0 ff 9d 	bg r5,r0,1b64 <number+0xc4>
    1cf4:	b9 60 28 00 	mv r5,r11
    1cf8:	35 6b ff ff 	addi r11,r11,-1
    1cfc:	e3 ff ff a7 	bi 1b98 <number+0xf8>
		return NULL;
    1d00:	34 01 00 00 	mvi r1,0
	if (base < 2 || base > 36)
    1d04:	55 2a ff c4 	bgu r9,r10,1c14 <number+0x174>
	c = (type & PRINTF_ZEROPAD) ? '0' : ' ';
    1d08:	20 e1 00 01 	andi r1,r7,0x1
    1d0c:	20 f2 00 11 	andi r18,r7,0x11
    1d10:	34 0f 00 30 	mvi r15,48
    1d14:	5c 20 ff 80 	bne r1,r0,1b14 <number+0x74>
    1d18:	34 0f 00 20 	mvi r15,32
    1d1c:	e3 ff ff 7e 	bi 1b14 <number+0x74>
	sign = 0;
    1d20:	34 13 00 00 	mvi r19,0
    1d24:	e3 ff ff ce 	bi 1c5c <number+0x1bc>
			if (buf < end)
    1d28:	51 02 00 02 	bgeu r8,r2,1d30 <number+0x290>
				*buf = ' ';
    1d2c:	31 03 00 00 	sb (r8+0),r3
			++buf;
    1d30:	35 08 00 01 	addi r8,r8,1
		while(size-->0) {
    1d34:	5d 01 ff fd 	bne r8,r1,1d28 <number+0x288>
    1d38:	34 0b ff fe 	mvi r11,-2
    1d3c:	34 05 ff ff 	mvi r5,-1
    1d40:	e3 ff ff df 	bi 1cbc <number+0x21c>
		if (buf < end)
    1d44:	51 02 00 02 	bgeu r8,r2,1d4c <number+0x2ac>
			*buf = '0';
    1d48:	31 03 00 00 	sb (r8+0),r3
		++buf;
    1d4c:	35 08 00 01 	addi r8,r8,1
	while (i < precision--) {
    1d50:	5d 01 ff fd 	bne r8,r1,1d44 <number+0x2a4>
    1d54:	b4 ed 20 00 	add r4,r7,r13
    1d58:	b8 20 18 00 	mv r3,r1
	while (i-- > 0) {
    1d5c:	b4 29 38 00 	add r7,r1,r9
    1d60:	e3 ff ff 96 	bi 1bb8 <number+0x118>
		tmp[i++] = digits[num % base];
    1d64:	b9 20 68 00 	mv r13,r9
		num = num / base;
    1d68:	b9 60 18 00 	mv r3,r11
    1d6c:	e3 ff ff 74 	bi 1b3c <number+0x9c>
			size--;
    1d70:	34 a5 ff ff 	addi r5,r5,-1
			sign = '+';
    1d74:	34 13 00 2b 	mvi r19,43
    1d78:	e3 ff ff b9 	bi 1c5c <number+0x1bc>
			if (buf < end)
    1d7c:	51 02 00 03 	bgeu r8,r2,1d88 <number+0x2e8>
				*buf = '0';
    1d80:	34 01 00 30 	mvi r1,48
    1d84:	31 01 00 00 	sb (r8+0),r1
			++buf;
    1d88:	35 01 00 01 	addi r1,r8,1
			if (buf < end)
    1d8c:	50 22 00 03 	bgeu r1,r2,1d98 <number+0x2f8>
				*buf = digits[33];
    1d90:	11 81 00 21 	lb r1,(r12+33)
    1d94:	31 01 00 01 	sb (r8+1),r1
			++buf;
    1d98:	35 08 00 02 	addi r8,r8,2
    1d9c:	e3 ff ff d1 	bi 1ce0 <number+0x240>
			if (buf < end)
    1da0:	51 02 00 03 	bgeu r8,r2,1dac <number+0x30c>
				*buf = '0';
    1da4:	34 01 00 30 	mvi r1,48
    1da8:	31 01 00 00 	sb (r8+0),r1
			++buf;
    1dac:	35 08 00 01 	addi r8,r8,1
    1db0:	e3 ff ff cc 	bi 1ce0 <number+0x240>
			size -= 2;
    1db4:	34 a5 ff fe 	addi r5,r5,-2
    1db8:	e3 ff ff ae 	bi 1c70 <number+0x1d0>

00001dbc <vscnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * You probably want scnprintf() instead.
 */
int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
{
    1dbc:	37 9c ff f8 	addi sp,sp,-8
    1dc0:	5b 8b 00 08 	sw (sp+8),r11
    1dc4:	5b 9d 00 04 	sw (sp+4),ra
    1dc8:	b8 40 58 00 	mv r11,r2
	int i;

	i=vsnprintf(buf,size,fmt,args);
    1dcc:	fb ff f8 f4 	calli 19c <vsnprintf>
	return (i >= size) ? (size - 1) : i;
    1dd0:	49 61 00 02 	bg r11,r1,1dd8 <vscnprintf+0x1c>
    1dd4:	35 61 ff ff 	addi r1,r11,-1
}
    1dd8:	2b 9d 00 04 	lw ra,(sp+4)
    1ddc:	2b 8b 00 08 	lw r11,(sp+8)
    1de0:	37 9c 00 08 	addi sp,sp,8
    1de4:	c3 a0 00 00 	ret

00001de8 <snprintf>:
 * generated for the given input, excluding the trailing null,
 * as per ISO C99.  If the return is greater than or equal to
 * @size, the resulting string is truncated.
 */
int snprintf(char * buf, size_t size, const char *fmt, ...)
{
    1de8:	37 9c ff e4 	addi sp,sp,-28
    1dec:	5b 9d 00 04 	sw (sp+4),ra
    1df0:	5b 84 00 0c 	sw (sp+12),r4
	va_list args;
	int i;

	va_start(args, fmt);
	i=vsnprintf(buf,size,fmt,args);
    1df4:	37 84 00 0c 	addi r4,sp,12
{
    1df8:	5b 83 00 08 	sw (sp+8),r3
    1dfc:	5b 85 00 10 	sw (sp+16),r5
    1e00:	5b 86 00 14 	sw (sp+20),r6
    1e04:	5b 87 00 18 	sw (sp+24),r7
    1e08:	5b 88 00 1c 	sw (sp+28),r8
	i=vsnprintf(buf,size,fmt,args);
    1e0c:	fb ff f8 e4 	calli 19c <vsnprintf>
	va_end(args);
	return i;
}
    1e10:	2b 9d 00 04 	lw ra,(sp+4)
    1e14:	37 9c 00 1c 	addi sp,sp,28
    1e18:	c3 a0 00 00 	ret

00001e1c <scnprintf>:
 * The return value is the number of characters written into @buf not including
 * the trailing '\0'. If @size is <= 0 the function returns 0.
 */

int scnprintf(char * buf, size_t size, const char *fmt, ...)
{
    1e1c:	37 9c ff e0 	addi sp,sp,-32
    1e20:	5b 8b 00 08 	sw (sp+8),r11
    1e24:	5b 9d 00 04 	sw (sp+4),ra
    1e28:	5b 84 00 10 	sw (sp+16),r4
	va_list args;
	int i;

	va_start(args, fmt);
	i = vsnprintf(buf, size, fmt, args);
    1e2c:	37 84 00 10 	addi r4,sp,16
{
    1e30:	b8 40 58 00 	mv r11,r2
    1e34:	5b 83 00 0c 	sw (sp+12),r3
    1e38:	5b 85 00 14 	sw (sp+20),r5
    1e3c:	5b 86 00 18 	sw (sp+24),r6
    1e40:	5b 87 00 1c 	sw (sp+28),r7
    1e44:	5b 88 00 20 	sw (sp+32),r8
	i = vsnprintf(buf, size, fmt, args);
    1e48:	fb ff f8 d5 	calli 19c <vsnprintf>
	va_end(args);
	return (i >= size) ? (size - 1) : i;
    1e4c:	49 61 00 02 	bg r11,r1,1e54 <scnprintf+0x38>
    1e50:	35 61 ff ff 	addi r1,r11,-1
}
    1e54:	2b 9d 00 04 	lw ra,(sp+4)
    1e58:	2b 8b 00 08 	lw r11,(sp+8)
    1e5c:	37 9c 00 20 	addi sp,sp,32
    1e60:	c3 a0 00 00 	ret

00001e64 <vsprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * You probably want sprintf() instead.
 */
int vsprintf(char *buf, const char *fmt, va_list args)
{
    1e64:	37 9c ff fc 	addi sp,sp,-4
    1e68:	5b 9d 00 04 	sw (sp+4),ra
	return vsnprintf(buf, INT_MAX, fmt, args);
    1e6c:	b8 60 20 00 	mv r4,r3
    1e70:	b8 40 18 00 	mv r3,r2
    1e74:	38 02 ff ff 	mvu r2,0xffff
    1e78:	78 42 7f ff 	orhi r2,r2,0x7fff
    1e7c:	fb ff f8 c8 	calli 19c <vsnprintf>
}
    1e80:	2b 9d 00 04 	lw ra,(sp+4)
    1e84:	37 9c 00 04 	addi sp,sp,4
    1e88:	c3 a0 00 00 	ret

00001e8c <sprintf>:
 * The function returns the number of characters written
 * into @buf. Use snprintf() or scnprintf() in order to avoid
 * buffer overflows.
 */
int sprintf(char * buf, const char *fmt, ...)
{
    1e8c:	37 9c ff e0 	addi sp,sp,-32
    1e90:	5b 9d 00 04 	sw (sp+4),ra
    1e94:	5b 82 00 08 	sw (sp+8),r2
    1e98:	5b 83 00 0c 	sw (sp+12),r3
    1e9c:	5b 84 00 10 	sw (sp+16),r4
	va_list args;
	int i;

	va_start(args, fmt);
	i=vsnprintf(buf, INT_MAX, fmt, args);
    1ea0:	b8 40 18 00 	mv r3,r2
    1ea4:	37 84 00 0c 	addi r4,sp,12
    1ea8:	38 02 ff ff 	mvu r2,0xffff
    1eac:	78 42 7f ff 	orhi r2,r2,0x7fff
{
    1eb0:	5b 85 00 14 	sw (sp+20),r5
    1eb4:	5b 86 00 18 	sw (sp+24),r6
    1eb8:	5b 87 00 1c 	sw (sp+28),r7
    1ebc:	5b 88 00 20 	sw (sp+32),r8
	i=vsnprintf(buf, INT_MAX, fmt, args);
    1ec0:	fb ff f8 b7 	calli 19c <vsnprintf>
	va_end(args);
	return i;
}
    1ec4:	2b 9d 00 04 	lw ra,(sp+4)
    1ec8:	37 9c 00 20 	addi sp,sp,32
    1ecc:	c3 a0 00 00 	ret

00001ed0 <rand>:
 */

static unsigned int seed;
unsigned int rand(void)
{
	seed = 129 * seed + 907633385;
    1ed0:	78 01 00 00 	mvhi r1,0x0
    1ed4:	38 21 23 f8 	ori r1,r1,0x23f8
    1ed8:	28 22 00 00 	lw r2,(r1+0)
    1edc:	28 43 00 00 	lw r3,(r2+0)
    1ee0:	3c 61 00 07 	sli r1,r3,7
    1ee4:	b4 23 08 00 	add r1,r1,r3
    1ee8:	38 03 62 e9 	mvu r3,0x62e9
    1eec:	78 63 36 19 	orhi r3,r3,0x3619
    1ef0:	b4 23 08 00 	add r1,r1,r3
    1ef4:	58 41 00 00 	sw (r2+0),r1
	return seed;
}
    1ef8:	c3 a0 00 00 	ret

00001efc <abort>:

void abort(void)
{
    1efc:	37 9c ff fc 	addi sp,sp,-4
    1f00:	5b 9d 00 04 	sw (sp+4),ra
	printf("Aborted.");
    1f04:	78 02 00 00 	mvhi r2,0x0
    1f08:	38 42 23 fc 	ori r2,r2,0x23fc
    1f0c:	28 41 00 00 	lw r1,(r2+0)
    1f10:	fb ff fb f1 	calli ed4 <printf>
	while(1);
    1f14:	e0 00 00 00 	bi 1f14 <abort+0x18>
