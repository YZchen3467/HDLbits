/*Module*/
//Modules
module top_module(input a, b,
					output out);
    mod_a instance1 (.in1(a), .in2(b), .out(out));
endmodule

//////////////////////

//Connecting ports by position
module top_module(input a, b, c, d,
					output out1, out2);
    mod_a inist1 (out1, out2, a, b, c, d);			
endmodule

/////////////////////

//Connecting ports by name
module top_module(input a, b, c, d,
					output out1, out2);
    mod_a inist1 (.out1(out1), .out2(out2), .in1(a), .in2(b), .in3(c), .in4(d));			
endmodule

/////////////////////

//Three module
module top_module(input clk, d, 
					output q);
	wire q1;
	wire q2;
	my_dff d1 (clk, d, q1);
	my_dff d2 (clk, q1, q2);
	my_dff d3 (clk, q2, q);
endmodule

////////////////////

//Module and vectors
module top_module(	input clk, 
					input [7:0] d,
					input [1:0] sel,
					output [7:0] q);
	wire [7:0] q1;
	wire [7:0] q2;
	wire [7:0] q3;
	
	my_dff8(clk, d, q1);
	my_dff8(clk, q1, q2);
	my_dff8(clk, q2, q3);
	
	always @(*)
		case(sel)
			2'h0: q=d;
			2'h1: q=q1;
			2'h2: q=q2;
			2'h3: q=q3;
		endcase
endmodule

/**************************/
/*date:06/07/2022**********/
