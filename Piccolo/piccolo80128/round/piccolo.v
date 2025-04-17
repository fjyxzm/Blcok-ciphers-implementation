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
wire [0:127] keyin,keyin0;
wire [0:31] wk23;
reg [0:63] datai;
reg [0:127] r_key;
wire [0:63] datao;


reg [0:4] clockNum;
reg [0:2] yushu;
piccoloenc enc(r_key, datai, clockNum, yushu,datao,version,keyin0);

assign wk23=version?{keyin[64:71],keyin[120:127],keyin[112:119],keyin[72:79]}:{keyin[64:71],keyin[56:63],keyin[48:55],keyin[72:79]};
assign ciphertext = {{datao[48:55], datao[24:31]} ^ wk23[0:15],
			datao[0:7],datao[40:47],{datao[16:23],datao[56:63]}^wk23[16:31],
			datao[32:39],datao[8:15]};

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
					datai    <= datao;
					clockNum     <= clockNum + 5'b00001;
					//r_key <= version?keyin0:keyin;
					r_key <= keyin0;
				end
			
				if(yushu[0]==1'b1) 
					begin
						yushu <=3'b000;
					end
				else
					begin
						yushu     <= yushu + 3'b001;
					end
			end
		end  	
end   
endmodule
