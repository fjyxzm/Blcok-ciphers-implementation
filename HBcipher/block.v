module block1(L,R,in,r);
  input[0:63] in;
  input[0:7] r;
  output[0:31] L;  
  output[0:31] R;
  reg[0:31] L;  
  reg[0:31] R;
  
  always @(r)
	 
	 begin 
	    case (r%2)
	      1'b0: 
        begin
            L={in[0:3],in[ 8:11],in[16:19],in[24:27],in[32:35],in[40:43],in[48:51],in[56:59]};
            R={in[4:7],in[12:15],in[20:23],in[28:31],in[36:39],in[44:47],in[52:55],in[60:63]};  
        end
        1'b1: 
        begin
            R={in[0:3],in[ 8:11],in[16:19],in[24:27],in[32:35],in[40:43],in[48:51],in[56:59]};
            L={in[4:7],in[12:15],in[20:23],in[28:31],in[36:39],in[44:47],in[52:55],in[60:63]}; 
        end
      endcase 
       //P0P1P2P3 ? P8P9P10P11···? P8i+0P8i+1P8i+2P8i+3    
	  end    
endmodule