/*Vectors*/
//Vectors
module top_module(input wire [2:0] vec,
					output wire [2:0] outv,
					output wire o2,
                  	output wire o1, 
                  	output wire o0);
	assign outv = vec;
	assign o2 = vec[2];
	assign o1 = vec[1];
	assign o0 = vec[0];
endmodule	

//////////////////////////////

//Vectors in more detail
module top_module(input wire [15:0] in,
					output wire [7:0] out_hi,
					output wire [7:0] out_lo);

	assign out_hi = in[15:8];
	assign out_lo = in[7:0];
endmodule

/////////////////////////////

//Vector part select
module top_module(input [31:0] in,
					output [31:0] out);
	assign out[31:24] = in[7:0];
	assign out[23:16] = in[15:8];
	assign out[15:8] = in[23:16];
	assign out[7:0] = in[31:24];
endmodule

////////////////////////////

//Bitwise operators
module top_module(input [2:0] a, b,
					output [2:0] out_or_bitwise,
					output out_or_logical,
					output [5:0] out_not);
	assign out_or_bitwise[2:0] = a[2:0] | b[2:0];
	assign out_or_logical = a || b;
	assign out_not[5:3] = ~b[2:0];
	assign out_not[2:0] = ~a[2:0];
endmodule

//////////////////////////

//Four input gate
module top_module(input [3:0] in,
					output out_and,
					output out_or,
					output out_xor);
	assign out_and = in[3] & in[2] & in[1] & in[0];
	assign out_or = in[3] | in[2] | in[1] | in[0];
	assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0];
endmodule

////////////////////////

//Vector concatenation operators
module top_module(input [4:0] a, b, c, d, e, f,
					output [7:0] w, x, y, z);
	assign w = {a[4:0], b[4:2]};
	assign x = {b[1:0], c[4:0], d[4]};
	assign y = {d[3:0], e[4:1]};
	assign z = {e[0], f[4:0], 2'b11};
endmodule

///////////////////////

//Vector reversal 1
module top_module(input [7:0] in,
					output [7:0] out);
	assign out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};
endmodule

//////////////////////////

//Replication operator
module top_module(input [7:0] in,
					output [31:0] out);
    assign out = {{24{in[7]}}, in};
endmodule

//////////////////////////

//More replication
module top_module(input a, b, c, d, e,
					output [24:0] out);
	assign out = ~{{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}} ^ {5{a, b, c, d, e}};
endmodule

/**************************/
/*date:06/07/2022**********/
