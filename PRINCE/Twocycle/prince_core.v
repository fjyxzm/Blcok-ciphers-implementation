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
//module prince_core(data_in,wk,key,ctr,data_out,cipher,plain);
//	input [63:0] data_in,key,plain,wk;
//	input ctr;
//	output [63:0] data_out,cipher;	
//	wire [63:0] m[1:5],m1[1:5],m2,m3,m4;//,rc0,rc1,rc2,rc3,rc4,in;
//	reg [63:0] ai[1:5];
//	wire [383:0] rc;
//	initial  begin
//		ai[1]=64'h13198A2E03707344;
//     ai[2]=64'hA4093822299F31D0;
//      ai[3]=64'h082EFA98EC4E6C89; 
//      ai[4]=64'h452821E638D01377; 
//      ai[5]=64'hBE5466CF34E90C6C;
//	end
	
//	assign rc = (ctr==1'b1)?{wk,ai[5],ai[4],ai[3],ai[2],ai[1]}:{key,ai[1],ai[2],ai[3],ai[4],ai[5]};	
	
//	subprince_core c1(plain,data_in,rc[383:320],ctr,rc[319:256],m[1],m1[1]);
//	subprince_core c2(m[1],m1[1],rc[383:320],ctr,rc[255:192],m[2],m1[2]);	
//	subprince_core c3(m[2],m1[2],rc[383:320],ctr,rc[191:128],m[3],m1[3]);
//	subprince_core c4(m[3],m1[3],rc[383:320],ctr,rc[127:64],m[4],m1[4]);
//	subprince_core c5(m[4],m1[4],rc[383:320],ctr,rc[63:0],m[5],m1[5]);
		
//	assign data_out = m[5];
//	assign cipher =m1[5];
	
//endmodule

module prince_core(data_in,data_in0,key,ctr,rc,data_out,data_out0);
	input[63:0] data_in,data_in0,key,rc;
	input ctr;
	output [63:0] data_out,data_out0;
	wire [63:0] ai0;//,subkey;	
	wire [63:0] sb_out,m_out,nsb_out,sr_out,xor_in,xor_out,nm_out,nsr_out;
	
	
	sm s11(data_in,m_out);
	linear_m sr(m_out,sr_out);//s2
	
	assign xor_in = (ctr==1'b1)?data_in0:sr_out;//s2  s1
	
	//assign subkey = (rc==1'b1)?key1:key;//s2  s1
	assign xor_out = xor_in ^ key ^ rc;
		
		linear_m_inv nsr_0(xor_out,nsr_out);
		
		linear_mprime m_2(nsr_out,nm_out);
		   
		invsbox inv1(nm_out,nsb_out);
		
		assign data_out  = xor_out;
		
		assign data_out0 = nsb_out;//s2  s1
			
endmodule

module sms(data_in,data_out);
	input[63:0] data_in;
	output [63:0] data_out;
	wire [63:0] ai0;//,subkey;	
	wire [63:0] sb_out;
	
	
	sm sm1(data_in,sb_out);
	
	invsbox inv1(sb_out,data_out);
			
endmodule

module sm(data_in,data_out);
	input[63:0] data_in;
	output [63:0] data_out;
	wire [63:0] sb_out;
	
	
	sbox s1(data_in,sb_out);
	
	linear_mprime m_0(sb_out,data_out);
			
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
