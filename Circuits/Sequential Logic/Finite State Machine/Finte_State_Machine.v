/*Finite State Machines*/
//Simple FSM1(asynchronous reset)
module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

	//This part is for state desciption
    parameter A=1'b0, B=1'b1; 
    reg current_state, next_state;

	always@(posedge clk or posedge areset) begin
		if(areset) begin
			current_state <= B;
		end
		else begin
			current_state <= next_state;
		end
	end

	always@(*) begin
		case(current_state)
			B:begin
				if(in == 1'b1) begin
					next_state = B;
				end
				else begin
					next_state = A;
				end
			end
			
			A:begin
				if(in == 1'b1) begin
					next_state = A;
				end
				else begin
					next_state = B;
				end
			end
			
			default: begin
				next_state = current_state;
			end
		endcase
	end

	//When you after state desciption, you need to implement state output
	always@(*) begin
		if(areset) begin
			out <= 1'b1;
		end
		else if(current_state == B) begin
			out <= 1'b1;
		end
		else begin
			out <= 1'b0;
		end
	end
endmodule

////////////////////////////////////////

//Simple FSM1(synchronous reset)
module top_module(
	input clk,
	input reset,
	input in,
	output out
);
	parameter A = 1'b0, B = 1'b1;
	reg current_state,  next_state;
	
	always@(posedge clk) begin
		if(reset)
			current_state <= B;
		else
			current_state <= next_state;
	end
	
	always@(*) begin
		case(current_state)
			B: begin
				if(in == 1'b1)
					next_state = B;
				else
					next_state = A;
			end
			A: begin
				if(in == 1'b1)
					next_state = A;
				else
					next_state = B;
			end
			
			default: 
				next_state = current_state;
		endcase
	end
	
	always@(posedge clk) begin
		if(reset)
			out <= 1'b1;
		else if(next_state == B)
			out <= 1'b1;
		else if(next_state == A)
			out <= 1'b0;
	end
endmodule

/////////////////////////////////////////////

//Simple FSM2(asynchronous)
module top_module(
	input clk,
	input areset,
	input j,
	input k,
	output out);
	
	parameter OFF = 1'b0, ON = 1'b1;
	reg current_state, next_state;
	
	always@(posedge clk or posedge areset) begin
		if(areset)
			current_state <= OFF;
		else
			current_state <= next_state;
	end
	
	always@(*) begin
		case(current_state)
			OFF: begin 
				if(j == 1'b0)
					next_state = OFF;
				else if(j == 1'b1)
					next_state = ON;
			end
			ON: begin
				if(k == 1'b0)
					next_state = ON;
				else if(k == 1'b1)
					next_state = OFF;
			end
			
			default: begin
				next_state = current_state;
			end
		endcase
	end
	
	always@(posedge clk or posedge areset) begin
		if(areset)
			out <= 1'b0;
		else if(next_state == OFF)
			out <= 1'b0;
		else if(next_state == ON)
			out <= 1'b1;
	end	
	
endmodule

/////////////////////////////////////

//Simple FSM2(synchronous)
module top_module(
	input clk,
	input reset,
	input j,
	input k,
	output out);
	
	parameter OFF = 1'b0, ON = 1'b1;
	reg current_state, next_state;
	
	always@(posedge clk) begin
		if(reset)
			current_state <= OFF;
		else
			current_state <= next_state;
	end
	
	always@(*) begin
		case(current_state)
			OFF: begin 
				if(j == 1'b0)
					next_state = OFF;
				else if(j == 1'b1)
					next_state = ON;
			end
			ON: begin
				if(k == 1'b0)
					next_state = ON;
				else if(k == 1'b1)
					next_state = OFF;
			end
			
			default: begin
				next_state = current_state;
			end
		endcase
	end
	
	always@(posedge clk) begin
		if(reset)
			out <= 1'b0;
		else if(next_state == OFF)
			out <= 1'b0;
		else if(next_state == ON)
			out <= 1'b1;
	end	
	
endmodule

////////////////////////////////////

//Simple state transitions 3
module top_module(
	input in,
	input [1:0] state,
	output [1:0] next_state,
	output out);
	
	parameter A=2'b00, B=2'b01, C=2'b10, D=2'b11;
	
	always@(*) begin
		case(state)
			2'b00: begin
				if(in == 1'b0)
					next_state = A;
				else if(in == 1'b1)
					next_state = B;
			end
			
			2'b01: begin
				if(in == 1'b0)
					next_state = C;
				else if(in == 1'b1)
					next_state = B;
			end
			
			2'b10: begin
				if(in == 1'b0)
					next_state = A;
				else if(in == 1'b1)
					next_state = D;
			end
			
			2'b11: begin
				if(in == 1'b0)
					next_state = C;
				else if(in == 1'b1)
					next_state = B;
			end
			
			default:
				next_state = state;
		endcase
	end
	
	always@(*) begin
		if(state == 2'b00)
			out = 1'b0;
		else if(state == 2'b01)
			out = 1'b0;
		else if(state == 2'b10)
			out = 1'b0;
		else if(state == 2'b11)
			out = 1'b1;
	end
	
endmodule

///////////////////////////////////////

//Simple one-hot state transitions 3
/*One-hot means one time one bit change*/
module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = state[A]&~in | state[C]&~in;
    assign next_state[B] = state[A]&in | state[B]&in | state[D]&in;
    assign next_state[C] = state[B]&~in|state[D]&~in;
    assign next_state[D] = state[C]&in;

    // Output logic: 
    assign out = state[D];

endmodule

///////////////////////////////////

//Simple FSM 3(asynchronous)
module top_module(
	input clk,
	input in,
	input areset,
	output out
);
	
	parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	reg [1:0] current_state, next_state;
	
	always@(posedge clk or posedge areset) begin
		if(areset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	always@(*) begin
		case(current_state)
			A: begin
				if(in == 1'b0)
					next_state = A;
				else if(in == 1'b1)
					next_state = B;
			end
			
			B: begin
				if(in == 1'b0)
					next_state = C;
				else if(in == 1'b1)
					next_state = B;
			end
			
			C: begin
				if(in == 1'b0)
					next_state = A;
				else if(in == 1'b1)
					next_state = D;
			end
			
			D: begin
				if(in == 1'b0)
					next_state = C;
				else if(in == 1'b1)
					next_state = B;
			end
			
			default:
				next_state = current_state;
		endcase
	end
	
	 always@(posedge clk or posedge areset)begin
        if(areset)begin
        	out <= 1'b0;
        end
        else if(next_state == A)begin
            out <= 1'b0;
        end
        else if(next_state == B)begin
            out <= 1'b0;
        end
        else if(next_state == C)begin
            out <= 1'b0;
        end
        else if(next_state == D)begin
            out <= 1'b1;
        end
    end
	
endmodule

///////////////////////////////////////////

//Simple FSM 3(synchronous)
module top_module(
	input clk,
	input in,
	input reset,
	output out
);
	
	parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	reg [1:0] current_state, next_state;
	
	always@(posedge clk) begin
		if(reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	always@(*) begin
		case(current_state)
			A: begin
				if(in == 1'b0)
					next_state = A;
				else if(in == 1'b1)
					next_state = B;
			end
			
			B: begin
				if(in == 1'b0)
					next_state = C;
				else if(in == 1'b1)
					next_state = B;
			end
			
			C: begin
				if(in == 1'b0)
					next_state = A;
				else if(in == 1'b1)
					next_state = D;
			end
			
			D: begin
				if(in == 1'b0)
					next_state = C;
				else if(in == 1'b1)
					next_state = B;
			end
			
			default:
				next_state = current_state;
		endcase
	end
	
	 always@(posedge clk)begin
        if(reset)begin
        	out <= 1'b0;
        end
        else if(next_state == A)begin
            out <= 1'b0;
        end
        else if(next_state == B)begin
            out <= 1'b0;
        end
        else if(next_state == C)begin
            out <= 1'b0;
        end
        else if(next_state == D)begin
            out <= 1'b1;
        end
    end
	
endmodule

//////////////////////////////////////////

//Design a Moore FSM
module top_module(
	input clk,
	input reset,
	input [3:1] s,
	output fr3,
	output fr2,
	output fr1,
	output dfr
);

	parameter A=0, B1=1, B2=2, C1=3, C2=4, D=5;
	reg[2:0] current_state, next_state;

	//Q flip-flop
	always@(posedge clk) begin
		if(reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	//state transfer block
	always@(*) begin
		case(current_state)
			A: next_state <= s[1]?B1:A;
			B1: next_state <= s[2]?C1:(s[1]?B1:A);
			B2: next_state <= s[2]?C1:(s[1]?B2:A);
			C1: next_state <= s[3]?D:(s[2]?C1:B2);
			C2: next_state <= s[3]?D:(s[2]?C2:B2);
			D: next_state <= s[3]?D:C2;
			default: next_state <= A;
		endcase
	end
	
	//state output	
	always@(*) begin
		case(current_state)
			A: {fr3, fr2, fr1, dfr} = 4'b1111;
			B1: {fr3, fr2, fr1, dfr} = 4'b0110;
			B2: {fr3, fr2, fr1, dfr} = 4'b0111;
			C1: {fr3, fr2, fr1, dfr} = 4'b0010;
			C2: {fr3, fr2, fr1, dfr} = 4'b0011;
			D: {fr3, fr2, fr1, dfr} = 4'b0000;
			default: {fr3, fr2, fr1, dfr} = 4'b1111;
		endcase
	end
		
endmodule