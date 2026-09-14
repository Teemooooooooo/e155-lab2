// Ellen Yu ellyu@g.hmc.edu Sep. 10 2026
// Top level containing the modules

module lab2_ey(
    input  logic [3:0]   s0, s1, c,
    input  logic         reset, enable, 
    output logic [6:0]   seg,
    output logic         a0, a1, // control which one is on
    output logic [3:0]   led
    // TODO: HARDWARE: corresponding pins of the 2 digits connected to the same pin
);
    logic       int_osc, digit_select;
    logic [3:0] s;
    logic [16:0]    digit_counter;
    HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));	

    // counter blinking at above 60 Hz would be enough to fool human eyes
    counter #(16,40000) counter(.clk(int_osc), .reset, .slow_clk(digit_select), .enable, .counter(digit_counter)); 
	
    // decides what input switch to use
    assign s = digit_select ? s0 : s1;
    // determine which digit lights up
    assign a0 = digit_select;
    assign a1 = ~ digit_select;
    seven_seg seven_seg(.s, .seg);

    // LED logic from input 
    assign led = ~ c;
    

    
    
endmodule