module snake(start, master_clk, DAC_clk, VGA_R, VGA_G, VGA_B, VGA_hSync, VGA_vSync, blank_n,x,y,z,w,h ,seg1,seg2);
	
	input master_clk, x,y,z,w,h; 
	output reg [7:0]VGA_R, VGA_G, VGA_B;
   
	output VGA_hSync, VGA_vSync, DAC_clk, blank_n; 
	wire [9:0] xCount; 
	wire [9:0] yCount; 
	wire displayArea; 
	wire VGA_clk;
	wire R;
	wire G;
	wire B;
	wire snakeHead,snakeBody ;
	wire  game_over;
	reg  border; 
	wire apple ;

output wire [6:0]seg1;
output wire [6:0]seg2;
	input start;

	wire update;
	collision col(snakeBody,snakeHead,border,game_over,VGA_clk,update,start,xCount,yCount,x,y,z,w,h,apple,seg1,seg2);
	VGA_Controller VGA(VGA_clk, xCount, yCount, displayArea, VGA_hSync, VGA_vSync, blank_n);
	Clks_Generator CLKs(master_clk, update,VGA_clk);
	
	assign DAC_clk = VGA_clk;
	
	

	
	always @(posedge VGA_clk) 
	begin
		border <= (((xCount >= 0) && (xCount < 31) || (xCount >= 610) && (xCount < 641)) || ((yCount >= 0) && (yCount < 31) || (yCount >= 450) && (yCount < 481)));
	end


							
	assign R = (displayArea && ( apple || game_over));
	assign G = (displayArea && ((snakeBody || snakeHead || border)&& ~game_over));
	assign B = (displayArea && ~game_over);
	always@(posedge VGA_clk)
	begin
		VGA_R = {8{R}};
		VGA_G = {8{G}};
		VGA_B = {8{B}};
	end 

endmodule
