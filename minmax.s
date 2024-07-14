.data

num: .asciiz " Enter 3 numbers : "
max: .asciiz " Maximum number : "
min: .asciiz " Minimum number : "
newline: .asciiz " \n "

.text
.globl main

min_max_function:
    move $t0, $t7
    move $t1, $t8
    move $t2, $t9

    blt $t1, $t0, min_swap
    move $t0, $t1
min_swap:
    blt $t2, $t0, min_end
    move $t0, $t2
min_end:
    move $t4, $t7
    move $t5, $t8
    move $t6, $t9

    bgt $t1, $t0, max_swap
    move $t4, $t1
max_swap:
    bgt $t2, $t4, max_end
    move $t4, $t2
max_end:

    li $v0, 4
    la $a0, max
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, min
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    jr $ra

main:
    li $v0, 4
    la $a0, num
    syscall

    li $v0, 5
    syscall
    move $t7, $v0

    li $v0, 5
    syscall
    move $t8, $v0

    li $v0, 5
    syscall
    move $t9, $v0

    jal min_max_function

    li $v0, 10
    syscall
