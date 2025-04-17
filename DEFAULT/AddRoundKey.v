`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:15:13 09/20/2021 
// Design Name: 
// Module Name:    AddRoundKey 
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
module AddRoundKey(adkin, keyin, adkout);
	 input [127:0]adkin,keyin;
    output [127:0]adkout;
	assign adkout=adkin^keyin;
endmodule
