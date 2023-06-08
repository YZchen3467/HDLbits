/*PS/2 control*/
//PS/2 packet parser
module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    
    parameter IDLE = 0, BYTE1=1, BYTE2=2, BYTE3=3;
    reg [1:0] curr_state, next_state;
    
    always@(posedge clk)begin
    // State transition logic (combinational)
        if(reset)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end
    
    always@(*)begin
    // State flip-flops (sequential)
        case(curr_state)
        	IDLE:
                next_state = in[3] ? BYTE1:IDLE;
            BYTE1:
                next_state = BYTE2;
            BYTE2:
                next_state = BYTE3;
            BYTE3:
                next_state = in[3] ? BYTE1:IDLE;
            default: next_state = IDLE;
        endcase
    end
    
    always@(*)begin
    // Output logic
        done = (curr_state == BYTE3);
    end

endmodule

//PS/2 packet parser and datapath
module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    
    parameter IDLE = 0, BYTE1=1, BYTE2=2, BYTE3=3;
    reg [1:0] curr_state, next_state;
    
    always@(posedge clk)begin
    // State transition logic (combinational)
        if(reset)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end
    
    always@(*)begin
    // State flip-flops (sequential)
        case(curr_state)
        	IDLE:
                next_state = in[3] ? BYTE1:IDLE;
            BYTE1:
                next_state = BYTE2;
            BYTE2:
                next_state = BYTE3;
            BYTE3:
                next_state = in[3] ? BYTE1:IDLE;
            default: next_state = IDLE;
        endcase
    end
    
    always@(*)begin
    // Output logic
        done = (curr_state == BYTE3);
    end

    always@(posedge clk) begin
		if(reset)
			out_bytes <= 24'b0;
		else begin
            case(curr_state)
				IDLE: out_bytes[23:16] <= in;
				BYTE1: out_bytes[15:8] <= in;
				BYTE2: out_bytes[7:0] <= in;
				BYTE3: out_bytes[23:16]<=in;
			endcase
		end
	end
endmodule