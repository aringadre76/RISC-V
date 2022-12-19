##########################################################################
# Created by: Gadre, Arin
#		aagadre
#       		16 May 2022
#
# Assignment: Lab 3: Looping in RISC-V Assembly
#			CSE 12, Computer Systems and Assembly Language
#			UC Santa Cruz, Spring 2022

# Description: In this lab, the user enters a number h. Then, a right angle triangle will be printed made of asterisks and dollar signs with height h.
#
# Notes: This program is intended to be run from the RARS IDE.
##########################################################################

#  macros
.macro exit 			#macro to exit program
		li a7, 10
		ecall
		.end_macro	
		
.macro print_str(%string1) 	# macro to print any string
    li a7,4 
    la a0, %string1
    ecall
    .end_macro
    
.macro print_int (%x)  	# macro to print any integer or register
    li a7, 1
    add a0, zero, %x
    ecall
    .end_macro

.data					# storing messages and strings that will be printed fpr the prompts and the trinagle

dollar: .asciz  "$"
asterisk: .asciz  "*"
dol_ask: .asciz  "*$"
intial_prompt: .asciz  "Enter the height of the pattern (must be greater than 0):"
error_message: .asciz  "Invalid Entry!"
newline: .asciz  "\n"  	

.text

#/++++++++++++++++++++++++ ACTUAL CODE +++++++++++++++++++++++++/
main:


	print_str(intial_prompt)    # asks the user for the desried height of the triangle
    	li 	a7 5 				# reads the input
    	ecall					# ecall to save input

    	addi 	t0, a0, 0			# intializing t0 to (a0 + 0)
    	blez 	t0,  error_prompt 		# checking if t0 is less than or equal to zero if so then branches  to the error label 
    	
    	
   	li 	s1, 1				# constant kept at one
    	li 	t1, 1				# counter for the row_loop
    	li 	t2 1				# the number that is to be printed at the end of every row
    	
    	
    	j  triangle_apex		# if t0 is 1 then jumps to triangle_apex that makes the top of the pyramid
    	exit
 
 
error_prompt:		#  If the input is equal to or less than 0 the following prints an error message and branches back to the prompts
     	print_str(error_message) 	# prints  error message
     	print_str(newline)		# prints newline 
     	j main		# jumps to the prompt again


#/++++++++++++++++++ THE CODE BELOW PRINTS THE TRIANGLE +++++++++++++++++++++++/

 triangle_apex: 				# This section prints the first row and then branches to the main loop
     	print_str(dollar)		# prints the dollar sign
     	print_int (s1)		# prints s1 which is set to 1
     	bgt 	t0, s1, outer	# if t0 is greater than s1, branch to outer
     	print_str(newline) 	# prints a new line
     	exit				# exits program if the input is 1


 outer:			# this is the outer loop, which will run (the input  -  1) number of times
         	print_str(newline)	# prints a newline
         	print_str(dollar)		# prints a dollar sign as the first character for  every row of the triangle
         	addi 	t2, t2, 2 		#  increase the t2 by 2 for every row
         	li 	t3, 0			# intialize t3 to be the index for the pattern_loop
            	inner:		#  this inner loop creates the pattern of dollars and asterisks for every row other than the first row
                		print_str(dol_ask) # prints ' *$ '
                		addi 	t3, t3, 1
            		blt 	t3, t1, inner 	# if more characters need to be printed, branch to pattern_loop
            		
            		
	print_int(t2)			# prints t2 at the end of every row
   	addi 	t1, t1, 1		# increase the counter of the outer loop
         	bgt 	t0, t1, outer	# check if more rows need to be printed, if so, branch to row_loop
         	print_str(newline)		# prints a newline
         	exit				# exits program
         	
# /++++++++++++++++++++++++++++++++ END PROGRAM ++++++++++++++++++++++++++++++++/
