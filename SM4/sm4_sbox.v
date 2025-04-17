`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 11:04:25
// Design Name: 
// Module Name: sm4_sbox
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


module sm4_sbox(
	input           	clk,
    input          	 	rst_n,
    input          	 	start,
    input      [7:0]    x,//m,
    output       	finish,
    output [7:0]    s_out1
    );
   
   //	reg       [3:0]  now_state;       // State Machine register
 //   reg       [3:0]  next_state;      // Next State Machine value
  //  reg              start_flag; 
  wire       [3:0]  f_count;   
  wire start_flag;
  // reg flag_0,flag_1,flag_2,flag_3,flag_4,flag_5,flag_6,flag_7;
  wire [7:0] flag;
//   `define  IDLE       3'h1           
 //  `define  AF_MAP     3'h1           
  // `define  First      3'h2
 //  `define  Second     3'h3
 //  `define  Third      3'h4
   //`define  INV_AF_MAP 3'h5            
   
   wire [3:0] a0,a1,b0,b1;
   wire [3:0] c0,c1,c2,c3;
   //reg [3:0] d1,d0;
   wire [1:0] e1,e0,f1,f0;
   wire [1:0] g3,g2,g1,g0;
   wire [1:0] h1,h0;
   wire [1:0] i1,i0;
   wire [3:0] j3,j2,j1,j0;
  // reg [3:0] k1,k0;
   wire [7:0] p3,p2,p1,p0;
 //  reg [7:0] y1,y0;
   

   
   
   function [7:0] affine;
        input [7:0] x;
        input r;
        
        reg [7:0] y;
        begin
            y[7] = (^(x & 8'b11010011))^r;
            y[6] = (^(x & 8'b11101001))^r;
            y[5] =  ^(x & 8'b11110100);
            y[4] = (^(x & 8'b01111010))^r;   
            y[3] =  ^(x & 8'b00111101);  
            y[2] =  ^(x & 8'b10011110);  
            y[1] = (^(x & 8'b01001111))^r;
            y[0] = (^(x & 8'b10100111))^r;
            affine = y;    
        end    
   endfunction
   
   function [7:0] Map;
        input [7:0] y;
        input r;
        
        reg [7:0] x1,x0;
        reg a,b,c,d,e,f,g,h;
        begin
            x0 = affine(y,r);    
            x1[7] = ^(x0 & 8'b01011110);
            x1[6] = ^(x0 & 8'b01111100);
            x1[5] = ^(x0 & 8'b11010000);
            x1[4] = ^(x0 & 8'b01010000);   
            x1[3] = ^(x0 & 8'b00101110);  
            x1[2] = ^(x0 & 8'b11001110);  
            x1[1] = ^(x0 & 8'b00001010);
            x1[0] = ^(x0 & 8'b00101101);
            a  = ^(x1[7:4] & 4'b1000);
            b  = ^(x1[7:4] & 4'b1110);
            c  = ^(x1[7:4] & 4'b1100);
            d  = ^(x1[7:4] & 4'b0001);
            e  = ^(x1[3:0] & 4'b1000);
            f  = ^(x1[3:0] & 4'b1110);
            g  = ^(x1[3:0] & 4'b1100);
            h  = ^(x1[3:0] & 4'b0001);
            Map = {a,b,c,d,e,f,g,h};
        end
   endfunction
   
   function [7:0] inv_map;
       input [7:0] x;
       input r;
       
       reg [7:0] y,z,u;
       begin
           y[7] = ^(x[7:4] & 4'b1000);
           y[6] = ^(x[7:4] & 4'b1010);
           y[5] = ^(x[7:4] & 4'b0110);
           y[4] = ^(x[7:4] & 4'b0001);
           y[3] = ^(x[3:0] & 4'b1000);
           y[2] = ^(x[3:0] & 4'b1010);
           y[1] = ^(x[3:0] & 4'b0110);
           y[0] = ^(x[3:0] & 4'b0001);
           z[7] = ^(y & 8'b00110000);
           z[6] = ^(y & 8'b10100100);
           z[5] = ^(y & 8'b10011000);
           z[4] = ^(y & 8'b10110100);
           z[3] = ^(y & 8'b01011010);
           z[2] = ^(y & 8'b10010010);
           z[1] = ^(y & 8'b01011000);
           z[0] = ^(y & 8'b01010001);
           u = affine(z,r);
           
           inv_map = u;
       end 
   endfunction
 
   
   
   function [1:0] Multi22;
        input [1:0] g,d;
        
        Multi22 = {(g[1] ^ g[0]) & (d[1] ^ d[0])^ (g[0] & d[0]), (g[1] & d[1]) ^ (g[0] & d[0])};
   endfunction
   
   
   function [3:0] Multi24;
        input [3:0] x,y;
        
        reg [1:0] m0,m1,m2,m3;
        begin
            m0 = Multi22(x[3:2],y[3:2]);
            m1 = Multi22( m0 , 2'b10);
            m2 = Multi22( x[3:2]^x[1:0], y[3:2]^y[1:0]);
            m3 = Multi22( x[1:0],y[1:0]);
            Multi24 = {m2 ^ m3, m1 ^ m3};
        end
   endfunction
   
   
   function [3:0] Square24;
        input [3:0] x;
        
        reg [3:0] x_sq;
        begin
            x_sq = Multi24(x,x);
            Square24 = Multi24(x_sq,4'b1111);
        end
   endfunction
   
   
   
   function [1:0] Square22;
        input [1:0] x;
        
        reg [1:0] m;
        begin
            m = Multi22(x,x);
            Square22 = Multi22(m,2'b10);
        end
   endfunction
   //GF(2^2)
   
   function [1:0] Inv;
        input [1:0] x;
        Inv  = {x[1], x[1]^x[0]};
   endfunction
   
	assign {a1,b1} = Map(x,1'b1);//affine(x,1'b1);
   //assign {a0,b0} = Map(m,1'b0);//affine(m,1'b0);
   assign c3 = Multi24(a1^b1, b1) ^ Square24(a1); 
   //assign c2 = Multi24(a1^b1, b0);
   //assign c1 = Multi24(a0^b0, b1);
   //assign c0 = Multi24(a0^b0, b0) ^ Square24(a0);    
	assign {e1,f1} = c3 ;//^ c2;
   //assign {e0,f0} = c1 ^ c0;
   assign g3 = Multi22(e1^f1, f1) ^ Square22(e1);
   //assign g2 = Multi22(e1^f1, f0);
   //assign g1 = Multi22(e0^f0, f1);
  // assign g0 = Multi22(e0^f0, f0) ^ Square22(e0);
   assign i1 = Inv(g3);//^ g2
   //assign i0 = Inv(g1 ^ g0);
	assign j3 = {Multi22(i1, e1), Multi22(i1, e1^f1)};
   //assign j2 = {Multi22(i1, e0), Multi22(i1, e0^f0)};
   //assign j1 = {Multi22(i0, e1), Multi22(i0, e1^f1)};
   //assign j0 = {Multi22(i0, e0), Multi22(i0, e0^f0)};
	assign p3 = {Multi24(j3, a1), Multi24(j3, a1^b1)};
	//assign p3 = {Multi24(j3^j2, a1), Multi24(j3^j2, a1^b1)};
   //assign p2 = {Multi24(j3^j2, a0), Multi24(j3^j2, a0^b0)};
   //assign p1 = {Multi24(j1^j0, a1), Multi24(j1^j0, a1^b1)};
   //assign p0 = {Multi24(j1^j0, a0), Multi24(j1^j0, a0^b0)};
	assign s_out1 = inv_map(p3,1'b1);
	//assign s_out0 = inv_map(p1^p0,1'b0);
    
     
endmodule