`timescale  1ns/1ns
module FieldMutil(c,a,b);
    
    input [0:3] a,b;
    output[0:3] c;
    
    wire  [0:3] s2,s1,s0;
    
    assign  s2=( a[0]==1)?{ a[1:2], !a[3],1'b1}:{ a[1:3],1'b0};
    assign  s1=(s2[0]==1)?{s2[1:2],!s2[3],1'b1}:{s2[1:3],1'b0};
    assign  s0=(s1[0]==1)?{s1[1:2],!s1[3],1'b1}:{s1[1:3],1'b0};
    
    assign  c=( (b[3]==1)?a:0)^( (b[2]==1)?s2:0)^( (b[1]==1)?s1:0)^( (b[0]==1)?s0:0);
    
endmodule