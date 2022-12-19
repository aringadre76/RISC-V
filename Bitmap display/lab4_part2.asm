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


#in this section of code, you must direct the new position of the pixel based on the label we branched to in lab4.asm

#remember at this point, (x,y) coordinates are in a0,a1 registers respectively
#do the appropriate change in a0 a1 values based on the labels below.

#within each label, make sure to jump to the correct label in  lab4.asm file. 
#This is so that exactly one of the labels moveleft,moveright, movedown, moveup is executed depending on which key user enetered as defined in lab4.asm

#NOTE: To make sure you ONLY use a0,a1 registers in your instructions below. There is no need to involve any other rgeister in this section of code!

moveleft:
	addi a0, a0, -1 # moves left
	j newPosition
	
movedown:
	addi a1, a1, 1  # moves down
	j newPosition
	
moveright:
	addi a0, a0, 1  # moves right
	j newPosition
	
moveup:
	addi a1, a1, -1 # moves up
	j newPosition
	
moveDiagonalLeftUp:
	addi a1, a1, -1 # moves up
	addi a0, a0, -1  # moves left
 	j newPosition
 	
moveDiagonalLeftDown:
	addi a0, a0, -1   # moves left
 	addi a1, a1, 1  # moves down
 	j newPosition
 	
moveDiagonalRightUp:
	addi a1, a1, -1 # moves up
	addi a0, a0, 1 # moves right
	j newPosition
	
moveDiagonalRightDown:
	addi a1, a1, 1  # moves down
	addi a0, a0, 1 # moves right
	j newPosition
