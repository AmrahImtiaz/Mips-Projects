.data
prompt_p1: .asciiz "Player 1: Enter your choice (1 for Rock, 2 for Paper, 3 for Scissors): "
prompt_p2: .asciiz "Player 2: Enter your choice (1 for Rock, 2 for Paper, 3 for Scissors): "
result_win: .asciiz "Player 1 wins!\n"
result_lose: .asciiz "Player 2 wins!\n"
result_draw: .asciiz "It's a draw!\n"

.text
.globl main

main:
    # Player 1's turn
    li $v0, 4           
    la $a0, prompt_p1   
    syscall

    li $v0, 5           
    syscall
    move $t0, $v0       # Player 1's choice is stored in $t0

    # Player 2's turn
    li $v0, 4           
    la $a0, prompt_p2   
    syscall

    li $v0, 5           
    syscall
    move $t1, $v0       # Player 2's choice is stored in $t1

    # Determine winner
    sub $t2, $t0, $t1   # $t2 = Player 1's choice - Player 2's choice

    # Player 1 wins cases
    beq $t2, 1, winner  # Player 1: Rock (1), Player 2: Scissors (3)
    beq $t2, -2, winner # Player 1: Scissors (3), Player 2: Paper (2)
    beq $t2, 2, winner  # Player 1: Paper (2), Player 2: Rock (1)

    # Player 2 wins cases
    beq $t2, -1, loser  # Player 1: Scissors (3), Player 2: Rock (1)
    beq $t2, 2, loser   # Player 1: Rock (1), Player 2: Paper (2)
    beq $t2, -2, loser  # Player 1: Paper (2), Player 2: Scissors (3)

    # Draw case
    bne $t2, 0, draw    # if $t2 != 0, it's a draw

    li $v0, 4           
    la $a0, result_draw 
    syscall
    j end_game

winner:
    li $v0, 4          
    la $a0, result_win   
    syscall
    j end_game

loser:
    li $v0, 4           
    la $a0, result_lose  
    syscall
    j end_game

draw:
    li $v0, 4          
    la $a0, result_draw  # load address of draw message
    syscall

end_game:
    li $v0, 10         
    syscall
