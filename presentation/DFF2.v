module DFF2(WRSTN,CLK,D,Q);
  
input WRSTN;
input CLK;
input D;
output Q;

 reg Q;
 always @ (posedge CLK)
 if  (!WRSTN)
   Q=0;
 else Q <= D;
endmodule