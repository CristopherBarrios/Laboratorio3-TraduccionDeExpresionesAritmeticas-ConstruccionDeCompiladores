class Main {
      i : IO <- new IO;
      count : Int <- 0;
      input : Int;
      ant : Int <- 1;
      lat : Int <- 0;
      output : Int;

      main(): IO {{
        input <- (i.in_int());
        while (count<input) loop {
            output <- (lat + ant);
            lat <- ant;
            ant <- output;
            count <- (count + 1);
            
        } pool;
        (i.out_int(output));
        (new Main).main();
        
      }};

};