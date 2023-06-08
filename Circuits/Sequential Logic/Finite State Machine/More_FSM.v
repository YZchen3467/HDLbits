/*More FSM*/
//FSM1
module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

	parameter A=1'b0, B=1'b1;
	reg curr_state, next_state;

	always @(posedge clk)begin
		if(reset)
			curr_state <= A;
		else
			curr_state <= next_state;
	end
	
	always @(*)begin
		case(curr_state)
			A: next_state = s ? B:A;
			B: next_state = B;
		endcase
	end
	
	//accoridng to the B state, assign w value.
	reg w_reg1, w_reg2;
	always @(posedge clk)begin
		if(reset)begin
			w_reg1 <= 1'b0;
			w_reg2 <= 1'b0;
 		end
		else if(next_state == B)begin
			w_reg1 <= w;
			w_reg2 <= w_reg1;
		end
		else begin
			w_reg1 <= 1'b0;
			w_reg2 <= 1'b0;
		end	
	end
	
	//if and only if w=1 occur twice in three clock cycle, then output z=1.
	always @(posedge clk)begin
		if(reset)
			z <= 1'b0;
		else if(curr_state == B && counter == 2'd0)begin
			if(~w & w_reg1 & w_reg2 | w & ~w_reg1 & w_reg2 | w & w_reg1 & ~w_reg2)
				z <= 1'b1;
			else
				z <= 1'b0;
		end
		else
			z <= 1'b0;
	end
	
	//non-multiple three clock cycle check
	reg [1:0] counter;
	always @(posedge clk)begin
		if(reset)
			counter <= 2'd0;
		else if(counter == 2'd2)
			counter <= 2'd0;
		else if(next_state == B)
			counter <= counter + 1'b1;
	end
	
endmodule

//FSM2
module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
	
	parameter [2:0] A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4;
	reg [2:0] curr_state, next_state;
	
	always @(posedge clk)begin
		if(reset)
			curr_state <= A;
		else
			curr_state <= next_state;
	end
	
	always @(*)begin
		case(curr_state)
			A: next_state = x ? B:A;
			B: next_state = x ? E:B;
			C: next_state = x ? B:C;
			D: next_state = x ? C:B;
			E: next_state = x ? E:D;
			default: next_state = A;
		endcase
	end
	
	always @(*)begin
		z = (curr_state == D || curr_state == E);
	end

endmodule


//FSM3
module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

	parameter [2:0] A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4;
	reg [2:0] next_state;
	
	//state transfer
	always @(*)begin
        case(y)
			A: next_state = x ? B:A;
			B: next_state = x ? E:B;
			C: next_state = x ? B:C;
			D: next_state = x ? C:B;
			E: next_state = x ? E:C;
			default: next_state = A;
		endcase
	end
	
	//combination logic
	always @(*)begin
        case(y)
			A: begin
				Y0 = x ? 1'b1 : 1'b0;
				z = 1'b0;
			end
			B: begin
				Y0 = x ? 1'b0 : 1'b1;
				z = 1'b0;
			end
			C: begin
				Y0 = x ? 1'b1 : 1'b0;
				z = 1'b0;
			end
			D: begin
				Y0 = x ? 1'b0 : 1'b1;
				z = 1'b1;
			end
			E: begin
				Y0 = x ? 1'b0 : 1'b1;
				z = 1'b1;
			end
			default: begin
				Y0 = x ? 1'b0 : 1'b1;
				z = 1'b0;
			end
		endcase
	end
endmodule

//FSM4
module top_module (
    input [3:1] y,
    input w,
    output Y2);
	
	parameter [3:1] A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4, F=3'd5;
	wire [3:1] next_state;
	
	always @(*)begin
        case(y)
			A: next_state = w?A:B;
			B: next_state = w?D:C;
			C: next_state = w?D:E;
			D: next_state = w?A:F;
			E: next_state = w?D:E;
			F: next_state = w?D:C;
		endcase
	end
	
    assign Y2= (next_state == C);
endmodule

//FSM5(not finished yet)
module top_module (
    input [3:1] y,
    input w,
    output Y2,
	output Y4);
	
	parameter [6:1] A=6'd000001, B=6'd000010, C=6'd000100, D=6'd001000, E=6'010000, F=6'd100000;
	wire [6:1] next_state;
	
	always @(*)begin
        case(y)
			A: next_state = w?A:B;
			B: next_state = w?D:C;
			C: next_state = w?D:E;
			D: next_state = w?A:F;
			E: next_state = w?D:E;
			F: next_state = w?D:C;
			default:next_state = A;
		endcase
	end
	
    assign Y2=next_state[1] & ~w;
	assign Y4=
	
endmodule