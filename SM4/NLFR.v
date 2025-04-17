`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/19 10:32:38
// Design Name: 
// Module Name: NLFR
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


module NLFR(
	input				clk,
	input				rst_n,
	output		[127:00]	Random
    );
	//intermediate:
	(* dont_touch="true" *)reg			[07:00]	Rand1_r;
	(* dont_touch="true" *)reg			[07:00]	Rand2_r;
	(* dont_touch="true" *)reg			[07:00]	Rand3_r;
	(* dont_touch="true" *)reg			[07:00]	Rand4_r;
	(* dont_touch="true" *)reg			[07:00]	Rand5_r;
	(* dont_touch="true" *)reg			[07:00]	Rand6_r;
	
	(* dont_touch="true" *)reg			[07:00]	Rand7_r;
	(* dont_touch="true" *)reg			[07:00]	Rand8_r;
	(* dont_touch="true" *)reg			[07:00]	Rand9_r;
	(* dont_touch="true" *)reg			[07:00]	Randa_r;
	(* dont_touch="true" *)reg			[07:00]	Randb_r;
	(* dont_touch="true" *)reg			[07:00]	Randc_r;
	
	(* dont_touch="true" *)reg			[07:00]	Randd_r;
	(* dont_touch="true" *)reg			[07:00]	Rande_r;
	(* dont_touch="true" *)reg			[07:00]	Randf_r;
	(* dont_touch="true" *)reg			[07:00]	Randg_r;
	
	
	
	assign Random = {Rand1_r, Rand2_r, Rand3_r, Rand4_r, Rand5_r, Rand6_r, Rand7_r, Rand8_r, Rand9_r, Randa_r, Randb_r, Randc_r,  Randd_r, Rande_r, Randf_r, Randg_r};
	
	always @(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
			begin
				Rand1_r <= 8'd12;
				Rand2_r <= 8'd23;
				Rand3_r <= 8'd34;
				Rand4_r <= 8'd56;
				Rand5_r <= 8'd67;
				Rand6_r <= 8'd78;
				
				Rand7_r <= 8'd12;
				Rand8_r <= 8'd22;
				Rand9_r <= 8'd35;
				Randa_r <= 8'd44;
				Randb_r <= 8'd67;
				Randc_r <= 8'd75;
				
				Randd_r <= 8'd11;
				Rande_r <= 8'd21;
				Randf_r <= 8'd33;
				Randg_r <= 8'd44;				
			end
		else
			begin
				Rand1_r[0] <= Rand1_r[7] ^ Rand1_r[1] ^ Rand1_r[0];
				Rand1_r[1] <= Rand1_r[0];
				Rand1_r[2] <= Rand1_r[1];
				Rand1_r[3] <= Rand1_r[2];
				Rand1_r[4] <= Rand1_r[3];
				Rand1_r[5] <= Rand1_r[4];
				Rand1_r[6] <= Rand1_r[5];
				Rand1_r[7] <= Rand1_r[6];
				
				Rand2_r[0] <= Rand2_r[7] ^ Rand2_r[3] ^ Rand2_r[0];
				Rand2_r[1] <= Rand2_r[0];
				Rand2_r[2] <= Rand2_r[1];
				Rand2_r[3] <= Rand2_r[2];
				Rand2_r[4] <= Rand2_r[3];
				Rand2_r[5] <= Rand2_r[4];
				Rand2_r[6] <= Rand2_r[5];
				Rand2_r[7] <= Rand2_r[6];
				
				Rand3_r[0] <= Rand3_r[7] ^ Rand3_r[5] ^ Rand3_r[2] ^ Rand3_r[1] ^ Rand3_r[0];
				Rand3_r[1] <= Rand3_r[0];
				Rand3_r[2] <= Rand3_r[1];
				Rand3_r[3] <= Rand3_r[2];
				Rand3_r[4] <= Rand3_r[3];
				Rand3_r[5] <= Rand3_r[4];
				Rand3_r[6] <= Rand3_r[5];
				Rand3_r[7] <= Rand3_r[6];
				
				Rand4_r[0] <= Rand4_r[7] ^ Rand4_r[1] ^ Rand4_r[0];
				Rand4_r[1] <= Rand4_r[0];
				Rand4_r[2] <= Rand4_r[1];
				Rand4_r[3] <= Rand4_r[2];
				Rand4_r[4] <= Rand4_r[3];
				Rand4_r[5] <= Rand4_r[4];
				Rand4_r[6] <= Rand4_r[5];
				Rand4_r[7] <= Rand4_r[6];
				
				Rand5_r[0] <= Rand5_r[7] ^ Rand5_r[3] ^ Rand5_r[0];
				Rand5_r[1] <= Rand5_r[0];
				Rand5_r[2] <= Rand5_r[1];
				Rand5_r[3] <= Rand5_r[2];
				Rand5_r[4] <= Rand5_r[3];
				Rand5_r[5] <= Rand5_r[4];
				Rand5_r[6] <= Rand5_r[5];
				Rand5_r[7] <= Rand5_r[6];
				
				Rand6_r[0] <= Rand6_r[7] ^ Rand6_r[5] ^ Rand6_r[2] ^ Rand6_r[1] ^ Rand6_r[0];
				Rand6_r[1] <= Rand6_r[0];
				Rand6_r[2] <= Rand6_r[1];
				Rand6_r[3] <= Rand6_r[2];
				Rand6_r[4] <= Rand6_r[3];
				Rand6_r[5] <= Rand6_r[4];
				Rand6_r[6] <= Rand6_r[5];
				Rand6_r[7] <= Rand6_r[6];
				
				Rand7_r[0] <= Rand7_r[7] ^ Rand7_r[1] ^ Rand7_r[0];
				Rand7_r[1] <= Rand7_r[0];
				Rand7_r[2] <= Rand7_r[1];
				Rand7_r[3] <= Rand7_r[2];
				Rand7_r[4] <= Rand7_r[3];
				Rand7_r[5] <= Rand7_r[4];
				Rand7_r[6] <= Rand7_r[5];
				Rand7_r[7] <= Rand7_r[6];
				
				Rand8_r[0] <= Rand8_r[7] ^ Rand8_r[3] ^ Rand8_r[0];
				Rand8_r[1] <= Rand8_r[0];
				Rand8_r[2] <= Rand8_r[1];
				Rand8_r[3] <= Rand8_r[2];
				Rand8_r[4] <= Rand8_r[3];
				Rand8_r[5] <= Rand8_r[4];
				Rand8_r[6] <= Rand8_r[5];
				Rand8_r[7] <= Rand8_r[6];
				
				Rand9_r[0] <= Rand9_r[7] ^ Rand9_r[5] ^ Rand9_r[2] ^ Rand9_r[1] ^ Rand9_r[0];
				Rand9_r[1] <= Rand9_r[0];
				Rand9_r[2] <= Rand9_r[1];
				Rand9_r[3] <= Rand9_r[2];
				Rand9_r[4] <= Rand9_r[3];
				Rand9_r[5] <= Rand9_r[4];
				Rand9_r[6] <= Rand9_r[5];
				Rand9_r[7] <= Rand9_r[6];
				
				Randa_r[0] <= Randa_r[7] ^ Randa_r[1] ^ Randa_r[0];
				Randa_r[1] <= Randa_r[0];
				Randa_r[2] <= Randa_r[1];
				Randa_r[3] <= Randa_r[2];
				Randa_r[4] <= Randa_r[3];
				Randa_r[5] <= Randa_r[4];
				Randa_r[6] <= Randa_r[5];
				Randa_r[7] <= Randa_r[6];
				
				Randb_r[0] <= Randb_r[7] ^ Rand5_r[3] ^ Randb_r[0];
				Randb_r[1] <= Randb_r[0];
				Randb_r[2] <= Randb_r[1];
				Randb_r[3] <= Randb_r[2];
				Randb_r[4] <= Randb_r[3];
				Randb_r[5] <= Randb_r[4];
				Randb_r[6] <= Randb_r[5];
				Randb_r[7] <= Randb_r[6];
				
				Randc_r[0] <= Randc_r[7] ^ Randc_r[5] ^ Rand6_r[2] ^ Randa_r[1] ^ Rand6_r[0];
				Randc_r[1] <= Randc_r[0];
				Randc_r[2] <= Randc_r[1];
				Randc_r[3] <= Randc_r[2];
				Randc_r[4] <= Randc_r[3];
				Randc_r[5] <= Randc_r[4];
				Randc_r[6] <= Randc_r[5];
				Randc_r[7] <= Randc_r[6];
				
				Randd_r[0] <= Randd_r[7] ^ Randd_r[5] ^ Randc_r[2] ^ Randd_r[1] ^ Rand9_r[0];
				Randd_r[1] <= Randd_r[0];
				Randd_r[2] <= Randd_r[1];
				Randd_r[3] <= Randd_r[2];
				Randd_r[4] <= Randd_r[3];
				Randd_r[5] <= Randd_r[4];
				Randd_r[6] <= Randd_r[5];
				Randd_r[7] <= Randd_r[6];
				
				Rande_r[0] <= Rande_r[7] ^ Rande_r[1] ^ Randd_r[0];
				Rande_r[1] <= Rande_r[0];
				Rande_r[2] <= Rande_r[1];
				Rande_r[3] <= Rande_r[2];
				Rande_r[4] <= Rande_r[3];
				Rande_r[5] <= Rande_r[4];
				Rande_r[6] <= Rande_r[5];
				Rande_r[7] <= Rande_r[6];
				
				Randf_r[0] <= Randf_r[7] ^ Rande_r[3] ^ Randb_r[0];
				Randf_r[1] <= Randf_r[0];
				Randf_r[2] <= Randf_r[1];
				Randf_r[3] <= Randf_r[2];
				Randf_r[4] <= Randf_r[3];
				Randf_r[5] <= Randf_r[4];
				Randf_r[6] <= Randf_r[5];
				Randf_r[7] <= Randf_r[6];
				
				Randg_r[0] <= Randg_r[7] ^ Randf_r[5] ^ Rand6_r[2] ^ Randa_r[1] ^ Rand6_r[0];
				Randg_r[1] <= Randg_r[0];
				Randg_r[2] <= Randg_r[1];
				Randg_r[3] <= Randg_r[2];
				Randg_r[4] <= Randg_r[3];
				Randg_r[5] <= Randg_r[4];
				Randg_r[6] <= Randg_r[5];
				Randg_r[7] <= Randg_r[6];
			end
	end
endmodule
