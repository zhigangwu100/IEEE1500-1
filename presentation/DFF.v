module DFF(resetn,CLK,D,Q);
 output Q;
 input D,CLK,resetn;
 reg Q;
 
 always @ (posedge CLK)
 begin
 Q <= D;
 end
 
always @ (negedge resetn)
 //always @ (resetn)
 begin
 Q<=0;
 end
 
 
/* always @ (posedge CLK or negedge resetn)
 if  (!resetn)
 begin
   Q=0;
 end
 else Q <= D;*/
 
endmodule