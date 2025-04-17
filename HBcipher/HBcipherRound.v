`timescale    1ns/1ns
`define       N    63

module  HBcipher_r(res,r_keys,s,keys,r);
    input [0:7]  r;
    input [0:`N] s,keys;
    
    output[0:`N] res,r_keys;
    reg  [0:31] L,R;
    reg [0:31] temp0,temp1,o_temp0,o_temp1;
    reg [0:7] temp2,temp3;
    reg [0:3] sbox[0:15];
    initial  begin
       sbox[0]=12;  sbox[1]=5; sbox[2]=6;  sbox[3]=11;
       sbox[4]=9;   sbox[5]=0; sbox[6]=10; sbox[7]=13;
       sbox[8]=3;  sbox[9]=14;sbox[10]=15; sbox[11]=8;
       sbox[12]=4; sbox[13]=7;sbox[14]=1;  sbox[15]=2;
	  end
    
    temp2={keys[0],keys[16],keys[32],keys[48],keys[15],keys[31],keys[47],keys[63]};
    temp3={sbox[temp2[0:3]],sbox[temp2[4:7]]};
    r_keys={
   keys[13],keys[ 2],keys[ 6],keys[10],keys[14],keys[ 3], keys[7],keys[11],temp3[4],temp3[0],keys[ 4],keys[ 8],keys[12],keys[ 1],keys[ 5],keys[ 9],
   keys[22],keys[26],keys[30],keys[19],keys[23],keys[27],temp3[5],temp3[1],keys[20],keys[24],keys[28],keys[17],keys[21],keys[25],keys[29],keys[18],
   keys[46],keys[35],keys[39],keys[43],temp3[6],temp3[2],keys[36],keys[40],keys[44],keys[33],keys[37],keys[41],keys[45],keys[34],keys[38],keys[42],
   keys[55],keys[59],temp3[7],temp3[3],keys[52],keys[56],keys[60],keys[49],keys[53],keys[57],keys[61],keys[50],keys[54],keys[58],keys[62],keys[51]};
  
  always @(r)
	 
	  begin 
	    case (r%2)
            1'b0: 
              begin
                L={in[0:3],in[ 8:11],in[16:19],in[24:27],in[32:35],in[40:43],in[48:51],in[56:59]};
                R={in[4:7],in[12:15],in[20:23],in[28:31],in[36:39],in[44:47],in[52:55],in[60:63]}; 
                L=L^{r_keys[0: 7],r_keys[16:23],r_keys[32:39],r_keys[48:55]};
                R=R^{r_keys[8:15],r_keys[24:31],r_keys[40:47],r_keys[56:63]};
               // temp0={L[0],L[8],L[16],L[24],L[1],L[9],L[17],L[25],L[2],L[10],L[18],L[26],L[3],L[11],L[19],L[27],L[4],L[12],L[20],L[28],L[5],L[13],L[21],L[29],L[6],L[14],L[22],L[30],L[7],L[15],L[23],L[31]};
               // temp1={R[0],R[8],R[16],R[24],R[1],R[9],R[17],R[25],R[2],R[10],R[18],R[26],R[3],R[11],R[19],R[27],R[4],R[12],R[20],R[28],R[5],R[13],R[21],R[29],R[6],R[14],R[22],R[30],R[7],R[15],R[23],R[31]};
               // temp0={sbox[temp0[ 0: 3]],sbox[temp0[ 4: 7]],sbox[temp0[ 8:11]],sbox[temp0[12:15]],
                       //sbox[temp0[16:19]],sbox[temp0[20:23]],sbox[temp0[24:27]],sbox[temp0[28:31]]};
               // temp1={sbox[temp1[ 0: 3]],sbox[temp1[ 4: 7]],sbox[temp1[ 8:11]],sbox[temp1[12:15]],
                      // sbox[temp1[16:19]],sbox[temp1[20:23]],sbox[temp1[24:27]],sbox[temp1[28:31]]};
                temp0={L[0],L[8],L[16],L[24],L[1],L[9],L[17],L[25],L[2],L[10],L[18],L[26],L[3],L[11],L[19],L[27],L[4],L[12],L[20],L[28],L[5],L[13],L[21],L[29],L[6],L[14],L[22],L[30],L[7],L[15],L[23],L[31]};
                temp1={R[0],R[8],R[16],R[24],R[1],R[9],R[17],R[25],R[2],R[10],R[18],R[26],R[3],R[11],R[19],R[27],R[4],R[12],R[20],R[28],R[5],R[13],R[21],R[29],R[6],R[14],R[22],R[30],R[7],R[15],R[23],R[31]};
                temp0={sbox[temp0[ 0: 3]],sbox[temp0[ 4: 7]],sbox[temp0[ 8:11]],sbox[temp0[12:15]],
                       sbox[temp0[16:19]],sbox[temp0[20:23]],sbox[temp0[24:27]],sbox[temp0[28:31]]};
                temp1={sbox[temp1[ 0: 3]],sbox[temp1[ 4: 7]],sbox[temp1[ 8:11]],sbox[temp1[12:15]],
                       sbox[temp1[16:19]],sbox[temp1[20:23]],sbox[temp1[24:27]],sbox[temp1[28:31]]};
           
                o_temp0={temp0[3:7],temp0[0:2],temp0[13:15],temp0[8:12],temp0[22:23],temp0[16:21],temp0[31],temp0[24:30]};
              end
            1'b1:
            begin
                R={in[0:3],in[ 8:11],in[16:19],in[24:27],in[32:35],in[40:43],in[48:51],in[56:59]};
                L={in[4:7],in[12:15],in[20:23],in[28:31],in[36:39],in[44:47],in[52:55],in[60:63]};
                L=R^{r_keys[8:15],r_keys[24:31],r_keys[40:47],r_keys[56:63]};
                R=L^{r_keys[0: 7],r_keys[16:23],r_keys[32:39],r_keys[48:55]};
                 temp0={L[0],L[8],L[16],L[24],L[1],L[9],L[17],L[25],L[2],L[10],L[18],L[26],L[3],L[11],L[19],L[27],L[4],L[12],L[20],L[28],L[5],L[13],L[21],L[29],L[6],L[14],L[22],L[30],L[7],L[15],L[23],L[31]};
                temp1={R[0],R[8],R[16],R[24],R[1],R[9],R[17],R[25],R[2],R[10],R[18],R[26],R[3],R[11],R[19],R[27],R[4],R[12],R[20],R[28],R[5],R[13],R[21],R[29],R[6],R[14],R[22],R[30],R[7],R[15],R[23],R[31]};
                temp0={sbox[temp0[ 0: 3]],sbox[temp0[ 4: 7]],sbox[temp0[ 8:11]],sbox[temp0[12:15]],
                       sbox[temp0[16:19]],sbox[temp0[20:23]],sbox[temp0[24:27]],sbox[temp0[28:31]]};
                temp1={sbox[temp1[ 0: 3]],sbox[temp1[ 4: 7]],sbox[temp1[ 8:11]],sbox[temp1[12:15]],
                       sbox[temp1[16:19]],sbox[temp1[20:23]],sbox[temp1[24:27]],sbox[temp1[28:31]]};
           
                o_temp0={temp0[3:7],temp0[0:2],temp0[13:15],temp0[8:12],temp0[22:23],temp0[16:21],temp0[31],temp0[24:30]};
          end 
      endcase
      case (r%4)
        2'b00: 
           begin
               o_temp1={temp1[0:7]^r[0:7],temp1[8:31]}; 
          end
        2'b01: 
           begin
              o_temp1={temp1[0:7],temp1[8:15]^r[0:7],temp1[15:31]};   
          end
        2'b10: 
           begin
               o_temp1={temp1[0:15],temp1[16:23]^r[0:7],temp1[24:31]};  
          end
        2'b11: 
           begin
              o_temp1={temp1[0:23],temp1[24:31]^r[0:7]};   
          end
      endcase
    end
    
    //assign o_temp1={temp1[3:7],temp1[0:2],temp1[13:15],temp0[8:12],temp0[22:23],temp0[16:21],temp0[31],temp0[24:30]};
    
    assign o_temp0={sbox[o_temp0[ 0: 3]],sbox[o_temp0[ 4: 7]],sbox[o_temp0[ 8:11]],sbox[o_temp0[12:15]],
                    sbox[o_temp0[16:19]],sbox[o_temp0[20:23]],sbox[o_temp0[24:27]],sbox[o_temp0[28:31]]};
    assign o_temp1={sbox[temp1[ 0: 3]],sbox[temp1[ 4: 7]],sbox[temp1[ 8:11]],sbox[temp1[12:15]],
                    sbox[temp1[16:19]],sbox[temp1[20:23]],sbox[temp1[24:27]],sbox[temp1[28:31]]};
                    
    assign     res ={o_temp0,o_temp1};
    
endmodule

