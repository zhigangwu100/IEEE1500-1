module WC_SF1_CII_test ();
reg resetn;
reg CLK;
reg CFI;
reg CTI;
reg ScanEnable;
reg HoldEnable;

wire CFO;
wire CTO;

parameter FAST_PERIOD=10;

////////////////////////////////////
initial 
begin
CLK=0;
forever
#(FAST_PERIOD/2)CLK=~CLK;
end

////////////////////////////////////
initial 
begin
CFI=0;
forever
#(FAST_PERIOD)CFI=~CFI;
end


initial 
begin
CTI=0;
forever
#(FAST_PERIOD)CTI=~CTI;
end


////////////////////////////////////
initial
begin
#0  resetn=0;

#20 ScanEnable=0;
    HoldEnable=0;
#100 resetn=1;  
#100 ScanEnable=0;
    HoldEnable=1;
#100 ScanEnable=1;
    HoldEnable=1;    
#100 ScanEnable=1;
    HoldEnable=0;

    
end


////////////////////////////////////
WC_SF1_CII WC_SF1_CII(
.resetn(resetn),
.CLK(CLK),
.CFI(CFI),
.CTI(CTI),
.ScanEnable(ScanEnable),
.HoldEnable(HoldEnable),
.CFO(CFO),
.CTO(CTO)
);


endmodule
