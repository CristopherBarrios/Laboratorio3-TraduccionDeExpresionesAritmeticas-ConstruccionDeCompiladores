.data
prompt1: .asciiz "Ingrese el número máximo: "
prompt2: .asciiz "Ingrese el número mínimo: "
result_msg: .asciiz "El MCD es: "

.text
.globl main

main:
    # Preguntar al usuario que ingrese el número máximo
    li $v0, 4
    la $a0, prompt1
    syscall

    # Leer el número máximo
    li $v0, 5
    syscall
    move $s0, $v0  # Guardar el número máximo en $s0

    # Preguntar al usuario que ingrese el número mínimo
    li $v0, 4
    la $a0, prompt2
    syscall

    # Leer el número mínimo
    li $v0, 5
    syscall
    move $s1, $v0  # Guardar el número mínimo en $s1

    # Calcular el MCD usando el algoritmo de Euclides
    b MCD_loop

MCD_loop:
    beq $s1, $zero, MCD_done  # Si $s1 == 0, terminar el bucle
    div $s0, $s1
    mfhi $t0
    move $s0, $s1
    move $s1, $t0
    j MCD_loop

MCD_done:
    # El resultado (MCD) se encuentra en $s0

    # Imprimir el resultado
    li $v0, 4
    la $a0, result_msg
    syscall

    li $v0, 1
    move $a0, $s0
    syscall

    # Salir del programa
    li $v0, 10
    syscall
