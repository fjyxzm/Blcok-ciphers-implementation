`timescale   1ns/1ns

module newcipher(result,state,keys,clk);
    
    input clk;
    input  [63:0] state;
    input  [63:0] keys;
    output [63:0] result;
    
    reg   ready;
    reg   [4:0] cnt;
    
    reg   [63:0]  res;
    reg   [63:0]  k;
    wire  [63:0]  te;
    wire  [63:0]  te1;
    wire  [63:0]  r_keys;
    reg   [4:0] rc;
    reg   [4:0] rcc;
    wire  [4:0] rc1;
    initial  begin
        
         ready  <=1;
         cnt    <=0;
          rcc<=1;
    end
    
    assign  result =res;
    always @(posedge  clk)  begin
        
        
        cnt    <= (cnt^28)? cnt+1: cnt;
        res    <= ready ? ( (cnt) ?te:state) :res;
      
        k      <= ready ? ( (cnt) ?r_keys:keys) :k;
      rc      <= ready ? ( (cnt) ?rc1:rcc) :rc; 
        ready  <= (cnt^28)? 1:0;
      
    end
   // always @(*)$display(" cnt=%d  res=%x te=%x,key=%x,r_keys=%x",cnt,res,te,k,r_keys);
    newcipherRound   ncPR(te,r_keys,rc1,res,k,cnt,rc);
endmodule
