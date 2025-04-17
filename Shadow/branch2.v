`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:25:45 10/08/2020 
// Design Name: 
// Module Name:    branch2 
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
module branch2(Lin,Rin,key,Lout,Rout);
input [7:0]  Lin,Rin,key;
output [7:0] Lout,Rout;

wire [7:0]  rol0_1, rol0_7, rol0_2;

    
   assign rol0_1 = {Lin[6:0], Lin[7]};
   assign rol0_2 = {Lin[5:0], Lin[7:6]};
   assign rol0_7 = {Lin[0], Lin[7:1]};
   
   assign Rout=(((rol0_1 & rol0_7) ^ Rin) ^ rol0_2) ^ key;
   assign Lout=Lin;

endmodule 
