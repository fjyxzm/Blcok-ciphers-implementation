`timescale   1ns/1ns

module   test;
    reg  clk;
    reg [63:0]  state;
    reg [79:0]  keys;
    
    wire[63:0]  res;
    
    initial  begin
         clk<=0;
         state<=64'h0000_0000_0000_0000;
         keys<=80'h0000_0000_0000_0000_0000;
         //state=0;
         //keys=0;
     end
     
     always #5 clk=~clk;
     Present PS(res,state,keys,clk);
 endmodule
