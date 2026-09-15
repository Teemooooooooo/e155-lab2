// Ellen Yu ellyu@g.hmc.edu Sep. 14 2026
// Testbench for the lab 2 top level
// exercises multiplexing functionality and LED driving functionality.

`timescale 1 ns/1 ns

module lab2_ey_tb();
  logic [3:0]     s0, s1, c;    // input signals of switches and read back from col
  logic           reset, enable;  // active high reset, enable
  logic [6:0]     seg;
  logic           a0, a1; // control which one is on
  logic [3:0]     led;
    lab2_ey dut (
        .reset(reset),
        .enable(enable),
        .s0, .s1, .c, .seg, .a0, .a1, .led
    );

  // apply stimuli and check outputs
  initial begin
    reset = 0;
    enable = 1;
    #22 reset = 1;

    // for each test case we setup the inputs, wait for the outputs to update,
    // and then check that the outputs match what we expect using `assert`
   
    // multiplexing functionality test
        s0[3:0] = ~4'b0000;                // input for s0
        s1[3:0] = ~4'b1111;                // input for s1
        #10;
        assert (a1 == 0)        // check outputs
            $display("PASSED! a1 is 0 at time: %0t.", $time);
        else 
            $error("FAILED! a1 is 1 at time: %0t.", $time); 
        assert (a0 == 1)        // check outputs
            $display("PASSED! a0 is 1 at time: %0t.", $time);
        else 
            $error("FAILED! a0 is 0 at time: %0t.", $time); 
        assert (seg == ~7'b1111110)        // check outputs
            $display("PASSED! The 7 segment display behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The 7 segment display behaves incorrectly at time: %0t.", $time); 

        // now it should switch
        #17000000;
        assert (a0 == 0)        // check outputs
            $display("PASSED! a0 is 0 at time: %0t.", $time);
        else 
            $error("FAILED! a0 is 1 at time: %0t.", $time); 
        assert (a1 == 1)        // check outputs
            $display("PASSED! a1 is 1 at time: %0t.", $time);
        else 
            $error("FAILED! a1 is 0 at time: %0t.", $time); 
        assert (seg == ~7'b1000111)          // check outputs
            $display("PASSED! The 7 segment display behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The 7 segment display behaves incorrectly at time: %0t.", $time); 
    
    
    // LED driving functionality test
        c[3:0] = 4'b0010;                // input from col
   
        #10;
        assert (led == 4'b1101)        // check outputs
            $display("PASSED! led is 1101 at time: %0t.", $time);
        else 
            $error("FAILED! led is %0b at time: %0t.", led, $time); 
        

        c[3:0] = 4'b1011;                // input from col
   
        #10;
        assert (led == 4'b0100)        // check outputs
            $display("PASSED! led is 0100 at time: %0t.", $time);
        else 
            $error("FAILED! led is %0b at time: %0t.", led, $time); 
         
    #100 $stop;
  end
endmodule