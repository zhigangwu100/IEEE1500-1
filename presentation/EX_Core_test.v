module EX_Core_test();
reg  [3:0]ScanChainIN;
reg SCANMODE;
reg CLK;
reg resetn;
reg [7:0]Address;
wire [3:0]ScanChainOut;
wire [7:0]DataOut;

parameter FAST_PERIOD=20;
initial 
begin
#0 CLK=0;
forever
#(FAST_PERIOD/2)CLK=~CLK;
end


initial
begin
#10    resetn=0;
     SCANMODE=0;
#40    resetn=1;
     SCANMODE=0; 
#100 SCANMODE=1;  
      Address=8'h1e;
#100  Address=8'h4f;
end


//////////////////扫描链的扫描输入端的信号

initial 
begin
#0 ScanChainIN[0]=0;
forever
#(FAST_PERIOD)ScanChainIN[0]=~ScanChainIN[0];
end


initial 
begin
#0 ScanChainIN[1]=0;
forever
#(FAST_PERIOD)ScanChainIN[1]=~ScanChainIN[1];
end


initial 
begin
#0 ScanChainIN[2]=0;
forever
#(FAST_PERIOD)ScanChainIN[2]=~ScanChainIN[2];
end

initial 
begin
#0 ScanChainIN[3]=0;
forever
#(FAST_PERIOD)ScanChainIN[3]=~ScanChainIN[3];
end

///////////////////////////////////////////////



EX_Core E1(
.ScanChainIN(ScanChainIN),
.ScanChainOut(ScanChainOut),
.SCANMODE(SCANMODE),
.CLK(CLK),
.resetn(resetn),
.Address(Address),
.DataOut(DataOut)
);

endmodule





