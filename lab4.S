.global lab4
.syntax unified

#define X1 #12
#define X2 #2
#define X3 #-10
#define X4 #15

lab4:
	push {lr}
	bl task1
	bl task2
	pop {pc}

task1:
	push {lr}
	mov r0, X1
	mov r1, #0

	mov r2, X2
	mov r3, #0

	mov r4, X3
	mov r5, #0xFFFFFFFF

	mov r6, X4
	mov r7, #0

	// Calculation
	add r4, #1
	adc r5, #0

	sub r4, r6
	sbc r5, r7
	
	lsr r4, #1
	asr r5, #1
	lsr r4, #1
	asr r5, #1

	lsr r0, #1
	asr r1, #1
	
	add r0, r2
	adc r1, r3

	orr r0, r4
	orr r1, r5
	
	bl check_result
	pop {pc}
	


// Result correction
check_result:
	push {lr}
	bvc step2
	lsr r0, #1
	lsr r1, #1
step2:
	orr r0, #0	// Update flag reg
	bne step4
	orr r1, #0	// Update flag reg
	bne step4
	mov r0, #0b00100101
step4:
	add r1, #0b00100101
	and r5, r1, #0xc0000000
	beq step7
	eor r5, #0xc0000000
	beq step7
	lsr r0, #1
	lsr r1, #1
step7:
	bvs end_check_result
	push {r0}
	push {r1}
	pop {r1}
	pop {r0}

end_check_result:
	pop {pc}

task2:
	push {lr}

	// Init regs
	mov r0, #2
	mov r1, #3
	mov r2, #4

prog_a:
	add r0, r1
	add r0, r2
	bl prog_b
l3:
	lsl r0, #1
	

	bcc l1
	lsr r0, #1
	b l2
l1:
	add r0, #1
	sub r1, #2
l2:
	bvc l3
	orr r0, r1
	pop {pc}

prog_b:
	push {lr}
l5:
	sub r2, #1
	bne l4
	bl prog_c
	add r1, r2
l4:
	bcc l5

	add r0, r1
	and r1, r2
	pop {pc}

prog_c:
	push {lr}
	mov r0, #5
	mov r2, #255
	pop {pc}

