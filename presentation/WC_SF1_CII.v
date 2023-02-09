module WC_SF1_CII(resetn,CLK,CFI,CTI,ScanEnable,HoldEnable,CFO,CTO);
input CLK,CFI,CTI,ScanEnable,HoldEnable,resetn;
output CFO,CTO;
//wire Q;
wire D;
//wire Hout;
wire Sout;
wire CFO;
mux muxS(CFO,CTI,ScanEnable,Sout);
mux muxH(CFI,Sout,HoldEnable,D);
//mux muxS(Hout,CTI,ScanEnable,D);
//mux muxH(CFI,CFO,HoldEnable,Hout);
DFF DFF(resetn,CLK,D,CFO);
assign CTO=CFO;
endmodule


