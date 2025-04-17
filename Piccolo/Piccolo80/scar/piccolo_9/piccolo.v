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
module piccolo(
    input clk,
    input reset,
	 //input ready,
    input [0:63] plaintext,
    //input [0:79] keyin,
    output [0:63] ciphertext
    );

wire [0:79] keyin;

reg [0:63] datai;
wire [0:63] datao0,datao1,datao2,datao3,datao4,datao5,datao6,datao7,datao8,datao9,datao10;

wire [0:63] data0,data1,data2,data3,data4,data5,data6;

reg [0:4] clockNum;
reg [0:2] yushu;
piccoloenc enc0(keyin, datai, clockNum, yushu,datao0);
piccoloenc enc1(keyin, datao0, clockNum+5'b00001, yushu[0]?3'b000:3'b001,datao1);
piccoloenc enc2(keyin, datao1, clockNum+5'b00010, yushu[0]?3'b001:3'b010,datao2);
piccoloenc enc3(keyin, datao2, clockNum+5'b00011, yushu[0]?3'b010:3'b011,datao3);
piccoloenc enc4(keyin, datao3, clockNum+5'b00100, yushu[0]?3'b011:3'b100,datao4);

piccoloenc enc5(keyin, datao4, clockNum+5'b00101, yushu,datao5);
piccoloenc enc6(keyin, datao5, clockNum+5'b00110, yushu[0]?3'b000:3'b001,datao6);
piccoloenc enc7(keyin, datao6, clockNum+5'b00111, yushu[0]?3'b001:3'b010,datao7);
piccoloenc enc8(keyin, datao7, clockNum+5'b01000, yushu[0]?3'b010:3'b011,datao8);

piccoloenc enc00(keyin, datao8, 5'b10011, 3'b011,data0);
piccoloenc enc01(keyin, data0, 5'b10100, 3'b100,data1);
piccoloenc enc02(keyin, data1, 5'b10101, 3'b000,data2);
piccoloenc enc03(keyin, data2, 5'b10110, 3'b001,data3);
piccoloenc enc04(keyin, data3, 5'b10111, 3'b010,data4);
piccoloenc enc05(keyin, data4, 5'b11000, 3'b011,data5);
piccoloenc enc06(keyin, data5, 5'b11001, 3'b100,data6);

assign ciphertext = //datao0;//{(datao0[0:15] ^ {keyin[64:71],keyin[56:63]}), 
			//datao0[16:31],(datao0[32:47] ^ {keyin[48:55],keyin[72:79]}),datao0[48:63]};
			{{data6[48:55], data6[24:31]} ^ {keyin[64:71],keyin[56:63]},
			data6[0:7],data6[40:47],{data6[16:23],data6[56:63]}^{keyin[48:55],keyin[72:79]},
			data6[32:39],data6[8:15]};
assign keyin = 80'h00112233445566778899;
always @(posedge(clk)) begin
	if (reset==1'b1)
		begin
			clockNum    <= 5'b00001;
			yushu <=3'b000;
			datai	<=	{(plaintext[0:15] ^ {keyin[0:7], keyin[24:31]}), 
			plaintext[16:31],(plaintext[32:47] ^ {keyin[16:23],keyin[8:15]}),plaintext[48:63]};
	   end
	else
		begin
			if(clockNum==5'b01010) 
				begin
					datai    <= datai;
					//ready <=1;
					clockNum     <= clockNum;
				end
			else
				begin
					datai    <= datao8;//{datao1[16:23], datao1[56:63], datao1[32:39], datao1[8:15], datao1[48:55], datao1[24:31], datao1[0:7], datao1[40:47]};
					clockNum     <= clockNum + 5'b01001;
					if(yushu==3'b100) 
						begin
							yushu     <= 3'b000;
						end
					else
						begin
							yushu     <= 3'b100;
						end
				end
			
		end  	
end   
endmodule
