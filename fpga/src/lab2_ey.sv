// Ellen Yu ellyu@g.hmc.edu Sep. 10 2026
// Top level containing the modules

module lab2_ey(
    input  logic [3:0]   s0, s1,
    input  logic         reset, enable, 
    output logic [6:0]   seg,
    output logic         digit_select // control which one is on
    // TODO: HARDWARE: add a not gate somewhere to connect to the other annode?
    // TODO: HARDWARE: corresponding pins of the 2 digits connected to the same pin
);
    logic       int_osc;
    logic [3:0] s;
    HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));	

    // TODO: figure out what size counter need to be and what speed to blink at
    counter #(1,1) counter(.clk(int_osc), .reset, .slow_clk(digit_select), .enable); 
	
    // decides what input switch to use
    assign s = digit_select ? s0 : s1;
    seven_seg seven_seg(.s, .seg);
    

    
    
endmodule