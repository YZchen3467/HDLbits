/*Procedures*/
//Always blocks(combinational)
module top_module(	input a, b,
					output wire out_assign,
					output reg out_alwaysblock);
	
	assign out_assign = a & b;
	
	always@(*) out_alwaysblock = a & b;
endmodule

//////////////////////

//Always blocks(clocked)
module top_module(	input a, b, clk,
					output wire out_assign,
					output reg out_always_comb,
					output reg out_always_ff);
	
	assign out_assign = a^b;
	
	always@(*) out_always_comb = a^b;//blocking mean: when this part have finished, next part will be excuted.
	
	always@(posedge clk) out_always_ff <= a^b; //non-blocking mean: Synchronize excute
endmodule

///////////////////////

//if stament
module top_module(	input a, b, sel_b1, sel_b2,
					output wire out_assign,
					output reg out_always);
	
	assign out_assign = (sel_b1 == 1 && sel_b2 == 1) ? b:a;

	always@(*) begin
		if (sel_b1 == 1 && sel_b2 == 1) begin
			out_always = b;
		end
		else begin
			out_always = a;
		end
	end
endmodule

//////////////////////

//if stament latches
module top_module (	input cpu_overheated,
					output reg shut_off_computer,
					input arrived,
					input gas_tank_empty,
					output reg keep_driving); 
	always@(*) begin
        if (cpu_overheated) begin
			shut_off_computer = 1;
		end
		else begin
			shut_off_computer = 0;
		end
    end
		
	always@(*) begin
        if (~arrived) begin
			keep_driving = ~gas_tank_empty;
		end
		else begin
			keep_driving = 0;
		end
    end
endmodule

///////////////////////

//Case stament
module top_module(	input [2:0] sel,
					input [3:0] data0,
					input [3:0] data1,
					input [3:0] data2,
					input [3:0] data3,
					input [3:0] data4,
					input [3:0] data5,
					output [3:0] out);
		
	always@(*) begin
		case(sel)
			3'b000: begin
						out = data0;
					end
			3'b001: begin
						out = data1;
					end
			3'b010: begin
						out = data2;
					end
			3'b011: begin
						out = data3;
					end
			3'b100: begin
						out = data4;
					end
			3'b101: begin
						out = data5;
					end		
			default: out = 0;
		endcase
	end
endmodule
