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
wire [0:63] datao0,datao1,datao2,datao3,datao4,datao5,datao6;

reg [0:4] clockNum;
reg [0:2] yushu;

wire sig0,sig1,sig2,sig3;

assign sig1=(yushu[1]&yushu[2])==1'b1;
piccoloenc enc0(keyin, datai, clockNum, yushu,datao0);
piccoloenc enc1(keyin, datao0, clockNum+5'b00001, yushu[0]?3'b000:(yushu+3'b001),datao1);
piccoloenc enc2(keyin, datao1, clockNum+5'b00010, yushu[0]?3'b001:(sig1?3'b000:(yushu+3'b010)),datao2);
piccoloenc enc3(keyin, datao2, clockNum+5'b00011, yushu[0]?3'b010:(sig1?3'b001:(yushu[1]?3'b000:yushu+3'b011)),datao3);
piccoloenc enc4(keyin, datao3, clockNum+5'b00100, yushu[0]?3'b011:(sig1?3'b010:(yushu[1]?3'b001:((yushu[2]==1'b1)?3'b000:3'b100))),datao4);
piccoloenc enc5(keyin, datao4, clockNum+5'b00101, yushu,datao5);

piccoloenc enc6(keyin, datao5, 5'b11001, 3'b100,datao6);

assign ciphertext = //datao0;//{(datao0[0:15] ^ {keyin[64:71],keyin[56:63]}), 
			//datao0[16:31],(datao0[32:47] ^ {keyin[48:55],keyin[72:79]}),datao0[48:63]};
			{{datao6[48:55], datao6[24:31]} ^ {keyin[64:71],keyin[56:63]},
			datao6[0:7],datao6[40:47],{datao6[16:23],datao6[56:63]}^{keyin[48:55],keyin[72:79]},
			datao6[32:39],datao6[8:15]};
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
			if(clockNum==5'b10011) 
				begin
					datai    <= datai;
					//ready <=1;
					clockNum     <= clockNum;
				end
			else
				begin
					datai    <= datao5;//{datao1[16:23], datao1[56:63], datao1[32:39], datao1[8:15], datao1[48:55], datao1[24:31], datao1[0:7], datao1[40:47]};
					clockNum     <= clockNum + 5'b00110;
					if(yushu[0]==1'b1) 
						begin
							yushu     <= 3'b000;
						end
					else
						begin
							yushu     <= yushu + 3'b001;
						end
				end
			
		end  	
end   
endmodule
