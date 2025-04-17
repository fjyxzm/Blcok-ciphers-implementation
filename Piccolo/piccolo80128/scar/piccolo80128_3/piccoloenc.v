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
/*
module piccoloenc(
    input [0:127] keyin,
    input [0:63] plaintext,
    input [0:4] round,
    input [0:2] yueshu,
    output [0:63] ciphered,
	 input version,
    output [0:127] r_key
    );
	wire [0:15] zrrk0,zrrk1,rrk0,rrk1,rrk0_80,rrk1_80,function_a_out,function_b_out,key_out_rk1,key_out_rk2;
	wire [0:63] m;

	wire [0:15] rk0,rk1,rk0_80,rk1_80,rk01_80,rk11_80,con0,con1;

	assign rk01_80=yueshu[1]?keyin[64:79]:keyin[0:15];
	assign rk11_80=yueshu[1]?keyin[64:79]:keyin[16:31];
	assign rk0_80=yueshu[0]^yueshu[2]?rk01_80:keyin[32:47];
	assign rk1_80=yueshu[0]^yueshu[2]?rk11_80:keyin[48:63];
	
	//assign rrk0_80 = {rk0_80[0:3],~rk0_80[4:7],rk0_80[8:10],~rk0_80[11:14],rk0_80[15]};
	//assign rrk1_80 = {rk1_80[0:1],~rk1_80[2],rk1_80[3],~rk1_80[4:5],rk1_80[6], ~rk1_80[7],rk1_80[8:9], ~rk1_80[10:13],rk1_80[14:15]};
	
	//reg [0:2] cnt;
	assign r_key=round[3]&round[4]?{keyin[64:79],keyin[48:63],keyin[0:47],keyin[80:127]}:{keyin[32:127],keyin[0:31]};
	assign rk0 = keyin[0:15];
	assign rk1 = keyin[16:31];	
	//assign round0 =round+5'b00001;
	//assign rrk0 = {rk0[0],~rk0[1:2],rk0[3:4],~rk0[5],rk0[6],~rk0[7],rk0[8],~rk0[9],rk0[10:12],~rk0[13:15]};

	//assign rrk1 = {~rk1[0],rk1[1],~rk1[2],rk1[3],~rk1[4],rk1[5:6], ~rk1[7:8],rk1[9:11], ~rk1[12],rk1[13],~rk1[14:15]};
	
	assign zrrk0 = version?rk0:rk0_80;

	assign zrrk1 = version?rk1:rk1_80;
	assign con0 = version?16'h6547:16'h0f1e;

	assign con1 = version?16'ha98b:16'h2d3c;
	
	assign key_out_rk1 = plaintext[16:31]^con0^{(round^zrrk0[0:4]),zrrk0[5:9] ,(round ^ zrrk0[10:14]), zrrk0[15]};//
	assign key_out_rk2 = plaintext[48:63]^con1^{zrrk1[0],(round ^ zrrk1[1:5]),zrrk1[6:10] ,(round ^ zrrk1[11:15])};//


	piccolofunction function_a(plaintext[0:15],function_a_out);

	piccolofunction function_b(plaintext[32:47],function_b_out);

//Genrk key(keyin,round,rk0,rk1); 

		 
assign m = {plaintext[0:15],key_out_rk1^function_a_out, 
	plaintext[32:47],key_out_rk2 ^ function_b_out};

//Permutation RP(m,ciphered);


	assign ciphered = {m[16:23], m[56:63], m[32:39], m[8:15], m[48:55], m[24:31], m[0:7], m[40:47]};
	
endmodule
*/

module piccoloenc(
    input [0:127] keyin,
    input [0:63] plaintext,
    input [0:4] round,
    input [0:2] yueshu,
    output [0:63] ciphered,
	 input version,
    output [0:127] r_key,
    output [0:2] ys
    );
	wire [0:15] zrrk0,zrrk1,rrk0,rrk1,rrk0_80,rrk1_80,function_a_out,function_b_out,key_out_rk1,key_out_rk2;
	wire [0:63] m;

	wire [0:15] rk0,rk1,rk0_80,rk1_80,rk01_80,rk11_80;
	wire [0:31] k0_80,k1_80,k2_80,k0_128,k1_128,zk;

	//assign rk01_80=yueshu[1]?keyin[64:79]:keyin[0:15];
	//assign rk11_80=yueshu[1]?keyin[64:79]:keyin[16:31];
	//assign rk0_80=yueshu[0]^yueshu[2]?rk01_80:keyin[32:47];
	//assign rk1_80=yueshu[0]^yueshu[2]?rk11_80:keyin[48:63];
	
	//assign rrk0_80 = {rk0_80[0:3],~rk0_80[4:7],rk0_80[8:10],~rk0_80[11:14],rk0_80[15]};
	//assign rrk1_80 = {rk1_80[0:1],~rk1_80[2],rk1_80[3],~rk1_80[4:5],rk1_80[6], ~rk1_80[7],rk1_80[8:9], ~rk1_80[10:13],rk1_80[14:15]};
	
	assign ys=yueshu[0]?3'b000:yueshu+3'b001;
	
	assign k0_80=yueshu[1]?{keyin[64:79],keyin[64:79]}:{keyin[0:31]};
	assign k1_80=yueshu[0]^yueshu[2]?k0_80:{keyin[32:63]};
	
	assign k2_80={k1_80[0:3],~k1_80[4:7],k1_80[8:10],~k1_80[11:14],k1_80[15:17],~k1_80[18],k1_80[19],~k1_80[20:21],k1_80[22], 
	~k1_80[23],k1_80[24:25], ~k1_80[26:29],k1_80[30:31]};
	
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
	//assign r_key=version?(round[3]&round[4]?{keyin[64:79],keyin[48:63],keyin[0:47],keyin[80:127]}:{keyin[32:127],keyin[0:31]}):keyin;
	assign r_key=version?(round[3]&round[4]?{keyin[0:31],keyin[96:111],keyin[80:95],keyin[32:79],keyin[112:127]}:{keyin[32:127],keyin[0:31]}):keyin;
	
	//assign rk0 = keyin[32:47];
	//assign rk1 = keyin[48:63];	
	//assign rrk0 = {rk0[0],~rk0[1:2],rk0[3:4],~rk0[5],rk0[6],~rk0[7],rk0[8],~rk0[9],rk0[10:12],~rk0[13:15]};
	//assign rrk1 = {~rk1[0],rk1[1],~rk1[2],rk1[3],~rk1[4],rk1[5:6], ~rk1[7:8],rk1[9:11], ~rk1[12],rk1[13],~rk1[14:15]};
	//assign zrrk0 = version?rrk0:rrk0_80;

	//assign zrrk1 = version?rrk1:rrk1_80;
	//assign key_out_rk1 = plaintext[16:31]^{(round^zrrk0[0:4]),zrrk0[5:9] ,(round ^ zrrk0[10:14]), zrrk0[15]};//
	//assign key_out_rk2 = plaintext[48:63]^{zrrk1[0],(round ^ zrrk1[1:5]),zrrk1[6:10] ,(round ^ zrrk1[11:15])};//
	
	assign k0_128=keyin[32:63];//round0 =round+5'b00001;
	assign k1_128={k0_128[0],~k0_128[1:2],k0_128[3:4],~k0_128[5],k0_128[6],~k0_128[7],k0_128[8],~k0_128[9],k0_128[10:12],~k0_128[13:16],
	k0_128[17],~k0_128[18],k0_128[19],~k0_128[20],k0_128[21:22], ~k0_128[23:24],k0_128[25:27], ~k0_128[28],k0_128[29],~k0_128[30:31]};
	
	assign zk=version?k1_128:k2_80;
	
	assign key_out_rk1 = plaintext[16:31]^{(round^zk[0:4]),zk[5:9] ,(round ^ zk[10:14]), zk[15]};//
	assign key_out_rk2 = plaintext[48:63]^{zk[16],(round ^ zk[17:21]),zk[22:26] ,(round ^ zk[27:31])};//

	piccolofunction function_a(plaintext[0:15],function_a_out);

	piccolofunction function_b(plaintext[32:47],function_b_out);

//Genrk key(keyin,round,rk0,rk1); 

		 
assign m = {plaintext[0:15],key_out_rk1^function_a_out, 
	plaintext[32:47],key_out_rk2 ^ function_b_out};

//Permutation RP(m,ciphered);


	assign ciphered = {m[16:23], m[56:63], m[32:39], m[8:15], m[48:55], m[24:31], m[0:7], m[40:47]};
	
endmodule
