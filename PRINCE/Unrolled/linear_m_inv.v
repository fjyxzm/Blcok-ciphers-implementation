`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:17:03 09/20/2020 
// Design Name: 
// Module Name:    linear_m_inv 
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
module linear_m_inv(data_in,data_out);
	input [63:0] data_in;
	output [63:0] data_out;
	wire [63:0] mp;
   
	assign mp[63:60] = data_in[63:60];
	assign mp[59:56] = data_in[11:8];
	assign mp[55:52] = data_in[23:20];
	assign mp[51:48] = data_in[35:32];
	assign mp[47:44] = data_in[47:44];
	assign mp[43:40] = data_in[59:56];
	assign mp[39:36] = data_in[7:4];
	assign mp[35:32] = data_in[19:16];
	assign mp[31:28] = data_in[31:28];
	assign mp[27:24] = data_in[43:40];
	assign mp[23:20] = data_in[55:52];
	assign mp[19:16] = data_in[3:0];
	assign mp[15:12] = data_in[15:12];
	assign mp[11:8]  = data_in[27:24];
	assign mp[7:4]   = data_in[39:36];
	assign mp[3:0]   = data_in[51:48];
	
	linear_mprime mp0(mp,data_out);
  
endmodule
