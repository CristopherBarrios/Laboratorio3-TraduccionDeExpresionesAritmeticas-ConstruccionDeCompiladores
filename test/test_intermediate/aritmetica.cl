class Other {
      g: String <- "Este es un ejemplo";
      h: Int <- 4;
      i: Int <- 5;
      j: Int <- 14;
      l: Int;
      sub(k:Int) : Int {{
         l <- (h - i - j + k);
      }};
  };


class Main {
      kill: Other <- new Other;
      otherKill: Other <- new Other;
      x: String <- "Hola mundo";
      a: Int <- 4;
      b: Int <- 5;
      c: Int <- 14;
      d: Int <- 100;
      z: Int <- 90 - (100+30);
      e: Bool <- true;
      f: Bool <- false;
      suma(y:Int, k:Int) : Int { y + k};
      main() : Object {{
         while not (a = b) loop  a <- c  pool;
         if not (a < b) then c <- (c + b) else c <- (d + b) fi;
         suma(a, b);
         a <- (kill.h());
         (new Main).main();
      }};
  };
