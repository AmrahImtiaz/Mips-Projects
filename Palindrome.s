.data
    prompt:      .asciiz "Enter a string: " #to enter the string
    not_palindrome: .asciiz " is not a palindrome\n" #message that it is not palindrome
    is_palindrome: .asciiz " is a palindrome\n" #message that it is palindrome
    buffer:      .space 50  # Increased space to handle the null terminator

.text
.globl main

main:
    # Print the prompt
    li $v0, 4                
    la $a0, prompt           
    syscall

    #cin function
    li $v0, 8      #v0,8           
    la $a0, buffer      #address load kardiya    
    li $a1, 50          #limit dai di
    syscall

    # Calculate the length of the string
    la $t0, buffer           # address of buffer
    li $t1, 0                # counter

length_calculation: #to find the length 
    lb $t2, 0($t0)           # load byte from buffer
    beq $t2, '\n', length_done # if byte is newline, end of string
    beqz $t2, length_done    # if byte is zero, end of string
    addi $t1, $t1, 1         # increment counter to confirm length
    addi $t0, $t0, 1         # move to the next byte of address
    j length_calculation

length_done:
    move $t3, $t1            # store length in $t3

    # Check if the string is a palindrome
    li $t4, 0                # initialize index i to 0 ya for (check palindrome) loop ka liya counter hai
    li $t5, 0                # initialize flag to 0 ya bool value hai
    sub $t6, $t3, 1         # length - 1

check_palindrome:
    bge $t4, $t3, palindrome_done  # if i >= length, end of loop - ulti loop chal rhi hai
    lb $t7, buffer($t4)           # load byte at buffer[i] n
    lb $t8, buffer($t6)           # load byte at buffer[length-i-1] 
    bne $t7, $t8, not_palindrome_set  # if bytes are not equal, set flag
    addi $t4, $t4, 1               # increment i ya agay move kar rha hai 
    sub $t6, $t6, 1               # decrement length-i-1 aur ya peechay
    j check_palindrome

not_palindrome_set:
    li $t5, 1                      # set flag to 1 just to check

palindrome_done:
    # Print the result
    la $a0, buffer                 # load address of buffer
    li $v0, 4                      # syscall for print string
    syscall

    beqz $t5, print_palindrome     # if flag == 0, print is_palindrome
    la $a0, not_palindrome         # load address of not_palindrome
    j print_result

print_palindrome:
    la $a0, is_palindrome          # load address of is_palindrome ta kai message print hojai

print_result:
    li $v0, 4                     
    syscall

    # Exit the program
    li $v0, 10                     
    syscall
