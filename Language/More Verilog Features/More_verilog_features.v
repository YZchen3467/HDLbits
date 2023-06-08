/*More Verilog Features*/
//Conditional ternary operator
module top_module(	input [7:0] a, b, c, d,
					output [7:0] min);
	assign min = (a<b ? a:b) < (c<d ? c:d) ? (a<b ? a:b):(c<d ? c:d);
endmodule

////////////////////////////////

//Reduction operator
module top_module(	input[7:0] in,
					output parity);
	assign parity = ~^{in[7:0], 1'b1}; //even parity: detect even 1 output 1
endmodule

module top_module(	input[7:0] in,
					output parity);
	assign parity = ^{in[7:0], 1'b1}; //odd parity: detect odd 1 output 1
endmodule

////////////////////////////////

//Reduction: Even wider gates
module top_module(	input [99:0] in,
					output out_and,
					output out_or,
					output out_xor);
	assign out_and = &in;
	assign out_or = |in;
	assign out_xor = ^in;
endmodule

/////////////////////////////////

//Combinational for-loop: Vector reversal 2
module top_module(	input [99:0] in,
					output [99:0] out);
	always@(*) begin
		for(integer i=0; i<$bits(out); i=i+1) begin
			out[i] = in[99-i]; // or out[i]=in[$bits(out)-i-1];
		end
	end
endmodule

////////////////////////////////

//Combinational for-loop: 255bit population count
module top_module( input [254:0] in,
					output [7:0] out);
	always@(*) begin
		out = 8'b0000_0000;
		for(integer i=0; i<$bits(in); i=i+1) begin
			if(in[i] == 1'b1) 
				out = out + 1'b1;
            else
                out = out + 1'b0;
		end
	end
endmodule

////////////////////////////////

//Generate for-loop: 100-bit binary adder2
module top_module(	input [99:0] a, b,
					input cin,
					output [99:0] cout,
					output [99:0] sum);
	always@(*) begin
		for(integer i=0; i<100; i=i+1) begin
			if(i == 0) begin
				sum[0] = a[0]^b[0]^cin;
				cout[0] = (a[0]&b[0])|(a[0]&cin)|(b[0]&cin);
			end
			else begin
				sum[i] = a[i]^b[i]^cout[i-1];
				cout[i] = (a[i]&b[i])|(a[i]&cout[i-1])|(b[i]&cout[i-1]);
			end
		end
	end
endmodule

/////////////////////////////////

//Generate for-loop: 100bit-digit BCD adder2
module top_module(	input [399:0] a, b,
					input cin,
					output cout,
					output [399:0] sum);
	wire [99:0] cout_1;
	
	generate
		genvar i;
		for(i=0; i<100; i=i+1) begin: BCD_100bits
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
		assign cout = cout_1[99];
	endgenerate
endmodule
