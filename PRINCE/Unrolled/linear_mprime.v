`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:12 09/20/2020 
// Design Name: 
// Module Name:    linear_mprime 
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
module linear_mprime(data_in,data_out);
	input [63:0] data_in;
	output [63:0] data_out;
	wire [31:0] ims;
    		  assign ims[0] = data_in[59] ^ data_in[55];
		  assign ims[1] = data_in[54] ^ data_in[50];		  
		  assign ims[2] = data_in[61] ^ data_in[49];
		  assign ims[3] = data_in[60] ^ data_in[56];
		  
        assign data_out[63] = ims[0] ^ data_in[51];
        assign data_out[62] = data_in[62] ^ ims[1];
        assign data_out[61] = data_in[57] ^ ims[2];
        assign data_out[60] = ims[3] ^ data_in[52];
        assign data_out[59] = data_in[63] ^ ims[0];
        assign data_out[58] = data_in[58] ^ ims[1];
        assign data_out[57] = data_in[53] ^ ims[2];
        assign data_out[56] = ims[3] ^ data_in[48];
		  
		  assign ims[4] = data_in[63] ^ data_in[51];
		  assign ims[5] = data_in[62] ^ data_in[58];		  
		  assign ims[6] = data_in[57] ^ data_in[53];
		  assign ims[7] = data_in[52] ^ data_in[48];
		  
        assign data_out[55] = data_in[59] ^ ims[4];
        assign data_out[54] = ims[5] ^ data_in[54];
        assign data_out[53] = ims[6] ^ data_in[49];
        assign data_out[52] = data_in[60] ^ ims[7];
        assign data_out[51] = data_in[55] ^ ims[4];
        assign data_out[50] = ims[5] ^ data_in[50];
        assign data_out[49] = data_in[61] ^ ims[6];
        assign data_out[48] = data_in[56] ^ ims[7];
		  
		  assign ims[8] = data_in[47] ^ data_in[43];
		  assign ims[9] = data_in[42] ^ data_in[38];		  
		  assign ims[10] = data_in[37] ^ data_in[33];
		  assign ims[11] = data_in[44] ^ data_in[32];
		  
        assign data_out[47] = ims[8] ^ data_in[39];
        assign data_out[46] = ims[9] ^ data_in[34];
        assign data_out[45] = data_in[45] ^ ims[10];
        assign data_out[44] = ims[11] ^ data_in[40];
        assign data_out[43] = ims[8] ^ data_in[35];
        assign data_out[42] = data_in[46] ^ ims[9];
        assign data_out[41] = data_in[41] ^ ims[10];
        assign data_out[40] = ims[11] ^ data_in[36];
        
		  assign ims[12] = data_in[39] ^ data_in[35];
		  assign ims[13] = data_in[46] ^ data_in[34];		  
		  assign ims[14] = data_in[45] ^ data_in[41];
		  assign ims[15] = data_in[40] ^ data_in[36];
		  
		  assign data_out[39] = data_in[47] ^ ims[12];
        assign data_out[38] = ims[13] ^ data_in[42];
        assign data_out[37] = ims[14] ^ data_in[37];
        assign data_out[36] = ims[15] ^ data_in[32];
        assign data_out[35] = data_in[43] ^ ims[12];
        assign data_out[34] = ims[13] ^ data_in[38];
        assign data_out[33] = ims[14] ^ data_in[33];
        assign data_out[32] = data_in[44] ^ ims[15];
		  
		  assign ims[16] = data_in[31] ^ data_in[27];
		  assign ims[17] = data_in[26] ^ data_in[22];		  
		  assign ims[18] = data_in[21] ^ data_in[17];
		  assign ims[19] = data_in[28] ^ data_in[16];
		  
        assign data_out[31] = ims[16] ^ data_in[23];
        assign data_out[30] = ims[17] ^ data_in[18];
        assign data_out[29] = data_in[29] ^ ims[18];
        assign data_out[28] = ims[19] ^ data_in[24];
        assign data_out[27] = ims[16] ^ data_in[19];
        assign data_out[26] = data_in[30] ^ ims[17];
        assign data_out[25] = data_in[25] ^ ims[18];
        assign data_out[24] = ims[19] ^ data_in[20];
		  
		  assign ims[20] = data_in[23] ^ data_in[19];
		  assign ims[21] = data_in[30] ^ data_in[18];		  
		  assign ims[22] = data_in[29] ^ data_in[25];
		  assign ims[23] = data_in[24] ^ data_in[20];
		  
        assign data_out[23] = data_in[31] ^ ims[20];
        assign data_out[22] = ims[21] ^ data_in[26];
        assign data_out[21] = ims[22] ^ data_in[21];
        assign data_out[20] = ims[23] ^ data_in[16];
        assign data_out[19] = data_in[27] ^ ims[20];
        assign data_out[18] = ims[21] ^ data_in[22];
        assign data_out[17] = ims[22] ^ data_in[17];
        assign data_out[16] = data_in[28] ^ ims[23];

		  assign ims[24] = data_in[11] ^ data_in[7];
		  assign ims[25] = data_in[6]  ^ data_in[2];		  
		  assign ims[26] = data_in[13] ^ data_in[1];
		  assign ims[27] = data_in[12] ^ data_in[8];
		  
        assign data_out[15] = ims[24] ^ data_in[3];
        assign data_out[14] = data_in[14] ^ ims[25];
        assign data_out[13] = ims[26] ^ data_in[9];
        assign data_out[12] = ims[27] ^ data_in[4];
        assign data_out[11] = data_in[15] ^ ims[24];
        assign data_out[10] = data_in[10] ^ ims[25];
        assign data_out[9]  = ims[26] ^ data_in[5];
        assign data_out[8]  = ims[27] ^ data_in[0];
		   
		  assign ims[28] = data_in[15] ^ data_in[3];
		  assign ims[29] = data_in[14] ^ data_in[10];		  
		  assign ims[30] = data_in[9] ^ data_in[5];
		  assign ims[31] = data_in[4] ^ data_in[0];
		  
        assign data_out[7]  = ims[28] ^ data_in[11];
        assign data_out[6]  = ims[29] ^ data_in[6];
        assign data_out[5]  = ims[30] ^ data_in[1];
        assign data_out[4]  = data_in[12] ^ ims[31];
        assign data_out[3]  = ims[28] ^ data_in[7];
        assign data_out[2]  = ims[29] ^ data_in[2];
        assign data_out[1]  = ims[30] ^ data_in[13];
        assign data_out[0]  = data_in[8] ^ ims[31];
	
endmodule
