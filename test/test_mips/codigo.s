.data
newline: .asciiz "\n"       # Cadena para la nueva línea
msg: .asciiz "Hola mundo"  # Cadena "Hola mundo"

.text
.globl main

# Función para imprimir una cadena de caracteres
print_string:
    li $v0, 4             # Cargar el código del sistema para imprimir cadena (4)
    syscall
    jr $ra                # Retornar

# Función para imprimir un entero
print_int:
    li $v0, 1             # Cargar el código del sistema para imprimir entero (1)
    syscall
    jr $ra                # Retornar

# Función suma
suma:
    add $v0, $a0, $a1     # Sumar los dos argumentos (y + k)
    jr $ra                # Retornar el resultado

main:
    # Inicializar valores
    li $t0, 4             # a = 4
    li $t1, 5             # b = 5

    # Llamar a la función suma(a, b)
    move $a0, $t0         # Pasar el primer argumento (a)
    move $a1, $t1         # Pasar el segundo argumento (b)
    jal suma              # Llamar a suma
    move $t2, $v0         # Guardar el resultado en t2

    # Imprimir el resultado
    move $a0, $t2         # Pasar el resultado a print_int
    jal print_int         # Llamar a print_int
    la $a0, newline       # Cargar la dirección de la cadena newline
    jal print_string      # Llamar a print_string

    # Imprimir la cadena "Hola mundo"
    la $a0, msg           # Cargar la dirección de la cadena msg
    jal print_string      # Llamar a print_string

    # Terminar el programa
    li $v0, 10            # Cargar el código del sistema para salir (10)
    syscall
