 .data
message:     .asciiz "Loading: "
loading:     .asciiz "#"
percent_text:.asciiz " %"
newline:     .asciiz "\n"
endmsg:     .asciiz "\nProgram Exited"

wishtocontinue:     
.asciiz "\n Do you wish to continue ? or exit\n" # to check if i should end the program

check:
.asciiz "\t\t\nPress 1 to continue and 2 to exit\n" # taking userinput

Welcome:    .asciiz "\n\n\n\t\t\t\tWELCOME (͠≖ ͜ʖ͠≖) \n"
   
Projectname:
    .ascii      "\t\t Towers of Hanoi\n"
Studentname: 
   .asciiz     "\t\t Amrah Imtiaz\n"
StudentID:
    .asciiz     "\t\tSTUDENT ID: SP22-BSCS-0082 \n"
Prompt:  
    .asciiz     "\t\t\t\t\nEnter the number of disks: "
Move:
    .asciiz      "\t\t\t\t\nMove disk from "
To:
    .ascii      " to "
.text
.globl main
    .text  
        
main:
  li $t0, 0              # Initialize counter i = 0

load_loop:
    bgt $t0, 10, start  # if (i > 10) break #ya simple for loop hai

   
    li $v0, 4   # Display loading message
    la $a0, message #"loading"
    syscall

  
    move $t1, $t0   # Display loading bar

load_bar_loop:
    beqz $t1, load_bar_end #loop to basically print the # sign number of times 
    li $v0, 4
    la $a0, loading
    syscall
    addi $t1, $t1, -1 #inverse loop chalai hai 
    j load_bar_loop

load_bar_end:

    # Calculate and display percentage by multiplication
    li $t2, 10           # Set max percentage value or the limit
    mul $t3, $t0, 10     # Calculate the percentage (t0 * 10)

    li $v0, 1        # Display percentage value after calculation
    move $a0, $t3
    syscall

    li $v0, 4        # Display percent symbol %
    la $a0, percent_text
    syscall

    # Display newline #move to the next line once the previous loading is printed
    li $v0, 4
    la $a0, newline
    syscall

    #loop to delay
    li $t4, 50000
delay_loop:
    beqz $t4, delay_end
    addi $t4, $t4, -1
    j delay_loop
delay_end:

    # Increment counter
    addi $t0, $t0, 1 #after each percentage line is completed

    # Jump back to the beginning of the loop
    j load_loop

start:
    li $v0, 4 			#Print Welcome message 
    la $a0, Welcome
    syscall

    li $v0, 4 			#Print project name
    la $a0, Projectname
    syscall

    li $v0, 4 			#Print my student ID
    la $a0, StudentID
    syscall

    li  $v0, 4 			#Print prompt to ask for number of disks
    la  $a0, Prompt
    syscall

    li $v0, 5
    syscall
    add $a0, $v0, $zero 	#$a0 = num of disks
    
    addi $a1, $zero, 1		#$a1 = start peg
    addi $a2, $zero, 3		#$a2 = end peg
    addi $a3, $zero, 2		#$a3 = extra peg
    jal hanoi_towers

checkifexit: #we come here when our program is ending

   li $v0,4
   la $a0,wishtocontinue
   syscall

   li $v0,4
   la $a0,check
   syscall

   li $v0,5
   syscall
   move $t4,$v0
   li $t5,1
   li $t6,2
   
   beq $t4,$t6,exit
   beq $t4,$t5,load_loop

exit:
    li $v0,4
    la $a0,endmsg
    syscall
 
    li $v0, 10 			# Exit
    syscall
    
hanoi_towers:   

    #pseudocode for understanding purpose only 
    # if (num_of_disks == 1)
    # 	move disk to end_peg
    # else
    #   hanoi_towers(num_of_disks-1, start_peg, extra_peg, end_peg)
    #	move disk from start_peg to end_peg
    # 	hanoi_towers(num_of_disks-1, extra_peg, end_peg, start_peg) 
    
    # YA BASE CASE HAI 
    # if (num_of_disks == 1)
    #move disk to end_peg

    addi $t0, $a0, 0		# temp save $a0

    addi $t1, $zero, 1 #add zero and one in t1

    bne $a0, $t1, else #will run untill it is not equal to the value of t1

    li $v0, 4			# print move message string that it moved where
    la $a0, Move
    syscall
    li $v0, 1 			# print start_peg
    move $a0, $a1
    syscall
    li $v0, 4			# print to message
    la $a0, To
    syscall
    li $v0, 1 			# print end_peg
    move $a0, $a2
    syscall
    addi $a0, $t0, 0		# restore $a0
    jr $ra #run honay kai baad return kardai ga
    
else:
    #expand stack
    	addi $sp, $sp, -20
    
    #save to stack
    	sw $ra, 16($sp)         #store the returned value
    	sw $a3, 12($sp)		#store a3(extra_peg)
    	sw $a2, 8($sp)		#store a2(end_peg)
    	sw $a1, 4($sp)		#store a1(start_peg)
	sw $a0, 0($sp)		#store a0(num_of_disks)
	    
    #hanoi_towers(num_of_disks-1, start_peg, extra_peg, end_peg)    
    	#set arguments for recursive call of the function
    		addi $t3, $a3, 0		#copy var into temp
    		addi $a3, $a2, 0		#extra_peg = end_peg
    		addi $a2, $t3, 0		#end_peg = extra_peg
    		addi $a0, $a0, -1		#jaisa jaisa move hota rhai ga waisa waisa num of disk--   		
    	#recursive call
    		jal hanoi_towers   
    	
    #load off stack
    	lw $ra, 16($sp)
    	lw $a3, 12($sp)		#load a3(extra_peg)
    	lw $a2, 8($sp)		#load a2(end_peg)
    	lw $a1, 4($sp)		#load a1(start_peg)
    	lw $a0, 0($sp)		#load a0(num_of_disks)
   
    #move a disk from start_peg to end_peg
    	addi $t0, $a0, 0		# temp save $a0
    	addi $t1, $zero, 1
    	li $v0, 4			# print move
    	la $a0, Move
    	syscall
    	li $v0, 1 			# print start_peg
    	move $a0, $a1
    	syscall
    	li $v0, 4			# print to
    	la $a0, To
    	syscall
    	li $v0, 1 			# print end_peg
    	move $a0, $a2
    	syscall
    	addi $a0, $t0, 0		# restore $a0
    
    #hanoi_towers(num_of_disks-1, extra_peg, end_peg, start_peg)  
    	#set args for subsequent recursive call
    		addi $t3, $a3, 0		#copy var into temp
    		addi $a3, $a1, 0		#extra_peg = start_peg
    		addi $a1, $t3, 0		#start_peg = extra_peg
    		addi $a0, $a0, -1		#num of disk--  		
    	#recursive call
    		jal hanoi_towers  
    	#load params off stack
    		lw $ra, 16($sp)
    		
    #to clear my stack
    	addi $sp, $sp, 20 #jaisa phelay minus kiya tha 20 abhi add krdiya ta kai stack puri clear hojai

    #return function
    	add $v0, $zero, $t5
    	jr $ra    
