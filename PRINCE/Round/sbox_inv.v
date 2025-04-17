`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:46:25 09/20/2020 
// Design Name: 
// Module Name:    sbox 
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
module sbox_inv(data_in,data_out);
	input [3:0] data_in;
	reg [3:0] data_out;
	output [3:0] data_out;
	
	 always @(data_in)
	 
	  begin 
	    case (data_in)
		 4'h0: 
			begin 
				data_out = 4'hb;
			end
		 4'h1: 
			begin 
				data_out = 4'h7;
			end
		 4'h2: 
			begin 
				data_out = 4'h3;
			end
		 4'h3: 
			begin 
				data_out = 4'h2;
			end
		 4'h4: 
			begin 
				data_out = 4'hf;
			end
		 4'h5: 
			begin 
				data_out = 4'hd;
			end
		 4'h6: 
			begin 
				data_out = 4'h8;
			end
		 4'h7: 
			begin 
				data_out = 4'h9;
			end
		 4'h8: 
			begin 
				data_out = 4'ha;
			end
		 4'h9: 
			begin 
				data_out = 4'h6;
			end
		 4'hA: 
			begin 
				data_out = 4'h4;
			end
		 4'hB: 
			begin 
				data_out = 4'h0;
			end
		 4'hC: 
			begin 
				data_out = 4'h5;
			end
		 4'hD: 
			begin 
				data_out = 4'he;
			end
		 4'hE: 
			begin 
				data_out = 4'hc;
			end
		 4'hF: 
			begin 
				data_out = 4'h1;
			end		 
	endcase;
end

endmodule
