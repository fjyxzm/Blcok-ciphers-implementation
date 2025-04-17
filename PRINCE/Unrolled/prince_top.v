`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:46:29 09/20/2020 
// Design Name: 
// Module Name:    prince_top 
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
module prince_top(plaintext,key,ciphertext);
	input [63:0] plaintext;
	input [127:0] key;
	output [63:0] ciphertext;	
	wire [63:0] m[0:11],m1,m2,subkey;
	reg [63:0] ai[1:5];
	initial  begin
		ai[1]=64'h13198A2E03707344;
      ai[2]=64'hA4093822299F31D0;
      ai[3]=64'h082EFA98EC4E6C89; 
      ai[4]=64'h452821E638D01377; 
      ai[5]=64'hBE5466CF34E90C6C;
	end
	
	addkeyancon akc1(plaintext,key[127:64],key[63:0],m[0]);
	// Round 1 to 5
	
	prince_core p001(m[0],key[63:0],ai[1],m[1]);
	prince_core p011(m[1],key[63:0],ai[2],m[2]);
	prince_core p021(m[2],key[63:0],ai[3],m[3]);
	prince_core p031(m[3],key[63:0],ai[4],m[4]);
	prince_core p041(m[4],key[63:0],ai[5],m[5]);
	
	//Middle layer
	
	sbox s1(m[5],m1);
	
	linear_mprime mm1(m1,m2);
	
	invsbox ss1(m2,m[6]);
	
	//Round 6 to 10
	getk11 k11(key[63:0],subkey);
	
	prince_core1 p101(m[6],subkey,ai[5],m[7]);	
	prince_core1 p111(m[7],subkey,ai[4],m[8]);	
	prince_core1 p121(m[8],subkey,ai[3],m[9]);
	prince_core1 p131(m[9],subkey,ai[2],m[10]);
	prince_core1 p141(m[10],subkey,ai[1],m[11]);
     
   addkeyancon akc31(m[11],subkey,{key[64],key[127:66],key[65]^ key[127]},ciphertext);	
	 
endmodule

module getk11(key,wk);
   input  [63:0] key;
   output [63:0] wk;
	assign wk = {~key[63:62],key[61:56],~key[55],key[54],~key[53],
		key[52],~key[51:50],key[49:46],~key[45],key[44],
		~key[43],key[42:41],~key[40:39],key[38],~key[37:36],
		key[35],~key[34:30],key[29:28],~key[27],key[26:25],
		~key[24],key[23],~key[22:18],key[17:15],~key[14],
		key[13],~key[12],key[11:8],~key[7:6],key[5],
		~key[4:2],key[1],~key[0]};
endmodule