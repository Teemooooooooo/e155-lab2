// Ellen Yu ellyu@g.hmc.edu Sep. 10 2026
// TODO: Outputs {0001, 0010, 0100, 1000} rotating at 2 Hz

module scanning(
    input  logic        reset, enable,clk,
    output logic [3:0]  scan_out
);
    //TODO: calculation to get 2 Hz
    counter #() scan_counter(.clk, .reset, .slow_clk(), .enable); 

    assign scan_out = 
endmodule