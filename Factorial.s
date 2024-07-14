.data
    prompt_num: .asciiz "Enter a number: "
    result_msg: .asciiz "Factorial: "
    num: .word 0

.text
.globl main

main:
   
    li $v0, 4
    la $a0, prompt_num
    syscall
    
    li $v0, 5
    syscall
    move $a0, $v0
    
    jal factorial
    
    li $v0, 4
    la $a0, result_msg
    syscall
    
    li $v0, 1
    move $a0, $v1
    syscall

exit:
    li $v0, 10
    syscall

factorial:
    li $t0, 1
    ble $a0, $t0, base_case
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Decrement $a0 and call factorial recursively
    addi $a0, $a0, -1
    jal factorial
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    # Multiply the returned value with the current $a0 + 1
    addi $a0, $a0, 1
    mul $v1, $a0, $v1
    jr $ra

base_case:
    li $v1, 1
    jr $ra