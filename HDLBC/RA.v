`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:14:45 04/14/2022 
// Design Name: 
// Module Name:    RA 
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
module RA(state,keys,Lout0, Lout1);
input [0:63] state;//明文
input [0:15] keys;//密钥

output[0:15] Lout0,Lout1;

wire[0:15] tem0,keyxor;

//循环移位
assign tem0 =~({state[1:15],state[0]}&{state[40:47],state[32:39]});

assign keyxor=tem0^keys^state[32:47];
assign Lout0 = keyxor ^ state[16:31];
assign Lout1 = keyxor ^ state[48:63];

endmodule
