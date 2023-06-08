/*Latches and Flip-Flops*/
//D FF
module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q );//

    // Use a clocked always block
    //   copy d to q at every positive edge of clk
    //   Clocked always blocks should use non-blocking assignments
	always@(posedge clk) begin
		q <= d;
	end
endmodule

//////////////////////////////////

//D FFs
module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
	always@(posedge clk) begin
		q <= d;
	end
endmodule

////////////////////////////////

//DFF with reset
module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
	always@(posedge clk) begin
		if(reset) 
			q <= 8'b0000_0000;
		else
			q <= d;
	end
endmodule

/////////////////////////////////

//DFF with reset value
module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
	always@(negedge clk) begin
		if(reset)
			q <= 8'h34;
		else
			q <= d;
	end
endmodule

///////////////////////////////

//DFF with asynchronous reset
module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
	always@(posedge clk, posedge areset) begin
		if(areset)
			q <= 8'b0000_0000;
		else
			q <= d;
	end	
endmodule

/////////////////////////////

//DFF with byte enable
module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
	always@(posedge clk) begin
		if(!resetn)
			q <= 16'h0;
		else if(byteena[0] || byteena[1]) begin
            if(byteena[1])  
                q[15:8] <= d[15:8];
            if(byteena[0])  
                q[7:0] <= d[7:0];
        end
	end
endmodule

/////////////////////////////

//D Latches
module top_module (
    input d, 
    input ena,
    output q);
	always@(*) begin
		if(ena == 1'b1)
			q = d;
	end
endmodule

////////////////////////////

//DFF 1
module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);
	always@(posedge clk, posedge ar) begin
		if(ar)
			q <= 1'b0;
		else
			q <= d;
	end
endmodule

////////////////////////////

//DFF 2
module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q);
	always@(posedge clk) begin
		if(r)
			q <= 1'b0;
		else
			q <= d;
	end
endmodule

//////////////////////////////

//DFF+gate
module top_module (
    input clk,
    input in, 
    output out);
	always@(posedge clk) begin
		out <= in ^ out;
	end
endmodule

////////////////////////////

//Mux and DFF 1
module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
	always@(posedge clk) begin
		if(L) 
			Q <= r_in;
		else
			Q <= q_in;
	end
endmodule

////////////////////////////

//Mux and DFF 2
module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
	always@(posedge clk) begin
		if(E) begin
			if(L)
				Q <= R;
			else
				Q <= w;
		end
		else
			if(L)
				Q <= R;
			else
				Q <= Q;
	end	
endmodule

///////////////////////////

//DFF and gates
module top_module (
    input clk,
    input x,
    output z
); 
	reg Q1, Q2, Q3;
	initial z = 1;
	always@(posedge clk) begin
		Q1 = x^Q1;
        Q2 = x&(~Q2);
        Q3 = x|(~Q3); 
		z = ~(Q1 | Q2 | Q3);
	end
endmodule

///////////////////////////

//Create circuit from truth table
module top_module (
    input clk,
    input j,
    input k,
    output Q); 
	
    always@(posedge clk) begin
		if(j==0 & k==0)
			Q <= Q;
		if(j==0 & k==1)
			Q <= 1'b0;
		if(j==1 & k==0)
			Q <= 1'b1;	
		if(j==1 & k==1)
			Q <= ~Q;
    end
endmodule

//////////////////////////

//Detect an edge
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
	reg [7:0] D_detection;
	always@(posedge clk) begin
		D_detection <= in;
		pedge <= in&~D_detection;//posedge; if negedge is ~in&D_detection
	end
endmodule

///////////////////////////

//Detect both edge
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] D_detection;
    always@(posedge clk) begin
		D_detection <= in;
		anyedge <= in^D_detection;
	end
endmodule

///////////////////////////

//Edge capture register 
module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
	reg [31:0] D_detection;
	always@(posedge clk) begin
		D_detection <= in; 
	end
	
	always@(posedge clk) begin
		if(reset)
			out <= 32'b0;
		else
			out <= ~in & D_detection | out;
	end
endmodule //need to study more

/////////////////////////////

//Dual-edge-triggered flip-flop
module top_module (
    input clk,
    input d,
    output q
);
    reg q_up;
    reg q_down;
	always@(posedge clk) begin
		q_up <= d;
	end
	always@(negedge clk) begin
        q_down <= d;
	end
    
    assign q = clk ? q_up:q_down;
endmodule

