`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:14:30 10/11/2023 
// Design Name: 
// Module Name:    piccoloenc 
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
module piccoloenc(
    input [0:31] rk0,
    input [0:63] plaintext,
    input [0:4] round,
    output [0:63] ciphered
    );
	wire [0:31] rrk0;
	wire [0:15] function_a_out,function_b_out,rrk1,key_out_rk1,key_out_rk2;


	wire [0:63] m;
		
	//assign round0 =round+5'b00001;
	assign rrk0 = {rk0[0:3],~rk0[4:7],rk0[8:10],~rk0[11:14],rk0[15],rk0[16:17],~rk0[18],rk0[19],~rk0[20:21],rk0[22], ~rk0[23],rk0[24:25], ~rk0[26:29],rk0[30:31]};
				
	assign key_out_rk1 = plaintext[16:31]^{(round^rrk0[0:4]),rrk0[5:9] ,(round ^ rrk0[10:14]), rrk0[15]};
	assign key_out_rk2 = plaintext[48:63]^{rrk0[16],(round ^ rrk0[17:21]),rrk0[22:26] ,(round ^ rrk0[27:31])};


	piccolofunction function_a(plaintext[0:15],function_a_out);

	piccolofunction function_b(plaintext[32:47],function_b_out);

//Genrk key(keyin,round,rk0,rk1); 

		 
assign m = {plaintext[0:15],key_out_rk1^function_a_out, 
	plaintext[32:47],key_out_rk2 ^ function_b_out};

//Permutation RP(m,ciphered);


	assign ciphered = {m[16:23], m[56:63], m[32:39], m[8:15], m[48:55], m[24:31], m[0:7], m[40:47]};
	
endmodule
