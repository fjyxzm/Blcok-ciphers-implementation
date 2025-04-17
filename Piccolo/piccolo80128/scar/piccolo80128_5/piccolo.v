`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:22:07 10/11/2023 
// Design Name: 
// Module Name:    piccolo 
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
module piccolo(clk, reset,version,plaintext, ciphertext );
parameter round=25;
    input clk, reset,version;
    input [0:63] plaintext;
    //input [0:127] keyin;
    output [0:63] ciphertext;
wire [0:127] keyin,k0,k1,k2,k3,k4,kk0,kk1,kk2,kk3;
wire [0:31] wk23;
reg [0:63] datai;
reg [0:127] r_key;
wire [0:63] datao0,datao1,datao2,datao3,datao4,data0,data1,data2,data3;

wire [0:2] ys0,ys1,ys2,ys3,ys4,yys0,yys1,yys2,yys3;

reg [0:4] clockNum;
reg [0:2] yushu;
piccoloenc enc0(r_key, datai, clockNum, yushu,datao0,version,k0,ys0);
piccoloenc enc1(k0,datao0, clockNum+5'b00001, ys0,datao1,version,k1,ys1);
piccoloenc enc2(k1,datao1, clockNum+5'b00010, ys1,datao2,version,k2,ys2);
piccoloenc enc3(k2,datao2, clockNum+5'b00011, ys2,datao3,version,k3,ys3);
piccoloenc enc4(k3,datao3, clockNum+5'b00100, ys3,datao4,version,k4,ys4);

piccoloenc ence0(k4,datao4, 5'b11111, ys4,data0,version,kk0,yys0);
//piccoloenc ence1(kk0,data0, 5'b11110, yys0,data1,version,kk1,yys1);
//piccoloenc ence2(kk1,data1, 5'b11111, yys1,data2,version,kk2,yys2);

assign data3=version?data0:datao4;
assign wk23=version?{keyin[64:71],keyin[120:127],keyin[112:119],keyin[72:79]}:{keyin[64:71],keyin[56:63],keyin[48:55],keyin[72:79]};
assign ciphertext = {{data3[48:55], data3[24:31]} ^ wk23[0:15],
			data3[0:7],data3[40:47],{data3[16:23],data3[56:63]}^wk23[16:31],
			data3[32:39],data3[8:15]};

assign keyin =128'h00112233445566778899aabbccddeeff;
always @(posedge(clk)) begin
	if (reset==1'b1)
		begin
			clockNum    <= 5'b00001;
			yushu <=3'b000;
			datai	<=	{(plaintext[0:15] ^ {keyin[0:7], keyin[24:31]}), 
			plaintext[16:31],(plaintext[32:47] ^ {keyin[16:23],keyin[8:15]}),plaintext[48:63]};
			//r_key <=version?{keyin[32:127],keyin[0:31]}:keyin;
			r_key <=keyin;
	   end
	else
		begin
		   //if()
			begin
			if(clockNum==round) 
				begin
					datai    <= datai;
					clockNum     <= clockNum;
					r_key <=r_key;
				end
			else
				begin
					datai    <= datao4;
					clockNum     <= clockNum + 5'b00101;
					//r_key <= version?keyin0:keyin;
					r_key <= k4;
				yushu     <= ys4;
				end
			
			end
		end  	
end   
endmodule
