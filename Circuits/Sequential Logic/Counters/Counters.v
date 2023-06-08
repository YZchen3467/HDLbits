/*Counters*/
//Four-bit binary counter
module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
	
	always@(posedge clk) begin
		if(reset || q == 4'hf)
			q <= 4'd0;
		else
			q <= q + 1'b1;
	end	
	
endmodule

////////////////////////////

//Decade counter
module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
	
	always@(posedge clk) begin
		if(reset || q == 4'h9)
			q <= 4'd0;
		else 
			q <= q + 1'b1;
	end
	
endmodule

//////////////////////////////

//Decade counter again
module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
	
	always@(posedge clk) begin
		if(reset || q == 4'ha)
			q <= 4'd1;
		else 
			q <= q + 1'b1;
	end
	
endmodule

/////////////////////////////

//Show decade counter
module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
	
	always@(posedge clk) begin
		if(reset)
			q <= 4'd0;
		else if(slowena) begin
			if(q == 4'd9)
				q <= 4'd0;
			else
				q <= q + 1'b1;
		end
	end	
	
endmodule

<<<<<<< HEAD
//////////////////////////////

//Counter 1-12
=======
/////////////////////////////////

//Counter 1-12 (important)
module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); 
	
	assign c_enable = enable;
    assign c_load = reset || ((Q == 4'd12) && enable == 1'b1);
    assign c_d = c_load ? 4'd1 : 4'd0;
    
	count4 the_counter (clk, c_enable, c_load, c_d, Q);
	
endmodule
//need to comfirm this problem

/////////////////////////////////

//Counter 1000
=======
); 
	
    assign c_enable = enable;
    assign c_load = reset || ((Q == 4'd12) && (enable == 1'b1));
    assign c_d = c_load ? 4'd1 : 4'd0;
   
    count4 the_counter (clk, c_enable, c_load, c_d, Q);

endmodule

//////////////////////////////////

//Counter 1000 (important)
module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);
	wire [3:0] Q0, Q1, Q2;
	
    bcdcount counter0 (clk, reset, c_enable[0], Q0);
    bcdcount counter1 (clk, reset, c_enable[1], Q1);
	bcdcount counter1 (clk, reset, c_enable[2], Q2);
	
	assign c_enable[0] = ~reset;
	assign c_enable[1] = ~reset && (Q0 == 4'd9);
	assign c_enable[2] = ~reset && (Q0 == 4'd9) && (Q1 == 4'd9);
	
	assign OneHertz = (Q0 == 4'd9) && (Q1 == 4'd9) && (Q2 == 4'd9) ? 1'b1 : 1'b0;
endmodule

////////////////////////////////////

//4-digit decimal counter
module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    always@(posedge clk)begin
        if(reset)begin
            q <= 'd0;
        end
        else if(q[3:0] != 'd9)begin
            q[3:0] <= q[3:0] + 1'b1;
        end
        else begin
            q[3:0] <= 'd0;
            q[7:4] <= q[7:4] + 1'b1;
            if(q[7:4] == 'd9)begin
                q[7:4] <= 'd0;
                q[11:8] <= q[11:8] + 'd1;
                if(q[11:8] == 'd9)begin
                    q[11:8] <= 'd0;
                    q[15:12] <= q[15:12] + 'd1;
                    if(q[15:12] == 'd9)begin
                        q[15:12] <= 'd0;
                    end
                end
            end
        end
    end
    assign ena[1] = q[3:0] == 4'd9;
    assign ena[2] = q[7:4] == 4'd9 && q[3:0] == 4'd9; 
    assign ena[3] = q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9; 
endmodule

////////////////////////////////////

//12-hour clock
module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss);

    reg p;	//0 was am, 1 was pm
    reg [7:0] h;
    reg [7:0] m;
    reg [7:0] s;
    
	always@(posedge clk) begin
		if(reset) begin
			h <= 8'h12;
			m <= 8'h0;
			s <= 8'h0;
			p <= 1'b0;
		end	
		else begin
			if(ena) begin
				if(s < 8'h59) begin
					if(s[3:0] < 4'h9) begin
						s[3:0] <= s[3:0] + 1'h1;
					end
					else begin
					s[3:0] <= 4'h0;
					s[7:4] <= s[7:4] + 1'h1;
					end
				end
				else begin
					s <= 8'h0;
					if(m < 8'h59) begin
						if(m[3:0] < 4'h9) begin
							m[3:0] <= m[3:0] + 1'h1;
						end
						else begin
							m[3:0] <= 4'h0;
							m[7:4] <= m[7:4] + 1'h1;
						end
					end
					else begin
						m <= 8'h0;
						if(h == 8'h11)
							p = ~p;
                        if(h < 8'h12) begin
							if(h[3:0] < 4'h9)
								h[3:0] <= h[3:0] + 1'h1;
							else begin
								h[3:0] <= 4'h0;
								h[7:4] <= h[7:4] + 1'h1;
							end	
						end
						else begin
							h <= 1'h1;
						end
					end
				end
			end
		end
	end	
	
    assign pm = p;
    assign hh = h;
    assign mm = m;
    assign ss = s;
    
endmodule
