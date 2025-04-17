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
module prince_core(data_in,key,rc,rc0,data_out);
	input [63:0] data_in,key;
	input [2:0] rc;
	input rc0;
	output [63:0] data_out;
	reg [63:0] ai[0:5];
	reg [63:0] ai0[0:5];	
	reg [3:0] sbox[0:15],sbox_inv[0:15];
	wire [63:0] sb_out,nsb_out,sr_out,nsr_out,xor_out,nxor_out,m1,m2,m3;
	initial  begin
		 ai[0]=64'h000000000000000;
       ai[1]=64'h13198A2E03707344;
       ai[2]=64'hA4093822299F31D0;
       ai[3]=64'h082EFA98EC4E6C89; 
       ai[4]=64'h452821E638D01377; 
       ai[5]=64'hBE5466CF34E90C6C; 
		 ai0[0]=64'h000000000000000;
		 ai0[1]=64'h7EF84F78FD955CB1;
       ai0[2]=64'h85840851F1AC43AA;
       ai0[3]=64'hC882D32F25323C54; 
       ai0[4]=64'h64A51195E0E3610D; 
       ai0[5]=64'hD3B5A399CA0C2399;
		 
       sbox[0]=11; sbox[ 1]=15; sbox[2]=3; sbox[ 3]=2;
       sbox[4]=10; sbox[ 5]=12; sbox[6]=9; sbox[ 7]=1;
       sbox[8]= 6; sbox[ 9]= 7; sbox[10]=8; sbox[11]=0;
       sbox[12]=14; sbox[13]= 5; sbox[14]=13; sbox[15]=4;
		 
		 
       sbox_inv[0]=11; sbox_inv[ 1]=7; sbox_inv[2]=3; sbox_inv[ 3]=2;
       sbox_inv[4]=15; sbox_inv[ 5]=13; sbox_inv[6]=8; sbox_inv[ 7]=9;
       sbox_inv[8]=10; sbox_inv[ 9]= 6; sbox_inv[10]=4; sbox_inv[11]=0;
       sbox_inv[12]=5; sbox_inv[13]= 14; sbox_inv[14]=12; sbox_inv[15]=1;
	end
	assign sb_out={
	  sbox[data_in[63:60]],sbox[data_in[59:56]],sbox[data_in[55:52]],sbox[data_in[51:48]],
	  sbox[data_in[47:44]],sbox[data_in[43:40]],sbox[data_in[39:36]],sbox[data_in[35:32]],
	  sbox[data_in[31:28]],sbox[data_in[27:24]],sbox[data_in[23:20]],sbox[data_in[19:16]],
	  sbox[data_in[15:12]],sbox[data_in[11: 8]],sbox[data_in[ 7: 4]],sbox[data_in[ 3: 0]]
   };
	
	assign nxor_out = {data_in[63:49] ^ key[63:49] ^ ai0[rc][63:49],data_in[48] ^ key[48],
			data_in[47:0] ^ key[47:0] ^ ai0[rc][47:0]};
	
	linear_m_inv nsr(nxor_out,nsr_out);
	
	assign m1 = (rc0==1'b0)?sb_out:((rc==3'b000)?sb_out:nsr_out);
	
	linear_mprime m(m1,m2);
	
	assign nsb_out={
	  sbox_inv[m2[63:60]],sbox_inv[m2[59:56]],sbox_inv[m2[55:52]],sbox_inv[m2[51:48]],
	  sbox_inv[m2[47:44]],sbox_inv[m2[43:40]],sbox_inv[m2[39:36]],sbox_inv[m2[35:32]],
	  sbox_inv[m2[31:28]],sbox_inv[m2[27:24]],sbox_inv[m2[23:20]],sbox_inv[m2[19:16]],
	  sbox_inv[m2[15:12]],sbox_inv[m2[11: 8]],sbox_inv[m2[ 7: 4]],sbox_inv[m2[ 3: 0]]
   };
	
	linear_m sr(m2,sr_out);
	
	assign xor_out = {sr_out[63:49] ^ key[63:49] ^ ai[rc][63:49],sr_out[48] ^ key[48],
			sr_out[47:0] ^ key[47:0] ^ ai[rc][47:0]};
	
	assign data_out = (rc0==1'b1)?nsb_out:xor_out;
endmodule
