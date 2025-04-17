`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:41:21 10/11/2023
// Design Name:   piccolo
// Module Name:   E:/fpage/piccolo/round/NewPiccolo/piccolo_tb.v
// Project Name:  NewPiccolo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: piccolo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module piccolo_tb;

	// Inputs
	reg clk;
	reg reset;
	//reg [0:79] keyin;
	reg [0:63] plaintext;

	// Outputs
	wire [0:63] ciphertext;

	// Instantiate the Unit Under Test (UUT)
	piccolo uut (
		.clk(clk), 
		.reset(reset), 
		//.keyin(keyin),
		.plaintext(plaintext), 
		.ciphertext(ciphertext)
	);
	always #5 clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		plaintext = 64'h0123456789abcdef;
		//keyin = 80'h00112233445566778899;

		$dumpfile("piccolo.VCD");
		$dumpvars(1,piccolo_tb.uut);
		// Wait 100 ns for global reset to finish
		#10 reset = 0;
        
		// Add stimulus here
end
      
endmodule

