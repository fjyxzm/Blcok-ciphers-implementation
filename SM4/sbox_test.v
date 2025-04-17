`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:09:49 01/03/2024
// Design Name:   sm4_sbox
// Module Name:   E:/fpage/SM4/ljl/sbox_test.v
// Project Name:  ljl
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sm4_sbox
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sbox_test;

	// Inputs
	reg clk;
	reg rst_n;
	reg start;
	reg [7:0] x;
	//reg [7:0] m;

	// Outputs
	wire finish;
	wire [7:0] s_out1;

	// Instantiate the Unit Under Test (UUT)
	sm4_sbox uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.start(start), 
		.x(x), 
		//.m(m), 
		.finish(finish), 
		.s_out1(s_out1)
	);
	
	always #1 clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;
		start = 0;
		x = 0;
		//m = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always@(clk) begin
		x<=x+1;
	end
      
endmodule

