`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:14:33 09/20/2020 
// Design Name: 
// Module Name:    linear_m 
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
module linear_m(data_in,data_out);
	input [63:0] data_in;
	output [63:0] data_out;
	wire [63:0] mp;
   linear_mprime mp1(data_in, mp);
	assign data_out[63:60] = mp[63:60];
	assign data_out[59:56] = mp[43:40];
	assign data_out[55:52] = mp[23:20];
	assign data_out[51:48] = mp[3:0];
	assign data_out[47:44] = mp[47:44];
	assign data_out[43:40] = mp[27:24];
	assign data_out[39:36] = mp[7:4];
	assign data_out[35:32] = mp[51:48];
	assign data_out[31:28] = mp[31:28];
	assign data_out[27:24] = mp[11:8];
	assign data_out[23:20] = mp[55:52];
	assign data_out[19:16] = mp[35:32];
	assign data_out[15:12] = mp[15:12];
	assign data_out[11:8]  = mp[59:56];
	assign data_out[7:4]   = mp[39:36];
	assign data_out[3:0]   = mp[19:16];

endmodule
