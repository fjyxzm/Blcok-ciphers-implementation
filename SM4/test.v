`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:21:28 05/25/2023
// Design Name:   SubNibble
// Module Name:   E:/fpage/SM4/ljl/test.v
// Project Name:  ljl
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SubNibble
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg rst_n;
	reg start;
	reg [31:0] m;
	reg [31:0] x;

	// Outputs
	wire finish;
	wire [31:0] x_out;
	wire [31:0] m_out;

	// Instantiate the Unit Under Test (UUT)
	SubNibble uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.start(start), 
		.m(m), 
		.x(x), 
		.finish(finish), 
		.x_out(x_out), 
		.m_out(m_out)
	);
	always #2 clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;
		start = 0;
		m = 0;
		x = 0;
		#2 rst_n = 1;
		#2 start = 1;
   
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

