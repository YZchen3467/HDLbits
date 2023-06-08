//Mealy FSM
//Dsign a Mealy FSM
module top_module(
	input clk,
	input aresetn,
	input x,
	output z
);
	
	parameter [1:0] S0=2'd0, S1=2'd1, S2=2'd2;
	reg [1:0] curr_state, next_state;
	
	always@(posedge clk or negedge aresetn)begin
		if(!aresetn)
			curr_state <= S0;
		else
			curr_state <= next_state;
	end
	
	always@(*)begin
		case(curr_state)
			S0: next_state = x ? S1:S0;
			S1: next_state = x ? S1:S2;
			S2: next_state = x ? S1:S0;
			default: next_state = S0;
		endcase
	end
	
	always@(*)begin
		z = ((curr_state == S2) && (x == 1'b1));
	end
endmodule

//Serial two's complemmenter(Moore FSM)
module top_module(
	input clk,
	input areset,
	input x,
	output z
);
	parameter [1:0] A=2'd0, B=2'd1, C=2'd2;
	reg [1:0] curr_state, next_state;
	
	always@(posedge clk or posedge areset)begin
		if(areset)
			curr_state = A;
		else
			curr_state = next_state;
	end
	
	always@(*)begin
		case(curr_state)
			A: next_state = x ? B:A;
			B: next_state = x ? C:B;
			C: next_state = x ? C:B;
 		endcase
	end
	
	always@(*)begin
		z = (curr_state == B);
	end
endmodule


//2's complemmenter mealy machine
module top_module(
	input clk,
	input areset,
	input x,
	output z
);
	
	parameter  A=1'b0, B=1'b1;
	reg curr_state, next_state;
	
	always @(posedge clk or posedge areset)begin
		if(areset)
			curr_state <= A;
		else
			curr_state <= next_state;
	end
	
	always @(*)begin
		case(curr_state)
			A: next_state = x ? B:A;
			B: next_state = B; 
		endcase
	end
	
	always @(*)begin
		if(curr_state == A)
			z = (x == 1);
		else if(curr_state == B)
			z = (x == 0);
	end
	
endmodule