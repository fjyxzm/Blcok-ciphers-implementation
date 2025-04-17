module p_shift_state(
        in,
        out
        );
  input[63:0] in;
  output[63:0] out;

  assign out = {in[15:0],in[14:0],in[15],in[3:0],in[15:4],in[2:0],in[15:3]};

endmodule	
