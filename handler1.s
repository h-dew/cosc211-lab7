# Exception Handler Framework for COSC211 Assignment 7
#-----------------------------------------------------------------
#Benjamin Scown
#62071873
#COSC 211
#Computer Science
#Lab 7, Excercise 1
#-----------------------------------------------------------------
	.kdata

save0:	.word 0

	.ktext 0x80000180

	.set noat		#otherwise, we cannot touch $at  
	sw $at, save0
	
	#use $k0 and $k1 to hold the Cause and EPC
	
	mfc0 $k0, $14 # store EPC in $k0
	mfc0 $k1, $13 # store Cause in $k1

	# use a mask to determine what the cause of was for the exception
	andi $k1, $k1, 0x7c
	srl $k1, $k1, 2

	#and the branch to the correct part of code to handle the exception
	li $at, 12 
	beq $at, $k1, overflow
	
	li $at, 5
	beq $at, $k1, bAddr
	
	li $at, 4
	beq $at, $k1, bAddr
	
	j done

overflow:

	# the 2 following instructions are taken from the lab PDF
	li  $k1, 0x0  #this is the nop instruction value  
	sw  $k1, ($k0)  #now write is to the address in $k0 
	j done

bAddr:	

	# the 2 following instructions are taken from the lab PDF
	li  $k1, 0x0  #this is the nop instruction value  
	sw  $k1, ($k0)  #now write is to the address in $k0 

done:	

	mfc0 $k0, $14
	addiu $k0, $k0, 4  	# if this is an exception, we add 4 to EPC

	#update the EPC and clear the Cause registers.  You may need to do something to Status as well
	mtc0 $k0, $14
	mtc0 $zero, $13
	mtc0 $zero, $12

	lw $at, save0	  	# restore $at 
	
	eret	              	# return to EPC	


	# startup rountine
	.text
	.globl __start

__start:
	
	jal main
	li $v0, 10
	syscall


