module random_apple(VGA_clk, rand_X, rand_Y,update);
	input VGA_clk, update ;
	output reg [9:0]rand_X= 70;
	output reg [8:0]rand_Y=90;
	
	
	always@(posedge VGA_clk)
	begin
	rand_X= rand_X +30;
	if(rand_X >= 570)
		begin
		rand_X = 40 ;
		end
	end
	
	always @(posedge update)
	begin
	rand_Y=rand_Y+20 ;
	if(rand_Y >= 400)
		begin
		rand_Y = 40 ;
		end
	end
	
	

	
	
endmodule
