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
    input [0:63] plaintext,
    //input [0:79] keyin,
    output [0:63] ciphertext
    );

wire [0:79] keyin;

reg [0:63] datai;
wire [0:63] datao;

reg [0:4] clockNum;

piccoloenc enc(keyin, datai, clockNum, datao);

assign ciphertext = {{datao[48:55], datao[24:31]} ^ {keyin[64:71],keyin[56:63]},
			datao[0:7],datao[40:47],{datao[16:23],datao[56:63]}^{keyin[48:55],keyin[72:79]},
			datao[32:39],datao[8:15]};
			
assign keyin = 80'h00112233445566778899;
always @(posedge(clk)) begin
	if (reset==1'b1)
		begin
			clockNum    <= 5'b00000;
			datai	<=	{(plaintext[0:15] ^ {keyin[0:7], keyin[24:31]}), 
			plaintext[16:31],(plaintext[32:47] ^ {keyin[16:23],keyin[8:15]}),plaintext[48:63]};
	   end
	else
		begin
			if(clockNum==5'b11000) 
				begin
					datai    <= datai;
					clockNum     <= clockNum;
				end
			else
				begin
					datai    <= datao;
					clockNum     <= clockNum + 5'b00001;
				end
		end  	
end   
endmodule
