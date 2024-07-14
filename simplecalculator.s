.data
prompt1: .asciiz "Enter first operand: "
prompt2: .asciiz "Enter second operand: "
prompt3: .asciiz "Enter operation (+, -, *, /): "
result_prompt: .asciiz "Result: "
invalidop: .asciiz "Invalid operation!\n"

.text
.globl main

main:
    # Display prompt for first operand
    li $v0, 4
    la $a0, prompt1
    syscall
    
    # Read first operand
    li $v0, 5
    syscall
    move $s0, $v0  # $s0 = first operand
    
    # Display prompt for second operand
    li $v0, 4
    la $a0, prompt2
    syscall
    
    # Read second operand
    li $v0, 5
    syscall
    move $s1, $v0  # $s1 = second operand
    
    # Display prompt for operation
    li $v0, 4
    la $a0, prompt3
    syscall
    
    # Read operation (+, -, *, /)
    li $v0, 12   # syscall code for reading a character
    syscall
    move $t0, $v0  # $t0 = operation character
    
    # Perform operation based on the input character
    beq $t0, '+', perform_addition
    beq $t0, '-', perform_subtraction
    beq $t0, '*', perform_multiplication
    beq $t0, '/', perform_division
    
    # Invalid operation
    li $v0, 4
    la $a0,invalidop
    syscall
    j exit
    
perform_addition:
    add $t1, $s0, $s1  # $t1 = first operand + second operand
    j print_result
    
perform_subtraction:
    sub $t1, $s0, $s1  # $t1 = first operand - second operand
    j print_result
    
perform_multiplication:
    mult $s0, $s1      # Multiply first operand by second operand
    mflo $t1           # $t1 = product (low bits of the result)
    j print_result
    
perform_division:
    div $s0, $s1       # Divide first operand by second operand
    mflo $t1           # $t1 = quotient
    j print_result
    
print_result:
    # Display result
    li $v0, 4
    la $a0, result_prompt
    syscall
    
    # Print the result stored in $t1
    li $v0, 1
    move $a0, $t1
    syscall
    
exit:
    # Exit the program
    li $v0, 10
    syscall
