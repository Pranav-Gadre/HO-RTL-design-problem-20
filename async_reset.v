module async_reset (
  input    wire       clk,
  input    wire       reset,

  output   wire       release_reset_o,
  output   wire       gate_clk_o

);

  // Write your logic here...
	reg [2:0] count;
	reg [2:0] count_b;
	reg       release_reset;
	
	assign release_reset_o = release_reset;
	assign gate_clk_o      = release_reset & clk;
	
	always @ (posedge clk or posedge reset) begin 
		if (reset) begin 
			if (count >= 0) 
				count <= (clk & (count <= 7)) ? count + 1 : count;
			else 
				count <= 0;
			count_b <= 0;
		end else begin 
			count <= 0;
			if (count_b <= 7)
				count_b <= count_b + 1;
			else 
				count_b <= count_b;
		end 
	end 
	
	always @ (posedge clk or posedge reset) begin 
		if (reset) begin 
			release_reset <= (count >= 4) ? 0 : 1;
		end else begin 
			release_reset <= (count_b == 7) ? 1 : 0;
		end 
	end 

endmodule
