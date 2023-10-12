  
 Factorial:    
 	F0[0] = 0    
 factorial:    
 func begin 4    
 	LET lf0[0] Goto START_LET_L1    
 START_LET_L1:    
 	t0 = 0    
 	t1 = f0[0] = t0    
 	IfZ t1 Goto L0    
 	Goto L1    
 L0:    
 	t1 = 0    
 	lf0[0] = t1    
 	Goto L_END_IF    
 L1:    
 	t0 = 1    
 	t2 = f0[0] = t0    
 	IfZ t2 Goto L2    
 	Goto L3    
 L2:    
 	t2 = 1    
 	lf0[0] = t2    
 	Goto L_END_IF    
 L3:    
 	t0 = 1    
 	t3 = f0[0] - t0    
 	push param t3    
 	t0 = _MCall factorial, 1    
 	t0 = f0[0] * t0    
 	lf0[0] = t0    
 L_END_IF    
 L_END_IF    
 L_END_LET    
 func end    
     
 class end    
     
     
 Fibonacci:    
 fibonacci:    
 func begin 4    
 	LET lf1[0] Goto START_LET_L2    
 START_LET_L2:    
 	t0 = 1    
 	t4 = f1[0] = t0    
 	IfZ t4 Goto L4    
 	Goto L5    
 L4:    
 	t4 = 1    
 	lf1[0] = t4    
 	Goto L_END_IF    
 L5:    
 	t0 = 2    
 	t5 = f1[0] = t0    
 	IfZ t5 Goto L6    
 	Goto L7    
 L6:    
 	t5 = 1    
 	lf1[0] = t5    
 	Goto L_END_IF    
 L7:    
 	t0 = 1    
 	t6 = f1[0] - t0    
 	push param t6    
 	t0 = _MCall fibonacci, 1    
 	t7 = 2    
 	t8 = f1[0] - t7    
 	push param t8    
 	t7 = _MCall fibonacci, 1    
 	t9 = t0 + t7    
 	lf1[0] = t9    
 L_END_IF    
 L_END_IF    
 L_END_LET    
 func end    
     
 class end    
     
     
 Main:    
 	M2[0] = 10    
 main:    
 func begin 0    
 	t0 = allocate byte_size Factorial    
 	M2[4] = t0    
 	t7 = allocate byte_size Fibonacci    
 	M2[4] = t7    
 	param M2[4]    
 	push param M2[0]    
 	t10 = _MCall fibonacci, 1    
 	push param t10    
 	t10 = _MCall out_int, 1    
 	PopParams 1    
 	t10 = allocate byte_size Main    
 	param t10    
 	t11 = _MCall main, 0    
 func end    
     
 class end    
     
     
   