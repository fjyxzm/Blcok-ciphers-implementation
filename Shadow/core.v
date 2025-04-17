`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:25:05 10/08/2020 
// Design Name: 
// Module Name:    core 
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
//module core (x, k, round,r_keys, y);
module core (x, k, round,r_keys, out0, out1);
    input [31:0] x;
    input [63:0] k;
	//input [4:0] round;
   //output reg[31:0] y;
    output [63:0] r_keys;
   //wire [7:0] u_0,u_1;
	//wire [7:0] v_0,v_1;
	//wire [7:0] x_0,x_1;
	//wire [7:0] y_0,y_1;
   // wire [31:0] y_7,y_8;
	
	 output[7:0] out0,out1;
	 input [5:0] round;
	 reg [7:0] in0,in1,key;
	 
	 
	 always @(round) begin
		case(round[1:0])
			2'b00:begin
				in0 = x[31:24];
				in1 = x[23:16];
				key = r_keys[63:56];
				y[31:24] = out1;
				y[23:16] = out0;
				y[15:8] = y[15:8];
				y[7:0] = y[7:0];
			end
			2'b01:begin
				in0 = x[15:8];
				in1 = x[7:0];
				key = r_keys[55:48];
				y[31:24] = y[31:24];
				y[23:16] = y[23:16];
				y[15:8] = out1;
				y[7:0] = out0;
			end
			2'b10:begin
				in0 = y[31:24];
				in1 = y[23:16];
				key = r_keys[47:40];
				y[31:24] = (round^6'd64)?out0:out1;
				y[23:16] = (round^6'd64)?out1:out0;
				y[15:8] = y[15:8];
				y[7:0] = y[7:0];
			end
			2'b11:begin
				in0 = y[15:8];
				in1 = y[7:0];
				key = r_keys[39:32];
				y[31:24] = y[31:24];
				y[23:16] = y[23:16];
				y[15:8] = (round^6'd64)?out0:out1;
				y[7:0] = (round^6'd64)?out1:out0;
			end			
		endcase
	 end
  
   
	
	
	
	/*
	branch2 b00(x[31:24],x[23:16],r_keys[63:56],u_0,v_0);
	branch2 b01(x[15:8],x[7:0],r_keys[55:48],u_1,v_1);
	branch2 b02(v_0,u_0,r_keys[47:40],x_0,y_0);
	branch2 b03(v_1,u_1,r_keys[39:32],x_1,y_1);
	assign y_7={x_1,y_0,x_0,y_1};
	assign y_8={x_0,y_0,x_1,y_1};
	
	always @(*)  
    begin
        y <= (round^5'h10)? y_7:y_8;
       
    end
	 */
    
endmodule

