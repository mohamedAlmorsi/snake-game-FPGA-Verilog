module Clks_Generator(master_clk, update,VGA_clk);
	input master_clk;
	output reg update,VGA_clk;
	reg [21:0]count;	
	reg q;

	always@(posedge master_clk)
	begin
		count <= count + 1;
		if(count == 2000000)
		begin
			update <= ~update;
			count <= 0;
		end	
	end
	
	
	always@(posedge master_clk)
	begin
		q <= ~q; 
		VGA_clk <= q;
	end
	
	
endmodule