class Main inherits IO {
  a: Int <- 4;
  b: Int <- 5;
  x: String <- "Hola mundo";
  
  suma(y : Int, k : Int) : Int { 
        y + k
  };
  main() : Object {
    {
      out_int(suma(a, b));
      out_string("\n");
      out_string(x);
    }
  };
};
