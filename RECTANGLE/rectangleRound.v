module rectangleRound(res,r_keys,orc,state,keys,r,rc);
    input  [63:0] state;
    input  [79:0] keys;    
    input  [4:0] rc;
    input  [4:0]  r;
    
    output [63:0] res;
    output  [79:0] r_keys;
    output [4:0] orc;
    
    wire   [63:0] tem0,tem1,tem2;
    wire   [79:0] key0;//key1,key2;
    wire   [3:0]  s0,s1,s2,s3;
    reg [3:0] sbox[0:15];
    initial begin
        sbox[0]=6;  sbox[1]=5; sbox[2]=12;  sbox[3]=10;
        sbox[4]=1;   sbox[5]=14; sbox[6]=7; sbox[7]=9;
        sbox[8]=11;  sbox[9]=0;sbox[10]=3; sbox[11]=13;
        sbox[12]=8; sbox[13]=15;sbox[14]=4;  sbox[15]=2;
    end   
    
    assign        tem0= state[63:0] ^ keys[79:16];
    assign tem1={
        sbox[{tem0[15],tem0[31],tem0[47],tem0[63]}],sbox[{tem0[14],tem0[30],tem0[46],tem0[62]}],
        sbox[{tem0[13],tem0[29],tem0[45],tem0[61]}],sbox[{tem0[12],tem0[28],tem0[44],tem0[60]}],
        sbox[{tem0[11],tem0[27],tem0[43],tem0[59]}],sbox[{tem0[10],tem0[26],tem0[42],tem0[58]}],
        sbox[{tem0[ 9],tem0[25],tem0[41],tem0[57]}],sbox[{tem0[ 8],tem0[24],tem0[40],tem0[56]}],
        sbox[{tem0[ 7],tem0[23],tem0[39],tem0[55]}],sbox[{tem0[ 6],tem0[22],tem0[38],tem0[54]}],
        sbox[{tem0[ 5],tem0[21],tem0[37],tem0[53]}],sbox[{tem0[ 4],tem0[20],tem0[36],tem0[52]}],
        sbox[{tem0[ 3],tem0[19],tem0[35],tem0[51]}],sbox[{tem0[ 2],tem0[18],tem0[34],tem0[50]}],
        sbox[{tem0[ 1],tem0[17],tem0[33],tem0[49]}],sbox[{tem0[ 0],tem0[16],tem0[32],tem0[48]}]
    };
    assign tem2={
        tem1[60],tem1[56],tem1[52],tem1[48],tem1[44],tem1[40],tem1[36],tem1[32],tem1[28],tem1[24],tem1[20],tem1[16],tem1[12],tem1[ 8],tem1[4],tem1[0],
        tem1[61],tem1[57],tem1[53],tem1[49],tem1[45],tem1[41],tem1[37],tem1[33],tem1[29],tem1[25],tem1[21],tem1[17],tem1[13],tem1[ 9],tem1[5],tem1[1],
        tem1[62],tem1[58],tem1[54],tem1[50],tem1[46],tem1[42],tem1[38],tem1[34],tem1[30],tem1[26],tem1[22],tem1[18],tem1[14],tem1[10],tem1[6],tem1[2],
        tem1[63],tem1[59],tem1[55],tem1[51],tem1[47],tem1[43],tem1[39],tem1[35],tem1[31],tem1[27],tem1[23],tem1[19],tem1[15],tem1[11],tem1[7],tem1[3]
    };
    assign res = {tem2[63:48],tem2[46:32],tem2[47],tem2[19:16],tem2[31:20],tem2[2:0],tem2[15:3]};
    //p_shift_state p_state(tem2,res);
    assign     s0=sbox[{keys[19],keys[35],keys[51],keys[67]}];
    assign     s1=sbox[{keys[18],keys[34],keys[50],keys[66]}];
    assign     s2=sbox[{keys[17],keys[33],keys[49],keys[65]}];
    assign     s3=sbox[{keys[16],keys[32],keys[48],keys[64]}];
    assign     key0={
                  keys[79:68],s0[0],s1[0],s2[0],s3[0],
                  keys[63:52],s0[1],s1[1],s2[1],s3[1],
                  keys[47:36],s0[2],s1[2],s2[2],s3[2],
                  keys[31:20],s0[3],s1[3],s2[3],s3[3],
                  keys[15:0]
               };
    assign     r_keys={
                  key0[71:64]^key0[63:56],key0[79:77]^key0[55:53],key0[76:72]^key0[52:48]^rc[4:0],
                  key0[47:32],key0[31:16],
                  key0[19:16]^key0[15:12],key0[31:20]^key0[11:0],
                  key0[79:64]
               };
    assign     orc={
        rc[3:0],rc[4]^rc[2]
    };
endmodule    

