.global lab4
.syntax unified

#define X1 #12
#define X2 #2
#define X3 #-10
#define X4 #15

lab4:
	push {lr}
	mov r0, X1
	mov r1, X2
	mov r2, X3
	mov r3, X4
	mov r4, #0x00

	add r2, #1
	sub r2, r3
	asr r2, #2
	
	asr r0, #1
	add r0, r1

	orr r0, r2
	bl check_result

	bl lab4_2
	pop {pc}

// Result correction
check_result:
	push {lr}
	bvc step2
	asr r0, #1
step2:
	bne step4
	mov r4, #8229
step4:
	add r0, r4
	and r5, r0, #0xc0000000
	beq step7
	eor r5, #0xc0000000
	beq step7
	lsr r0, #1
step7:
	bvs end_check_result
	push {r0}
	pop {r0}

end_check_result:
	pop {pc}

lab4_2:
	push {lr}
	mov r0, X1
	mov r1, X2
	mov r2, X3

	add r0, r1
	adc r0, r2
l3:
	lsl r0, #1
	

	bcc l1
	lsr r0, #1
	b l2
l1:
	add r0, #1
	lsl r0, #1
l2:
	bne l3
	sub r1, r2
l5:
	lsr r0, r1
	bne l4
	add r1, r2
l4:
	bcc l5

	add r0, r1
	sub r1, #1
	add r2, #10
	add r1, r2

	pop {pc}

