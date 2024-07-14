.data
menu: .asciiz "Enter your choice: \n1) circle \n2) square \n3) rectangle \n4) triangle \n" #basically the menu

circlemsg: .asciiz " enter the radius: "

squaremsg: .asciiz " enter the side length: "

msg3: .asciiz " enter the length: "

msg4: .asciiz " enter the width: "

msg5: .asciiz " enter the base: "

msg6: .asciiz " enter the height: "

resultcirc: .asciiz "\n the circumference of the circle is: "

resultsq: .asciiz "\n the perimeter of the square is: "

resultrec: .asciiz "\n the area of the rectangle is: "

resulttri: .asciiz "\n the area of the triangle is: "

incorrect: .asciiz "\n You entered an invalid option."

.text
.globl main
main:
    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    #multiple conditions being checked/switch case
    beq $t0, 1, circle 
    beq $t0, 2, square
    beq $t0, 3, rectangle
    beq $t0, 4, triangle

    li $v0, 4
    la $a0, incorrect
    syscall
    j exit

circle:
    li $v0, 4
    la $a0, circlemsg
    syscall
	
    li $v0, 6
    syscall
    mov.s $f0, $f0  

    # Calculate circumference: 2 * pi * r

    li.s $f1, 3.14
    li.s $f2, 2.0
    mul.s $f3, $f2, $f1  
    mul.s $f4, $f3, $f0  
    
    li $v0, 4
    la $a0, resultcirc
    syscall

    li $v0, 2
    mov.s $f12, $f4
    syscall
    j exit

square:
    li $v0, 4
    la $a0, squaremsg
    syscall

    li $v0, 6
    syscall
    mov.s $f0, $f12  

    # Calculate perimeter: 4 * side
    li.s $f1, 4.0
    mul.s $f4, $f1, $f0  

    li $v0, 4
    la $a0, resultsq
    syscall

    li $v0, 2
    mov.s $f12, $f4
    syscall
    j exit

rectangle:
    li $v0, 4
    la $a0, msg3
    syscall

    li $v0, 6
    syscall
    mov.s $f0, $f12  

    li $v0, 4
    la $a0, msg4
    syscall

    li $v0, 6
    syscall
    mov.s $f1, $f12  

    # Calculate area: length * width
    mul.s $f4, $f0, $f1   #for float values

    # Print result
    li $v0, 4
    la $a0, resultrec
    syscall

    li $v0, 2
    mov.s $f12, $f4
    syscall
    j exit

triangle:

    li $v0, 4
    la $a0, msg5
    syscall

    li $v0, 6
    syscall
    mov.s $f0, $f12 

    li $v0, 4
    la $a0, msg6
    syscall

    li $v0, 6
    syscall
    mov.s $f1, $f12  

    # Calculate area: 1/2 * base * height
    li.s $f2, 0.5
    mul.s $f3, $f0, $f1  
    mul.s $f4, $f2, $f3  

    li $v0, 4
    la $a0, resulttri
    syscall

    li $v0, 2
    mov.s $f12, $f4
    syscall
    j exit

exit:
    li $v0, 10
    syscall