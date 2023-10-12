.data
newline: .asciiz "\n"   # Cadena para la nueva línea
msg_even: .asciiz " es par!\n"
msg_odd: .asciiz " es impar!\n"

.text
.globl main

# Definición de la clase A
class_A:

    var: .word 0   # Variable de instancia 'var'

    # Método 'value'
    value:
        lw $v0, 0($a0)   # Cargar el valor de 'var' en $v0
        jr $ra

    # Método 'set_var'
    set_var:
        sw $a1, 0($a0)   # Almacenar el valor de $a1 en 'var'
        move $v0, $a0    # Devolver 'self'
        jr $ra

    # Método 'method1' (Igual que 'set_var')
    method1:
        move $v0, $a0    # Devolver 'self'
        jr $ra

    # Método 'method2' (B)
    method2:
        # $a0 = dirección del objeto A
        # $a1 = num1
        # $a2 = num2
        lw $t0, 0($a0)     # Cargar 'var' de A en $t0
        add $t1, $a1, $a2  # Sumar num1 y num2 en $t1
        move $a0, $t1      # Pasar el resultado a A
        jal set_var        # Llamar a 'set_var' en A
        la $t2, class_B    # Cargar la dirección de la clase B
        jal new_object     # Crear un nuevo objeto B
        move $a0, $v0      # Pasar el objeto B a $a0
        jal set_var        # Llamar a 'set_var' en B
        jr $ra

    # Método 'method3' (C)
    method3:
        # $a0 = dirección del objeto A
        # $a1 = num
        lw $t0, 0($a0)   # Cargar 'var' de A en $t0
        not $t0, $a1     # Negar num y almacenar en $t0
        move $a0, $t0    # Pasar el resultado a A
        jal set_var      # Llamar a 'set_var' en A
        la $t2, class_C  # Cargar la dirección de la clase C
        jal new_object   # Crear un nuevo objeto C
        move $a0, $v0    # Pasar el objeto C a $a0
        jal set_var      # Llamar a 'set_var' en C
        jr $ra

    # Método 'method4' (D)
    method4:
        # $a0 = dirección del objeto A
        # $a1 = num1
        # $a2 = num2
        bge $a2, $a1, greater_than_or_equal  # Comprobar si num2 >= num1
        sub $t0, $a1, $a2                    # Calcular num1 - num2 y almacenar en $t0
        j done
    greater_than_or_equal:
        sub $t0, $a2, $a1                    # Calcular num2 - num1 y almacenar en $t0
    done:
        move $a0, $t0                        # Pasar el resultado a A
        jal set_var                          # Llamar a 'set_var' en A
        la $t2, class_D                      # Cargar la dirección de la clase D
        jal new_object                       # Crear un nuevo objeto D
        move $a0, $v0                        # Pasar el objeto D a $a0
        jal set_var                          # Llamar a 'set_var' en D
        jr $ra

    # Método 'method5' (E)
    method5:
        # $a0 = dirección del objeto A
        # $a1 = num
        li $t0, 1                            # Inicializar x a 1
        li $t1, 1                            # Inicializar y a 1
    loop_start:
        ble $t1, $a1, loop_body              # Comprobar si y <= num
        j loop_end
    loop_body:
        mul $t0, $t0, $t1                   # x = x * y
        addi $t1, $t1, 1                    # y = y + 1
        j loop_start
    loop_end:
        move $a0, $t0                        # Pasar el resultado a A
        jal set_var                          # Llamar a 'set_var' en A
        la $t2, class_E                      # Cargar la dirección de la clase E
        jal new_object                       # Crear un nuevo objeto E
        move $a0, $v0                        # Pasar el objeto E a $a0
        jal set_var                          # Llamar a 'set_var' en E
        jr $ra

# Definición de la clase B (hereda de A)
class_B:
    .word class_A  # Puntero a la clase base A

    # Método 'method5' (E) en B (square)
    method5:
        # $a0 = dirección del objeto B
        # $a1 = num
        lw $t0, 0($a0)   # Cargar 'var' de B en $t0
        mul $t0, $t0, $a1  # Calcular el cuadrado de num y almacenar en $t0
        move $a0, $t0    # Pasar el resultado a B
        jal set_var      # Llamar a 'set_var' en B
        la $t2, class_E  # Cargar la dirección de la clase E
        jal new_object   # Crear un nuevo objeto E
        move $a0, $v0    # Pasar el objeto E a $a0
        jal set_var      # Llamar a 'set_var' en E
        jr $ra

# Definición de la clase C (hereda de B)
class_C:
    .word class_B  # Puntero a la clase base B

    # Método 'method6' (A) en C (negate)
    method6:
        # $a0 = dirección del objeto C
        # $a1 = num
        not $a1, $a1     # Negar num y almacenar en $a1
        move $a0, $a1    # Pasar el resultado a C
        jal set_var      # Llamar a 'set_var' en C
        la $t2, class_A  # Cargar la dirección de la clase A
        jal new_object   # Crear un nuevo objeto A
        move $a0, $v0    # Pasar el objeto A a $a0
        jal set_var      # Llamar a 'set_var' en A
        jr $ra

    # Método 'method5' (E) en C (cube)
    method5:
        # $a0 = dirección del objeto C
        # $a1 = num
        lw $t0, 0($a0)     # Cargar 'var' de C en $t0
        mul $t0, $t0, $a1  # Calcular el cubo de num y almacenar en $t0
        move $a0, $t0      # Pasar el resultado a C
        jal set_var        # Llamar a 'set_var' en C
        la $t2, class_E    # Cargar la dirección de la clase E
        jal new_object     # Crear un nuevo objeto E
        move $a0, $v0      # Pasar el objeto E a $a0
        jal set_var        # Llamar a 'set_var' en E
        jr $ra

# Definición de la clase D (hereda de B)
class_D:
    .word class_B  # Puntero a la clase base B

    # Método 'method7' en D (divisible by 3)
    method7:
        # $a0 = num
        li $t0, 0        # Inicializar $t0 a 0
        blez $a0, done   # Saltar si num <= 0
    loop_start:
        subi $a0, $a0, 3  # Restar 3 a num
        addi $t0, $t0, 1  # Incrementar contador
        bgtz $a0, loop_start  # Saltar si num > 0
    done:
        move $v0, $t0     # Devolver el resultado (número de divisiones por 3)
        jr $ra

# Definición de la clase E (hereda de D)
class_E:
    .word class_D  # Puntero a la clase base D

    # Método 'method6' (A) en E (division)
    method6:
        # $a0 = dirección del objeto E
        # $a1 = num
        div $a1, $a1, 8  # Dividir num por 8
        mflo $a0          # Pasar el resultado a E
        jal set_var       # Llamar a 'set_var' en E
        la $t2, class_A   # Cargar la dirección de la clase A
        jal new_object    # Crear un nuevo objeto A
        move $a0, $v0     # Pasar el objeto A a $a0
        jal set_var       # Llamar a 'set_var' en A
        jr $ra

# Definición de la clase Main
class_Main:
    .word class_IO  # Puntero a la clase base IO

    char: .asciiz "A"  # Cadena de caracteres 'A'

    avar: .word 0  # Variable para el objeto A
    a_var: .word 0  # Variable para el segundo objeto A
    flag: .word 1  # Bandera (verdadero)

    # Método 'is_even'
    is_even:
        # $a0 = num
        li $t0, 0        # Inicializar $t0 a 0
        blez $a0, done   # Saltar si num <= 0
    loop_start:
        subi $a0, $a0, 2  # Restar 2 a num
        addi $t0, $t0, 1  # Incrementar contador
        bgtz $a0, loop_start  # Saltar si num > 0
    done:
        beqz $t0, is_even_result_true  # Saltar si es par
        li $v0, 0          # Cargar 0 en $v0 (falso)
        jr $ra
    is_even_result_true:
        li $v0, 1          # Cargar 1 en $v0 (verdadero)
        jr $ra

    # Método 'main'
    main:
        # Crear objetos A
        la $t0, class_A  # Cargar la dirección de la clase A
        jal new_object  # Crear un nuevo objeto A
        sw $v0, avar  # Almacenar el objeto A en 'avar'
        li $a1, 2  # Valor a asignar
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        jal set_var  # Llamar a 'set_var' en A
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        jal value  # Llamar a 'value' en A
        move $a0, $v0  # Pasar el resultado a $a0
        jal out_int  # Llamar a 'out_int'

        # Verificar si el valor es par o impar
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        jal value  # Llamar a 'value' en A
        jal is_even  # Llamar a 'is_even'
        beqz $v0, even_branch  # Saltar si es par
        la $a0, msg_odd  # Cargar la dirección de la cadena 'es impar!'
        jal out_string  # Llamar a 'out_string'
        j after_even_branch
    even_branch:
        la $a0, msg_even  # Cargar la dirección de la cadena 'es par!'
        jal out_string  # Llamar a 'out_string'
    after_even_branch:

        # Crear otro objeto A
        la $t0, class_A  # Cargar la dirección de la clase A
        jal new_object  # Crear un nuevo objeto A
        sw $v0, a_var  # Almacenar el objeto A en 'a_var'
        li $a1, 3  # Valor a asignar
        lw $a0, a_var  # Cargar la dirección de 'a_var' en $a0
        jal set_var  # Llamar a 'set_var' en A
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        lw $a1, a_var  # Cargar la dirección de 'a_var' en $a1
        jal method2  # Llamar a 'method2' en A
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        jal value  # Llamar a 'value' en A
        jal out_int  # Llamar a 'out_int'

        # Crear objeto C
        la $t0, class_C  # Cargar la dirección de la clase C
        jal new_object  # Crear un nuevo objeto C
        sw $v0, avar  # Almacenar el objeto C en 'avar'
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        li $a1, 5  # Valor a pasar a 'method6'
        jal method6  # Llamar a 'method6' en C
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        jal value  # Llamar a 'value' en C
        jal out_int  # Llamar a 'out_int'

        # Crear otro objeto A
        la $t0, class_A  # Cargar la dirección de la clase A
        jal new_object  # Crear un nuevo objeto A
        sw $v0, a_var  # Almacenar el objeto A en 'a_var'
        li $a1, 5  # Valor a asignar
        lw $a0, a_var  # Cargar la dirección de 'a_var' en $a0
        jal set_var  # Llamar a 'set_var' en A
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        lw $a1, a_var  # Cargar la dirección de 'a_var' en $a1
        jal method4  # Llamar a 'method4' en A
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        jal value  # Llamar a 'value' en A
        jal out_int  # Llamar a 'out_int'

        # Llamar a 'method5' en C (A.method5)
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        jal value  # Llamar a 'value' en C
        la $t2, class_C  # Cargar la dirección de la clase C
        jal method5  # Llamar a 'method5' en C
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        jal value  # Llamar a 'value' en C
        jal out_int  # Llamar a 'out_int'

        # Configurar un valor en 'avar' y llamar a 'method5' en C (B.method5)
        li $a1, 6  # Valor a asignar a 'avar'
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        jal set_var  # Llamar a 'set_var' en C
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        jal value  # Llamar a 'value' en C
        la $t2, class_C  # Cargar la dirección de la clase C
        jal method5  # Llamar a 'method5' en C
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        jal value  # Llamar a 'value' en C
        jal out_int  # Llamar a 'out_int'

        # Llamar a 'main' nuevamente (recursión)
        la $t0, class_Main  # Cargar la dirección de la clase Main
        jal new_object  # Crear un nuevo objeto Main
        lw $a0, avar  # Cargar la dirección de 'avar' en $a0
        jal value  # Llamar a 'value' en Main
        jal method_main  # Llamar a 'main' en Main

# Función para crear un nuevo objeto
new_object:
    # $a0 = dirección de la clase
    # $v0 = dirección del objeto creado
    lw $t0, 0($a0)   # Cargar el puntero a la clase base
    lw $t1, 0($t0)   # Cargar el puntero a la clase base de la clase base
    move $v0, $t1    # Copiar el puntero a la clase base
    jr $ra

# Función para imprimir una cadena de caracteres
out_string:
    # $a0 = dirección de la cadena
    li $v0, 4         # Cargar el código del sistema para imprimir cadena (4)
    syscall
    jr $ra

# Función para imprimir un entero
out_int:
    # $a0 = entero a imprimir
    li $v0, 1         # Cargar el código del sistema para imprimir entero (1)
    syscall
    jr $ra

# Punto de entrada
main:
    # Configurar valores iniciales
    la $t0, class_Main  # Cargar la dirección de la clase Main
    jal new_object  # Crear un nuevo objeto Main
    sw $v0, avar  # Almacenar el objeto Main en 'avar'

    # Llamar a 'main' en Main
    lw $a0, avar  # Cargar la dirección de 'avar' en $a0
    jal method_main  # Llamar a 'main' en Main

    # Terminar el programa
    li $v0, 10  # Cargar el código del sistema para salir (10)
    syscall
