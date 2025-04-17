`timescale   1ns/1ns
module  newcipherRound(res,r_keys,orc,state,keys,r,rc);
    input  [63:0] state;
    input  [63:0] keys;    
    input  [4:0] rc;
    input  [4:0]  r;
    
    output [63:0] res;
    output  [63:0] r_keys;
    output [4:0] orc;
    
    //wire   [31:0] tem0;
    wire   [63:0] key0;//key1,key2;
    wire   [3:0]  s0,s1;
    reg [3:0] sbox[0:15];
    wire   [31:0] tem0,tem1,tem2,tem3;
    wire   [63:0] tem4,tem5;
    initial begin
        sbox[0]=6;  sbox[1]=5; sbox[2]=12;  sbox[3]=10;
        sbox[4]=1;   sbox[5]=14; sbox[6]=7; sbox[7]=9;
        sbox[8]=11;  sbox[9]=0;sbox[10]=3; sbox[11]=13;
        sbox[12]=8; sbox[13]=15;sbox[14]=4;  sbox[15]=2;
    end   
    assign tem4=(r==(5'b00001))?{
      state[63:60],state[39:36],state[ 3: 0],state[27:24],
      state[43:40],state[51:48],state[23:20],state[15:12],
      state[19:16],state[11: 8],state[47:44],state[55:52],
      state[ 7: 4],state[31:28],state[59:56],state[35:32]}:state;
    assign        tem0= {tem4[55:48] ^ keys[63:56],tem4[39:32]^ keys[55:48],tem4[23:16]^ keys[31:24],tem4[7:0] ^ keys[23:16]};
    assign tem1={
        sbox[{tem0[ 7],tem0[15],tem0[23],tem0[31]}],sbox[{tem0[ 6],tem0[14],tem0[22],tem0[30]}],
        sbox[{tem0[ 5],tem0[13],tem0[21],tem0[29]}],sbox[{tem0[ 4],tem0[12],tem0[20],tem0[28]}],
        sbox[{tem0[ 3],tem0[11],tem0[19],tem0[27]}],sbox[{tem0[ 2],tem0[10],tem0[18],tem0[26]}],
        sbox[{tem0[ 1],tem0[ 9],tem0[17],tem0[25]}],sbox[{tem0[ 0],tem0[ 8],tem0[16],tem0[24]}]
    };
    //sbox ss(tem1,tem0);
    assign tem2={
        tem1[28],tem1[24],tem1[20],tem1[16],tem1[12],tem1[ 8],tem1[4],tem1[0],
        tem1[29],tem1[25],tem1[21],tem1[17],tem1[13],tem1[ 9],tem1[5],tem1[1],
        tem1[30],tem1[26],tem1[22],tem1[18],tem1[14],tem1[10],tem1[6],tem1[2],
        tem1[31],tem1[27],tem1[23],tem1[19],tem1[15],tem1[11],tem1[7],tem1[3]
    };
    //assign tem3 = {tem2[31:24],tem2[22:16],tem2[23],tem2[11:8],tem2[15:12],tem2[2:0],tem2[7:3]};
    assign tem3 = {
        tem2[31],tem2[27],tem2[21],tem2[17],tem2[ 4],tem2[ 0],tem2[14],tem2[10],
        tem2[22],tem2[18],tem2[28],tem2[24],tem2[13],tem2[ 9],tem2[ 7],tem2[ 3],
        tem2[ 8],tem2[12],tem2[ 2],tem2[ 6],tem2[19],tem2[23],tem2[25],tem2[29],
        tem2[ 1],tem2[ 5],tem2[11],tem2[15],tem2[26],tem2[30],tem2[16],tem2[20]
    };
    
    assign tem5={
      tem4[55:48],tem4[63:56]^tem3[31:24],
      tem4[39:32],tem4[47:40]^tem3[23:16], 
      tem4[23:16],tem4[31:24]^tem3[15: 8], 
      tem4[ 7: 0],tem4[15: 8]^tem3[ 7: 0] 
    };
    assign res=(r==(5'b11100))?{
      tem5[55:52],tem5[15:12],tem5[27:24],tem5[35:32],
      tem5[31:28],tem5[39:36],tem5[51:48],tem5[11: 8],
      tem5[ 3: 0],tem5[59:56],tem5[47:44],tem5[23:20],
      tem5[43:40],tem5[19:16],tem5[ 7: 4],tem5[63:60]
    }:tem5;
    //cipherF spn(tem0,state[31:0],keys[63:32]);
    //assign res={state[31:0],tem0^state[63:32]};
    assign     s0=sbox[{keys[51],keys[35],keys[50],keys[34]}];
    assign     s1=sbox[{keys[49],keys[33],keys[48],keys[32]}];
    assign     key0={
                  keys[63:52],s0[3],s0[1],s1[3],s1[1],
                  keys[47:36],s0[2],s0[0],s1[2],s1[0],
                  keys[31:0]
               };
    assign     r_keys={
                  key0[52:48]^key0[47:43],key0[63:58]^key0[42:37],key0[57:53]^key0[36:32]^rc[4:0],
                  key0[31:0],
                  key0[63:48]
               };
    assign     orc={
        rc[3:0],rc[4]^rc[2]   
    };
    
endmodule    
    
