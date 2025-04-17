`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:16:38 09/25/2021 
// Design Name: 
// Module Name:    SubCell_core 
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
//S盒组合逻辑实现

module sboxes_core(sbin, sbout);
	input [3:0]sbin;
   output [3:0]sbout;
	
	wire t0,t1,t2;
	assign t0=sbin[1]^sbin[2];
	assign t1=sbin[1]^sbin[3];
	assign t2=sbin[0]&sbin[3];
	
	assign sbout={(sbin[0]|sbin[3]) ^ (sbin[2]&t1) ^ (t2&sbin[1]),t0^t2,
		t0^(sbin[0]&sbin[2])^sbin[3], ~t1^(sbin[0]&t0)
	};

endmodule

module SubCell_core(sbin, sbout);
	input [127:0]sbin;
   output [127:0]sbout;
	sboxes_core sc01(sbin[127:124],sbout[127:124]);
	sboxes_core sc2(sbin[123:120],sbout[123:120]);
	sboxes_core sc3(sbin[119:116],sbout[119:116]);
	sboxes_core sc4(sbin[115:112],sbout[115:112]);
	sboxes_core sc5(sbin[111:108],sbout[111:108]);
	sboxes_core sc6(sbin[107:104],sbout[107:104]);
	sboxes_core sc7(sbin[103:100],sbout[103:100]);
	sboxes_core sc8(sbin[99:96],sbout[99:96]);
	sboxes_core sc9(sbin[95:92],sbout[95:92]);
	sboxes_core sc10(sbin[91:88],sbout[91:88]);
	sboxes_core sc11(sbin[87:84],sbout[87:84]);
	sboxes_core sc12(sbin[83:80],sbout[83:80]);
	sboxes_core sc13(sbin[79:76],sbout[79:76]);
	sboxes_core sc14(sbin[75:72],sbout[75:72]);
	sboxes_core sc15(sbin[71:68],sbout[71:68]);
	sboxes_core sc16(sbin[67:64],sbout[67:64]);
	sboxes_core sc17(sbin[63:60],sbout[63:60]);
	sboxes_core sc18(sbin[59:56],sbout[59:56]);
	sboxes_core sc19(sbin[55:52],sbout[55:52]);
	sboxes_core sc20(sbin[51:48],sbout[51:48]);
	sboxes_core sc21(sbin[47:44],sbout[47:44]);
	sboxes_core sc22(sbin[43:40],sbout[43:40]);
	sboxes_core sc23(sbin[39:36],sbout[39:36]);
	sboxes_core sc24(sbin[35:32],sbout[35:32]);
	sboxes_core sc25(sbin[31:28],sbout[31:28]);
	sboxes_core sc26(sbin[27:24],sbout[27:24]);
	sboxes_core sc27(sbin[23:20],sbout[23:20]);
	sboxes_core sc28(sbin[19:16],sbout[19:16]);
	sboxes_core sc29(sbin[15:12],sbout[15:12]);
	sboxes_core sc30(sbin[11: 8],sbout[11: 8]);
	sboxes_core sc31(sbin[ 7: 4],sbout[ 7: 4]);
	sboxes_core sc32(sbin[ 3: 0],sbout[ 3: 0]);
	
endmodule
