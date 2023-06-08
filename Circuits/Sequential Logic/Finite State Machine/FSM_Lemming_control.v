/*FSM keyboard control*/
//Lemmings 1
module top_module(
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	parameter LEFT = 1, RIGHT = 0;
	reg [1:0] current_state, next_state;
	wire [1:0] obstacle = {bump_left, bump_right}; 
	
	always@(posedge clk or posedge areset) begin
		if(areset)
			current_state <= LEFT;
		else
			current_state <= next_state;
	end
	
	always@(*) begin
		case(current_state)
			LEFT: begin
				if((obstacle == 2'b10) || (obstacle == 2'b11))
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if((obstacle == 2'b01) || (obstacle == 2'b11))
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			default: 
				next_state = LEFT;
		endcase
	end
	
	assign walk_left = (current_state == LEFT);
	assign walk_right = (current_state == RIGHT);
endmodule
	

///////////////////////////////////////////////////////

//Lemmings 2
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah );
	
	parameter FALL_L = 2'b11, FALL_R = 2'b10, LEFT = 2'b01, RIGHT = 2'b00;
	reg [1:0] current_state, next_state;
	
	always@(posedge clk or posedge areset) begin
		if(areset)
			current_state <= LEFT;
		else
			current_state <= next_state;
	end
	
	always@(*) begin
		case(current_state)
			LEFT: begin
				if(ground == 0)
					next_state = FALL_L;
                else if(bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if(ground == 0)
					next_state = FALL_R;
                else if(bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			FALL_L: begin
				if(ground == 1)
					next_state = LEFT;
				else
					next_state = FALL_L;
			end
			FALL_R: begin
				if(ground == 1)
					next_state = RIGHT;
				else
					next_state = FALL_R;
			end
			default: 
				next_state = LEFT;
		endcase
	end
	
    assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);
	assign aaah = (current_state == FALL_L) || (current_state == FALL_R);
	
endmodule

/////////////////////////////////////////////////

//Lemmings 3
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging );

	parameter DIGGING_L = 3'b101, DIGGING_R = 3'b100, FALL_L = 3'b011, FALL_R = 3'b010, LEFT = 3'b001, RIGHT = 3'b000;
	reg [2:0] current_state, next_state;
	
	always@(posedge clk or posedge areset) begin
		if(areset)
			current_state <= LEFT;
		else
			current_state <= next_state;
	end
	
	always@(*) begin
		case(current_state)
			LEFT: begin
				if(ground == 0)
					next_state = FALL_L;
				else if(dig)
					next_state = DIGGING_L;	
                else if(bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if(ground == 0)
					next_state = FALL_R;
				else if(dig)
					next_state = DIGGING_R;
                else if(bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			FALL_L: begin
				if(ground == 1)
					next_state = LEFT;
				else
					next_state = FALL_L;
			end
			FALL_R: begin
				if(ground == 1)
					next_state = RIGHT;
				else
					next_state = FALL_R;
			end
			DIGGING_L: begin
				if(ground == 0)
					next_state = FALL_L;
				else
					next_state = DIGGING_L;		
			end
			DIGGING_R: begin
				if(ground == 0)
					next_state = FALL_R;
				else
					next_state = DIGGING_R;		
			end
			default: 
				next_state = LEFT;
		endcase	
	end
	
	assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);
	assign aaah = (current_state == FALL_L) || (current_state == FALL_R);
	assign digging = (current_state == DIGGING_L) || (current_state == DIGGING_R);

endmodule

///////////////////////////////////////////////////

//Lemmings 4
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging );
	
	parameter LEFT = 4'd0, RIGHT = 4'd1, FALL_L = 4'd2, FALL_R = 4'd3;
	parameter DIGGING_L = 4'd4, DIGGING_R = 4'd5, SPLATTER = 4'd6, END = 4'd7;
	
	reg [3:0] current_state, next_state;
	
	always@(posedge clk or posedge areset) begin
		if(areset)
			current_state <= LEFT;
		else
			current_state <= next_state;
	end
	
	//Counter for counting lemming falls time. If the time >= 20, then lemming will end of life.
	reg [4:0] counter;
	always@(posedge clk or posedge areset) begin
		if(areset)
			counter <= 5'd0;
		else if(next_state == FALL_L|| next_state == FALL_R)
			counter <= counter + 1'b1;
		else
			counter <= 5'd0;
	end
	
	//state transfer
	always@(*) begin
		case(current_state)
			LEFT: begin
				if(!ground)
					next_state = FALL_L;
				else if(dig)
					next_state = DIGGING_L;
				else if(bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if(!ground)
					next_state = FALL_R;
				else if(dig)
					next_state = DIGGING_R;
				else if(bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			FALL_L: begin
				if(ground)
					next_state = LEFT;
				else if(counter == 5'd20)
					next_state = SPLATTER;
				else
					next_state = FALL_L;
			end
			FALL_R: begin
				if(ground)
					next_state = RIGHT;
				else if(counter == 5'd20)
					next_state = SPLATTER;
				else
					next_state = FALL_R;
			end
			DIGGING_L: begin
				if(ground == 0)
					next_state = FALL_L;
				else
					next_state = DIGGING_L;		
			end
			DIGGING_R: begin
				if(ground == 0)
					next_state = FALL_R;
				else
					next_state = DIGGING_R;		
			end
			SPLATTER: begin
				if(ground)
					next_state = END;
				else
					next_state = SPLATTER;
			end
			END: begin
				next_state = END;
			end
			default:
				next_state = LEFT;
		endcase
	end
	
	assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);
	assign aaah = (current_state == FALL_L) || (current_state == FALL_R) || (current_state == SPLATTER);
	assign digging = (current_state == DIGGING_L) || (current_state == DIGGING_R);
	
endmodule