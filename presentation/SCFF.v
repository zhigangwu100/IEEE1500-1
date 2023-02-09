module SCFF(LogicIN,ScanIN,se,CLK,resetn,Q);
input LogicIN;
input ScanIN;
//input SCANMODE;
input se;
input CLK;
input resetn;
output Q;
wire D;

DFF DforSCFF  (resetn,CLK,D,Q);
mux muxforSCFF(LogicIN,ScanIN,se,D);
endmodule
