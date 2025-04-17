`timescale   1ns/1ns

module Present(result,state,keys,clk);
    
    input clk;
    input  [0:63] state;
    input  [0:79] keys;
    output [0:63] result;
    
    reg   ready;
    reg   [0:7] cnt;
    
    reg   [0:63]  res;
    reg   [0:79]  k;
    wire  [0:63]  te;
    wire  [0:79]  r_keys;
    
    initial  begin
        
         ready  <=1;
         cnt    <=0;
    end
    
    assign  result =res ^k[0:63];
    always @(posedge  clk)  begin
        
        
        cnt    <= (cnt^31)? cnt+1: cnt;
        res    <= ready ? ( (cnt) ?te:state ) :res;
        k      <= ready ? ( (cnt) ?r_keys:keys) :k;
        ready  <= (cnt^31)? 1:0;
      
    end
   // always @(*)$display(" cnt=%d  res=%x te=%x,key=%x,r_keys=%x",cnt,res,te,k,r_keys);
    PresentRound   PR(te,r_keys,res,k,cnt[3:7]);

endmodule
