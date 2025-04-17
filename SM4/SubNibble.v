`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/16 20:21:49
// Design Name: 
// Module Name: SubNibble
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SubNibble(
	input 			clk,
    input 			rst_n,
    input 			start,
    input   [31:0] 	m,
    input   [31:0] 	x,
    output  		finish,
    output  [31:0] 	x_out,
    output  [31:0] 	m_out
    );
    
    wire   [7:0] sbox3,sbox2,sbox1,sbox0;
    wire   [7:0] m_sbox3,m_sbox2,m_sbox1,m_sbox0;
    wire   finish_1,finish_2,finish_3,finish_0;
    
    sm4_box ts3(
    .clk				(clk			),
    .rst_n				(rst_n			),
    .start				(start			),
    .finish				(finish_3		),
    .s_out1				(sbox3			),
    .s_out0				(m_sbox3		),
    .m					(m[31:24]		),
    .x					(x[31:24]		)
    );    
	
	 sm4_sbox ts2(
    .clk				(clk			),
    .rst_n				(rst_n			),
    .start				(start			),
    .finish				(finish_2		),
    .s_out1				(sbox2			),
    .s_out0				(m_sbox2		),
    .m					(m[23:16]		),
    .x					(x[23:16]		)
    );    
	
	 sm4_sbox ts1(
    .clk				(clk			),
    .rst_n				(rst_n			),
    .start				(start			),
    .finish				(finish_1		),
    .s_out1				(sbox1			),
    .s_out0				(m_sbox1		),
    .m					(m[15:8]		),
    .x					(x[15:8]		)
    );    
	
	 sm4_sbox ts0(
    .clk				(clk			),
    .rst_n				(rst_n			),
    .start				(start			),
    .finish				(finish_0		),
    .s_out1				(sbox0			),
    .s_out0				(m_sbox0		),
    .m					(m[07:00]		),
    .x					(x[07:00]		)
    );    
    
    
    assign x_out = {sbox3,sbox2,sbox1,sbox0};
    assign m_out = {m_sbox3,m_sbox2,m_sbox1,m_sbox0};
    assign finish = finish_0;
	
endmodule
