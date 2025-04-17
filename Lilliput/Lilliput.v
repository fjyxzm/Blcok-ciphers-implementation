`timescale   1ns/1ns
module lilliput(result,state,Key,clk);    
input clk;
input  [63:0]state;
input  [79:0]Key;
output [63:0]result;

reg  ready;
reg  [4:0] cnt;

reg  [63:0] res;
reg  [79:0] k;
wire [63:0] temp;
wire [79:0] out_keys;

 initial  begin
        
         ready  <=1;
         cnt    <=5'b11111;
    end
    
     assign  result={
		res[31:28],
		res[3:0],
		res[27:24],
		res[11:8],
		res[7:4],
		res[15:12],
		res[23:20],
		res[19:16],
		res[63:60],
		res[51:48],
		res[47:44],
		res[43:40],
		res[35:32],
		res[59:56],
		res[39:36],
		res[55:52]
	};

    always @(posedge  clk)  begin    
        cnt    <= (cnt^29)? cnt+1: cnt;
        res    <= ready ? ( (cnt^5'b11111) ?temp:state ) :res;
        k      <= ready ? ( (cnt^5'b11111) ?out_keys:Key) :k;
        ready  <= (cnt^29)? 1:0;
    end

    encryption en_round(temp,out_keys,cnt,k,res);
endmodule


module encryption(result,out_key,count,Key,state);

input  [63:0]state;
input  [79:0]Key;
input  [4:0]count;
output [63:0]result;
output [79:0]out_key;
wire   [31:0]Z;
wire   [31:0]roundkeys; 
wire [63:0]temp1;
wire [31:0]temp;
reg    [3:0] sbox[0:15];


//0 1 2 3 4 5 6 7  8 9  A B  C  D E  F     sbox
//4 8 7 1 9 3 2 14 0 11 6 15 10 5 13 12
initial begin 
 sbox[0]=4;    sbox[1]=8;   sbox[2]=7;   sbox[3]=1;
 sbox[4]=9;    sbox[5]=3;   sbox[6]=2;   sbox[7]=14;
 sbox[8]=0;    sbox[9]=11;  sbox[10]=6;  sbox[11]=15;
 sbox[12]=10;  sbox[13]=5;  sbox[14]=13; sbox[15]=12;
end 


assign Z={ 
Key[75:72],Key[67:64],Key[55:52],Key[43:40],
Key[39:36],Key[27:24],Key[15:12],Key[7:4]};
                
assign temp={
sbox[{Z[7],Z[15],Z[23],Z[31]}],sbox[{Z[6],Z[14],Z[22],Z[30]}],sbox[{Z[5],Z[13],Z[21],Z[29]}],sbox[{Z[4],Z[12],Z[20],Z[28]}],
sbox[{Z[3],Z[11],Z[19],Z[27]}],sbox[{Z[2],Z[10],Z[18],Z[26]}],sbox[{Z[1],Z[9],Z[17],Z[25]}],sbox[{Z[0],Z[8],Z[16],Z[24]}]           
};                 
assign roundkeys={temp[31:27]^count[4:0],temp[26:0]};         


assign temp1 ={
state[63:60]^sbox[state[3:0]^roundkeys[31:28]], //x15
state[59:56]^sbox[(state[7:4]^roundkeys[27:24])], //x14
state[55:52]^sbox[(state[11:8]^roundkeys[23:20])], //x13
state[51:48]^sbox[(state[15:12]^roundkeys[19:16])], //x12
state[47:44]^sbox[(state[19:16]^roundkeys[15:12])], //x11
state[43:40]^sbox[(state[23:20]^roundkeys[11:8])], //x10
state[39:36]^sbox[(state[27:24]^roundkeys[7:4])], //x9
state[35:32]^sbox[state[31:28]^roundkeys[3:0]], //x8
state[31:28],   //x7
state[27:24],   //x6
state[23:20],   //x5
state[19:16],   //x4
state[15:12],   //x3
state[11:8],   //x2
state[7:4],    //x1
state[3:0]    //x0 };
};      //线性层

assign result={
temp1[31:28],   //x7
temp1[11:8],    //x2
temp1[3:0],    //x0
temp1[27:24],   //x6
temp1[23:20], //x5
temp1[19:16],   //4
temp1[7:4],  //x1
temp1[15:12],  //x3
temp1[63:60]^temp1[31:28]^temp1[27:24]^temp1[23:20]^temp1[19:16]^temp1[15:12]^temp1[11:8]^temp1[7:4], //15
temp1[55:52]^temp1[31:28],  //x13
temp1[39:36]^temp1[31:28], //9
temp1[35:32],  //x8
temp1[43:40]^temp1[31:28],   //x10
temp1[51:48]^temp1[31:28],   //x12
temp1[47:44]^temp1[31:28],   //x11
temp1[59:56]^temp1[31:28]   //x14
};          

assign out_key={
Key[75:72],Key[71:68],{Key[70:68],Key[71]}^Key[67:64]^{Key[60],1'b0,1'b0,1'b0},Key[63:60],Key[79:76],
{1'b0,1'b0,1'b0,Key[51]}^Key[55:52],Key[51:48],{Key[48],Key[51:49]}^Key[47:44],Key[43:40],Key[59:56],
Key[35:32],Key[31:28],{Key[28],1'b0,1'b0,1'b0}^Key[27:24],Key[23:20],{Key[34:32],Key[35]}^Key[39:36],
Key[15:12],Key[11:  8],{1'b0,1'b0,1'b0,Key[11]}^Key[ 7:  4],{Key[16],Key[19:17]}^Key[ 7:  4],Key[19:16]
};

endmodule
