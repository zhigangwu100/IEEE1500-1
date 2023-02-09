module CDR_test();
reg ScanChainIN;
wire ScanChainOut;
reg se;
reg CLK;
reg CoreIN_RESET;
initial
begin
/*
#10 CoreIN_RESET=0;
    se=0;
#30 CoreIN_RESET=1;
    se=0;
#100 se=1;
 */  
#10 CoreIN_RESET=0;
    se=1;
#50 CoreIN_RESET=1;
    se=1;
#100 se=1; 


end


parameter FAST_PERIOD=20;
initial 
begin
CLK=0;
forever
#(FAST_PERIOD/2)CLK=~CLK;
end


initial 
begin
ScanChainIN=0;
forever
#(FAST_PERIOD)ScanChainIN=~ScanChainIN;
end

CDR CDR(
.ScanChainIN(ScanChainIN),
.ScanChainOut(ScanChainOut),
.se(se),
.CLK(CLK),
.CoreIN_RESET(CoreIN_RESET));



endmodule