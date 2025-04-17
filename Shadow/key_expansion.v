`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:26:35 10/08/2020 
// Design Name: 
// Module Name:    key_expansion 
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
module  key_expansion (
    input [0:63] key,
    input [4:0] i0, //denotes current round 
    output  [0:63] key_i//第i轮密钥
	);
     
    wire [4:0] i1;
	wire   [7:0] tem1;
    assign   tem1={ key[56]&(key[56]^key[62]),key[57]&(key[57]^key[63]),key[58]&(key[58]^key[56]^key[62]),
						 key[59]&(key[59]^key[57]^key[63]),
						 key[60]&(key[60]^key[58]^key[56]^key[62]),
						 key[61]&(key[61]^key[59]^key[57]^key[63]),
						 key[62]&(key[62]^key[60]^key[58]^key[56]^key[62]),
						 key[63]&(key[63]^key[61]^key[59]^key[57]^key[63])
				      }; 
	
	    assign i1={key[3:7]^i0}; //轮常数加
        assign key_i={ tem1[7:4],key[16:27],tem1[3:0],key[28:55],key[0:2],i1,key[8:15]
		                 
		           }; //P置换
      
    endmodule  


