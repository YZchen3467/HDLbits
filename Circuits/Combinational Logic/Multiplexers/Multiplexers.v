/*Multiplexers*/
//2-to-1 multiplexer
module top_module( 
    input a, b, sel,
    output out ); 
	assign out = sel ? b:a;
endmodule

////////////////////////////

//2-to-1 bus multiplexer
module top_module( 
    input [99:0] a, b,
    input sel,
    output [99:0] out );
	assign out = sel ? b:a;
endmodule

///////////////////////////

//9-to-1 multiplexer
module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );
	always@(*) begin
		out = '1;
		case(sel)
			4'b0000: out = a;
			4'b0001: out = b;
			4'b0010: out = c;
			4'b0011: out = d;
			4'b0100: out = e;
			4'b0101: out = f;
			4'b0110: out = g;
			4'b0111: out = h;
			4'b1000: out = i;
		endcase
	end
endmodule

///////////////////////////

//256-to-1 multiplexer(special method)
module top_module( 
    input [255:0] in,
    input [7:0] sel,
    output out );
	assign out = in[sel];
endmodule

//////////////////////////

//256-to-1 4-bit multiplexer
module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
	assign out = in[sel*4 +: 4];
	
	/*second way
	  assign out = {in[sel*4 + 3], in[sel*4 + 2], in[sel*4 + 1], in[sel*4]};*/
endmodule
