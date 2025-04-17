`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:24:40 04/09/2022 
// Design Name: 
// Module Name:    HDLBC_test 
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
module HDLBC_test(result,state,keys,clk);
input clk;
input [0:63] state;//64bit明文
input [0:63] keys;//64bit密钥
output[0:63] result;//密文输出

reg ready;
reg[0:4]cnt;

reg[0:63]res;
reg[0:63]k;
wire[0:63]te;//明文
wire[0:63]r_keys;

assign result=res;
initial begin
	  ready =1;
	  cnt   =0;
end

always @(posedge clk) begin
	cnt <= (cnt^25) ? cnt+1:cnt;//控制轮数
	res <= ready ? ((cnt) ? te:state ) :res;
	k   <= ready ? ((cnt) ?r_keys:keys) :k;//密钥更新
	ready <= (cnt^25)? 1:0;
end

HDLBCRound HR(te,r_keys,res,k,cnt-1);

endmodule
