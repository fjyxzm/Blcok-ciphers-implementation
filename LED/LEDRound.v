`timescale    1ns/1ns
`define       N    63

module  LEDRound_r(res,s,key,r);
    input [7:0]  r;
    input [`N:0] s,key;
    
    output[`N:0] res;
    wire  [`N:0] led0,led1,led2,led3;
    
    reg [7:0] RC[0:47];
    reg [3:0] sbox[0:15];
    initial  begin
       RC[ 0]=8'h01; RC[ 1]=8'h03; RC[ 2]=8'h07; RC[ 3]=8'h0F; RC[ 4]=8'h1F;
       RC[ 5]=8'h3E; RC[ 6]=8'h3D; RC[ 7]=8'h3B; RC[ 8]=8'h37; RC[ 9]=8'h2F;
		 RC[10]=8'h1E; RC[11]=8'h3C; RC[12]=8'h39; RC[13]=8'h33; RC[14]=8'h27;
		 RC[15]=8'h0E; RC[16]=8'h1D; RC[17]=8'h3A; RC[18]=8'h35; RC[19]=8'h2B;
		 RC[20]=8'h16; RC[21]=8'h2C; RC[22]=8'h18; RC[23]=8'h30; RC[24]=8'h21;
		 RC[25]=8'h02; RC[26]=8'h05; RC[27]=8'h0B; RC[28]=8'h17; RC[29]=8'h2E;
		 RC[30]=8'h1C; RC[31]=8'h38; RC[32]=8'h31; RC[33]=8'h23; RC[34]=8'h06;
		 RC[35]=8'h0D; RC[36]=8'h1B; RC[37]=8'h36; RC[38]=8'h2D; RC[39]=8'h1A;
		 RC[40]=8'h34; RC[41]=8'h29; RC[42]=8'h12; RC[43]=8'h24; RC[44]=8'h08; 
		 RC[45]=8'h11; RC[46]=8'h22; RC[47]=8'h04;
		 
       sbox[0]=12;  sbox[1]=5; sbox[2]=6;  sbox[3]=11;
       sbox[4]=9;   sbox[5]=0; sbox[6]=10; sbox[7]=13;
       sbox[8]=3;  sbox[9]=14;sbox[10]=15; sbox[11]=8;
       sbox[12]=4; sbox[13]=7;sbox[14]=1;  sbox[15]=2;
	 end
    

    
    assign   led0={
                     s[63:60],     s[59:56]^RC[r][5:3],s[55:48], 
                     s[47:44]^4'h1,s[43:40]^RC[r][2:0],s[39:32],
                     s[31:28]^4'h2,s[27:24]^RC[r][5:3],s[23:16],
                     s[15:12]^4'h3,s[11: 8]^RC[r][2:0],s[ 7: 0]
    };
                     
    assign   led1={
               sbox[led0[63:60]],sbox[led0[59:56]],sbox[led0[55:52]],sbox[led0[51:48]],
               sbox[led0[47:44]],sbox[led0[43:40]],sbox[led0[39:36]],sbox[led0[35:32]],
               sbox[led0[31:28]],sbox[led0[27:24]],sbox[led0[23:20]],sbox[led0[19:16]],
               sbox[led0[15:12]],sbox[led0[11:8]], sbox[led0[ 7: 4]],sbox[led0[ 3: 0]]
    };
    
    assign     led2={led1[63:48],led1[43:32],led1[47:44],led1[23:16],led1[31:24],led1[3:0],led1[15:4]};
    MixColumn  MC(led3,led2);
    
    assign     res =(r[1:0]==(2'b11))? led3^key:led3;
    
endmodule
