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
wire [0:63] datao0,datao1,datao2,datao3;

reg [0:4] clockNum;
reg [0:2] yushu;

piccoloenc enc0(keyin, datai, clockNum, yushu,datao0);
piccoloenc enc1(keyin, datao0, clockNum+5'b00001, (yushu==3'b100)?3'b000:yushu+3'b001,datao1);
piccoloenc enc2(keyin, datao1, clockNum+5'b00010, (yushu==3'b011)?3'b000:((yushu==3'b100)?3'b001:yushu+3'b010),datao2);


piccoloenc enc3(keyin, datao2, 5'b11001, 3'b100,datao3);

assign ciphertext = //datao0;//{(datao0[0:15] ^ {keyin[64:71],keyin[56:63]}), 
			//datao0[16:31],(datao0[32:47] ^ {keyin[48:55],keyin[72:79]}),datao0[48:63]};
			{{datao3[48:55], datao3[24:31]} ^ {keyin[64:71],keyin[56:63]},
			datao3[0:7],datao3[40:47],{datao3[16:23],datao3[56:63]}^{keyin[48:55],keyin[72:79]},
			datao3[32:39],datao3[8:15]};
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
			if(clockNum==5'b10110) 
				begin
					datai    <= datai;
					//ready <=1;
					clockNum     <= clockNum;
				end
			else
				begin
					datai    <= datao2;//{datao1[16:23], datao1[56:63], datao1[32:39], datao1[8:15], datao1[48:55], datao1[24:31], datao1[0:7], datao1[40:47]};
					clockNum     <= clockNum + 5'b00011;
					if(yushu==3'b000) 
						begin
							yushu <=3'b011;
						end
					else
						begin
							if(yushu==3'b011) 
								begin
									yushu <=3'b001;
								end
							else
								begin
								if(yushu==3'b001) 
									begin
										yushu <=3'b100;
									end
								else
									begin
										if(yushu==3'b100) 
											begin
												yushu <=3'b010;
											end
										else
											begin
												yushu     <= 3'b000;
											end
									end
								end
						end
					
				end
			
		end  	
end   
endmodule
