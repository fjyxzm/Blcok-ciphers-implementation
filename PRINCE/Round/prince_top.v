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
module prince_top(plaintext,key,clk,ciphertext);
	input  clk;
   input  [63:0] plaintext;
   input  [127:0] key;
   output [63:0] ciphertext;
    
   wire   [63:0] te,middle3;
   reg    [63:0] res;
   reg    [ 2:0] rc;
	reg	 rc0;
	reg	 rc1;
   reg    ready;
	
	initial  begin 
      rc  <= 3'b000;
		rc0  <= 1'b0;
      ready<=1'b1;
    end
	 assign middle3 = res ^key[63:0] ^ {key[64],key[127:66],key[65]^ key[127]};
	 assign ciphertext = {~middle3[63:62],middle3[61:56],~middle3[55],middle3[54],~middle3[53],
middle3[52],~middle3[51:50],middle3[49:46],~middle3[45],middle3[44],
~middle3[43],middle3[42:41],~middle3[40:39],middle3[38],~middle3[37:36],
middle3[35],~middle3[34:30],middle3[29:28],~middle3[27],middle3[26:25],
~middle3[24],middle3[23],~middle3[22:18],middle3[17:15],~middle3[14],
middle3[13],~middle3[12],middle3[11:8],~middle3[7:6],middle3[5],
~middle3[4:2],middle3[1],~middle3[0]};
    always @(posedge  clk)  begin
        
        rc0    <= (rc0)?rc0:((rc^5)? rc0: 1'b1);
		  rc     <= (rc^3'b101)?(rc+1'b1):((rc0)?rc:3'b000);
        res <= ready ? ( (rc0)?te:((rc)?te:(plaintext^key[127:64]^key[63:0]))):res;
        ready  <= (rc0)?((rc^5)?1'b1:1'b0):1'b1;
    end
     
    prince_core  p_0(res,key[63:0],rc,rc0,te);
	 
endmodule
