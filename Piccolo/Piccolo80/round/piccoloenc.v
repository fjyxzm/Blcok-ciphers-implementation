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
    input [0:79] keyin,
    input [0:63] plaintext,
    input [0:4] round,
    output [0:63] ciphered
    );
	wire [0:15] rrk0,rrk1,function_a_out,function_b_out,key_out_rk1,key_out_rk2;
	wire [0:63] m;

	reg [0:15] rk0,rk1;

	//reg [0:2] cnt;
	wire [0:4] round0;
	always @(keyin,round)  begin
		case (round)  
		   5'b00000,5'b00010,5'b00101,5'b00111,5'b01010,5'b01100,5'b01111,5'b10001,5'b10100,5'b10110: 
				begin
					rk0<= keyin[32:47];
					rk1<= keyin[48:63];  			
				end
			5'b00011,5'b01000,5'b01101,5'b10010,5'b10111:
					begin
						rk0<= keyin[64:79];
						rk1<= keyin[64:79];
					end
			default:
					begin
						rk0 <= keyin[0:15];
						rk1 <= keyin[16:31];		     
					end			
		endcase
	end
		
	assign round0 =round+5'b00001;
	assign rrk0 = {rk0[0:3],~rk0[4:7],rk0[8:10],~rk0[11:14],rk0[15]};

	assign rrk1 = {rk1[0:1],~rk1[2],rk1[3],~rk1[4:5],rk1[6], ~rk1[7],rk1[8:9], ~rk1[10:13],rk1[14:15]};
				
	assign key_out_rk1 = plaintext[16:31]^{(round0^rrk0[0:4]),rrk0[5:9] ,(round0 ^ rrk0[10:14]), rrk0[15]};
	assign key_out_rk2 = plaintext[48:63]^{rrk1[0],(round0 ^ rrk1[1:5]),rrk1[6:10] ,(round0 ^ rrk1[11:15])};


	piccolofunction function_a(plaintext[0:15],function_a_out);

	piccolofunction function_b(plaintext[32:47],function_b_out);

//Genrk key(keyin,round,rk0,rk1); 

		 
assign m = {plaintext[0:15],key_out_rk1^function_a_out, 
	plaintext[32:47],key_out_rk2 ^ function_b_out};

//Permutation RP(m,ciphered);


	assign ciphered = {m[16:23], m[56:63], m[32:39], m[8:15], m[48:55], m[24:31], m[0:7], m[40:47]};
	
endmodule
