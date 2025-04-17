`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:11:30 09/20/2020
// Design Name:   prince_top
// Module Name:   C:/fpage/PRINCE/round-based/RoundBasedOptional/prince_tb.v
// Project Name:  RoundBasedOptional
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: prince_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module prince_tb;

	// Inputs
	reg [63:0] plaintext;
	reg [127:0] key;
	reg clk;
	reg reset;

	// Outputs
	wire [63:0] ciphertext, c,wk;

	// Instantiate the Unit Under Test (UUT)
	
    always #10 clk=~clk;
	initial begin
		// Initialize Inputs
		plaintext = 0;
		key = 0;
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here

	end
	assign wk = {~key[63:62],key[61:56],~key[55],key[54],~key[53],
		key[52],~key[51:50],key[49:46],~key[45],key[44],
		~key[43],key[42:41],~key[40:39],key[38],~key[37:36],
		key[35],~key[34:30],key[29:28],~key[27],key[26:25],
		~key[24],key[23],~key[22:18],key[17:15],~key[14],
		key[13],~key[12],key[11:8],~key[7:6],key[5],
		~key[4:2],key[1],~key[0]};
		
	prince_top uut (
		.plaintext(plaintext^key[63:0]^key[127:64]), 
		.wk(wk), 
		.key(key[63:0]), 
		.clk(clk), 
		.ciphertext(c)
	);
	assign ciphertext = c^wk ^ {key[64],key[127:66],key[65]^ key[127]};
   
	
endmodule

