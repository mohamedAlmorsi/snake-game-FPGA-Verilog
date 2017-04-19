module Controller(x,y,z,w,h, direction, reset);
	
	input  x,y,z,w,h;
	output reg [2:0] direction;
	output reg reset =0; 

	always@(x,y,z,w,h)
begin
	 if(h)
		begin
			reset = 1;
			direction =3'b111;
		end
	else  
			begin
			reset =0 ;
			if(~x)
			direction = 3'b001;
			
			else if(~y)
			direction = 3'b010;
			
			else if(~z)
			 direction = 3'b011;
			else if(~w)
			direction = 3'b100;
			else  
			direction <= direction;
	end	
end
endmodule