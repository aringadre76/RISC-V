##########################################################################
# Created by: Gadre, Arin
#		aagadre
#       		29 May 2022
#
# Assignment: Lab 4: Paint Application
#			CSE 12, Computer Systems and Assembly Language
#			UC Santa Cruz, Spring 2022

# Description: In this lab, the user enters coordinates accoring to the prompt.  
# The user then enters a letter on a keyboard. A pixel on a bitmap display is drawn according to the letter.

# Notes: This program is intended to be run from the RARS IDE.
##########################################################################

.text
#Note that this file only contains a function xyCoordinatesToAddress
#As such, this function should work independent of any caller funmction which calls it
#When using regisetrs, you HAVE to make sure they follow the register usage convention in RISC-V as discussed in lectures.
#Else, your function can potentially fail when used by the autograder and in such a context, you will receive a 0 score for this part

xyCoordinatesToAddress:
	#(x,y) in (a0,a1) arguments
	#a2 argument contains base address
	#returns pixel address in a0
	#li a0, 0 # x
	#li a1, 0 # y
	#li a2, 0x10008000 # base address

	

	#make sure to return to calling function after putting correct value in a0!
	#Enter code below!DO NOT MODIFY ANYTHING BEFORE THIS COMMENT LINE!
	addi	s2, a0, 0 # new x
	addi     s3, a1, 0 # new y
	addi     s4, a2, 0 # new base address
	addi     s5, a2, 0 # base addresss to be changed
	li 	t3, 0 # temp sum for x
	li	t4, 0 # temp sum for y
	li 	s6, 0 # sum to be added to base address 

	bnez 	s2, mathx #  if a0 != 0, branch to mathx
	
 	second:
      		bnez 	s3, mathy  #  if a1 != 0, branch to mathy
	
	j final
	
	mathx:
		slli t3, s2, 2 # same as t3  = s2 * 4	
		j second
		
	mathy:
		slli t4, s3, 7 # same as t4 = s3 * 128
		
 	final:
 		add 	s6, t3, t4 # s6 = t3 + t4
 		add	s5, s5, s6 # s5 = s5 + s6
		mv 	a0, s5 
		ret
