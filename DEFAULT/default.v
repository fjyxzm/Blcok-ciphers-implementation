`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:26:21 09/20/2021 
// Design Name: 
// Module Name:    Default_Top 
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
module Default_Top(plain, key, clk, cipher);
	
	input  clk;
   input  [127:0] plain, key;
   output [127:0] cipher;
    
   wire   [127:0] te;
   wire   [127:0] tkey;
   reg    [127:0] res;
   reg    [127:0] rkey;
   reg    [ 4:0] rc;
   reg    ready;
	reg    [ 1:0] rcc;
	
	initial  begin 
      rc  <= 5'b000000;
      ready<=1'b1;
		rcc<=2'b00;
    end
	 assign cipher = res;
    always @(posedge  clk)  begin
        
		  rc <= (rcc==2'b00)?((rc^5'b11100)?rc+1'b1:5'b00001):((rcc==2'b01)?((rc^5'b11000)?rc+1'b1:5'b00001):(rc^5'b11100)?rc+1'b1:rc);
		  rcc<=(rcc==2'b00&&rc==5'b11100)?2'b01:((rcc==2'b01&&rc==5'b11000)?2'b10:((rcc==2'b10&&rc==5'b11100)?2'b10:rcc));
        res <= ready ? ((rc)?te:plain):res;
		  rkey <= ready ? ((rcc==2'b01|rc==5'b11100)?tkey:key):rkey;
      
        ready  <= ((rcc==2'b10)&(rc==5'b11100))?1'b0:1'b1;
    end
     
    layer_Function  l_0(res,rkey,rc,te,tkey,rcc);

endmodule
