`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:07:26 10/11/2023 
// Design Name: 
// Module Name:    piccolofunction 
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
module piccolofunction(
    input [0:15] datai,
    output [0:15] datao
    );
wire [0:15] s0_out, m_out;

	//sub_sbox sbox0(datai, s0_out);
	assign s0_out = { s_box(datai[0:3]),s_box(datai[4:7]),
						  s_box(datai[8:11]), s_box(datai[12:15])
			  };
	//piccolomatrix matrix_component(s0_out,m_out);
	wire [0:15] x0,x1;
	assign x0 =  s0_out ^ {s0_out[4:15],s0_out[0:3]};
	assign x1={x0[1:2],x0[3]^x0[0],x0[0],x0[5:6],x0[7]^x0[4],x0[4],
	x0[9:10],x0[11]^x0[8],x0[8],x0[13:14],x0[15]^x0[12],x0[12]};
	assign m_out= x1^ {s0_out[4:15],s0_out[0:3]} ^ {x0[8:15],x0[0:7]};//out_buffer_0 ^ data_i[4:7] ^ x2;
	//assign m_out[4:7] = {}^ s0_out[8:11] ^ x3;//out_buffer_1 ^ data_i[8:11] ^ x3;
	//assign m_out[8:11] = {}^ s0_out[12:15] ^ x0;//out_buffer_2 ^ data_i[12:15] ^ x0;
	//assign m_out[12:15] = {}^ s0_out[0:3] ^ x1;//out_buffer_3 ^ data_i[0:3] ^ x1;
	
	
	assign datao = { s_box(m_out[0:3]),s_box(m_out[4:7]),
						  s_box(m_out[8:11]), s_box(m_out[12:15])
			  };
	//sub_sbox sbox1(m_out, datao);
	function [0:3] s_box;   // SoD  S0	4,2,11,17,20,10,25,27,3,14,6,23,7,18,0,9,19,31,21,5,28,8,24,16,26,29,22,13,1,30,15,12
		input    [0:3] aij;
		reg      [0:3] sb[0:15];
		begin
		{  
			sb[  0],sb[  1],sb[  2],sb[  3],sb[  4],sb[  5],sb[  6],sb[  7],
			sb[  8],sb[  9],sb[ 10],sb[ 11],sb[ 12],sb[ 13],sb[ 14],sb[ 15]
	 
		} =

		{  			
			4'hE, 4'h4, 4'hB, 4'h2, 4'h3, 4'h8, 4'h0, 4'h9, 4'h1, 4'hA, 4'h7, 
			4'hF, 4'h6, 4'hC, 4'h5, 4'hD	
		};

		s_box =sb[aij];
		end
	endfunction
endmodule
