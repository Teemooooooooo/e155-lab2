// Ellen Yu ellyu@g.hmc.edu Sep. 10 2026
// This module that takes in a clk input and outputs a signal at lower frequency

module counter #(parameter COUNTER_SIZE = 25, MAX_THRESHOLD = 24'd10000000)(
	input   logic 		clk, reset, enable,
	output  logic 		slow_clk,
	output  logic 		[COUNTER_SIZE-1:0] counter
	);

	// Simple clock divider
	always_ff @(posedge clk)
		if (~reset)
			begin
				slow_clk <= 0;
				counter <= 0;
			end
		else
			if (enable)
				if (counter == (MAX_THRESHOLD - 1)) 
					begin
						counter <= 0;
						slow_clk 	<= ~slow_clk;
					end
				else
					begin
						counter <= counter + 1;
						slow_clk <= slow_clk;
					end
	

endmodule