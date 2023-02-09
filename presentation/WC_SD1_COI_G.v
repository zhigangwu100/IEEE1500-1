module WC_SD1_COI_G (resetn,CLK,CFI,CTI,ScanEnable,HoldEnable,BusDisable,CFO,CTO);
input CLK,CFI,CTI,ScanEnable,HoldEnable,resetn,BusDisable;
output CFO,CTO;
wire CFO_internal;
WC_SD1_COI WC_SD1_COI(resetn,CLK,CFI,CTI,ScanEnable,HoldEnable,CFO_internal,CTO);
assign CFO=CFO_internal | ScanEnable | BusDisable;
endmodule
