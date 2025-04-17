`timescale   1ns/1ns

/*
module  PresentRound1(res,r_keys,state,keys,r);

    input  [0:63] state;
    input  [0:79] keys;
    input  [0:4]  r;
    output [0:63] res;
    output [0:79] r_keys;
    
    wire   [0:63] tem0;
	  wire   [0:67] tem1;
  
    
    assign        tem0= state ^ keys[0:63];
	 
    presentsbox sbox({tem0,keys[61:64]},tem1);
    
    Exchange      Ec(res,tem1[0:63]);
    assign     r_keys={
        tem1[64:67],keys[65:79],keys[0:40],(keys[41:45])^r,keys[46:60]
    };
    
endmodule    
*/
module  PresentRound(res,state);

    input  [0:63] state;
    output [0:63] res;
    
    wire   [0:63] tem0,tem1;
    reg [0:3] sbox[0:15];
    initial begin
        sbox[0]=12;  sbox[1]=5; sbox[2]=6;  sbox[3]=11;
        sbox[4]=9;   sbox[5]=0; sbox[6]=10; sbox[7]=13;
        sbox[8]=3;  sbox[9]=14;sbox[10]=15; sbox[11]=8;
        sbox[12]=4; sbox[13]=7;sbox[14]=1;  sbox[15]=2;
    end
    
    
    
    assign        tem0= state;// ^ keys[0:63];
    assign res={
               sbox[tem0[ 0: 3]],sbox[tem0[ 4: 7]],sbox[tem0[ 8:11]],sbox[tem0[12:15]],
               sbox[tem0[16:19]],sbox[tem0[20:23]],sbox[tem0[24:27]],sbox[tem0[28:31]],
               sbox[tem0[32:35]],sbox[tem0[36:39]],sbox[tem0[40:43]],sbox[tem0[44:47]],
               sbox[tem0[48:51]],sbox[tem0[52:55]],sbox[tem0[56:59]],sbox[tem0[60:63]]
    };
    Exchange      Ec(res,tem1);
    //assign     r_keys={
     //   sbox[ keys[61:64] ],keys[65:79],keys[0:40],(keys[41:45])^r,keys[46:60]
    //};
    
endmodule    