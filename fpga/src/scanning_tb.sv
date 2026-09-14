// Ellen Yu ellyu@g.hmc.edu Sep. 14 2026
// Testbench for the scanning module
// demonstrates all four output transitions, enable and reset features.

`timescale 1 ns/1 ns

module scanning_tb();
  logic           clk;    // system clock
  logic           reset, enable;  // active high reset, enable
  logic [3:0]     scan_out;      // 4 bit output

    scanning dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .scan_out(scan_out)
    );

  // generate clock
  always begin
      clk = 0; #5;
      clk = 1; #5;
  end

  // apply stimuli and check outputs
  initial begin
    reset = 0;
    enable = 1;
    #22 reset = 1;

    // for each test case we setup the inputs, wait for the outputs to update,
    // and then check that the outputs match what we expect using `assert`
   
    // testing reset behavior
        #50;
        reset = 1'b0;
        #20;
        assert (dut.counter == 24'b0)
            $display("PASSED! Counter resetted as expected at time: %0t.", $time);
        else 
            $error("FAILED! Counter behaves incorrectly at time: %0t.", $time); 
        
        assert (scan_out == 4'b0001)
            $display("PASSED! output shows 0001 as expected at time: %0t.", $time);
        else 
            $error("FAILED! output is %0d, incorrect at time: %0t.", dut.count, $time); 

    // testing enable behavior (off)
        enable = 1'b0;
        reset = 1'b0;
        #10;
        reset = 1'b1;
        #50;
        assert (dut.count == 21'b0)
            $display("PASSED! Counter did not increment at time: %0t.", $time);
        else 
            $error("FAILED! Counter behaves incorrectly at time: %0t.", $time); 
        
        assert (scan_out == 4'b0001)
            $display("PASSED! output is 0001 as expected: %0t.", $time);
        else 
            $error("FAILED! output behaves incorrectly at time: %0t.", $time); 
        
    // testing enable behavior (on)
        enable = 1'b1;
        reset = 1'b0;
        #10;
        reset = 1'b1;
        #50;
        assert (dut.count == 21'b101)
            $display("PASSED! Counter did increment at time: %0t.", $time);
        else 
            $error("FAILED! Counter behaves incorrectly at time: %0t.", $time); 
        
        assert ( scan_out == 4'b0001)
            $display("PASSED! output is 0001 as expected: %0t.", $time);
        else 
            $error("FAILED! output behaves incorrectly at time: %0t.", $time); 

    // testing all 4 state behaviors 
    // starting with 0010 (0001 already tested above)
        reset = 1'b0;
        #10;
        reset = 1'b1;
        #300000; // counter get to 300000
		assert (dut.count == 21'b300000)
            $display("PASSED! Counter got back to zero as expected: %0t.", $time);
        else
            $display("FAILED! Counter has %0d at time: %0t.", dut.counter, $time);
		
        assert (scan_out == 4'b0010)
            $display("PASSED! output is 0010 as expected: %0t.", $time);
        else
            $display("FAILED! incorrect output behavior %0d at time: %0t.", scan_out, $time);
    
    // case: 0100
        #300000;
        assert (scan_out == 4'b0100)
            $display("PASSED! output is 0100 as expected at counter %0d: %0t.", dut.count, $time);
        else
            $display("FAILED! incorrect output behavior %0d at time: %0t.", scan_out, $time);

    // case: 1000
        #300000;
        assert (scan_out == 4'b1000)
            $display("PASSED! output is 1000 as expected at counter %0d: %0t.", dut.count, $time);
        else
            $display("FAILED! incorrect output behavior %0d at time: %0t.", scan_out, $time);

    // counter go back to 0
        #300000;
        assert (dut.counter == 24'b0)
            $display("PASSED! Counter resetted as expected at time: %0t.", $time);
        else 
            $error("FAILED! Counter behaves incorrectly at time: %0t.", $time); 
        
        assert (scan_out == 4'b0001)
            $display("PASSED! output shows 0001 as expected at time: %0t.", $time);
        else 
            $error("FAILED! output is %0d, incorrect at time: %0t.", dut.count, $time); 
    #100 $stop;
  end
endmodule