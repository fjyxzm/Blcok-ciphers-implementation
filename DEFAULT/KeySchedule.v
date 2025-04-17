`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:55:01 09/25/2021 
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
module KeySchedule(kin,kout);
	input [127:0] kin;
	output [127:0] kout;
	assign kout={
		kin[19:0],kin[127:36],kin[20],kin[35:21]
	};

endmodule
