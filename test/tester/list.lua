  
 List:    
 isNil:    
 func begin 0    
 	t0 = Bool 1    
 func end    
     
 head:    
 func begin 0    
 	t0 = _MCall abort, 0    
 	t0 = 0    
 func end    
     
 tail:    
 func begin 0    
 	t1 = _MCall abort, 0    
 func end    
     
 cons:    
 func begin 4    
 	t1 = allocate byte_size Cons    
 	param t1    
 	push param c3[0]    
 	push param SELF    
 	t2 = _MCall init, 2    
 func end    
     
 class end    
     
     
 Cons:    
 isNil:    
 func begin 0    
 	t1 = Bool 0    
 func end    
     
 head:    
 func begin 0    
 func end    
     
 tail:    
 func begin 0    
 func end    
     
 init:    
 func begin 4    
 	C1[0] = i7[0]    
 	C1[4] = i7[4]    
 func end    
     
 class end    
     
     
 Main:    
 print_list:    
 func begin 0    
 	param p8[0]    
 	t1 = _MCall isNil, 0    
 	IfZ t1 Goto L0    
 	Goto L1    
 L0:    
 	t1 = "\n"    
 	push param t1    
 	t1 = _MCall out_string, 1    
 	PopParams 2    
 	Goto L_END_IF    
 L1:    
 	param p8[0]    
 	t1 = _MCall head, 0    
 	push param t1    
 	t1 = _MCall out_int, 1    
 	PopParams 1    
 	t1 = " "    
 	push param t1    
 	t2 = _MCall out_string, 1    
 	PopParams 1    
 	param p8[0]    
 	t2 = _MCall tail, 0    
 	push param t2    
 	t2 = _MCall print_list, 1    
 L_END_IF    
 func end    
     
 main:    
 func begin 0    
 	t2 = allocate byte_size List    
 	param t2    
 	t3 = 1    
 	push param t3    
 	t4 = _MCall cons, 1    
 	param t4    
 	t3 = 2    
 	push param t3    
 	t2 = _MCall cons, 1    
 	param t2    
 	t3 = 3    
 	push param t3    
 	t4 = _MCall cons, 1    
 	param t4    
 	t3 = 4    
 	push param t3    
 	t2 = _MCall cons, 1    
 	param t2    
 	t3 = 5    
 	push param t3    
 	t4 = _MCall cons, 1    
 	M2[0] = t4    
 L2:    
 	param M2[0]    
 	t3 = _MCall isNil, 0    
 	t3 = not t3    
 	IfW t3 Goto L3    
 	Goto L_END_WHILE    
 L3:    
 	push param M2[0]    
 	t3 = _MCall print_list, 1    
 	param M2[0]    
 	t3 = _MCall tail, 0    
 	M2[0] = t3    
 	Goto L2    
 L_END_WHILE    
 	t3 = allocate byte_size Main    
 	param t3    
 	t3 = _MCall main, 0    
 func end    
     
 class end    
     
     
   