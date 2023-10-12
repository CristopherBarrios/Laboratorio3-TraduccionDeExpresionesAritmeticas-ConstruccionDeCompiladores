  
 Main:    
 main:    
 func begin 0    
 	t0 = allocate byte_size Object    
 	param t0    
 	t1 = _MCall type_name, 0    
 	param t1    
 	t0 = 4    
 	push param t0    
 	t1 = 1    
 	push param t1    
 	t2 = _MCall substr, 2    
 	push param t2    
 	t1 = _MCall out_string, 1    
 	PopParams 1    
 	param t1    
 	t1 = isvoid SELF    
 	param t1    
 	t0 = _MCall type_name, 0    
 	param t0    
 	t1 = 1    
 	push param t1    
 	t0 = 3    
 	push param t0    
 	t1 = _MCall substr, 2    
 	push param t1    
 	t0 = _MCall out_string, 1    
 	t0 = allocate byte_size Object    
 	param t0    
 	t1 = _MCall type_name, 0    
 	param t1    
 	t0 = 4    
 	push param t0    
 	t1 = 1    
 	push param t1    
 	t0 = _MCall substr, 2    
 	push param t0    
 	t1 = _MCall out_string, 1    
 	PopParams 1    
 	t1 = isvoid SELF    
 	param t1    
 	t0 = _MCall type_name, 0    
 	param t0    
 	t1 = 1    
 	push param t1    
 	t0 = 3    
 	push param t0    
 	t1 = _MCall substr, 2    
 	t0 = "\n"    
 	push param t0    
 	t1 = _MCall out_string, 1    
 	PopParams 2    
 	t1 = allocate byte_size Main    
 	param t1    
 	t0 = _MCall main, 0    
 func end    
     
 class end    
     
     
   