module snake_body(update,start,VGA_clk,snakeHead,snakeBody,xCount,yCount,x,y,z,w,h,size);
	input update , start,VGA_clk,xCount,yCount,x,y,w,z,h,size;
	wire[4:0] size ;
	wire reset ;
	output  snakeHead,snakeBody;
	reg [9:0] snakeX[0:31];
	reg [8:0] snakeY[0:31];
	reg [9:0] snakeHeadX;
	reg [9:0] snakeHeadY;
	integer  count1, count2, count3;
	reg snakeHead;
	reg snakeBody;
	wire [9:0] xCount;
	wire [9:0] yCount;
	wire [2:0] direction;
	Controller cont(x,y,z,w,h, direction, reset);
	always@(posedge update)
	begin
	if(start)
	begin
		if(direction != 3'b111)begin
		for(count1 = 31; count1 > 0; count1 = count1 - 1)
			begin
				if(count1 <= size - 1)
				begin
					snakeX[count1] = snakeX[count1 - 1];
					snakeY[count1] = snakeY[count1 - 1];
				end
			end
			end
		case(direction)
			3'b001: snakeY[0] <= (snakeY[0] - 10);
			3'b010: snakeX[0] <= (snakeX[0] - 10);
			3'b011: snakeY[0] <= (snakeY[0] + 10);
			3'b100: snakeX[0] <= (snakeX[0] + 10);
			3'b111:begin snakeX[0] <= snakeX[0];
			snakeY[0] <= snakeY[0]; end 
			endcase	
		end
	else if(~start)
	begin
		for(count3 = 1; count3 < 32; count3 = count3+1)
			begin
			snakeX[count3] = 700;
			snakeY[count3] = 500;
			end
			snakeX[0] = 300;
			snakeY[0] = 300;
	end
	
	end
	
	
	
	
	
	always@(posedge VGA_clk)
	begin
	
		snakeBody =0 ;
		
		for(count2 = 1; count2 < size; count2 = count2 + 1)
		begin
				
			if(snakeBody ==0 )
			snakeBody = ((xCount > snakeX[count2] && xCount < snakeX[count2]+10) && (yCount > snakeY[count2] && yCount < snakeY[count2]+10));
		
		
		end
	end


	
	always@(posedge VGA_clk)
	begin	
		snakeHead = (xCount > snakeX[0] && xCount < (snakeX[0]+10)) && (yCount > snakeY[0] && yCount < (snakeY[0]+10));
	end
	

endmodule 