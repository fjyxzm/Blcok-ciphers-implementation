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
    input [0:127] keyin,
    input [0:63] plaintext,
    input [0:4] round,
    output [0:63] ciphered,
    output [0:127] r_key
    );
	wire [0:15] rrk0,rrk1,function_a_out,function_b_out,key_out_rk1,key_out_rk2;
	wire [0:63] m;

	wire [0:15] rk0,rk1;

	//reg [0:2] cnt;
	/*
	wire [0:4] round0;
	always @(keyin,round)  begin
	   
		case (round[3:4])  
		   2'b11:
			begin
				r_key <= {keyin[64:79],keyin[48:63],
				       keyin[0:47],keyin[80:127]};
			end
			default:
			begin	 
				r_key <= {keyin[32:127],keyin[0:31]};
			end			
		endcase
	end
	*/
	assign r_key=round[3]&round[4]?{keyin[64:79],keyin[48:63],keyin[0:47],keyin[80:127]}:{keyin[32:127],keyin[0:31]};
	assign rk0 = keyin[0:15];
	assign rk1 = keyin[16:31];	
	//assign round0 =round+5'b00001;
	assign rrk0 = {rk0[0],~rk0[1:2],rk0[3:4],~rk0[5],rk0[6],~rk0[7],rk0[8],~rk0[9],rk0[10:12],~rk0[13:15]};

	assign rrk1 = {~rk1[0],rk1[1],~rk1[2],rk1[3],~rk1[4],rk1[5:6], ~rk1[7:8],rk1[9:11], ~rk1[12],rk1[13],~rk1[14:15]};
	
	
	assign key_out_rk1 = plaintext[16:31]^{(round^rrk0[0:4]),rrk0[5:9] ,(round ^ rrk0[10:14]), rrk0[15]};//
	assign key_out_rk2 = plaintext[48:63]^{rrk1[0],(round ^ rrk1[1:5]),rrk1[6:10] ,(round ^ rrk1[11:15])};//


	piccolofunction function_a(plaintext[0:15],function_a_out);

	piccolofunction function_b(plaintext[32:47],function_b_out);

//Genrk key(keyin,round,rk0,rk1); 

		 
assign m = {plaintext[0:15],key_out_rk1^function_a_out, 
	plaintext[32:47],key_out_rk2 ^ function_b_out};

//Permutation RP(m,ciphered);


	assign ciphered = {m[16:23], m[56:63], m[32:39], m[8:15], m[48:55], m[24:31], m[0:7], m[40:47]};
	
endmodule
