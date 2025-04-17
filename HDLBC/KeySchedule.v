`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:40:23 04/14/2022 
// Design Name: 
// Module Name:    KeySchedule 
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
module KeySchedule(key,rkeys,rc);
input [0:63] key; //√‹‘ø
input [0:4] rc;

output[0:63] rkeys;

wire[0:63] p0;
wire [0:31] l0,r0;

//—≠ª∑“∆Œª

//P∫–÷√ªª
PBox Pb(p0,key);

assign l0=~({p0[16:31],p0[0:15]}&p0[32:63]);
assign r0=l0^p0[32:63];

assign rkeys={l0,r0[0:26],r0[27:31]^rc};


endmodule
