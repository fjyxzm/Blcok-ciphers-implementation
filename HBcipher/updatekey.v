module updatekey(nk0,nk1,key,in);
  input[0:63] in;
  output[0:31] nk0;  
  output[0:31] nk1;
  output[0:63] key;  
  reg[0:63] in0;  
  assign nk0[0:31]={in[0:7],in[16:23],in[32:39],in[48:55]};
  assign nk1[0:31]={in[8:15],in[24:31],in[40:47],in[56:63]};
endmodule

