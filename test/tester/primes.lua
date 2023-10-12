  
 Main:    
 	t0 = "2 is trivially prime.\n"    
 	push param t0    
 	t1 = _MCall out_string, 1    
 	PopParams 23    
 	t1 = 2    
 	M0[4] = M0[0]    
 	M0[12] = 500    
 main:    
 func begin 0    
 L0:    
 	t2 = Bool 1    
 	IfW t2 Goto L1    
 	Goto L_END_WHILE    
 L1:    
 	t2 = 1    
 	t2 = M0[4] + t2    
 	M0[4] = t2    
 	t2 = 2    
 	M0[8] = t2    
 L2:    
 	t3 = M0[8] * M0[8]    
 	t4 = M0[4] < t3    
 	IfZ t4 Goto L3    
 	Goto L4    
 L3:    
 	t4 = Bool 0    
 	Goto L_END_IF    
 L4:    
 	t4 = M0[4] / M0[8]    
 	t3 = M0[8] * t4    
 	t4 = M0[4] - t3    
 	t3 = 0    
 	t5 = t4 = t3    
 	IfZ t5 Goto L5    
 	Goto L6    
 L5:    
 	t5 = Bool 0    
 	Goto L_END_IF    
 L6:    
 	t5 = Bool 1    
 L_END_IF    
 L_END_IF    
 	IfW 0 Goto L7    
 	Goto L_END_WHILE    
 L7:    
 	t5 = 1    
 	t4 = M0[8] + t5    
 	M0[8] = t4    
 	Goto L2    
 L_END_WHILE    
 	t5 = M0[8] * M0[8]    
 	t3 = M0[4] < t5    
 	IfZ t3 Goto L8    
 	Goto L9    
 L8:    
 	M0[0] = M0[4]    
 	push param M0[0]    
 	t3 = _MCall out_int, 1    
 	PopParams 1    
 	t3 = " is prime.\n"    
 	push param t3    
 	t5 = _MCall out_string, 1    
 	PopParams 12    
 	Goto L_END_IF    
 L9:    
 	t5 = 0    
 L_END_IF    
 	t6 = M0[12] <= M0[4]    
 	IfZ t6 Goto L10    
 	Goto L11    
 L10:    
 	t6 = "halt"    
 	param t6    
 	t7 = _MCall abort, 0    
 	Goto L_END_IF    
 L11:    
 	t6 = "continue"    
 L_END_IF    
 	Goto L0    
 L_END_WHILE    
 	t7 = allocate byte_size Main    
 	param t7    
 	t8 = _MCall main, 0    
 func end    
     
 class end    
     
     
   