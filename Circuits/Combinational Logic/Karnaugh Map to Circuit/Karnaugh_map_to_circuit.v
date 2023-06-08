/*Karnaguh Map to Circuit*/
//3-variable
module top_module(
    input a,
    input b,
    input c,
    output out  ); 

	assign out = a&~c | c | b;

endmodule

//////////////////////////////

//4-variable 1
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
	assign out = ~a&~d | ~b&~c | b&c&d | a&~b&d;
endmodule

//////////////////////////////

//4-variable 2
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    assign out = a | (~b)&c;
endmodule

//////////////////////////////

//4-variable 3
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
	assign out = a^b^c^d;
endmodule

//////////////////////////////

//Minimum SOP and POS
module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
	assign out_sop = c&d | ~a&~b&c;
    assign out_pos = c&(~a|d)&(~b|d);
endmodule

////////////////////////////////

//Karnaguh Map 1
module top_module (
    input [4:1] x, 
    output f );
    assign f = ~x[1]&x[3] | x[1]&x[2]&x[4];
endmodule

/////////////////////////////////

//Karnaguh Map 2
module top_module (
    input [4:1] x,
    output f
); 
    assign f = ~x[2]&~x[4] | ~x[1]&x[3] | x[2]&x[3]&x[4];
endmodule

//////////////////////////////////

//K-Map implemented with a multiplexer
module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 
	assign mux_in[3] = c&d;
	assign mux_in[2] = ~d;
	assign mux_in[1] = 1'b0;
	assign mux_in[0] = d|c;
    /*assign mux_in = {c&d, ~d, 1'b0, d|c};*/
endmodule
