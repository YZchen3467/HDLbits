/*Serial FSM*/
//Serial receiver
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    parameter [3:0] IDLE=4'd00;
    parameter [3:0] START=4'd01;
    parameter [3:0] BIT1=4'd02;
    parameter [3:0] BIT2=4'd03;
    parameter [3:0] BIT3=4'd04;
    parameter [3:0] BIT4=4'd05;
    parameter [3:0] BIT5=4'd06;
    parameter [3:0] BIT6=4'd07;
    parameter [3:0] BIT7=4'd08;
    parameter [3:0] BIT8=4'd09;
    parameter [3:0] STOP=4'd10;
    parameter [3:0] ERROR=4'd11; 
    
    reg [3:0] curr_state, next_state;
    
    always@(posedge clk)begin
        if(reset)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end
    always@(*)begin
        case(curr_state)
            IDLE: next_state = in ? IDLE:START;
            START: next_state = BIT1;
            BYTE1: next_state = BIT2;
            BYTE2: next_state = BIT3;
            BYTE3: next_state = BIT4;
            BYTE4: next_state = BIT5;
            BYTE5: next_state = BIT6;
            BYTE6: next_state = BIT7;
            BYTE7: next_state = BIT8;
            BYTE8: next_state = in ? STOP:ERROR;
            STOP: next_state = in ? IDLE:START;
            ERROR: next_state = in ? IDLE:ERROR;
			default: next_state = IDLE;
        endcase
    end
    
    always@(*)begin
        done = (curr_state == STOP);
    end
endmodule


//Serial receiver and datapath
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
	parameter [3:0] IDLE=4'd00;
    parameter [3:0] START=4'd01;
    parameter [3:0] BIT1=4'd02;
    parameter [3:0] BIT2=4'd03;
    parameter [3:0] BIT3=4'd04;
    parameter [3:0] BIT4=4'd05;
    parameter [3:0] BIT5=4'd06;
    parameter [3:0] BIT6=4'd07;
    parameter [3:0] BIT7=4'd08;
    parameter [3:0] BIT8=4'd09;
    parameter [3:0] STOP=4'd10;
    parameter [3:0] ERROR=4'd11; 
    
    reg [3:0] curr_state, next_state;
    
    always@(posedge clk)begin
        if(reset)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end
    always@(*)begin
        case(curr_state)
            IDLE: next_state = in ? IDLE:START;
            START: next_state = BIT1;
            BIT1: next_state = BIT2;
            BIT2: next_state = BIT3;
            BIT3: next_state = BIT4;
            BIT4: next_state = BIT5;
            BIT5: next_state = BIT6;
            BIT6: next_state = BIT7;
            BIT7: next_state = BIT8;
            BIT8: next_state = in ? STOP:ERROR;
            STOP: next_state = in ? IDLE:START;
            ERROR: next_state = in ? IDLE:ERROR;
			default: next_state = IDLE;
        endcase
    end
    
    always@(*)begin
        done = (curr_state == STOP);
    end
    
	//datapath implement
    always@(posedge clk)begin
        if(reset)
            out_byte <= 8'd00;
        else begin
            case(next_state)
                BIT1: out_byte <= {in, out_byte[7:1]};
				BIT2: out_byte <= {in, out_byte[7:1]};
				BIT3: out_byte <= {in, out_byte[7:1]};
				BIT4: out_byte <= {in, out_byte[7:1]};
				BIT5: out_byte <= {in, out_byte[7:1]};
				BIT6: out_byte <= {in, out_byte[7:1]};
				BIT7: out_byte <= {in, out_byte[7:1]};
				BIT8: out_byte <= {in, out_byte[7:1]};
            endcase
        end
    end
endmodule


//Serial receiver with parity checking
module top_module(
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	parameter [3:0] IDLE=4'd00;
    parameter [3:0] START=4'd01;
    parameter [3:0] BIT1=4'd02;
    parameter [3:0] BIT2=4'd03;
    parameter [3:0] BIT3=4'd04;
    parameter [3:0] BIT4=4'd05;
    parameter [3:0] BIT5=4'd06;
    parameter [3:0] BIT6=4'd07;
    parameter [3:0] BIT7=4'd08;
    parameter [3:0] BIT8=4'd09;
	parameter [3:0] PARITY=4'd10;
    parameter [3:0] STOP=4'd11;
    parameter [3:0] ERROR=4'd12; 
    
    reg [3:0] curr_state, next_state;
	
	wire odd;
	reg [7:0] par_in;
    
    always@(posedge clk)begin
        if(reset)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end
    always@(*)begin
        case(curr_state)
            IDLE: next_state = in ? IDLE:START;
            START:begin
				next_state = BIT1;
				par_in[0] = in;
			end			
            BIT1: begin
				next_state = BIT2;
				par_in[1] = in;
			end
            BIT2: begin
				next_state = BIT3;
				par_in[2] = in;
			end
            BIT3:begin
				next_state = BIT4;
				par_in[3] = in;
			end
            BIT4:begin
				next_state = BIT5;
				par_in[4] = in;
			end
            BIT5:begin 
				next_state = BIT6;
				par_in[5] = in;
			end
            BIT6:begin
				next_state = BIT7;
				par_in[6] = in;
			end
            BIT7:begin
				next_state = BIT8;
				par_in[7] = in;
			end
            BIT8: next_state = PARITY;
			PARITY: next_state = in ? STOP:ERROR;
            STOP: next_state = in ? IDLE:START;
            ERROR: next_state = in ? IDLE:ERROR;
			default: next_state = IDLE;
        endcase
    end
    
       always@(posedge clk)begin
        if(reset)begin
            done <= 1'b0;
        end
        else if(next_state == STOP && odd == 1'b1)begin
            done <= 1'b1;
        end
        else begin
            done <= 1'b0;
        end
    end  
	
    always@(posedge clk)begin
        if(reset)begin
            out_byte <= 8'd0;
        end
        else if(next_state == STOP && odd == 1'b1)begin
            out_byte <= par_in;
        end
        else begin
            out_byte <= 8'd0;
        end
    end 
	
	wire en;
	assign en = (reset == 1'b1 || next_state == IDLE || next_state == START);
	
	parity u_parity(
		.clk(clk),
		.reset(en),
		.in(in),
		.odd(odd)
	);
	
endmodule