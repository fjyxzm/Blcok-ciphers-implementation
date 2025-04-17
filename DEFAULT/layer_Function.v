`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:00:58 09/20/2021 
// Design Name: 
// Module Name:    layer_Function 
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

module layer_Function(plain, key, rcon, cipher,tkey,rcc);
	 input [127:0]plain, key;
    input [4:0]rcon;
    input [1:0]rcc;
    output [127:0]cipher,tkey;
	 
	wire[127:0] sout,sout_c,sout_l,pout,arcout;
	Subsell_layer sl(plain,sout_l);
	SubCell_core scl(plain,sout_c);
	assign sout= (rcc==2'b01)?sout_c:sout_l;
	PermBits_Layer pl(sout,pout);
	AddRoundConstants arc(pout,rcon,arcout);
	KeySchedule ks(key,tkey);
	AddRoundKey adk(arcout,key,cipher);
endmodule
