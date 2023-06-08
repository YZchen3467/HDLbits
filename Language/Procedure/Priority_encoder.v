/*Procedures*/
//Priority encoder(case1)	
module top_module(	input [3:0] in,
					output reg [1:0] pos);
	always@(*) begin
		case(in)
			4'b0001: begin
				pos = 2'd0;
			end
			4'b0010: begin
				pos = 2'd1;
			end
			4'b0011: begin
				pos = 2'd0;
			end
			4'b0100: begin
				pos = 2'd2;
			end
			4'b0101: begin
				pos = 2'd0;
			end
			4'b0110: begin
				pos = 2'd1;
			end
			4'b0111: begin
				pos = 2'd0;
			end
			4'b1000: begin
				pos = 2'd3;
			end
			4'b1001: begin
				pos = 2'd0;
			end
			4'b1010: begin
				pos = 2'd1;
			end
			4'b1011: begin
				pos = 2'd0;
			end
			4'b1100: begin
				pos = 2'd2;
			end
			4'b1101: begin
				pos = 2'd0;
			end
			4'b1110: begin
				pos = 2'd1;
			end
			4'b1111: begin
				pos = 2'd0;
			end
			default: begin
				pos = d'0;
			end
		endcase
	end
endmodule

///////////////////////////////////

//Priority encoder(case2)
module top_module(	input [3:0] in,
					output reg [1:0] pos);
	always@(*) begin
		case(1) //case(1) mean: the lowest bit have 1 is priority.
			in[0]: begin
				pos = 2'd0;
				end
			in[1]: begin
				pos = 2'd1;
				end
			in[2]: begin
				pos = 2'd2;
				end
			in[3]: begin
				pos = 2'd3;
				end
			default: begin
				pos = 2'd0;
			end
		endcase
	end
endmodule

//////////////////////////////////

//Priority encoder(casez)
module top_module(	input [3:0] in,
					output reg [1:0] pos);

	always@(*) begin
		casez(in)
			4'bzzz1: begin
				pos = 2'd0;
				end
			4'bzz10: begin
				pos = 2'd1;
				end
			4'bz100: begin
				pos = 2'd2;
				end
			4'b1000: begin
				pos = 2'd3;
				end
			default: begin
				pos = 2'd0;
			end
		endcase
	end
endmodule

////////////////////////////////

//Priority encoder(casex)
module top_module(	input [3:0] in,
					output reg [1:0] pos);
	
	always@(*) begin
		casex(in)
			4'bxxx1: begin
				pos = 2'd0;
				end
			4'bxx1x: begin
				pos = 2'd1;
				end
			4'bx1xx: begin
				pos = 2'd2;
				end
			4'b1xxx: begin
				pos = 2'd3;
				end
			default: begin
				pos = 2'd0;
			end
		endcase
	end
endmodule

///////////////////////////////

//Priority encoder with casez
module top_module(	input [7:0] in,
                  	output reg [2:0] pos);

	always@(*) begin
		casez(in)
			8'bzzzz_zzz1: begin
				pos = 3'd0;
				end
			8'bzzzz_zz10: begin
				pos = 3'd1;
				end
			8'bzzzz_z100: begin
				pos = 3'd2;
				end
			8'bzzzz_1000: begin
				pos = 3'd3;
				end
            8'bzzz1_0000: begin
				pos = 3'd4;
				end
            8'bzz10_0000: begin
				pos = 3'd5;
				end
            8'bz100_0000: begin
				pos = 3'd6;
				end
            8'b1000_0000: begin
				pos = 3'd7;
				end
			default: begin
				pos = 3'd0;
			end
		endcase
	end
endmodule