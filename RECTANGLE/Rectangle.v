module rectangle(result,state,keys,clk);
    input clk;
    input  [63:0] state;
    input  [79:0] keys;
    output [63:0] result;
    
    reg   ready;
    reg   [4:0] cnt;
    
    reg   [63:0]  res;
    reg   [79:0]  k;
    wire  [63:0]  te;
    wire  [79:0]  r_keys;
    reg   [4:0] rc;
    reg   [4:0] rcc;
    wire  [4:0] rc1;
    initial  begin
        
         ready  <=1;
         cnt    <=0;
         rcc<=1;
    end
    
    assign  result =res ^k[79:16];
    always @(posedge  clk)  begin
        cnt    <= (cnt^25)? cnt+1: cnt;
        res    <= ready ? ( (cnt) ?te:state ) :res;
        k      <= ready ? ( (cnt) ?r_keys:keys) :k;
        rc      <= ready ? ( (cnt) ?rc1:rcc) :rc; 
        ready  <= (cnt^25)? 1:0;     
    end
    always @(*)$display(" cnt=%d  res=%x te=%x,key=%x,r_keys=%x rc=%d",cnt,res,te,k,r_keys,rc);
    rectangleRound   PR(te,r_keys,rc1,res,k,cnt[4:0],rc);
endmodule
