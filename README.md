# lab08
Simple assembly program that counts the number of 1's in a binary string. This program can be made more efficient. This program has only been tested on Keil uVision5 using the Keil simulator.

## Table of Contents
* [Description of Assignment](#description-of-assignment)
* [Constraints](#constraints)
* [Documentation](#documentation)
	* [Commands](#commands)
* [Algorithm](#algorithm)
* [Steps](#steps)
* [Variables](#variables)
* [Assembly Code](#assembly-code)

## Description of Assignment
Write an ARM assembly language program that counts the number of 1’s for any value in R0. The program must assemble/compile in KEIL and must be able to run in the KEIL simulator. Generally, R0 may contain any value, but for purpose of this exercise, you may move 0x2345ABCD into R0. The number in R0 does not need be preserved. You may use any other registers as you need. The result, total count of 1’s in R0, should be in R1 when the program ends.

## Constraints
We are allowed to use the following 8 instructions:
1. LDR
2. MOV
3. CMP
4. BEQ
5. CLZ
6. ADD
7. LSL
8. BNE

## Documentation
### Commands
* [LDR](http://www.keil.com/support/man/docs/armasm/armasm_dom1361289873425.htm)
* [LSL](http://www.keil.com/support/man/docs/armasm/armasm_dom1361289876185.htm)
* [CLZ](http://www.keil.com/support/man/docs/armasm/armasm_dom1361289868426.htm)
* [MOV](http://www.keil.com/support/man/docs/armasm/armasm_dom1361289878994.htm)
* [CMP](http://www.keil.com/support/man/docs/armasm/armasm_dom1361289868786.htm)
* [Condition Code Suffixes](http://www.keil.com/support/man/docs/armasm/armasm_dom1361289860997.htm)

## Algorithm
* While the number of 0's is not equal to 32
	* Count the number of leading 0's
	* Shift binary string left by 1 bit
	* If binary string contains no leading 0's then increment counter (This means that a 1 is in the most significant bit)
	* If binary string contains 32 leading 0's then we stop (We are done!)

## Steps
* Initialize register 0 the hexidecimal value 0x2345ABCD
* Initialize register 1 to zero
* Initialize register 2 to zero
* loop
	* Count leading 0's of register 0 and place count in register 2
	* Shift binary string of register 0 left by one bit
	* If r2 is zero then increment register 1 (counter) by 1
		* Increment register 1
		* repeat loop
	* If r2 is anything other than 32 then repeat loop
	* If r2 is 32 then we stop

## Variables
* r0 - Stores the test value
* r1 - Counts leading 0's (counter)
* r2 - Stores the number of leading zeroes from r0

## Assembly Code
```
__main

	ldr r0, =0x2345ABCD	; This is how you assign large value to r0. mov will not work
					; due to the immediate (imm16) only having a range from 
					; 0 - 65,535. 0x2345ABCD is 591,768,525 in decimal.
	mov r1, #0		; intialize r1 to 0
	mov r2, #0		; intialize r2 to 0
loop
	clz r2, r0		; The clz instruction counts the number of leading zeros.
	lsl r0, r0, #1 		; Shift left by one bit
	cmp r2, #0		; If register 2 has no leading zeroes
	beq increment			; then branch to increment
	cmp r2, #32		; If register has any number other than 32 leading zeroes
	bne loop			; then loop again from the top of this loop
	cmp r2, #32		; If register 2 has 32 leading zeroes
	beq stop			; then we branch to stop (We are done!)
	
increment
	add r1, #1 		; Increment by one
	b loop				; repeat loop
	
stop B stop
	
	END
```