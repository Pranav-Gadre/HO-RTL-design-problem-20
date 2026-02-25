module async_reset (
  input    wire       clk,
  input    wire       reset,

  output   wire       release_reset_o,
  output   wire       gate_clk_o

);

  // Write your logic here...
	reg [4:0] count;
	reg [4:0] count_store;
	reg       release_reset;
	reg       gate_clk;
	
	assign release_reset_o = release_reset;
	assign gate_clk_o      = gate_clk;
	
	always @ (posedge clk or posedge reset) begin 
		if (reset) begin 
			count_store <= 0;
		end else begin 
			count_store <= count;
		end 
	end
	
	always @ (*) begin  
		if (count_store < 20) 
			count = count_store + 1;
		else 
			count = count_store;
	end 
	
	always @ (*) begin 
		if (count >= 11) begin 
			release_reset = 1;
		end else if (count < 11) begin 
			release_reset = 0;
		end else begin 
			release_reset = 1;
		end 
	end 
	
	always @ (*) begin 
		if (count < 5) begin 
			gate_clk = 0;
		end else if (count < 18) begin 
			gate_clk = 1;
		end else if (count >= 18) begin 
			gate_clk = 0;
		end else begin 
			gate_clk = 0;
		end 
	end 

endmodule
