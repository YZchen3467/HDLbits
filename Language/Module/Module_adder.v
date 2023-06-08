/*Module*/
//Adder1
module top_module(	input [31:0] a,
					input [31:0] b,
					output [31:0] sum);
	wire cout1;
	wire cout;
	add16 adder1 (a[15:0], b[15:0], 0, sum[15:0], cout1);
	add16 adder2 (a[31:16], b[31:16], cout1, sum[31:16], cout);
endmodule

////////////////////

//Adder2
module top_module(	input [31:0] a,
					input [31:0] b,
					output [31:0] sum);
	wire cout1;
	wire cout;
	add16 adder1 (a[15:0], b[15:0], 0, sum[15:0], cout1);
	add16 adder2 (a[31:16], b[31:16], cout1, sum[31:16], cout);
endmodule

module add1(	input a, b, cin,
				output sum, cout);
	xor(sum, a, b, cin);
	assign cout = (a&b)|(a&cin)|(b&cin);
endmodule

///////////////////

//Carry-select adder
module top_module(	input [31:0] a,
					input [31:0] b,
					output [31:0] sum);
					
	wire sel_cout;				
	wire cout;
	wire [15:0] sum1, sum2, sum3;
	add16 top_adder (a[15:0], b[15:0], 1'b0, sum1, sel_cout);
	add16 sel_add1 (a[31:16], b[31:16], 1'b0, sum2, cout);
	add16 sel_add2 (a[31:16], b[31:16], 1'b1, sum3, cout);
	
	assign sum = sel_cout ? {sum3, sum1}:{sum2, sum1};
endmodule

///////////////////

//Adder-subtractor
module top_module(	input [31:0] a,
					input [31:0] b,
					input sub,
					output [31:0] sum);
					
	wire cout;
	wire cout1;
	wire [31:0] b_compute;
	assign b_compute[31:0] = {32{sub}} ^ b[31:0];
	add16 adder1 (a[15:0], b_compute[15:0], sub, sum[15:0], cout1);
	add16 adder2 (a[31:16], b_compute[31:16], cout1, sum[31:16], cout);	
endmodule

/**************************/
/*date:06/07/2022**********/
