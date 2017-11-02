	AREA Lab_08_Larry_Carranco, CODE, READONLY
	EXPORT __main
	
	; “Write an ARM assembly language program that counts the number of 1’s for any value in R0. The
	; program must assemble/compile in KEIL and must be able to run in the KEIL simulator. Generally, R0 may
	; contain any value, but for purpose of this exercise, you may move 0x2345ABCD into R0. The number in
	; R0 does not need be preserved. You may use any other registers as you need. The result, total count of
	; 1’s in R0, should be in R1 when the program ends. “

	
	
__main

	ldr r0, =0x2345ABCD	; This is how you assign large value to r0. mov will not work
						; due to the immediate (imm16) only having a range from 
						; 0 - 65,535. 0x2345ABCD is 591,768,525 in decimal.
	mov r1, #0			; intialize r1 to 0
	mov r2, #0			; intialize r2 to 0
while
	clz r2, r0			; The clz instruction counts the number of leading zeros.
	lsl r0, r0, #1 		; Shift left by one bit
	cmp r2, #0			; If register 2 has no leading zeroes
	beq increment			; then branch to increment
	cmp r2, #32			; If register has any number other than 32 leading zeroes
	bne while				; then loop gain from the top of this loop
	cmp r2, #32			; If register 2 has 32 leading zeroes
	beq stop				; then we branch to stop (We are done!)
	
increment
	add r1, #1 			; Increment by one
	b while
	
stop B stop
	
	END