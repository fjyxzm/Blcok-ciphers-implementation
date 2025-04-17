`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/16 21:28:26
// Design Name: 
// Module Name: sm4
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


module sm4(
	input               resetn,       // Async reset.
	input               clock,        // clock.

	input               enc_dec,      // Encrypt/Decrypt select. 0:Encrypt  1:Decrypt
	input               key_exp,      // Round Key Expansion
	input               start,        // Encrypt or Decrypt Start
	output 	            key_val,      // Round Key valid
	output reg          text_val,     // Cipher Text or Inverse Cipher Text valid
	input      [127:0]  key_in,       // Key input
	input      [127:0]  text_in,      // Cipher Text or Inverse Cipher Text input
	output reg [127:0]  text_out,     // Cipher Text or Inverse Cipher Text output
	output reg          busy          // SM4 unit Busy
	);

	parameter ROUNDNUM = 6'd33;
    //reg [31:0] 	ram [ROUNDNUM-1:0];
	reg [31:0]	M0, M1, M2, M3, r1, r2, m_linear, x_linear;
	reg	[5:0]	counter;
	wire[31:0] 	rk;
	wire		rk_en;
	wire[4:0]	rkaddr;
	wire[31:0] 	sout;
	wire[31:0]	key;
	wire[127:0] randnum;
	reg		   sbox_finish0;
	reg		   sbox_start;
	reg	[1:0]  delay;
	reg		   d_exp;
	reg        d_start;
	reg [127:0]d_text_in;
	reg [127:0]d_key_in;
	reg		   exp_tmp;
	wire	   sbox_finish;
	wire[31:0] x_out;
	wire[31:0] m_out;
	wire	   ks_sbox_start;
	wire	   ks_sbox_finish;
	wire[31:0] ks_x;
	wire[31:0] ks_x_out;
	wire[31:0] ks_m_out;
	wire	   sb_sbox_start;
	wire	   sb_sbox_finish;
	wire[31:0] sb_x;
	wire[5:0]  rdkeyaddr;
    
	/*
	genvar i;
	generate
	for (i = 0; i < ROUNDNUM; i = i + 1)
	begin:KEY
		always @(posedge clock or negedge resetn)
		begin
			if (~resetn)
				ram[i] <= 32'd0;
			else if(rk_en && rkaddr == i)
				ram[i] <= rk;
			else
				ram[i] <= ram[i];
		end
	end
	endgenerate
*/

function [31:0] Linear_Layer_f;
	input [31:0] lin;
	reg [31:0] A;
	reg [31:0] B;
	reg [31:0] C;
	reg [31:0] D;
	begin 
		A = {lin[29:0], lin[31:30]};		//<<<2
		B = {lin[21:0], lin[31:22]};		//<<<10
		C = {lin[13:0], lin[31:14]};		//<<<18
		D = {lin[7 :0], lin[31: 8]};		//<<<24
		Linear_Layer_f = lin ^ A ^ B ^ C ^ D;
	end
endfunction



	always @(posedge clock)
	begin
		sbox_finish0 <= sbox_finish;
		d_exp <= key_exp;
		d_start <= start;
		d_text_in <= text_in;
		d_key_in <= key_in;
	end
	
	always @(posedge clock or negedge resetn)
	begin
		if (~resetn)
			counter <= ROUNDNUM;
		else if(d_start && counter == ROUNDNUM)
			counter <= 6'd0;
		else if (key_val && counter < ROUNDNUM && sbox_finish)
			counter <= counter + 1;
		else if (counter == ROUNDNUM - 1)
			counter <= counter + 1;
		else
			counter <= counter;
	end

	always @(posedge clock or negedge resetn)
	begin
		if (~resetn)
			{M0, M1, M2, M3} <= 128'd0;
		else if (d_start)
			{M0, M1, M2, M3} <= d_text_in ^ {r2, r2, r2, r2};
		else if (key_val && counter < ROUNDNUM && sbox_finish0)
			{M0, M1, M2, M3} <= {M1, M2, M3, M0 ^ m_linear ^ x_linear};
		else
			{M0, M1, M2, M3} <= {M0, M1, M2, M3};
	end
	
	always @(posedge clock or negedge resetn)
	begin
		if (~resetn)
			delay <= 2'd0;
		else
			delay <= {delay[0], key_val};
	end
		
	always @(posedge clock or negedge resetn)
	begin
		if (~resetn)
			sbox_start <= 1'd0;
		else if (counter == 0 && (~delay[1] & delay[0]))
			sbox_start <= 1'd1;
		else if (d_start && key_val)
			sbox_start <= 1'd1;
		else if (sbox_finish0 && key_val && counter < ROUNDNUM)
			sbox_start <= 1'd1;
		else
			sbox_start <= 1'd0;
	end
	
	
	always @(posedge clock or negedge resetn)
	begin
		if (~resetn) begin
			m_linear <= 32'd0;
			x_linear <= 32'd0;
		end
		else if (sbox_finish)begin
			m_linear <= Linear_Layer_f(m_out);
			x_linear <= Linear_Layer_f(x_out);
		end
		else begin
			m_linear <= m_linear;
			x_linear <= x_linear;
		end
	end
	
	always @(posedge clock or negedge resetn)
	begin
		if (~resetn)
			text_out <= 128'd0;
		else if (counter == ROUNDNUM && key_val && sbox_finish0)
			text_out <= {M3, M2, M1, M0} ^ {r2, r2, r2, r2};
		else
			text_out <= text_out;
	end
	
	always @(posedge clock or negedge resetn)
	begin
		if (~resetn)
			text_val <= 1'd0;
		else if (counter == ROUNDNUM && key_val && sbox_finish0)
			text_val <= 1'd1;
		else
			text_val <= 1'd0;
	end
	
	always @(posedge clock or negedge resetn)
	begin
		if (~resetn)
			busy <= 1'd0;
		else if (~d_start & start)
			busy <= 1'd1;
		else if (text_val)
			busy <= 1'd0;
		else
			busy <= busy;
	end
	
	//assign key = (enc_dec == 1'd0) ? ram[counter] : ram[ROUNDNUM - 2 - counter];
	assign rdkeyaddr = (enc_dec == 1'd0) ? counter : ROUNDNUM - 2 - counter;
	
	always @(posedge clock or negedge resetn)
	begin
		if (~resetn)begin
			r1 <= 32'ha1236bcd;//randnum[127:96];
		end
		else if (key_exp) begin
			r1 <=  randnum[127:96];
		end
		else begin
			r1 <= r1;
		end
	end
	
	always @(posedge clock or negedge resetn)
	begin
		if (~resetn)begin
			r2 <= 32'ha1244bcf;//randnum[31:0];
		end
		else if (start) begin
			r2 <= randnum[31:0];
		end
		else begin
			r2 <= r2;
		end
	end


	assign sb_sbox_start = (key_val) ? sbox_start : ks_sbox_start;
	assign sbox_finish = (key_val) ? sb_sbox_finish : 1'd0;
	assign ks_sbox_finish = (key_val) ? 1'd0 : sb_sbox_finish;
	assign sb_x = (key_val) ? M1 ^ M2 ^ M3 ^ key : ks_x;
	assign ks_x_out = x_out;
	assign ks_m_out = m_out;
	
	NLFR u_nlfr(
	.clk			(clock						),
	.rst_n			(resetn						),
	.Random			(randnum					)
    );
	
	key_ram u_keyRam(
    .clka			(clock						),
    .ena			(1							),
    .wea			(rk_en						),
    .addra			({0,rkaddr}					),
    .dina			(rk							),
    .clkb			(clock						),
    .addrb			(rdkeyaddr					),
    .doutb			(key						)
  );
	
	
	SubNibble sn(
    .clk			(clock						),
    .rst_n			(resetn						),
    .start			(sb_sbox_start				),
    .finish			(sb_sbox_finish				),
    .x_out			(x_out						),
    .m_out			(m_out						),
    .m				(r2	^ r1					),
    .x				(sb_x						)
	);
	
	
	KeySchedule keyschedule(
	.clk			(clock						),
	.rst_n			(resetn						),
	.r1				(r1							),
	.r2				(r2							),
	.key_inital		(d_key_in					),
	.key_en			(d_exp						),
	.rk				(rk							),
	.rk_en			(rk_en						),
	.rkaddr			(rkaddr						),
	.key_gen_done	(key_val					),
	
	.sbox_start		(ks_sbox_start				),
	.x				(ks_x						),
	.sbox_finish	(ks_sbox_finish				),
	.x_out			(ks_x_out					),
	.m_out			(ks_m_out					)
    );
	
endmodule
