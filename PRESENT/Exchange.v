`timescale 1ns/1ns

module Exchange(res,state);

 input  [0:63] state;
 output [0:63] res; 

 assign   res={
      state[ 0],state[ 4],state[ 8],state[12],state[16],state[20],state[24],state[28],
      state[32],state[36],state[40],state[44],state[48],state[52],state[56],state[60],
		state[ 1],state[ 5],state[ 9],state[13],state[17],state[21],state[25],state[29],
		state[33],state[37],state[41],state[45],state[49],state[53],state[57],state[61],
		state[ 2],state[ 6],state[10],state[14],state[18],state[22],state[26],state[30],
		state[34],state[38],state[42],state[46],state[50],state[54],state[58],state[62],
		state[ 3],state[ 7],state[11],state[15],state[19],state[23],state[27],state[31],
		state[35],state[39],state[43],state[47],state[51],state[55],state[59],state[63]
};
endmodule


