`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:06:54 09/20/2021 
// Design Name: 
// Module Name:    Subsell_layer 
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
//S盒查表实现
/*module Subsell_layer(sbin, sbout);
	input [127:0]sbin;
   output [127:0]sbout;
	reg [3:0] sbox[0:15];
	initial begin 
	sbox[ 0]=4'b0000;	sbox[ 1]=4'b0011;	sbox[ 2]=4'b0111;	sbox[ 3]=4'b1110;
	sbox[ 4]=4'b1101;	sbox[ 5]=4'b0100;	sbox[ 6]=4'b1010;	sbox[ 7]=4'b1001;
	sbox[ 8]=4'b1100;	sbox[ 9]=4'b1111;	sbox[10]=4'b0001;	sbox[11]=4'b1000;
	sbox[12]=4'b1011;	sbox[13]=4'b0010;	sbox[14]=4'b0110;	sbox[15]=4'b0101;
	end
	assign sbout={
		sbox[sbin[127:124]],sbox[sbin[123:120]],sbox[sbin[119:116]],sbox[sbin[115:112]],
		sbox[sbin[111:108]],sbox[sbin[107:104]],sbox[sbin[103:100]],sbox[sbin[ 99: 96]],
		sbox[sbin[ 95: 92]],sbox[sbin[ 91: 88]],sbox[sbin[ 87: 84]],sbox[sbin[ 83: 80]],
		sbox[sbin[ 79: 76]],sbox[sbin[ 75: 72]],sbox[sbin[ 71: 68]],sbox[sbin[ 67: 64]],
		sbox[sbin[ 63: 60]],sbox[sbin[ 59: 56]],sbox[sbin[ 55: 52]],sbox[sbin[ 51: 48]],
		sbox[sbin[ 47: 44]],sbox[sbin[ 43: 40]],sbox[sbin[ 39: 36]],sbox[sbin[ 35: 32]],
		sbox[sbin[ 31: 28]],sbox[sbin[ 27: 24]],sbox[sbin[ 23: 20]],sbox[sbin[ 19: 16]],
		sbox[sbin[ 15: 12]],sbox[sbin[ 11:  8]],sbox[sbin[  7:  4]],sbox[sbin[  3:  0]]
	};

endmodule*/
//S盒组合逻辑实现
module sboxes(sbin, sbout);
	input [3:0]sbin;
   output [3:0]sbout;
	
	wire t0,t1;
	assign t0=sbin[1]^sbin[2];
	assign t1=(sbin[0]^sbin[3])&t0;
	
	assign sbout={sbin[2]^sbin[3]^t1,sbin[3]^t0,sbin[0]^sbin[1]^t1,sbin[0]^t0};

endmodule

module Subsell_layer(sbin, sbout);
	input [127:0]sbin;
   output [127:0]sbout;
	sboxes s1(sbin[127:124],sbout[127:124]);
	sboxes s2(sbin[123:120],sbout[123:120]);
	sboxes s3(sbin[119:116],sbout[119:116]);
	sboxes s4(sbin[115:112],sbout[115:112]);
	sboxes s5(sbin[111:108],sbout[111:108]);
	sboxes s6(sbin[107:104],sbout[107:104]);
	sboxes s7(sbin[103:100],sbout[103:100]);
	sboxes s8(sbin[99:96],sbout[99:96]);
	sboxes s9(sbin[95:92],sbout[95:92]);
	sboxes s10(sbin[91:88],sbout[91:88]);
	sboxes s11(sbin[87:84],sbout[87:84]);
	sboxes s12(sbin[83:80],sbout[83:80]);
	sboxes s13(sbin[79:76],sbout[79:76]);
	sboxes s14(sbin[75:72],sbout[75:72]);
	sboxes s15(sbin[71:68],sbout[71:68]);
	sboxes s16(sbin[67:64],sbout[67:64]);
	sboxes s17(sbin[63:60],sbout[63:60]);
	sboxes s18(sbin[59:56],sbout[59:56]);
	sboxes s19(sbin[55:52],sbout[55:52]);
	sboxes s20(sbin[51:48],sbout[51:48]);
	sboxes s21(sbin[47:44],sbout[47:44]);
	sboxes s22(sbin[43:40],sbout[43:40]);
	sboxes s23(sbin[39:36],sbout[39:36]);
	sboxes s24(sbin[35:32],sbout[35:32]);
	sboxes s25(sbin[31:28],sbout[31:28]);
	sboxes s26(sbin[27:24],sbout[27:24]);
	sboxes s27(sbin[23:20],sbout[23:20]);
	sboxes s28(sbin[19:16],sbout[19:16]);
	sboxes s29(sbin[15:12],sbout[15:12]);
	sboxes s30(sbin[11: 8],sbout[11: 8]);
	sboxes s31(sbin[ 7: 4],sbout[ 7: 4]);
	sboxes s32(sbin[ 3: 0],sbout[ 3: 0]);
	

endmodule

