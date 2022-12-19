.data
displayBaseAddress: .word 0x10008000
passStr: .asciz "\npass\n"
failStr: .asciz "\nFAIL\n"
expectedStr: .asciz "\tExpected: "
gotStr: "\tGot: "
newLine: "\n"

.macro printInt(%reg)
	li a7 1
	mv a0 %reg
	ecall
	
	# print new line
	li a7 11
	li a0 10
	ecall
.end_macro

.macro printStr(%string)
	.data
	macroStr: .asciz %string
	.text
	li a7 4
	la a0 macroStr
	ecall
.end_macro

.text
main:
test1:
	printStr "Test 1"
	li a0 0
	li a1 0
	lw a2 displayBaseAddress
	jal runTest

test2:
	printStr "Test 2"
	li a0 5
	li a1 0
	li a2 0x10008014
	jal runTest
	
test3:
	printStr "Test 3"
	li a0 0
	li a1 5
	li a2 0x10008280
	jal runTest
	
test4:
	printStr "Test 4"
	li a0 25
	li a1 30
	li a2 0x10008f64
	jal runTest
j exit

.include "lab4_part1.asm"	

runTest:
	# a0: x
	# a1: y
	# a2: expected
	addi sp, sp, -8
	sw a2, 0(sp)
	sw ra, 4(sp)
	lw a2 displayBaseAddress
	jal xyCoordinatesToAddress
parseResults:
	mv t0 a0
	
	lw t1, 0(sp)
	lw ra, 4(sp)
	addi sp, sp, 8
	
	bne a0 t1 fail
pass:
	li a7 4
	la a0 passStr
	ecall
	
	j endOfRunTest	
fail:
	li a7 4
	la a0 failStr
	ecall
	
	j endOfRunTest
endOfRunTest:
	li a7 4
	la a0 expectedStr
	ecall
	printInt(t1)
	
	li a7 4
	la a0 gotStr
	ecall
	printInt(t0)
	# print new line
	ret
exit:
	li a7 10
	ecall
