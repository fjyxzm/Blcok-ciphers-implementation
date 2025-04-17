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
wire [0:63] datao0,datao1,datao2,datao3,datao4,datao5,datao6,datao7,datao8,datao9,data0,data1,data2,data3,data4;

reg [0:4] clockNum;

piccoloenc enc0(keyin[32:63], datai, clockNum, datao0);
piccoloenc enc1(keyin[0:31], datao0, clockNum+5'b00001, datao1);
piccoloenc enc2(keyin[32:63], datao1, clockNum+5'b00010,datao2);
piccoloenc enc3({keyin[64:79],keyin[64:79]}, datao2, clockNum+5'b00011,datao3);
piccoloenc enc4(keyin[0:31], datao3, clockNum+5'b00100,datao4);

piccoloenc enc00(keyin[32:63], datao4, clockNum+5'b00101, datao5);
piccoloenc enc10(keyin[0:31], datao5, clockNum+5'b00110, datao6);
piccoloenc enc20(keyin[32:63], datao6, clockNum+5'b00111, datao7);
piccoloenc enc30({keyin[64:79],keyin[64:79]}, datao7, clockNum+5'b01000, datao8);
piccoloenc enc40(keyin[0:31], datao8, clockNum+5'b01001, datao9);


piccoloenc enc000(keyin[32:63], datao9, 5'b10101,data0);
piccoloenc enc01(keyin[0:31], data0, 5'b10110,data1);
piccoloenc enc02(keyin[32:63], data1, 5'b10111,data2);
piccoloenc enc03({keyin[64:79],keyin[64:79]}, data2, 5'b11000,data3);
piccoloenc enc04(keyin[0:31], data3, 5'b11001,data4);

assign ciphertext = //datao0;//{(datao0[0:15] ^ {keyin[64:71],keyin[56:63]}), 
			//datao0[16:31],(datao0[32:47] ^ {keyin[48:55],keyin[72:79]}),datao0[48:63]};
			{{data4[48:55], data4[24:31]} ^ {keyin[64:71],keyin[56:63]},
			data4[0:7],data4[40:47],{data4[16:23],data4[56:63]}^{keyin[48:55],keyin[72:79]},
			data4[32:39],data4[8:15]};
assign keyin = 80'h00112233445566778899;
always @(posedge(clk)) begin
	if (reset==1'b1)
		begin
			clockNum    <= 5'b00001;
			datai	<=	{(plaintext[0:15] ^ {keyin[0:7], keyin[24:31]}), 
			plaintext[16:31],(plaintext[32:47] ^ {keyin[16:23],keyin[8:15]}),plaintext[48:63]};
	   end
	else
		begin
			if(clockNum==5'b01011) 
				begin
					datai    <= datai;
					//ready <=1;
					clockNum     <= clockNum;
				end
			else
				begin
					datai    <= datao9;//{datao1[16:23], datao1[56:63], datao1[32:39], datao1[8:15], datao1[48:55], datao1[24:31], datao1[0:7], datao1[40:47]};
					clockNum     <= 5'b01011;
				end
			
		end  	
end   
endmodule
