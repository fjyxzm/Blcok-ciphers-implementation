`timescale   1ns/1ns

module FieldMutilSum(c,x1,x2,x3,x4,
                     y1,y2,y3,y4);
    input  [0:3] x1,x2,x3,x4,y1,y2,y3,y4;
    output [0:3] c;
    
    wire   [0:3] re[0:3]; 
    wire   [0:3] c;
    
   FieldMutil   FM0(re[0],x1,y1);
   FieldMutil   FM1(re[1],x2,y2);
   FieldMutil   FM2(re[2],x3,y3);
   FieldMutil   FM3(re[3],x4,y4);
   assign       c=(re[0] ^ re[1] ^ re[2] ^re[3]);
   
 endmodule
