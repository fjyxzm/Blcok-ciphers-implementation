`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:31:09 09/20/2021 
// Design Name: 
// Module Name:    PermBits_Layer 
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
module PermBits_Layer(pin, pout);
	 input [127:0] pin;
    output [127:0] pout;
	 
	 assign {pout[31],pout[126],pout[93],pout[60],pout[63],pout[30],pout[125],pout[92],
				pout[95],pout[62],pout[29],pout[124],pout[127],pout[94],pout[61],pout[28],
				pout[27],pout[122],pout[89],pout[56],pout[59],pout[26],pout[121],pout[88],
				pout[91],pout[58],pout[25],pout[120],pout[123],pout[90],pout[57],pout[24],
				pout[23],pout[118],pout[85],pout[52],pout[55],pout[22],pout[117],pout[84],
				pout[87],pout[54],pout[21],pout[116],pout[119],pout[86],pout[53],pout[20],
				pout[19],pout[114],pout[81],pout[48],pout[51],pout[18],pout[113],pout[80],
				pout[83],pout[50],pout[17],pout[112],pout[115],pout[82],pout[49],pout[16],
				pout[15],pout[110],pout[77],pout[44],pout[47],pout[14],pout[109],pout[76],
				pout[79],pout[46],pout[13],pout[108],pout[111],pout[78],pout[45],pout[12],
				pout[11],pout[106],pout[73],pout[40],pout[43],pout[10],pout[105],pout[72],
				pout[75],pout[42],pout[9],pout[104],pout[107],pout[74],pout[41],pout[8],
				pout[7],pout[102],pout[69],pout[36],pout[39],pout[6],pout[101],pout[68],
				pout[71],pout[38],pout[5],pout[100],pout[103],pout[70],pout[37],pout[4],
				pout[3],pout[98],pout[65],pout[32],pout[35],pout[2],pout[97],pout[64],
				pout[67],pout[34],pout[1],pout[96],pout[99],pout[66],pout[33],pout[0]}=pin;
endmodule
