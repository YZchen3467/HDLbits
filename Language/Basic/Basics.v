/*Basic*/
//Simple Wire
module top_module(input in, output out);
	assign out = in;
endmodule

/////////////////////////

//Four Wire
module top_module(
				input a, b, c,
				output w, x, y, z);
	assign w = a;
	assign x = b;
	assign y = b;
	assign z = c;
endmodule

//////////////////////

//Notgate
module top_module(input in, output out);
	assign out = ~in;
endmodule

/////////////////////

//Andgate
module top_module(input a, b,
					output out);
	assign out = a & b;
endmodule

////////////////////

//Norgate
module top_module(input a, b,
					output out);
	assign out = ~(a | b);
endmodule

///////////////////

//Xorgate
module top_module(input a, b,
					output out);
	assign out = ~(a ^ b);
endmodule

//////////////////

//Declaring wires
module top_module(input a, b, c, d,
					output out, out_n);
	
	wire ab_wire;
	wire cd_wire;
	wire orgate_wire;
	
	assign out = orgate_wire;
	assign out_n = ~orgate_wire;
	
	assign orgate_wire = ab_wire | cd_wire;
	
	assign ab_wire = a&b;
	assign cd_wire = c&d;
endmodule

/////////////////

//7458 chip
module top_module(input p1a, p1b, p1c, p1d, p1e, p1f,
					input p2a, p2b, p2c, p2d,
					output p1y, p2y);
	wire p1_abc_wire;
	wire p1_def_wire;
	wire p2_ab_wire;
	wire p2_cd_wire;
	
	assign p1_abc_wire = p1a & p1b & p1c;
	assign p1_def_wire = p1d & p1e & p1f;
	
	assign p2_ab_wire = p2a & p2b;
	assign p2_cd_wire = p2c & p2d;
	
	assign p1y = p1_abc_wire | p1_def_wire;
	assign p2y = p2_ab_wire | p2_cd_wire;
endmodule

/*******************************/
/*date:06/06/2022**********/
