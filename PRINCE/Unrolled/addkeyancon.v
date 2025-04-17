`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:45:30 10/28/2020 
// Design Name: 
// Module Name:    addkeyancon 
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
module addkeyancon(data_in,k1,k,data_out);
 input[63:0] data_in,k1,k;
 output[63:0] data_out;
 
 assign data_out = data_in ^ k1 ^ k;

endmodule
