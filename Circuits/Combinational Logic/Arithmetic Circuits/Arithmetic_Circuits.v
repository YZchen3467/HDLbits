/*Arithmetic Circuits*/
//Half adder
module top_module(input a, b,
				  output cout, sum);
	assign cout = a&b;
	assign sum = a^b;
endmodule

//////////////////////////////////

//Full adder
module top_module(input a, b, cin,
				  output cout, sum);
	assign cout = a&b | a&cin | b&cin;
	assign sum = a^b^cin;
endmodule

/////////////////////////////////

//3-bit binary adder
module top_module(input [2:0] a, b,
				  input cin, 
				  output [2:0] cout,
				  output [2:0] sum);
	Full_adder FA0 (a[0], b[0], cin, cout[0], sum[0]);
	Full_adder FA1 (a[1], b[1], cout[0], cout[1], sum[1]);
	Full_adder FA2 (a[2], b[2], cout[1], cout[2], sum[2]);
	
endmodule

module Full_adder(input a, b, cin,
				  output cout, sum);
	assign cout = a&b | a&cin | b&cin;
	assign sum = a^b^cin;
endmodule

////////////////////////////////

//Adder
module top_module (input [3:0] x,
				   input [3:0] y, 
				   output [4:0] sum);
	wire [3:0] cout;
	Full_adder FA0 (x[0], y[0], 0, cout[0], sum[0]);
	Full_adder FA1 (x[1], y[1], cout[0], cout[1], sum[1]);
	Full_adder FA2 (x[2], y[2], cout[1], cout[2], sum[2]);
	Full_adder FA3 (x[3], y[3], cout[2], cout[3], sum[3]);
	assign sum[4] = cout[3]; 
	
endmodule

module Full_adder(input a, b, cin,
				  output cout, sum);
	assign cout = a&b | a&cin | b&cin;
	assign sum = a^b^cin;
endmodule

/*second way
module top_module (input [3:0] x,
				   input [3:0] y, 
				   output [4:0] sum);
	assign sum = x+y;
endmodule*/

///////////////////////////////////

//Signed addition overflow
module top_module (input [7:0] a,
				   input [7:0] b,
				   output [7:0] s,
				   output overflow);
	assign s = a+b;
	assign overflow = a[7] & b[7] & ~s[7] | ~a[7] & ~b[7] & s[7];
endmodule

//////////////////////////////////

//100-bit binary adder
module top_module(input [99:0] a, b,
				  input cin,
				  output cout,
				  output [99:0] sum);
    wire [99:0]cout_l;
	
	generate 
		genvar i;
        for(i=0; i<100; i=i+1) begin: BitAdder
			if(i==0)
				Full_adder FA0(.a(a[0]), .b(b[0]), .cin(cin), .cout(cout_l[0]), .sum(sum[0]));
			else
				Full_adder FA_grater0(.a(a[i]), .b(b[i]), .cin(cout_l[i-1]), .cout(cout_l[i]), .sum(sum[i]));
		end
		assign cout = cout_l[99];
	endgenerate
endmodule

module Full_adder(input a, b, cin,
				  output cout, sum);
	assign cout = a&b | a&cin | b&cin;
	assign sum = a^b^cin;
endmodule

////////////////////////////////

//4-digit BCD adder
module Full_adder(input a, b, cin,
				  output cout, sum);
	assign cout = a&b | a&cin | b&cin;
	assign sum = a^b^cin;
endmodule

module bcd_fadd (input [3:0] a,
				 input [3:0] b,
				 input cin,
				 output cout,
				 output [3:0] sum);
	wire Y;
	wire [3:0]cout_l;
	Full_adder FA0 (a[0], b[0], cin, cout_l[0], sum[0]);
	Full_adder FA1 (x[1], y[1], cout_l[0], cout_l[1], sum[1]);
	Full_adder FA2 (x[2], y[2], cout_l[1], cout_l[2], sum[2]);
	Full_adder FA3 (x[3], y[3], cout_l[2], cout_l[3], sum[3]);
endmodule

////////////////////////////////

//4-digit BCD adder
module top_module(	input [15:0] a, b,
					input cin,
					output cout,
					output [15:0] sum);
	wire [3:0] cout_1;
	
	genvar i;
	generate
		for(i=0; i<4; i=i+1) begin: BCD_100bits
			if(i == 0) begin
				bcd_fadd condi_0(.a(a[3:0]),
								 .b(b[3:0]),
								 .cin(cin),
								 .cout(cout_1[0]),
								 .sum(sum[3:0])
								);
			end
			else begin
				bcd_fadd condi_i(.a(a[i*4+3:i*4]),
								 .b(b[i*4+3:i*4]),
								 .cin(cout_1[i-1]),
								 .cout(cout_1[i]),
								 .sum(sum[i*4+3:i*4])
								);
			end			
		end
		assign cout = cout_1[3];
	endgenerate
endmodule
