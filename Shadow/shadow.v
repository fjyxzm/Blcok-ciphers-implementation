`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:21:35 10/08/2020 
// Design Name: 
// Module Name:    shadow03 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module  shadow03(result,state,key,clk);
    input  clk;
    input  [31:0] state;
    input  [63:0] key;
    output [31:0] result;
    
    reg [ 6:0] count;
    wire[63:0] k_out;
    reg [63:0] r_keys;
	 
    wire[7:0] in0,in1;
	 reg[7:0] key_in;
	 wire[7:0] out0,out1;
	 wire[15:0] branch_out;
	 reg[31:0] m_state;
	 reg x;

	 initial begin
	     count  <= 7'd0;	  
		  x<=0;
	 end
	 always @(posedge clk) begin	
		  if(x==1'b0) r_keys <= key; 
		  else if (count==7'd8) r_keys <= key; 
		  else if(count[1:0]==2'd3 )	r_keys <= k_out;
		  else r_keys <= r_keys;	 	
		if (x==1'b0) count<=7'd8;
		else if(count^7'd65 ) count <= count +1; 
		x<=1;
    end
	 
    always @(posedge clk) begin	
		  if(x==1'b0) m_state <= state;
		  else if(count[1:0]==2'd3) m_state <= {branch_out[7:0],m_state[15:8],m_state[7:0],branch_out[15:8]};
		  else if(count ^ 7'd65 ) m_state <= {m_state[15:0],branch_out};	 	
		  else m_state <= m_state;	 		  
    end
	 
	 always @(count) begin

		case(count[1:0])
			2'b00:begin
				//in0 = m_state[31:24];
				//in1 = m_state[23:16];
				key_in = r_keys[63:56];
				//m_state <= {m_state[31:24],m_state[23:16],branch_out};				
			end
			
			2'b01:begin
				//in0 = m_state[15:8];
				//in1 = m_state[7:0];
				key_in = r_keys[55:48];
				//m_state <= {branch_out,m_state[15:8],m_state[7:0]};							
			end
			
			2'b10:begin
				//in0 = m_state[23:16];
				//in1 = m_state[31:24];
				key_in = r_keys[47:40];
				//m_state <= {m_state[31:24],m_state[23:16],branch_out};
			end
			
			2'b11:begin
				//in0 = m_state[7:0];
				//in1 = m_state[15:8];
				key_in = r_keys[39:32];
				//m_state <= {m_state[15:8],branch_out[7:0],branch_out[15:8],m_state[7:0]};
			end			
		endcase	
	 end
	 assign in0 = m_state[31:24];
	 assign in1 = m_state[23:16];
	 branch2 b00(in0, in1, key_in, out0, out1);
	 key_expansion ex(r_keys, count[6:2], k_out);
	 assign branch_out = {out1,out0};
	 assign result = {m_state[23:16], m_state[15:8], m_state[31:24],m_state[7:0]};
endmodule



module  shadow03fjy(result,state,key,clk);
    input  clk;
    input  [31:0] state;
    input  [63:0] key;
    output [31:0] result;
    
    reg [ 6:0] count;
    wire[63:0] k_out;
    reg [63:0] r_keys;
	 
    reg[7:0] in0,in1,key_in;
	 wire[7:0] out0,out1;
	 reg[31:0] branch_out;
	 reg[31:0] m_state;

	 initial begin
	     count  <= 7'd0;	 
	 end
	 always @(posedge clk) begin	
		  count <=  count^64 ? count+1:count;
		  m_state <= count^64 ?((count)?state:branch_out):m_state;
		  r_keys <= (count)?key:r_keys;
    end	 
	 always @(posedge count[2]) begin	
	     r_keys <= k_out;
	 end  	 
	 always @(count) begin
		case(count[1:0])
			2'b00:begin
				key_in = r_keys[63:56];
				branch_out <= {m_state[31:24],m_state[23:16],out0,out1};				
			end
			
			2'b01:begin
				key_in = r_keys[55:48];
				branch_out <= {out0,out1,m_state[15:8],m_state[7:0]};							
			end
			
			2'b10:begin
				key_in = r_keys[47:40];
				branch_out <= {m_state[31:24],m_state[23:16],out0,out1};
			end
			
			2'b11:begin
				key_in = r_keys[39:32];
				branch_out <= {m_state[15:8],out1,out0,m_state[7:0]};
			end			
		endcase	
	 end
	 branch2 b00(m_state[31:24], m_state[23:16], key_in, out0, out1);
	 key_expansion ex(r_keys, count[6:2], k_out);
	 
	 assign result = {m_state[23:16], m_state[15:8], m_state[31:24],m_state[7:0]};
endmodule

