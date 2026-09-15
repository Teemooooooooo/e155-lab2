// Ellen Yu ellyu@g.hmc.edu Sep. 10 2026
// Outputs {0001, 0010, 0100, 1000} rotating at 2 Hz

module scanning(
    input  logic        reset, enable,clk,
    output logic [3:0]  scan_out
);
    logic [20:0] count;
    logic  slow_clk;
    counter #(21, 12000000) scan_counter(.clk, .reset, .slow_clk, .enable, .counter(count)); 

    assign scan_out[0] = (count < 21'd3000000);
    assign scan_out[1] = ((21'd3000000 <= count) & (count < 21'd6000000));
    assign scan_out[2] = ((21'd6000000 <= count) & (count < 21'd9000000));
    assign scan_out[3] = ((21'd9000000 <= count) & (count <= 21'd12000000));
endmodule