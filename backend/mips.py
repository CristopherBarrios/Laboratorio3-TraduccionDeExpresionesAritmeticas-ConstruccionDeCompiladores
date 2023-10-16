##################################
#  Cristopher Barrios 18207
# COMPILADORES 
##################################
# mips.py
##################################
# Traduccion de codigo intermedio a mips
###################################

import re

REGISTERS = ["R15", "R14", "R13", "R12", "R11", "R10", "R9", "R8", "R7", "R6", "R5", "R4", "R3", "R2", "R1", "R0"]


def whileStatementArmHandler(first_operand,second_operand,operation,inter,i):
    actual_line = inter[i].split(' ')
    next_line = inter[i+1].split(' ')
    next_next_line = inter[i+2].split(' ')

    arm_code = ''
    first_ = actual_line[2]

    if first_operand.isnumeric(): 
        memory_address = first_operand
    elif re.search("^t.*[0-9]$", first_operand): #check if has pattern for t0 - t9:
        memory_address1 = getBracketsContent(first_)
        memory_address = memory_address1 + 4
    else:
        memory_address = getBracketsContent(first_operand)

    if second_operand.isnumeric(): 
        memory_address2 = second_operand
    elif re.search("^t.*[0-9]$", second_operand): #check if has pattern for t0 - t9:
        memory_address1 = getBracketsContent(first_)
        memory_address2 = memory_address1 + 4
    else:
        memory_address2 = getBracketsContent(second_operand)

    regi1 = REGISTERS.pop()

    #des.addDRegister(regi1,[actual_line[0]])
    #des.addDAccess(actual_line[0],[regi1])

    arm_code += "\tlw " + regi1 + ", " + str(memory_address) + "($sp)\n"
    arm_code += "\tcmp " + regi1 + ", #" + str(memory_address2) + "\n"

    # actual_line [t0,=,m1[0],==,5]
    # next_line [IfW,t0,Goto,L0]
    numero = extractor(next_line[3])
    if  operation == '==': arm_code += "\tbne .LBB0_" + numero + "\n"
    elif operation == '>': arm_code += "\tblt .LBB0_" + numero + "\n"
    elif operation == '<': arm_code += "\tbgt .LBB0_" + numero + "\n"

    # !this one is handled in len(line) == 2 with if labels too
    # next_next_line ["Goto", "L_END_WHILE"]    
    # arm_code += "\tb ." + next_next_line[1]+ "\n" 

    REGISTERS.append(regi1)

    return arm_code


def ifStatementArmHandler(first_operand,second_operand,operation,inter,i):
    last_line = inter[i-1].split(' ')
    next_line = inter[i+1].split(' ')
    next_next_line = inter[i+2].split(' ')
    actual_line = inter[i].split(' ')

    arm_code = ''
    first_ = last_line[2]

    if first_operand.isnumeric(): 
        memory_address = first_operand
    elif re.search("^t.*[0-9]$", first_operand): #check if has pattern for t0 - t9:
        memory_address1 = getBracketsContent(first_)
        memory_address = memory_address1 + 4
    else:
        memory_address = getBracketsContent(first_operand)

    if second_operand.isnumeric(): 
        memory_address2 = second_operand
    elif re.search("^t.*[0-9]$", second_operand): #check if has pattern for t0 - t9:
        memory_address1 = getBracketsContent(first_)
        memory_address2 = memory_address1 + 4
    else:
        memory_address2 = getBracketsContent(second_operand)

    regi1 = REGISTERS.pop()

    #des.addDRegister(regi1,[actual_line[0]])
    #des.addDAccess(actual_line[0],[regi1])

    arm_code += "\tlw " + regi1 + ", " + str(memory_address) + "($sp)\n"
    arm_code += "\tcmp " + regi1 + ", #" + str(memory_address2) + "\n"

    # actual_line [t0,=,m1[0],==,5]
    # next_line [IfZ,t0,Goto,L0]
    numero = extractor(next_line[3])
    if  operation == '==': arm_code += "\tbne .LBB0_" + numero + "\n"
    elif operation == '>': arm_code += "\tblt .LBB0_" + numero + "\n"
    elif operation == '<': arm_code += "\tbgt .LBB0_" + numero + "\n"

    numero = extractor(next_next_line[1])
    # next_next_line ["Goto", "L1"]
    arm_code += "\tb .LBB0_" + numero + "\n"

    REGISTERS.append(regi1)

    return arm_code

def letStatementArmHandler(first_operand,second_operand,operation,inter,i):
    last_line = inter[i-1].split(' ')
    next_line = inter[i+1].split(' ')
    next_next_line = inter[i+2].split(' ')
    actual_line = inter[i].split(' ')

    arm_code = ''
    first_ = actual_line[2]

    if first_operand.isnumeric(): 
        memory_address = first_operand
    elif re.search("^t.*[0-9]$", first_operand): #check if has pattern for t0 - t9:
        memory_address1 = getBracketsContent(first_)
        memory_address = memory_address1 + 4
    else:
        memory_address = getBracketsContent(first_operand)

    if second_operand.isnumeric(): 
        memory_address2 = second_operand
    elif re.search("^t.*[0-9]$", second_operand): #check if has pattern for t0 - t9:
        memory_address1 = getBracketsContent(first_)
        memory_address2 = memory_address1 + 4
    else:
        memory_address2 = getBracketsContent(second_operand)

    regi1 = REGISTERS.pop()

    #des.addDRegister(regi1,[actual_line[0]])
    #des.addDAccess(actual_line[0],[regi1])

    arm_code += "\tlw " + regi1 +", " + str(memory_address) + "($sp)\n"
    arm_code += "\tcmp " + regi1 + ", #" + str(memory_address2) + "\n"

    # actual_line [t0,=,m1[0],==,5]
    # next_line [IfW,t0,Goto,L0]

    numero = extractor(next_line[3])
    if  operation == '==': arm_code += "\tbne .LBB0_" + numero + "\n"

    # !this one is handled in len(line) == 2 with if labels too
    # next_next_line ["Goto", "L_END_LET"]    
    # arm_code += "\tb ." + next_next_line[1]+ "\n" 

    REGISTERS.append(regi1)

    return arm_code

def operationsFunction(first_operand,second_operand,operation,inter,i):
    arm_code = ''
    last_line = inter[i-1].split(' ')
    actual_line = inter[i].split(' ')
    prev_temp = False
    if 'func' not in last_line and '_MCall' not in last_line and len(last_line)!=1 and len(last_line)!=3: 
        #print(' '.join(last_line))
        first_ = last_line[2]
        second_ = last_line[4]
        prev_temp = True

    if first_operand.isnumeric(): 
        memory_address = first_operand
    elif re.search("^t.*[0-9]$", first_operand): #check if has pattern for t0 - t9:
        if last_line[0] != "func" and last_line[2].isnumeric():
                left_side = last_line[0]
                memory_address = getBracketsContent(left_side)#############
        elif last_line[2] == '_MCall':
            memory_address = False
        else:
            memory_address1 = getBracketsContent(first_)
            memory_address2 = getBracketsContent(second_)
            if memory_address1 > memory_address2:
                memory_address = memory_address1 + 4
            else:
                memory_address = memory_address2 + 4
    else:
        memory_address = getBracketsContent(first_operand)

    if second_operand.isnumeric(): 
        memory_address2 = second_operand
    elif re.search("^t.*[0-9]$", second_operand): #check if has pattern for t0 - t9:
        if last_line[0] != "func" and last_line[2].isnumeric():
                left_side = last_line[0]
                memory_address2 = getBracketsContent(left_side)#############
        elif "~" in last_line[2]:
            las_last_line = inter[i-2].split(' ')
            left_side = las_last_line[2]
            memory_address2 = getBracketsContent(left_side)
        elif last_line[2] == '_MCall':
            memory_address2 = False
        else:
            memory_address1 = getBracketsContent(first_)
            memory_address2 = getBracketsContent(second_)
            if memory_address1 > memory_address2:
                memory_address2 = memory_address1 + 4
            else:
                memory_address2 = memory_address2 + 4
    else:
        memory_address2 = getBracketsContent(second_operand)

    regi1 = REGISTERS.pop()
    regi2 = REGISTERS.pop()

    arm_code += "\tlw " + regi1 + ", " + str(memory_address) + "($sp)\n"
    arm_code += "\tlw " + regi2 + ", " + str(memory_address) + "($sp)\n"
#
    #des.addDRegister(regi1,[actual_line[2],actual_line[4]])
    #des.addDRegister(regi2,[actual_line[2],actual_line[4]])
    #
    #des.addDRegister(regi1,[memory_address])
    #des.addDRegister(regi2,[memory_address2])
#
    #des.addDAccess(actual_line[0],[regi1])
    #des.addDAccess(actual_line[0],[regi2])
    #des.addDAccess(memory_address,[regi1])
    #des.addDAccess(memory_address2,[regi2])
#
    if operation == 'add': arm_code += "\tadd " + regi1 + ", " + regi1 + ", " + regi2 + "\n"
    elif operation == 'sub': arm_code += "\tsub " + regi1 + ", " + regi1 + ", " + regi2 + "\n"
    elif operation == 'mul': arm_code += "\tmul " + regi1 + ", " + regi1 + ", " + regi2 + "\n"
    elif operation == 'div': arm_code += "\tdiv " + regi1 + ", " + regi1 + ", " + regi2 + "\n"

    #!handle temporals like m#[#] = t# /////////////////////", " + str(memory_address) + "($sp)\n"
    if int(memory_address) > int(memory_address2):
        arm_code += "\tsw " + regi1 + ", " + str(int(memory_address) + 4) + "($sp)\n"
    else:
        arm_code += "\tsw " + regi1 + ", " + str(int(memory_address) + 4) + "($sp)\n"

    #?if last function
        #arm_code += "\tmove " + regi1 + " " +  str(function_alocated_space-4) + "\n"

    REGISTERS.append(regi2)
    REGISTERS.append(regi1)

    #print(des.d_accesos)
    #print(des.d_registros)

    return arm_code


def getBracketsContent(abstract_inter_var):
    len_str = len(abstract_inter_var)
    try:
        b_index = abstract_inter_var.index('[')
    except:
        if abstract_inter_var.isnumeric(): 
            return int(abstract_inter_var) - 4
        elif re.search("^t.*[0-9]$", abstract_inter_var):
            return 4
        elif '"' in abstract_inter_var:
            return 0
        else:
            return 0
        #return False
    pos_brackets = len_str - b_index
    brackets_content = abstract_inter_var[-pos_brackets:]
    memory_address = str(re.findall('[0-9]+', brackets_content)[0])
    
    return int(memory_address)

def extractor(list):
    numero = ""
    for par in list:
        if par.isnumeric():
            numero += par
    return numero


def read_lines(inter):
    armc = []
    arm_code_all = ""
    function_alocated_space = 0
    printi_consola = ".data\n"
    text_consola = ""
    actual_temp = 0
    varsito = 0
    conto = 0
    contoText = 0

    #for i in len(0,inter):
    i = 0
    while(i < len(inter)):
        line = inter[i]
        arm_code = ""
        # parts = line.split(" ")
        # Divide la cadena en espacios fuera de las comillas
        parts = re.split(r'\s+(?=(?:(?:[^"]*"){2})*[^"]*$)', line)

        if len(parts) == 1:
            if re.search("^L.*[0-9]:$", parts[0]): #se verifica partron L#:
                check_while = inter[i+3].split(' ')
                numero = extractor(parts[0])
                if 'L_END_WHILE' in check_while:
                    arm_code += "\tb .LBB0_" + numero + "\n"
                    arm_code += ".LBB0_" + numero + ":\n"
                else:
                    arm_code += ".LBB0_" + numero + ":\n"
            elif parts[0] == 'L_END_IF':
                arm_code += "\tb ." + parts[0] + '\n'   #     b .L_END_IF
                arm_code += "." + parts[0] + ':\n'      #.L_END_IF:
            elif parts[0] == 'L_END_WHILE':
                arm_code += "." + parts[0] + ':\n'      #.L_END_WHILE:
            elif parts[0] == 'L_END_LET':               #.L_END_LET:
                arm_code += "." + parts[0] + ':\n'  
            elif parts[0] == 'L_END_CASE':               #.L_END_CASE:
                arm_code += "." + parts[0] + ':\n'  
            else:
                arm_code += parts[0] + '\n'

        elif len(parts) == 2:
            # func end
            if parts[0] == "func" and parts[1] == "end":
                arm_code += "\tadd $sp, $sp, #" + str(function_alocated_space)+'\n'
                function_alocated_space = 0
                arm_code += "\tjr $ra\n"

            if parts[0] == "class" and parts[1] == "end":
                arm_code += "\tadd $sp, $sp, #" + str(function_alocated_space)+'\n'
                function_alocated_space = 0
                arm_code += "\tjr $ra\n"

            if parts[0] == "Obj":
                arm_code += "\tcmp " + reg1 + ", #" + str(varsito) + "\n"
                arm_code += "\tbne " + ".CASE_" + parts[1] + "\n"
                arm_code += ".CASE_" + parts[1] + ":" + "\n"
                varsito += 4

            # Goto L#
            if parts[0] == "Goto":
                if parts[1] == 'L_END_IF':
                    arm_code += '\tb .'+parts[1] + '\n'
                elif parts[1] == 'L_END_WHILE':
                    arm_code += '\tb .'+parts[1] + '\n'
                elif parts[1] == 'L_END_LET':
                    arm_code += '\tb .'+parts[1] + '\n'
                elif parts[1] == 'L_END_CASE':
                    varsito = 0
                    arm_code += '\tb .'+parts[1] + '\n'
                else:
                    numero = extractor(parts[1])
                    arm_code += '\tb .LBB0_' + numero + '\n'

            # param m#[#]
            elif parts[0] == 'param':
                i += 1
                continue

        elif len(parts) == 3:

            if parts[0] == "func" and parts[1] == 'begin':
                memory_pos = re.findall('[0-9]+', parts[2])
                memory_pos = parts[2]
                function_alocated_space = memory_pos
                arm_code += "\tsub $sp, $sp, #"+memory_pos+"\n"

            # m#[#] = literal
            elif parts[0] != "func" and parts[2].isnumeric():
                reg1 = REGISTERS.pop()
                right_side = parts[2]

                left_side = parts[0]
                memory_address = getBracketsContent(left_side)

                arm_code += "\tmove " + reg1 + ", #" + str(right_side) + "\n"
                arm_code += "\tsw " + reg1 + ", " + str(memory_address) + "($sp)\n"
                REGISTERS.append(reg1)

            # m#[#] = t#
            elif parts[0] != "func" and re.search("^t.*[0-9]$", parts[2]): #check if hast pattern for t0 - t9
                next_inter_line = inter[i+1].split(' ')
                if len(next_inter_line) > 3:
                    if  next_inter_line[3] == "out_string" or next_inter_line[3] == "in_string" or next_inter_line[3] == "in_int" or next_inter_line[3] == "out_int":
                        next_inter_line = inter[i-1].split('=')
                        next_next_inter_line = inter[i+2].split(' ')
                        whut = next_inter_line[1]


                        printi_consola += "message" + str(conto) + ":" + "\n"
                        printi_consola += "\t.asciiz " + str(whut)  + "\n"

                        reg1 = REGISTERS.pop()
                        reg2 = REGISTERS.pop()
                        reg3 = REGISTERS.pop()
                        reg4 = REGISTERS.pop()

                        arm_code += "\tmove " + reg1 + ", #" + "1" + "\n"
                        arm_code += "\tmove " + reg2 + ", " + "=message" + str(conto) + "\n"
                        arm_code += "\tmove " + reg3 + ", #" + str(next_next_inter_line[1])  + "\n"
                        arm_code += "\tmove " + reg4 + ", #" + "4"  + "\n"
                        arm_code += "\tswi " + "0"  + "\n"
                        arm_code += "\tmove " + reg4 + ", #" + "1"  + "\n"
                        arm_code += "\tswi " + "0"  + "\n"
                        
                        conto += 1
                        REGISTERS.append(reg4)
                        REGISTERS.append(reg3)
                        REGISTERS.append(reg2)
                        REGISTERS.append(reg1)

                # !this is handled in if len(parts) == 5:
                # i += 1
                # continue

            # push param m#[#]
            elif parts[0] == 'push':
                i += 1
                continue

            # t# = ~m#[#]
            elif "~" in parts[2]:
                negatibe = parts[2].split('~')
                if re.search("^t.*[0-9]$", negatibe[1]):
                    num_ant = inter[i-1].split(' ')
                    if num_ant[2].isnumeric():
                        reg1 = REGISTERS.pop()
                        arm_code += "\tneg " + reg1 + ", #" + str(num_ant[2]) + "\n"
                        REGISTERS.append(reg1)
                    else:
                        reg1 = REGISTERS.pop()
                        arm_code += "\tneg " + reg1 + ", " + reg1 + "\n"
                        REGISTERS.append(reg1)

                    # i += 1
                    # continue
                else:
                    negatibe = getBracketsContent(negatibe[1])
                    reg1 = REGISTERS.pop()
                    arm_code += "\tneg " + reg1 + ", #" + str(negatibe) + "\n"
                    REGISTERS.append(reg1)
                    # i += 1
                    # continue             

            elif '"' in parts[2]:
                reg1 = REGISTERS.pop()
                arm_code += "\tmove " + reg1 + ", " + "=text" + str(contoText) + "\n"
                text_consola += "text" + str(contoText) + ":"
                text_consola += "\t.asciiz " + str(parts[2])  + "\n"
                contoText += 1
                REGISTERS.append(reg1)
            # m#[#] = m#[#]
            else:
                i += 1
                continue

        elif len(parts) == 4:

                # i += 1
                # continue

            # IfL m#[#]
            # check if next line is an let expression
            if parts[0] == 'IfL':
                operand = parts[1]
                reg1 = REGISTERS.pop()

                memory_address = getBracketsContent(operand)
                arm_code += "\tsw " + reg1 + ", " + str(memory_address) + "($sp)\n"

                numero = extractor(parts[3])
                arm_code += "\tbne .LBB0_" + numero + "\n"
                REGISTERS.append(reg1)

            # IfC m#[#]
            # check if next line is an let expression              
            elif parts[0] == 'IfC':
                operand = parts[1]
                reg1 = REGISTERS.pop()

                memory_address = getBracketsContent(operand)
                arm_code += "\tsw " + reg1 + ", " + str(memory_address) + "($sp)\n"

                numero = extractor(parts[3])
                arm_code += "\tbne .LBB0_" + numero + "\n"
                REGISTERS.append(reg1)

            elif parts[2] == "Bool":
                reg1 = REGISTERS.pop()
                arm_code += "\tmove " + reg1 + ", #" + str(parts[3]) + "\n"
                REGISTERS.append(reg1)



        elif len(parts) == 5:
            next_inter_line = inter[i+1].split(' ')
            if parts[3] == "+":
                #left_side = parts[0]
                first_operand = parts[2]
                second_operand = parts[4]

                arm_code += operationsFunction(first_operand,second_operand,'add',inter,i)
            
            elif parts[3] == "-":
                first_operand = parts[2]
                second_operand = parts[4]
                
                arm_code += operationsFunction(first_operand,second_operand,'sub',inter,i)

            elif parts[3] == "*":
                first_operand = parts[2]
                second_operand = parts[4]

                arm_code += operationsFunction(first_operand,second_operand,'mul',inter,i)

            elif parts[3] == "/":
                first_operand = parts[2]
                second_operand = parts[4]

                arm_code += operationsFunction(first_operand,second_operand,'div',inter,i)
            # IfZ
            # check if next line is an if expression
            elif next_inter_line[0] == 'IfZ':
                first_operand = parts[2]
                second_operand = parts[4]
                if parts[3] == "<" or parts[3] == "<=":
                    arm_code += ifStatementArmHandler(first_operand,second_operand,'<',inter,i)
                elif parts[3] == ">" or parts[3] == ">=":
                    arm_code += ifStatementArmHandler(first_operand,second_operand,'>',inter,i)
                elif parts[3] == "=": 
                    arm_code += ifStatementArmHandler(first_operand,second_operand,'==',inter,i)
                    
                i = i + 2

            # IfW
            # check if next line is a while expression
            elif next_inter_line[0] == 'IfW':
                first_operand = parts[2]
                second_operand = parts[4]
                if parts[3] == "<" or parts[3] == "<=":
                    arm_code += whileStatementArmHandler(first_operand,second_operand,'<',inter,i)
                elif parts[3] == ">" or parts[3] == ">=":
                    arm_code += whileStatementArmHandler(first_operand,second_operand,'>',inter,i)
                elif parts[3] == "=": 
                    arm_code += whileStatementArmHandler(first_operand,second_operand,'==',inter,i)
                    
                i = i + 1

            # IfW
            # check if next line is a let expression
            elif next_inter_line[0] == 'IfL':
                first_operand = parts[2]
                second_operand = parts[4]
                if parts[3] == "=": 
                    arm_code += letStatementArmHandler(first_operand,second_operand,'==',inter,i)
                i = i + 1

            # para llamada a metodos
            if parts[2] == '_MCall':
                push_param = inter[i-1].split(' ')
                param = inter[i-2].split(' ')

                if param[0] == 'param':
                    if 't' in param[1]:
                        para = inter[i-3].split(' ')
                        if len(para) >= 3:
                            if para[2] == 'allocate':
                                reg1 = REGISTERS.pop()
                                arm_code += "\tlw " + str(reg1) + ", =" + str(para[4])  + "\n"
                                if push_param[0] == "push":
                                    if  "[" in push_param[2]:
                                        reg2 = REGISTERS.pop()
                                        memory_address = getBracketsContent(push_param[2])
                                        arm_code += "\tsw " + reg2 + ", " + str(memory_address) + "($sp)\n"
                                        REGISTERS.append(reg2)                            
                                        REGISTERS.append(reg1)

                                else:
                                    REGISTERS.append(reg1)
                arm_code += "\tjal " + str(parts[3])  + "\n"

        arm_code_all += arm_code
        armct = arm_code.replace("\t","")
        list_temp = armct.split("\n")
        for codeline in list_temp:
            if len(codeline) > 0:
                armc.append(codeline)
        i += 1

    arm_code_all += printi_consola
    arm_code_all += text_consola
    return arm_code_all


def codeGenerator(inter):
    print("////////final code///////////")
    mips_code = ".text\n.globl main\n"

    # Elimina los caracteres de tabulación antes de dividir el texto en líneas
    inter = inter.replace('\t', '')
    inter = inter.split("\n")
    mips_code += read_lines(inter)

    return mips_code
