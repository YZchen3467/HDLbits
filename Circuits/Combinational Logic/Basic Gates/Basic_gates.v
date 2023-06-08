/**Combinational Logic**/
/*Basic Gates*/
//Wire
module top_module(input in,
				  output out);
	assign out = in;
endmodule

//////////////////////////

//GND
module top_module(output out);
	assign out = 1'b0;
endmodule

//////////////////////////

//NOR
module top_module (
    input in1,
    input in2,
    output out);
	assign out = ~(in1|in2);
endmodule

/////////////////////////

//Another gate
module top_module (
    input in1,
    input in2,
    output out);
	assign out = in1 & ~in2;
endmodule

////////////////////////

//Two gates
module top_module (
    input in1,
    input in2,
    input in3,
    output out);
	assign out = ~(in1^in2)^in3;
endmodule

///////////////////////////

//More Logic gates
module top_module( 
    input a, b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);
	assign out_and = a&b;
	assign out_or = a|b;
	assign out_xor = a^b;
	assign out_nand = ~(a&b);
	assign out_nor = ~(a|b);
	assign out_xnor = ~(a^b);
	assign out_anotb = a&~b;
endmodule

///////////////////////////

//7420 Chip
module top_module ( 
    input p1a, p1b, p1c, p1d,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
	assign p1y = ~(p1a & p1b & p1c & p1d);
	assign p2y = ~(p2a & p2b & p2c & p2d);
endmodule

///////////////////////////

//Truth table
module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
	assign f = x1&x3 | x2&~x3; 
endmodule

//////////////////////////

//Two-bit equality
module top_module(input [1:0] A,
				  input [1:0] B,
				  output z);
	assign z = (A==B) ? 1'b1:1'b0;
endmodule

///////////////////////////

//Simple circuit A
module top_module (input x, input y, output z);
	assign z = (x^y)&x;
endmodule

//////////////////////////

//Simple circuit B
module top_module ( input x, input y, output z );
	assign z = ~(x^y);
endmodule

//////////////////////////

//Combine circuit A and B
module top_module (input x, input y, output z);
	assign z = (((x^y)&x)|(~(x^y))) ^ (((x^y)&x)&(~(x^y)));
endmodule

/////////////////////////

//Ring or vibrate
module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);
	assign ringer = ring&~vibrate_mode;
	assign motor = ring&vibrate_mode;
endmodule

////////////////////////

//Thermostat
module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 
	assign heater = too_cold & mode;
	assign aircon = too_hot & ~mode;
	assign fan = fan_on | too_cold & mode | too_hot & ~mode;
endmodule

///////////////////////

//3-bit population count
module top_module( 
    input [2:0] in,
    output [1:0] out );
    always@(*)begin
        integer i;
        out = 2'b00;
        for(i=0; i<$bits(in); i=i+1)begin:population_count
            if(in[i] == 1'b1)
            	out = out + 1'b1;
            else
                out = out + 1'b0;
        end
    end
endmodule
//////////////////////

//Gates and vectors
module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );
	assign out_both = in[2:0]&in[3:1];
	assign out_any = in[2:0]|in[3:1];
    assign out_different = {in[0], in[3:1]}^in;
endmodule

////////////////////////////

//Even longer vectors
module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );
    assign out_both = in[99:1] & in[98:0];
    assign out_any = in[99:1] | in[98:0];
    assign out_different = {in[0], in[99:1]}^in; 
endmodule
