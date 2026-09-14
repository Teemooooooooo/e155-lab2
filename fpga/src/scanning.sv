// Ellen Yu ellyu@g.hmc.edu Sep. 10 2026
// Outputs {0001, 0010, 0100, 1000} rotating at 2 Hz

module scanning(
    input  logic        reset, enable,clk,
    output logic [3:0]  scan_out
);
    logic [20:0] count;
    logic  slow_clk;
    counter #(21, 1200000) scan_counter(.clk, .reset, .slow_clk, .enable, .counter(count)); 

    assign scan_out[0] = (count < 21'd300000);
    assign scan_out[1] = ((21'd300000 <= count) & (count < 21'd600000));
    assign scan_out[2] = ((21'd600000 <= count) & (count < 21'd900000));
    assign scan_out[3] = ((21'd900000 <= count) & (count <= 21'd1200000));
endmodule