`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:39 09/20/2020 
// Design Name: 
// Module Name:    prince_core 
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
module prince_core(data_in,key,rc,data_out);
	input[63:0] data_in,key,rc;
	output [63:0] data_out;
	
	wire [63:0] sb_out,m_out,m_out0,xor_out;
	
	
	sbox s1(data_in,sb_out);
	
	linear_m m_0(sb_out,m_out);
		
	addkeyancon akc1(m_out,key,rc,data_out);
	
	//	addkeyancon akc2(data_in0,key,rc,xor_out);
	
	//linear_m_inv m_1(xor_out,m_out0);
	
	//invsbox s2(m_out0,data_out0);
			
endmodule

module prince_core1(data_in,key,rc,data_out);
	input[63:0] data_in,key,rc;
	output [63:0] data_out;
	
	wire [63:0] m_out,xor_out;
	
	addkeyancon akc2(data_in,key,rc,xor_out);
	
	linear_m_inv m_1(xor_out,m_out);
	
	invsbox s1(m_out,data_out);
				
endmodule

module sbox(data_in,data_out);
	input [63:0] data_in;
	output [63:0] data_out;
	reg [3:0] sbox[0:15];
	initial  begin
	
       sbox[0]=11; sbox[ 1]=15; sbox[2]=3; sbox[ 3]=2;
       sbox[4]=10; sbox[ 5]=12; sbox[6]=9; sbox[ 7]=1;
       sbox[8]= 6; sbox[ 9]= 7; sbox[10]=8; sbox[11]=0;
       sbox[12]=14; sbox[13]= 5; sbox[14]=13; sbox[15]=4;
		 
	end
	assign data_out={
	  sbox[data_in[63:60]],sbox[data_in[59:56]],sbox[data_in[55:52]],sbox[data_in[51:48]],
	  sbox[data_in[47:44]],sbox[data_in[43:40]],sbox[data_in[39:36]],sbox[data_in[35:32]],
	  sbox[data_in[31:28]],sbox[data_in[27:24]],sbox[data_in[23:20]],sbox[data_in[19:16]],
	  sbox[data_in[15:12]],sbox[data_in[11: 8]],sbox[data_in[ 7: 4]],sbox[data_in[ 3: 0]]
	};
endmodule

module invsbox(data_in,data_out);
	input [63:0] data_in;
	output [63:0] data_out;
	reg [3:0] sbox_inv[0:15];
	initial  begin
			 
       sbox_inv[0]=11; sbox_inv[ 1]=7; sbox_inv[2]=3; sbox_inv[ 3]=2;
       sbox_inv[4]=15; sbox_inv[ 5]=13; sbox_inv[6]=8; sbox_inv[ 7]=9;
       sbox_inv[8]=10; sbox_inv[ 9]= 6; sbox_inv[10]=4; sbox_inv[11]=0;
       sbox_inv[12]=5; sbox_inv[13]= 14; sbox_inv[14]=12; sbox_inv[15]=1;
		 
	end
	assign data_out={
	  sbox_inv[data_in[63:60]],sbox_inv[data_in[59:56]],sbox_inv[data_in[55:52]],sbox_inv[data_in[51:48]],
	  sbox_inv[data_in[47:44]],sbox_inv[data_in[43:40]],sbox_inv[data_in[39:36]],sbox_inv[data_in[35:32]],
	  sbox_inv[data_in[31:28]],sbox_inv[data_in[27:24]],sbox_inv[data_in[23:20]],sbox_inv[data_in[19:16]],
	  sbox_inv[data_in[15:12]],sbox_inv[data_in[11: 8]],sbox_inv[data_in[ 7: 4]],sbox_inv[data_in[ 3: 0]]
	};
endmodule
