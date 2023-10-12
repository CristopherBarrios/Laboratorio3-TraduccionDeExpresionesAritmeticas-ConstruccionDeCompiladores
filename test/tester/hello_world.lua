  
 Main:    
 main:    
 func begin 0    
 	t0 = "Hello, World.\n"    
 	push param t0    
 	t1 = _MCall out_string, 1    
 	PopParams 15    
 	t1 = allocate byte_size Main    
 	param t1    
 	t2 = _MCall main, 0    
 func end    
     
 class end    
     
     
   