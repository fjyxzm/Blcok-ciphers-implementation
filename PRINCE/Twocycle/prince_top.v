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
 module prince_top(plaintext,wk,key,clk,ciphertext);
	input  clk;
   input  [63:0] plaintext;
   input  [63:0] wk,key;
   output [63:0] ciphertext;
    
   wire   [63:0] te,m2,m3,m4,wk,c;
   reg    [63:0] res;
   reg    ctr;
	wire [63:0] m[1:5],m1[1:5];
	reg [63:0] ai[1:5];
	wire [383:0] rc;
	initial  begin
		ai[1]=64'h13198A2E03707344;
      ai[2]=64'hA4093822299F31D0;
      ai[3]=64'h082EFA98EC4E6C89; 
      ai[4]=64'h452821E638D01377; 
      ai[5]=64'hBE5466CF34E90C6C;
		
		ctr  <= 1'b0;
    end
	
	
	 assign ciphertext = c;
    always @(posedge  clk)  begin 
        ctr  <= 1'b1;
        res <= ctr ? res:m4;
    end
   assign rc = (ctr==1'b1)?{wk,ai[5],ai[4],ai[3],ai[2],ai[1]}:{key,ai[1],ai[2],ai[3],ai[4],ai[5]};	
	  
    //prince_core  p_0(res,wk,key[63:0],ctr,te,c,plaintext^key[63:0]^key[127:64]);
	prince_core c1(plaintext,res,rc[383:320],ctr,rc[319:256],m[1],m1[1]);
	prince_core c2(m[1],m1[1],rc[383:320],ctr,rc[255:192],m[2],m1[2]);	
	prince_core c3(m[2],m1[2],rc[383:320],ctr,rc[191:128],m[3],m1[3]);
	prince_core c4(m[3],m1[3],rc[383:320],ctr,rc[127:64],m[4],m1[4]);
	prince_core c5(m[4],m1[4],rc[383:320],ctr,rc[63:0],te,c);
	
	sms ss(te,m4);
	
endmodule
