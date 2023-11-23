# Exception Handler Framework for COSC211 Assignment 7

	.kdata

save0:	.word 0

	.ktext 0x80000180

	.set noat		#otherwise, we cannot touch $at  
	sw $at, save0
	
	#use $k0 and $k1 to hold the Cause and EPC

	# use a mask to determine what the cause of was for the exception

	#and the branch to the correct part of code to handle the exception

breakn:

overflow:

bAddr:	


done:	

	mfc0 $k0, $14
	addiu $k0, $k0, 4  	# if this is an exception, we add 4 to EPC

	#update the EPC and clear the Cause registers.  You may need to do something to Status as well
	

	lw $at, save0	  	# restore $at 
	eret	              	# return to EPC	


	# startup rountine
	.text
	.globl __start

__start:
	
	jal main
	li $v0, 10
	syscall


