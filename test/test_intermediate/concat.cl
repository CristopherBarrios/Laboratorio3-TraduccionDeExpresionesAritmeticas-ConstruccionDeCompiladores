class Main{
      i : IO;
      input : String;
      concat : String;
      output : String;

      main(): Object {{
        input <- (i.in_string());
        concat <- (input.concat("Hola Mundo\n"));
        i.out_string(concat);
        (new Main).main();
      }};

};