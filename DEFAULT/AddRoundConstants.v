`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:42:40 09/20/2021 
// Design Name: 
// Module Name:    AddRoundConstants 
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
module AddRoundConstants(rcin, rcon, rcout);
	 input [127:0] rcin;
	 input [4:0] rcon;
    output [127:0] rcout;
	reg [5:0] rc[1:28];
	initial begin 
	rc[ 1]=6'b000001;	rc[ 2]=6'b000011;	rc[ 3]=6'b000111;	rc[ 4]=6'b001111;
	rc[ 5]=6'b011111;	rc[ 6]=6'b111110;	rc[ 7]=6'b111101;	rc[ 8]=6'b111011;
	rc[ 9]=6'b110111;	rc[10]=6'b101111;	rc[11]=6'b011110;	rc[12]=6'b111100;
	rc[13]=6'b111001;	rc[14]=6'b110011; rc[15]=6'b100111;	rc[16]=6'b001110;	
	rc[17]=6'b011101; rc[18]=6'b111010;	rc[19]=6'b110101;	rc[20]=6'b101011;
	rc[21]=6'b010110; rc[22]=6'b101100;	rc[23]=6'b011000;	rc[24]=6'b110000;	
	rc[25]=6'b100001; rc[26]=6'b000010;	rc[27]=6'b000101;	rc[28]=6'b001011;
		
	end
	assign rcout={
		~rcin[127],rcin[126:24],rcin[23]^rc[rcon][5],rcin[22:20],rcin[19]^rc[rcon][4],rcin[18:16],
		rcin[15]^rc[rcon][3],rcin[14:12],rcin[11]^rc[rcon][2],rcin[10:8],
		rcin[7]^rc[rcon][1],rcin[6:4],rcin[3]^rc[rcon][0],rcin[2:0]
	};

endmodule
