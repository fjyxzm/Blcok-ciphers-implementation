`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:17:13 09/20/2021
// Design Name:   layer_Function
// Module Name:   E:/fpage/Default/Default_layer/DL_test.v
// Project Name:  Default_layer
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: layer_Function
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DL_test;

	// Inputs
	reg [127:0] p;
	reg [127:0] k;
	reg clk;

	// Outputs
	wire [127:0] c;

	// Instantiate the Unit Under Test (UUT)
	Default_Top uut (
		.plain(p), 
		.key(k), 
		.clk(clk),
		.cipher(c)
	);
	always #1 clk=~clk;
	initial begin
		// Initialize Inputs
		p = 0;
		k = 0;
		clk=0;

		// Wait 100 ns for global reset to finish
		//#1;
        
		// Add stimulus here

	end
      
endmodule

