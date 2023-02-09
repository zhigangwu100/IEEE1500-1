module WC_SD1_COI (resetn,CLK,CFI,CTI,ScanEnable,HoldEnable,CFO,CTO);
input CLK,CFI,CTI,ScanEnable,HoldEnable,resetn;
output CFO,CTO;
//wire Q;
wire D;
wire CTO;
//wire CFO;
wire CFO;

mux muxS  (CFO,CTI,ScanEnable,D);
DFF DFF(resetn,CLK,D,CTO);
mux muxH (CFI,CTO,HoldEnable,CFO);

//assign CTO=Q;
endmodule

