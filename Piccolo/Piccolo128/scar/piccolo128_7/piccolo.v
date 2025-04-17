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
    //input [0:127] keyin,
    output [0:63] ciphertext
    );

wire [0:127] keyin,rk0,rk1,rk2,rk3,rk4,rk5,rk6,k0,k1,k2;

reg [0:63] datai;
reg [0:127] r_key;
wire [0:63] datao0,datao1,datao2,datao3,datao4,datao5,datao6,data0,data1,data2;

reg [0:4] clockNum;
assign keyin = 128'h00112233445566778899aabbccddeeff;
piccoloenc enc0(r_key, datai, clockNum, datao0,rk0);
piccoloenc enc1(rk0, datao0, clockNum+5'b00001, datao1,rk1);
piccoloenc enc2(rk1, datao1, clockNum+5'b00010, datao2,rk2);
piccoloenc enc3(rk2, datao2, clockNum+5'b00011, datao3,rk3);
piccoloenc enc4(rk3, datao3, clockNum+5'b00100, datao4,rk4);
piccoloenc enc5(rk4, datao4, clockNum+5'b00101, datao5,rk5);
piccoloenc enc6(rk5, datao5, clockNum+5'b00110, datao6,rk6);

piccoloenc ence0(rk6, datao6, 5'b11101,data0,k0);
piccoloenc ence1(k0, data0, 5'b11110,data1,k1);
piccoloenc ence2(k1, data1, 5'b11111,data2,k2);

//piccoloenc ence0(rk5, datao5, 5'b11111,datao6,rk6);

assign ciphertext = {{data2[48:55], data2[24:31]} ^ {keyin[64:71],keyin[120:127]},
			data2[0:7],data2[40:47],{data2[16:23],data2[56:63]}^{keyin[112:119],keyin[72:79]},
			data2[32:39],data2[8:15]};

//assign keyin =128'h00112233445566778899aabbccddeeff;
always @(posedge(clk)) begin
	if (reset==1'b1)
		begin
			clockNum    <= 5'b00001;
			datai	<=	{(plaintext[0:15] ^ {keyin[0:7], keyin[24:31]}), 
			plaintext[16:31],(plaintext[32:47] ^ {keyin[16:23],keyin[8:15]}),plaintext[48:63]};
			r_key <={keyin[32:127],keyin[0:31]};
	   end
	else
		begin
		
			if(clockNum==5'b10110) 
				begin
					datai    <= datai;
					clockNum     <= clockNum;
					r_key <=r_key;
				end
			else
				begin
					datai    <= datao6;
					clockNum     <= clockNum + 5'b00111;
					r_key <= rk6;
				end
		end  	
end   
endmodule

/*
module piccolo(
    input clk,
    input reset,
    input insig,
    input [0:31] plaintext,
    //input [0:127] keyin,
    output [0:63] ciphertext
    );

wire [0:127] keyin,keyin0;//

reg [0:63] datai;
reg [0:127] r_key;
wire [0:63] datao;

reg [0:4] clockNum;
assign keyin = 128'h00112233445566778899aabbccddeeff;
piccoloenc enc(r_key, datai, clockNum, datao,keyin0);

assign ciphertext = {{datao[48:55], datao[24:31]} ^ {keyin[64:71],keyin[120:127]},
			datao[0:7],datao[40:47],{datao[16:23],datao[56:63]}^{keyin[112:119],keyin[72:79]},
			datao[32:39],datao[8:15]};

//assign keyin =128'h00112233445566778899aabbccddeeff;
always @(posedge(clk)) begin
   if(insig==1'b1)
		begin
			if (reset==1'b1)
				begin
				datai	<=	{datai[32:63],(plaintext[0:15] ^ {keyin[0:7], keyin[24:31]}), 
					plaintext[16:31]};
				end
			else 
				begin
					clockNum    <= 5'b00001;
					datai	<=	{datai[32:63],(plaintext[0:15] ^ {keyin[16:23],keyin[8:15]}), 
					plaintext[16:31]};
					r_key <={keyin[32:127],keyin[0:31]};
				end
		end
	else
		begin
		if(clockNum==5'b11111) 
			begin
				datai    <= datai;
				clockNum     <= clockNum;
				r_key <=r_key;
			end
		else
			begin
				datai    <= datao;
				clockNum     <= clockNum + 5'b00001;
				r_key <= keyin0;
			end
		end
end 
endmodule  
*/
