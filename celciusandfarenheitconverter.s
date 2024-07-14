.data
inputvalue: .asciiz "Enter temperature value: "
choose: .asciiz "Press 1 to convert to Fahrenheit and 2 to convert to Celsius: "
conversiondone: .asciiz "Temperature after conversion: "
newline: .asciiz "\n"

.text
.globl main
main:
    li $v0, 4
    la $a0, inputvalue
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 4
    la $a0, choose
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    li $t2, 1
    beq $t1, $t2, toFahrenheit
    j toCelsius

toFahrenheit:
    li $t3, 9
    li $t4, 5
    li $t5, 32
    mul $t6, $t0, $t3
    div $t6, $t4
    mflo $t6
    add $t6, $t6, $t5
    j printResult

toCelsius:
    li $t3, 32
    li $t4, 5
    li $t5, 9
    sub $t6, $t0, $t3
    mul $t6, $t6, $t4
    div $t6, $t5
    mflo $t6

printResult:
    li $v0, 4
    la $a0, conversiondone
    syscall

    li $v0, 1
    move $a0, $t6
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall
