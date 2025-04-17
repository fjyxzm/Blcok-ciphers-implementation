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
wire [0:127] keyin,k0,k1,k2,k3,k4,k5,k6,k7,kk0,kk1,kk2,kk3,kk4,kk5,kk6;
wire [0:31] wk23;
reg [0:63] datai;
reg [0:127] r_key;
wire [0:63] datao0,datao1,datao2,datao3,datao4,datao5,datao6,datao7,data0,data1,data2,data3,data4,data5,data6,data7;

wire [0:2] ys0,ys1,ys2,ys3,ys4,ys5,ys6,ys7,yys0,yys1,yys2,yys3,yys4,yys5,yys6;

reg [0:4] clockNum;
reg [0:2] yushu;
piccoloenc enc0(r_key, datai, clockNum, yushu,datao0,version,k0,ys0);
piccoloenc enc1(k0,datao0, clockNum+5'b00001, ys0,datao1,version,k1,ys1);
piccoloenc enc2(k1,datao1, clockNum+5'b00010, ys1,datao2,version,k2,ys2);
piccoloenc enc3(k2,datao2, clockNum+5'b00011, ys2,datao3,version,k3,ys3);
piccoloenc enc4(k3,datao3, clockNum+5'b00100, ys3,datao4,version,k4,ys4);
piccoloenc enc5(k4,datao4, clockNum+5'b00101, ys4,datao5,version,k5,ys5);
piccoloenc enc6(k5,datao5, clockNum+5'b00110, ys5,datao6,version,k6,ys6);
piccoloenc enc7(k6,datao6, clockNum+5'b00111, ys6,datao7,version,k7,ys7);

piccoloenc ence0(k7,datao7, version?5'b11001:5'b11001, ys7,data0,version,kk0,yys0);
piccoloenc ence1(kk0,data0, 5'b11010, yys0,data1,version,kk1,yys1);
piccoloenc ence2(kk1,data1, 5'b11011, yys1,data2,version,kk2,yys2);
piccoloenc ence3(kk2,data2, 5'b11100, yys2,data3,version,kk3,yys3);
piccoloenc ence4(kk3,data3, 5'b11101, yys3,data4,version,kk4,yys4);
piccoloenc ence5(kk4,data4, 5'b11110, yys4,data5,version,kk5,yys5);
piccoloenc ence6(kk5,data5, 5'b11111, yys5,data6,version,kk6,yys6);

assign data7=version?data6:data0;
assign wk23=version?{keyin[64:71],keyin[120:127],keyin[112:119],keyin[72:79]}:{keyin[64:71],keyin[56:63],keyin[48:55],keyin[72:79]};
assign ciphertext = {{data7[48:55], data7[24:31]} ^ wk23[0:15],
			data7[0:7],data7[40:47],{data7[16:23],data7[56:63]}^wk23[16:31],
			data7[32:39],data7[8:15]};

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
					datai    <= datao7;
					clockNum     <= clockNum + 5'b01000;
					//r_key <= version?keyin0:keyin;
					r_key <= k7;
				yushu     <= ys7;
				end
			
			end
		end  	
end   
endmodule
