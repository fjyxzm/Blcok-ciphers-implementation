`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:46:39 04/09/2022 
// Design Name: 
// Module Name:    HDLBCRound 
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
module HDLBCRound(res,r_keys,state,keys,rc);
input [0:63] state;//����
input [0:63] keys;//��Կ
input [0:4] rc;//�ֳ���


output[0:63]res;
output[0:63]r_keys;

wire[0:15] ra00,ra01,ra10,ra11;

//RA��������
RA ra0(state,keys[32:47],ra00,ra01);

RA ra1({ra00,state[0:15],ra01,state[32:47]},keys[48:63],ra10,ra11);
//RA��������


//P���û�
PBox Pb(res,{ra11,ra01,ra10,ra00});

//��Կ����
KeySchedule ks(keys,r_keys,rc);
endmodule
