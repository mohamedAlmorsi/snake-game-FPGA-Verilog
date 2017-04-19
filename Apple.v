module Apple(VGA_clk,good_collision,apple,start,xCount,yCount,update);
	
	input VGA_clk , good_collision,start,xCount,yCount,update;
	output reg apple ;
	reg [9:0] appleX;
	reg [8:0] appleY;
	reg apple_inX;
	reg apple_inY;
	wire [9:0]rand_X;
	wire [8:0]rand_Y;
	wire [9:0] xCount;
	wire [9:0] yCount;
	random_apple salem(VGA_clk, rand_X, rand_Y,update);
	always@(VGA_clk)
	begin
		if(good_collision)
		begin
			appleX=rand_X;
			appleY=rand_Y;
		end
		if(~start)
		begin
		appleX=rand_X;
		appleY=rand_Y;
		end
		
	 end
	
	always @(posedge VGA_clk)
	begin
		apple_inX <= (xCount > appleX && xCount < (appleX + 10));
		apple_inY <= (yCount > appleY && yCount < (appleY + 10));
		apple = apple_inX && apple_inY;
	end
	

endmodule 