module WC_SD1_CII_O (resetn,CLK,CFI,CTI,wse_inputs,hold_inputs,CFO,CTO);
//module WC_SD1_CII_O (resetn,CLK,CFI,CTI,ScanEnable,HoldEnable,CFO,CTO);
//input CLK,CFI,CTI,ScanEnable,HoldEnable,resetn;
input CLK,CFI,CTI,wse_inputs,hold_inputs,resetn;
output CFO,CTO;
wire Q;
wire D;
wire Hout;
wire CTO;

//mux muxS  (Hout,CTI,ScanEnable,D);
//mux muxH (CFI,CTO,HoldEnable,Hout);
mux muxS  (Hout,CTI,wse_inputs,D);
mux muxH (CFI,CTO,hold_inputs,Hout);

DFF DFF(resetn,CLK,D,Q);
assign CFO=CFI;//这一步决定RESET是异步信号
assign CTO=Q;
endmodule

