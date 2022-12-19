.data
CLIErrorMsg: .asciz  "Error: expected zero CLI args or one CLI arg cointaining a 1."
testStrokes: .asciz "ddssasddssasddsaasddzzzzzeessssssssssdddddwwwwddssssddddwwwwwwwwwcccqqqqqqqqqzx"
numStrokes: .word 79
testStartX: .word 3
testStartY: .word 5

.text
parseCLIArgs:
	###############################################################
	# Parse CLI args, or if none given, ask user.
	# 	
	# Inputs:
	# 	This must be run first in the program.  Inputs are specified by CLI.
	# Outputs:
	#	a0 -- hot only if test case is to be run
	#	a1 -- starting x coord
	#	a2 -- starting y coord
	#	a3 -- address of first test keystroke
	#       a4 -- number of test keystrokes
	################################################################ 
	addi sp sp -4
	sw ra 0(sp)
	
	li t0 1
	beqz a0 return
	beq a0 t0 loadTest  # assert only one CLI arg passed
raiseCLIError:
	li a7, 4
	la a0, CLIErrorMsg
	ecall
	
	# exit with error flag
	li a0 -1
	li a7 93
	ecall
loadTest:
	# assert the arg fed in is 1
	#lw t1 (a1)
	#lw t1 (t1)
	#li t2 48
	#bne t1 t2 raiseCLIError
	
	# load above test data
	li a0 1
	lw a1 testStartX
	lw a2 testStartY
	la a3 testStrokes
	lw a4 numStrokes
return:
	ret