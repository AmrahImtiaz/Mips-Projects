.data
input_string: .asciiz "reverse this string"

.text
.globl main
main:
    la $a0, input_string
    li $v0, 4
    syscall

    li $a0, 10
    li $v0, 11
    syscall

    la $a0, input_string
    li $t0, 0
find_length:
    lb $t1, 0($a0)
    beq $t1, $zero, reverse_words
    addi $t0, $t0, 1
    addi $a0, $a0, 1
    j find_length

reverse_words:
    la $a0, input_string
    li $t2, 0
    li $t3, 0

reverse_loop:
    lb $t1, 0($a0)
    beq $t1, $zero, reverse_word_end

    beq $t1, 32, reverse_word

    addi $a0, $a0, 1
    addi $t3, $t3, 1
    j reverse_loop

reverse_word:
    sub $t4, $t3, $t2
    addi $t4, $t4, -1

    la $a1, input_string
    add $a1, $a1, $t2
    add $a2, $a1, $t4

reverse_characters:
    blt $a1, $a2, swap_characters
    b reverse_done

swap_characters:
    lb $t5, 0($a1)
    lb $t6, 0($a2)
    sb $t6, 0($a1)
    sb $t5, 0($a2)

    addi $a1, $a1, 1
    addi $a2, $a2, -1
    j reverse_characters

reverse_done:
    addi $t3, $t3, 1
    addi $t2, $t3, 1
    addi $a0, $a0, 1
    j reverse_loop

reverse_word_end:
    sub $t4, $t3, $t2
    addi $t4, $t4, -1

    la $a1, input_string
    add $a1, $a1, $t2
    add $a2, $a1, $t4

reverse_characters_end:
    blt $a1, $a2, swap_characters_end
    b print_reversed

swap_characters_end:
    lb $t5, 0($a1)
    lb $t6, 0($a2)
    sb $t6, 0($a1)
    sb $t5, 0($a2)

    addi $a1, $a1, 1
    addi $a2, $a2, -1
    j reverse_characters_end

print_reversed:
    la $a0, input_string
    li $v0, 4
    syscall

    li $v0, 10
    syscall
