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

	// Outputs
	wire [63:0] ciphertext;

	// Instantiate the Unit Under Test (UUT)
	prince_top uut (
		.plaintext(plaintext), 
		.key(key),
		.ciphertext(ciphertext)
	);
	
	initial begin
		// Initialize Inputs
		plaintext = 0;
		key = 0;

		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here

	end
      
endmodule

