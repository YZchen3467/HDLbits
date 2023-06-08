/*Shift Registers*/
//4-bit shift register
module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
		
	always@(posedge clk, posedge areset) begin
		if(areset)
			q <= 4'b0;
		else if(load)
			q <= data;
		else if(ena)
			q <= q[3:1];
	end	

endmodule

////////////////////////////////

//Left/right rotator
module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 
	
	always@(posedge clk) begin
		if(load)
			q <= data;
		else
			case(ena)
				2'b00 : q <= q;
				2'b01 : q <= {q[0], q[99:1]};
				2'b10 : q <= {q[98:0], q[99]};
				default : q <= q;
			endcase
	end
	
endmodule

////////////////////////////////////

//Left/right arithmetic shift by 1 or 8
module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    always@(posedge clk)begin
        if(load)
            q <= data;
        else if(ena) begin
            case(amount)
                2'b00 : q <= {q[62:0], 1'b0};
                2'b01 : q <= {q[55:0], 8'b0};
                2'b10 : q <= {q[63], q[63:1]};
                2'b11 : q <= {{8{q[63]}}, q[63:8]};
				//default : q <= q;
			endcase
		end
    end
endmodule

/////////////////////////////////////

//5-bit LFSR

module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 
	
	always@(posedge clk) begin
		if(reset)
			q <= 5'h1;
		else
			q <= {0^q[0], q[4], q[3]^q[0], q[2], q[1]};
	end	
	
endmodule

////////////////////////////////////

//3-bit LFSR (Linear-feedback register needs to review)
/*first way*/
module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

    reg [2:0] LEDR_reg;
    
	//combinational circuit
    always@(*)begin
        if(KEY)begin
			LEDR_reg = SW;        
        end
        else begin
            LEDR_reg[0] = LEDR[2];
            LEDR_reg[1] = LEDR[0];
            LEDR_reg[2] = LEDR[1] ^ LEDR[2];
        end
    end
    
	//sequential circuit
    always@(posedge KEY[0])begin
        LEDR <= LEDR_reg;
    end
    
endmodule

/*second way*/
module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output reg [2:0] LEDR);  // Q

    wire clk = KEY[0];
    wire l = KEY[1];
    wire [2:0] d = l?SW:{LEDR[1]^LEDR[2],LEDR[0],LEDR[2]};
    
    always @(posedge clk)begin
            LEDR <=	d;
    end

endmodule

/////////////////////////////////

//32-bit LFSR
module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 

	always@(posedge clk) begin
		if(reset)
			q <= 32'h1;
		else
			q <= {1'b0^q[0], q[31:23], q[22]^q[0], q[21:3], q[2]^q[0], q[1]^q[0]};
	end
	
endmodule

/////////////////////////////////

//Shift register
module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
	
	reg [3:0] q;
	
	always@(posedge clk) begin
		if(!resetn) begin
			q[0] <= 1'b0;
			q[1] <= 1'b0;
			q[2] <= 1'b0;
			out <= 1'b0;
		end
		else begin
			q[0] <= in;
			q[1] <= q[0];
			q[2] <= q[1];
			out <= q[2];
		end
	end
	
endmodule

/////////////////////////////////

//Shift register
module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

	MUXDFF ins3_MUXDFF(.clk(KEY[0]), .R(SW[3]), .E(KEY[1]), .L(KEY[2]), .w(KEY[3]), .Q(LEDR[3]));

	MUXDFF ins2_MUXDFF(.clk(KEY[0]), .R(SW[2]), .E(KEY[1]), .L(KEY[2]), .w(LEDR[3]), .Q(LEDR[2]));
	
	MUXDFF ins1_MUXDFF(.clk(KEY[0]), .R(SW[1]), .E(KEY[1]), .L(KEY[2]), .w(LEDR[2]), .Q(LEDR[1]));
	
	MUXDFF ins0_MUXDFF(.clk(KEY[0]), .R(SW[0]), .E(KEY[1]), .L(KEY[2]), .w(LEDR[1]), .Q(LEDR[0]));
endmodule

module MUXDFF (input clk,
	input w, R, E, L,
	output reg Q); //make MUXDFF
	
	wire D_i;
	assign D_i = L?R:(E?w:Q);
	always@(posedge clk) begin
		Q <= D_i;
	end
	
endmodule

///////////////////////////////////

//3-input LUT
module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
	
	reg [7:0] Q;
	
	always@(posedge clk) begin
		if(enable)
			Q <= {Q[6:0], S};
		else
			Q <= Q;
	end
	
	assign Z = Q[{A,B,C}];
	
endmodule

