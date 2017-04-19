module collision(snakeBody,snakeHead,border,game_over,VGA_clk,update,start,xCount,yCount,x,y,z,w,h,apple,seg1,seg2);
	input border,VGA_clk,update,start,xCount,yCount,x,y,z,w,h;
	output  snakeBody,snakeHead,game_over,apple;
	
	wire apple ,snakeBody,snakeHead ;
	reg game_over;
	reg good_collision, bad_collision;
	wire [9:0] xCount;
	wire [9:0] yCount;
	output reg[6:0] seg1;
	reg azab = 1; 
	
	output reg[6:0] seg2;
	
	 reg [4:0] size =1;
	snake_body snake(update,start,VGA_clk,snakeHead,snakeBody,xCount,yCount,x,y,z,w,h,size);
	Apple app(VGA_clk,good_collision,apple,start,xCount,yCount,update);

	reg lethal, nonLethal ;
	always @(posedge VGA_clk) lethal = (border|| snakeBody)&& snakeHead ;
	always @(posedge VGA_clk) nonLethal = apple && snakeHead && azab;

	
	wire [4:0] check_size ;
	assign check_size = (size-1) ;
always @(check_size) 
begin 

if(check_size<=9)
		seg2 <= ~7'b0111111;
else if(check_size[4:3] ==2'b01)
		seg2 <= ~7'b0000110;

else if(check_size[4:3] ==2'b10)
		seg2 <= ~7'b1011011;

else  
		seg2 <= ~7'b1001111;

case (check_size[3:0] )
		0 : seg1 <= ~7'b0111111;
		1 : seg1 <= ~7'b0000110;
		2 : seg1 <= ~7'b1011011;
		3 : seg1 <= ~7'b1001111;
      4 : seg1 <= ~7'b1100110;
		5 : seg1 <= ~7'b1101101;
		6 : seg1 <= ~7'b1111101;
		7 : seg1 <= ~7'b0000111;
		8 : seg1 <= ~7'b1111111;
		9 : seg1 <= ~7'b1101111;
		default : seg1 <= ~7'bX;
endcase

end

	
	always @(posedge VGA_clk) 
											if(nonLethal) begin 
													good_collision<=1;
													size = size+1;
													azab=0 ;
																end
											else if(~start) size = 1;										
												else 	begin 
												good_collision=0; azab =1 ; 
													end 
										

	always @(posedge VGA_clk) if(lethal) bad_collision=1;
										else bad_collision=0;
	always @(posedge VGA_clk) if(bad_collision) game_over<=1;
										else if(~start) game_over=0;
										
	
									

endmodule
